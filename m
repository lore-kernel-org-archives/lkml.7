Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0A4C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E22121874
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567096493;
	bh=/RKsdtLqrxQECPMEcb06f4Tes5JVJqbTGBYapPZdC04=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=oIa7Lb1YE9XDlWkkS8kr/yRwUWAsLAGepOJv70XFTnO3oK+MNGn6l8LPZ/MvNy1RE
	 9iEf13O6tJtrpmRAVKhtESdG5OuTMTi8BlOf+C2F15gmSW00rXWSGkKCcAxQ3MXkZb
	 s+iCU07YrXdfU6APUi+ZJLS29gs6Wau8y2boJM3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfH2Qew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:34:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39610 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbfH2Qew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:34:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so4102868wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 09:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rXp82d/Wh2JCj1MeKUCs7Dh59nPL823HHzcVIr15+Dw=;
        b=VKCmFcb2S3Mq9p0LYLboYbF1qP2j2ZAI90ji5+u3zjlrgvn4r1GzZ8tkKfjOHAQK9k
         jhifUGueISlThco7jdJNNMTDvpopEugYlXhZB0zqyrE1lU/tBcOnopYKSR3+wPQOFSU3
         YCKllvezZjVCA3NVD5+ZUEoi4Gu44Ekx71zpzhzNSLF5g3jviBoXUw1n3B8HFWQxpOnk
         UL5hTbiLHaU5Lw9wTJP+RYkUiYAqDdcLsK2Z7ieVGW1lCuXpPw4Mgd7/+wZ9jVcyM88Y
         p8pHyW3OGOF2BQayHUXJkRJPQqd4NvM2BwWXMF19E6PwdW1K/VeDczIx+XOIq2Ssn2o+
         ZWtA==
X-Gm-Message-State: APjAAAX4AESIvgFlOleTb3lKVCvAmsVx7MFeJmnhCINQqGsHV90kv7JC
        6GIH3/YMPPSMqDTYCGGbRhQ=
X-Google-Smtp-Source: APXvYqywxm1LMKB2iR0OTC1ykV3jOzNzHtzu435QnQl4bZncpfWFDjKeO3SolUO0I3KlMVVZLyo6kg==
X-Received: by 2002:a5d:414f:: with SMTP id c15mr13062250wrq.248.1567096489955;
        Thu, 29 Aug 2019 09:34:49 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-37-188-253-38.eurotel.cz. [37.188.253.38])
        by smtp.gmail.com with ESMTPSA id z25sm3623081wml.5.2019.08.29.09.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 09:34:48 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm, oom: consider present pages for the node size
Date:   Thu, 29 Aug 2019 18:34:43 +0200
Message-Id: <20190829163443.899-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

constrained_alloc calculates the size of the oom domain by using
node_spanned_pages which is incorrect because this is the full range of
the physical memory range that the numa node occupies rather than the
memory that backs that range which is represented by node_present_pages.

Sparsely populated nodes (e.g. after memory hot remove or simply sparse
due to memory layout) can have really a large difference between the
two. This shouldn't really cause any real user observable problems
because the oom calculates a ratio against totalpages and used memory
cannot exceed present pages but it is confusing and wrong from code
point of view.

Noticed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/oom_kill.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index eda2e2a0bdc6..16af3da97d08 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -287,7 +287,7 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 	    !nodes_subset(node_states[N_MEMORY], *oc->nodemask)) {
 		oc->totalpages = total_swap_pages;
 		for_each_node_mask(nid, *oc->nodemask)
-			oc->totalpages += node_spanned_pages(nid);
+			oc->totalpages += node_present_pages(nid);
 		return CONSTRAINT_MEMORY_POLICY;
 	}
 
@@ -300,7 +300,7 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 	if (cpuset_limited) {
 		oc->totalpages = total_swap_pages;
 		for_each_node_mask(nid, cpuset_current_mems_allowed)
-			oc->totalpages += node_spanned_pages(nid);
+			oc->totalpages += node_present_pages(nid);
 		return CONSTRAINT_CPUSET;
 	}
 	return CONSTRAINT_NONE;
-- 
2.20.1

