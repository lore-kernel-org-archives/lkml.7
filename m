Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FF2C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED6A218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCVPQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:16:54 -0400
Received: from relay.sw.ru ([185.231.240.75]:46650 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbfCVPQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:16:54 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1h7LuX-00037y-LP; Fri, 22 Mar 2019 18:16:45 +0300
Subject: Re: [PATCH] fixup: vmscan: Fix build on !CONFIG_MEMCG from
 nr_deactivate changes
To:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
References: <20190322150513.GA22021@chrisdown.name>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <bf777760-083f-4297-9805-b355c65ab080@virtuozzo.com>
Date:   Fri, 22 Mar 2019 18:16:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322150513.GA22021@chrisdown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.2019 18:05, Chris Down wrote:
> "mm: move nr_deactivate accounting to shrink_active_list()" uses the
> non-irqsaved version of count_memcg_events (__count_memcg_events), but
> we've only exported the irqsaving version of it to userspace, so the
> build breaks:
> 
>     mm/vmscan.c: In function ‘shrink_active_list’:
>     mm/vmscan.c:2101:2: error: implicit declaration of function ‘__count_memcg_events’; did you mean ‘count_memcg_events’? [-Werror=implicit-function-declaration]
> 
> This fixup makes it build with !CONFIG_MEMCG.

Yeah, thanks, Chris.

> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: kernel-team@fb.com
> ---
>  include/linux/memcontrol.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 534267947664..b226c4bafc93 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1147,6 +1147,12 @@ static inline void count_memcg_events(struct mem_cgroup *memcg,
>  {
>  }
>  
> +static inline void __count_memcg_events(struct mem_cgroup *memcg,
> +					enum vm_event_item idx,
> +					unsigned long count)
> +{
> +}
> +
>  static inline void count_memcg_page_event(struct page *page,
>  					  int idx)
>  {
> 
