Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F96C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 12:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3718A20665
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 12:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNbjA0OL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408999AbfITM3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 08:29:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45137 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404619AbfITM3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 08:29:11 -0400
Received: by mail-lj1-f193.google.com with SMTP id q64so6850145ljb.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 05:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zRqTS3V+m+4w0d7L5MeANtoAWhuIONw+ofn7LfLax7M=;
        b=GNbjA0OLqlXcmqK1epU19sHUETfXuc5bNucGPbu43hbBJRRCHB84gR38mBnRnV4QDn
         IsLVHtJ/kjm4u7fOP6Xnu/6GT+JJyZBaOnsg6ZJijLJnhT5zeOg9QWCV0kWvAAbLFriF
         O50eGu7iyy1t1jvOHVL5qWjQ7YgiuPKF6YtZxDRY1ymTQljCalRidsAh/YRtDx13VLkd
         +ydRU7HEhHJlDDdy5aCCUk5PhtNQ7vpwRDXzpV9Jlwzbs5BcBPrTgXlXehqdant/eC2d
         PXKCsTgY02l6NJsYzdfLbI6nUsWt8jgtQdnJiUAWfOqwxIWCpigPQVr4pg+cp1Y97Z9Z
         PmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zRqTS3V+m+4w0d7L5MeANtoAWhuIONw+ofn7LfLax7M=;
        b=h5WqRiZxGnuqF+RwexQCqHw+/3qo75XoT2I6N9KKVz/gAPv46p1sOlxhqpCtpSZR6r
         W1g4wx+3J1anLmRqyRF0CUjRwD7NcykHViliRYB5gAofZk1KgCIBGgslrT+B5iCchZt5
         IyOILlOdN5DRVOtOnWlSlZIHcVnUvS0q3vgFEpjtEzjkbdle5yKsMMJTS9cpfyHjJGdQ
         462W3GshG+KLPlY478HKMqXUuXdUSp1psFTq3wW1IXzxyX33OVgjJVs0xT++KCchPH4z
         XwBJHZv6nJ1OnKa78/f7tRXWrGSAj0CSAovkO1xYJ09lTr9oTQ1MCxBIIIvwxdo8T3zJ
         PczQ==
X-Gm-Message-State: APjAAAU9gLdhAInByaWLl8iES5dnU63JectuV8/sXZbgFYerpR7TmjA3
        N12bl9D2nnIlJB6F94PiRtE=
X-Google-Smtp-Source: APXvYqysZ6X7F0kXPqDsa2l37Rkz7d6wWrYJIuXm6C88aYt/3zLc9GrhGdjYqnFW1nniutXZSOKk2A==
X-Received: by 2002:a2e:6804:: with SMTP id c4mr9364426lja.120.1568982549984;
        Fri, 20 Sep 2019 05:29:09 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id z72sm418739ljb.98.2019.09.20.05.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 05:29:08 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id ED22E461797; Fri, 20 Sep 2019 15:29:07 +0300 (MSK)
Date:   Fri, 20 Sep 2019 15:29:07 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: [PATCH] mm, memcg: assign shrinker_map before kvfree
Message-ID: <20190920122907.GG2507@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is a small gap between fetching pointer, calling
kvfree and assign its value to nil. In current callgraph it is
not a problem (since memcg_free_shrinker_maps is running from
memcg_alloc_shrinker_maps and mem_cgroup_css_free only) still
this looks suspicious and we can easily eliminate the gap at all.

Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
 mm/memcontrol.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-tip.git/mm/memcontrol.c
===================================================================
--- linux-tip.git.orig/mm/memcontrol.c
+++ linux-tip.git/mm/memcontrol.c
@@ -364,9 +364,9 @@ static void memcg_free_shrinker_maps(str
 	for_each_node(nid) {
 		pn = mem_cgroup_nodeinfo(memcg, nid);
 		map = rcu_dereference_protected(pn->shrinker_map, true);
+		rcu_assign_pointer(pn->shrinker_map, NULL);
 		if (map)
 			kvfree(map);
-		rcu_assign_pointer(pn->shrinker_map, NULL);
 	}
 }
 
