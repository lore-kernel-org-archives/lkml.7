Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7C6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 20:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C997E20652
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 20:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bc2gNDeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfCJUBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 16:01:16 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33113 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfCJUBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 16:01:15 -0400
Received: by mail-qt1-f194.google.com with SMTP id z39so2868370qtz.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 13:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cJzQZJGS3u6X82yZ/MtBJfkke08BS/hFxdt9Bk28ewU=;
        b=bc2gNDeYf6gDx3Yr3oQIeqvlH4mJsYHUhfZ1+LC+UjBPBRDDX5hwmcC+qNhr5HcH4p
         xE89kZjSVpwK2nAfwhyP0W1GrZr/pOCLlncHTInpN0FUTPKX5usrc6ffiwTCwb9dNO+m
         rSjfRu2emN1m4XZT6uksSk7mchCKi7fe/Efl7+ATZEUIiSnMa2rwDXpi4LHlriEkNPMo
         FWTtsdDolQZDYnKo6Q2v89MWozhanuIeFTTYVd6ZNyUV6t9+1xgkCr+Xh3o5jxuYJoVg
         HLgp2gmTuSIVfKDv8SJfIVeQ0FUb/gNUibpOmvfrCrhcmI6StAHlS4Zd0nZfAq62AgHT
         kMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cJzQZJGS3u6X82yZ/MtBJfkke08BS/hFxdt9Bk28ewU=;
        b=fAZME8n9YSKV8Lg6dMQZYvNSSmGZRkaUiaoJNBmKaLcqa/o8iFR3xXUpFKcjiYpGSO
         jTvoUIVf4JPn0aSsxexqSq4YjhwvXOdoqueTu2kGMGZBH9QtXKFIp+tl1i/BN0KrXDkE
         wNQuqDHttNUncSbnlmz3ynj1bPMj5ANOFN3afSzu+vZ9qHYAQpJfIxEJGmLpX2IFmPeV
         shkyfYGotXChUCrkk5TmoZgoplhic0jDtEPBYKXVAiWUctO0f5hgHMEQUY3/PPasCAed
         BL/ShqlZpXN3NHcWkeHYUaahl7uor/JjWveodjRki3ETyDwPDq1JLjMxBiPKqkiYAKr8
         wnMg==
X-Gm-Message-State: APjAAAUZhgmNq26KDWFsM5UynSApAMK0cohZZM+VbIlu90HX2V3VSRj5
        GxYKYPROhAoFOsChjiOA3QsmnI5rglk=
X-Google-Smtp-Source: APXvYqy43fpnSl61MlAaf6NcvNVwq1vbUnCoIdIqy0jXzR5xcuDTtfUMGWMtYF/5yU3isT1d1VT2Sg==
X-Received: by 2002:ad4:5190:: with SMTP id b16mr2614239qvp.100.1552248074382;
        Sun, 10 Mar 2019 13:01:14 -0700 (PDT)
Received: from ovpn-121-103.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s76sm2263077qki.42.2019.03.10.13.01.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 13:01:13 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [RESEND PATCH] mm/hotplug: don't reset pagetype flags for offline
Date:   Sun, 10 Mar 2019 16:01:02 -0400
Message-Id: <20190310200102.88014-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded
memory to zones until online") introduced move_pfn_range_to_zone() which
calls memmap_init_zone() during onlining a memory block.
memmap_init_zone() will reset pagetype flags and makes migrate type to
be MOVABLE.

However, in __offline_pages(), it also call undo_isolate_page_range()
after offline_isolated_pages() to do the same thing. Due to
the commit 2ce13640b3f4 ("mm: __first_valid_page skip over offline
pages") changed __first_valid_page() to skip offline pages,
undo_isolate_page_range() here just waste CPU cycles looping around the
offlining PFN range while doing nothing, because __first_valid_page()
will return NULL as offline_isolated_pages() has already marked all
memory sections within the pfn range as offline via
offline_mem_sections().

Also, after calling the "useless" undo_isolate_page_range() here, it
reaches the point of no returning by notifying MEM_OFFLINE. Those pages
will be marked as MIGRATE_MOVABLE again once onlining. In addition, fix
an incorrect comment along the way.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/memory_hotplug.c | 2 --
 mm/sparse.c         | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 6b05576fb4ec..46017040b2f8 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1655,8 +1655,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	/* Ok, all of our target is isolated.
 	   We cannot do rollback at this point. */
 	offline_isolated_pages(start_pfn, end_pfn);
-	/* reset pagetype flags and makes migrate type to be MOVABLE */
-	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
 	/* removal success */
 	adjust_managed_page_count(pfn_to_page(start_pfn), -offlined_pages);
 	zone->present_pages -= offlined_pages;
diff --git a/mm/sparse.c b/mm/sparse.c
index 77a0554fa5bd..b3771f35a0ed 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -556,7 +556,7 @@ void online_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-/* Mark all memory sections within the pfn range as online */
+/* Mark all memory sections within the pfn range as offline */
 void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 {
 	unsigned long pfn;
-- 
2.17.2 (Apple Git-113)

