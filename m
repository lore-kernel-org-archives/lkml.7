Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7C3C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD962171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="FpWx+tFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfDLPPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:15:25 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42886 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbfDLPPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:15:23 -0400
Received: by mail-qt1-f195.google.com with SMTP id p20so11591824qtc.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 08:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Os4Omut1si9dZUtk8xlS/9PlA4SUJZFOM37ndbDq3oI=;
        b=FpWx+tFikqrZdAqHy8DuhFwSzGznleXRgjxZNDwl8fFECEghu5j8q1+uwliecftUar
         L0qovs/uw2w7CgfnMoQx78Dk2YOOBJoP4QTDOWlGJbl0O6GIUQ59VmwlLyyT2oHnuPB9
         8hmvZJ247fTWRB9ZF+7KVq8xvyJanOTGCHhUTW0AmBAPBRC57t2u1Dj8wD9npYit59ja
         SWtjvgC6wCEuHSXwHDt8NxymIdh+HFjimb6yjHjLjhhk9NO03kJFznmagrp8qtPf2wJn
         CBD2GaKz8nvXzLO0rYOHzvsSx3udCXhFRsoJhxmSHMjI/slxgUGy30JqhrRYaSYZtXU6
         8JdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Os4Omut1si9dZUtk8xlS/9PlA4SUJZFOM37ndbDq3oI=;
        b=UzrCKi+tZAgdOrDu8ZqOD9Da0me67ZFBWaGcbI3fn5mDK43eaVnsWx5X59zsjJ3LII
         CeKHCtdVxxUrGEDsT4HAyP+pyoC6eJoYOq+erBYsYnC2tEp/YYwC6IoBolwZAbAgaAm8
         afCdt6/uQKgnVHfuPn4HYiAy4XNhNqRVbBOpNj9Yfb91S6PNY610ItOp9qySy21nzdio
         HMYF8kQGSvAMH6ht3/5qgFBMsfykwrfKwj/X6CRSNEejN491prMJs7l42GSPdbdYItVB
         IA7FIOFQYKNqgfDEPH8FUMdlek9NOScQhK14WdKLtiA4BesnGGSRInc8Fod3G9MnaNVk
         kATg==
X-Gm-Message-State: APjAAAWxYp6nN9uMDKQXr8if0rfzytRsVdff2yg5md9CSokyrcZtjPpa
        WzKttYqdWo2xLVv8aOhhx+b6klPzVt4=
X-Google-Smtp-Source: APXvYqzVDhpq/REyjk2jbBHCrlfGWJ514qWQfxe7lwASD2ybrledPl2eTVl5f7Jl8CXIIUISZgnShw==
X-Received: by 2002:a0c:92d5:: with SMTP id c21mr48389189qvc.215.1555082122539;
        Fri, 12 Apr 2019 08:15:22 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id m189sm25217643qkf.2.2019.04.12.08.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 08:15:21 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/4] mm: memcontrol: fix NUMA round-robin reclaim at intermediate level
Date:   Fri, 12 Apr 2019 11:15:07 -0400
Message-Id: <20190412151507.2769-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412151507.2769-1-hannes@cmpxchg.org>
References: <20190412151507.2769-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a cgroup is reclaimed on behalf of a configured limit, reclaim
needs to round-robin through all NUMA nodes that hold pages of the
memcg in question. However, when assembling the mask of candidate NUMA
nodes, the code only consults the *local* cgroup LRU counters, not the
recursive counters for the entire subtree. Cgroup limits are
frequently configured against intermediate cgroups that do not have
memory on their own LRUs. In this case, the node mask will always come
up empty and reclaim falls back to scanning only the current node.

If a cgroup subtree has some memory on one node but the processes are
bound to another node afterwards, the limit reclaim will never age or
reclaim that memory anymore.

To fix this, use the recursive LRU counts for a cgroup subtree to
determine which nodes hold memory of that cgroup.

The code has been broken like this forever, so it doesn't seem to be a
problem in practice. I just noticed it while reviewing the way the LRU
counters are used in general.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2eb2d4ef9b34..2535e54e7989 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1512,13 +1512,13 @@ static bool test_mem_cgroup_node_reclaimable(struct mem_cgroup *memcg,
 {
 	struct lruvec *lruvec = mem_cgroup_lruvec(NODE_DATA(nid), memcg);
 
-	if (lruvec_page_state_local(lruvec, NR_INACTIVE_FILE) ||
-	    lruvec_page_state_local(lruvec, NR_ACTIVE_FILE))
+	if (lruvec_page_state(lruvec, NR_INACTIVE_FILE) ||
+	    lruvec_page_state(lruvec, NR_ACTIVE_FILE))
 		return true;
 	if (noswap || !total_swap_pages)
 		return false;
-	if (lruvec_page_state_local(lruvec, NR_INACTIVE_ANON) ||
-	    lruvec_page_state_local(lruvec, NR_ACTIVE_ANON))
+	if (lruvec_page_state(lruvec, NR_INACTIVE_ANON) ||
+	    lruvec_page_state(lruvec, NR_ACTIVE_ANON))
 		return true;
 	return false;
 
-- 
2.21.0

