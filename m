Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC53AC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E40220644
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbfITOLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:11:21 -0400
Received: from relay.sw.ru ([185.231.240.75]:59458 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387615AbfITOLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:11:21 -0400
Received: from [172.16.24.104]
        by relay.sw.ru with esmtp (Exim 4.92.2)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1iBJct-0006XP-IK; Fri, 20 Sep 2019 17:11:11 +0300
Subject: Re: [PATCH] mm, memcg: assign shrinker_map before kvfree
To:     Cyrill Gorcunov <gorcunov@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <20190920122907.GG2507@uranus.lan>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <8a4b5293-6f79-2a5d-4ac8-f8fc17f13b6e@virtuozzo.com>
Date:   Fri, 20 Sep 2019 17:11:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190920122907.GG2507@uranus.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.09.2019 15:29, Cyrill Gorcunov wrote:
> Currently there is a small gap between fetching pointer, calling
> kvfree and assign its value to nil. In current callgraph it is
> not a problem (since memcg_free_shrinker_maps is running from
> memcg_alloc_shrinker_maps and mem_cgroup_css_free only) still
> this looks suspicious and we can easily eliminate the gap at all.
> 
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
> ---
>  mm/memcontrol.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-tip.git/mm/memcontrol.c
> ===================================================================
> --- linux-tip.git.orig/mm/memcontrol.c
> +++ linux-tip.git/mm/memcontrol.c
> @@ -364,9 +364,9 @@ static void memcg_free_shrinker_maps(str
>  	for_each_node(nid) {
>  		pn = mem_cgroup_nodeinfo(memcg, nid);
>  		map = rcu_dereference_protected(pn->shrinker_map, true);
> +		rcu_assign_pointer(pn->shrinker_map, NULL);
>  		if (map)
>  			kvfree(map);
> -		rcu_assign_pointer(pn->shrinker_map, NULL);
>  	}
>  }

The current scheme is following. We allocate shrinker_map in css_online,
while normal freeing happens in css_free. The NULLifying of pointer is needed
in case of "abnormal freeing", when memcg_free_shrinker_maps() is called
from memcg_alloc_shrinker_maps(). The NULLifying guarantees, we won't free
pn->shrinker_map twice.

There are no races or problems with kvfree() and rcu_assign_pointer() order,
because of nobody can reference shrinker_map before memcg is online.

In case of this rcu_assign_pointer() confuses, we may just remove is from
the function, and call it only on css_free. Something like the below:

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1c4c08b45e44..454303c3aa0f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -372,7 +372,6 @@ static void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
 		map = rcu_dereference_protected(pn->shrinker_map, true);
 		if (map)
 			kvfree(map);
-		rcu_assign_pointer(pn->shrinker_map, NULL);
 	}
 }
 
@@ -389,7 +388,6 @@ static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
 	for_each_node(nid) {
 		map = kvzalloc(sizeof(*map) + size, GFP_KERNEL);
 		if (!map) {
-			memcg_free_shrinker_maps(memcg);
 			ret = -ENOMEM;
 			break;
 		}
