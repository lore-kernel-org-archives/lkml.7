Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9CEC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 22:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA4F20830
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 22:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="MSvbRfFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfCBWpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 17:45:46 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45736 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfCBWpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 17:45:45 -0500
Received: by mail-qk1-f194.google.com with SMTP id v139so865514qkb.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 14:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DK+5XMVgtWeHEsPD9waEnnFYsNsVEJ351y7fqi8ULmY=;
        b=MSvbRfFsKZq4q8WcfA+qRoCom/ZwzH9c7N+J1P0pp5DfZJbwGhf/9k8NB8t1a13cdl
         OaEusB/BKn3xCvhVjSayHSTdN1CfhgweRPx4u5e24RNMcwZJH7OAR/lH1IahCOsngVWy
         9hVk9ma42j+BFS6RqnSxdzvqc/1tQhTKk8P95sdMPkijVDQaRyicr+156OQg121QxZq3
         tkAW7+Yz8NdcAWQ1s3dnWbjHMdwwIvj6U07mKP8y9kpYskZzjfW6d9bSvCP1KiBux67c
         zYrqQaCPkBO9UBVlXnJf/TlMiR9EIh10dsRCKv7h5Q9IhpJlrWtfsjM1n9IQjw6rdV1o
         RlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DK+5XMVgtWeHEsPD9waEnnFYsNsVEJ351y7fqi8ULmY=;
        b=pO5omz4jtBF/jMRDtvOjU97PFdi8LQt0dIxm/IQKmaKtVHSE/EN00VVUf8V40BnPQx
         9caTj/HszuB/dXZcR07lropR+wLGV04gmi2/6dMOrHFdtbjLYihImX87GtTKzzAwcoX0
         CgyIRSDS8Fo34Q/2NfSbkc2i+ARm/XiEvaWe/dfiA4D98IT1r//SCN57rawhCnUv/txs
         DLTD3hXiHWvze/1l+M5ILnvWKqqmQEpeH5Z1RBx8lmad7Iar13B1ZeCwQKj2j8p1P/tf
         Flve7/6CfBZbhaY3yMBImMN8lKfbXn2GNO7IikByCvlwuy7QDEJGpz/Oj6m3D/FgLfIl
         cB8A==
X-Gm-Message-State: APjAAAV+BryG3Am/tgC+49GU/GmyY8IWhGCpj0seEllNLdIkvucyLKdc
        27MAD0oF8sdaR/AizmIo8eOq8w==
X-Google-Smtp-Source: APXvYqxkw5sm1LIULdONWmeSqiNZNneM8+u3QafTNRkKR1AQt22sY3jZ6rsUmuuN9v2TJIHsmx3SOQ==
X-Received: by 2002:a37:f506:: with SMTP id l6mr9187794qkk.110.1551566377048;
        Sat, 02 Mar 2019 14:39:37 -0800 (PST)
Received: from ovpn-120-151.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l36sm1009683qte.82.2019.03.02.14.39.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 14:39:36 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/hotplug: don't reset pagetype flags for offline
Date:   Sat,  2 Mar 2019 17:39:20 -0500
Message-Id: <20190302223920.5704-1-cai@lca.pw>
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

Since undo_isolate_page_range() is rather unnecessary here, just remove
it. Also, fix an incorrect comment along the way.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/memory_hotplug.c | 2 --
 mm/sparse.c         | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 736e107e2197..e793f6514fb2 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1643,8 +1643,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
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

