Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE45C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836CF2070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfCNJrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:47:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfCNJrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:47:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E253305FCDF;
        Thu, 14 Mar 2019 09:47:18 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-22.pek2.redhat.com [10.72.12.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F9A45C241;
        Thu, 14 Mar 2019 09:47:10 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, keescook@chromium.org, kirill@shutemov.name,
        yamada.masahiro@socionext.com, tglx@linutronix.de, bp@alien8.de,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, x86@kernel.org, thgarnie@google.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 3/6] mm: Add build time sanity check for struct page size
Date:   Thu, 14 Mar 2019 17:46:42 +0800
Message-Id: <20190314094645.4883-4-bhe@redhat.com>
In-Reply-To: <20190314094645.4883-1-bhe@redhat.com>
References: <20190314094645.4883-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 14 Mar 2019 09:47:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Size of struct page might be larger than 64 bytes if debug options
enabled, or fields added for debugging intentionally. Yet an upper
limit need be added at build time to trigger an alert in case the
size is too big to boot up system, warning people to check if it's
be done on purpose in advance.

Here 1/4 of PAGE_SIZE is chosen since system must have been insane
with this value. For those systems with PAGE_SIZE larger than 4KB,
1KB is simply taken.

Signed-off-by: Baoquan He <bhe@redhat.com>
Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3eb01dedfb50..eddf96c137f2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -67,6 +67,7 @@
 #include <linux/lockdep.h>
 #include <linux/nmi.h>
 #include <linux/psi.h>
+#include <linux/sizes.h>
 
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
@@ -7170,6 +7171,7 @@ void __init free_area_init_nodes(unsigned long *max_zone_pfn)
 	unsigned long start_pfn, end_pfn;
 	int i, nid;
 
+	BUILD_BUG_ON(sizeof(struct page) > min_t(size_t, SZ_1K, PAGE_SIZE/4));
 	/* Record where the zone boundaries are */
 	memset(arch_zone_lowest_possible_pfn, 0,
 				sizeof(arch_zone_lowest_possible_pfn));
-- 
2.17.2

