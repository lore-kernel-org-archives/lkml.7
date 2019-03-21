Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38605C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EEF2218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfCUKdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:33:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbfCUKdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:33:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CFC5B85541;
        Thu, 21 Mar 2019 10:33:49 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-199.pek2.redhat.com [10.72.12.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF47819C57;
        Thu, 21 Mar 2019 10:33:38 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com
Subject: [PATCH 2/3 v9] resource: add the new I/O resource descriptor 'IORES_DESC_RESERVED'
Date:   Thu, 21 Mar 2019 18:33:08 +0800
Message-Id: <20190321103309.27883-3-lijiang@redhat.com>
In-Reply-To: <20190321103309.27883-1-lijiang@redhat.com>
References: <20190321103309.27883-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 21 Mar 2019 10:33:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing kexec_file_load, the first kernel needs to pass the e820
reserved ranges to the second kernel. But kernel can not exactly
match the e820 reserved ranges when walking through the iomem resources
with the descriptor 'IORES_DESC_NONE', because several e820 types(
e.g. E820_TYPE_RESERVED_KERN/E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820
_TYPE_RESERVED) are converted to the descriptor 'IORES_DESC_NONE'. It
may pass these four types to the kdump kernel, that is not desired result.

So, this patch adds a new I/O resource descriptor 'IORES_DESC_RESERVED'
for the iomem resources search interfaces. It is helpful to exactly
match the reserved resource ranges when walking through iomem resources.

In addition, since the new descriptor 'IORES_DESC_RESERVED' is introduced,
these code originally related to the descriptor 'IORES_DESC_NONE' need to
be updated. Otherwise, it will be easily confused and also cause some
errors. Because the 'E820_TYPE_RESERVED' type is converted to the new
descriptor 'IORES_DESC_RESERVED' instead of 'IORES_DESC_NONE', it has been
changed.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/kernel/e820.c | 2 +-
 include/linux/ioport.h | 1 +
 kernel/resource.c      | 6 +++---
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 2879e234e193..16fcde196243 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1050,10 +1050,10 @@ static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
 	case E820_TYPE_NVS:		return IORES_DESC_ACPI_NV_STORAGE;
 	case E820_TYPE_PMEM:		return IORES_DESC_PERSISTENT_MEMORY;
 	case E820_TYPE_PRAM:		return IORES_DESC_PERSISTENT_MEMORY_LEGACY;
+	case E820_TYPE_RESERVED:	return IORES_DESC_RESERVED;
 	case E820_TYPE_RESERVED_KERN:	/* Fall-through: */
 	case E820_TYPE_RAM:		/* Fall-through: */
 	case E820_TYPE_UNUSABLE:	/* Fall-through: */
-	case E820_TYPE_RESERVED:	/* Fall-through: */
 	default:			return IORES_DESC_NONE;
 	}
 }
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index da0ebaec25f0..6ed59de48bd5 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -133,6 +133,7 @@ enum {
 	IORES_DESC_PERSISTENT_MEMORY_LEGACY	= 5,
 	IORES_DESC_DEVICE_PRIVATE_MEMORY	= 6,
 	IORES_DESC_DEVICE_PUBLIC_MEMORY		= 7,
+	IORES_DESC_RESERVED			= 8,
 };
 
 /* helpers to define resources */
diff --git a/kernel/resource.c b/kernel/resource.c
index e81b17b53fa5..ee7348761858 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -990,7 +990,7 @@ __reserve_region_with_split(struct resource *root, resource_size_t start,
 	res->start = start;
 	res->end = end;
 	res->flags = type | IORESOURCE_BUSY;
-	res->desc = IORES_DESC_NONE;
+	res->desc = IORES_DESC_RESERVED;
 
 	while (1) {
 
@@ -1025,7 +1025,7 @@ __reserve_region_with_split(struct resource *root, resource_size_t start,
 				next_res->start = conflict->end + 1;
 				next_res->end = end;
 				next_res->flags = type | IORESOURCE_BUSY;
-				next_res->desc = IORES_DESC_NONE;
+				next_res->desc = IORES_DESC_RESERVED;
 			}
 		} else {
 			res->start = conflict->end + 1;
@@ -1488,7 +1488,7 @@ static int __init reserve_setup(char *str)
 			res->start = io_start;
 			res->end = io_start + io_num - 1;
 			res->flags |= IORESOURCE_BUSY;
-			res->desc = IORES_DESC_NONE;
+			res->desc = IORES_DESC_RESERVED;
 			res->child = NULL;
 			if (request_resource(parent, res) == 0)
 				reserved = x+1;
-- 
2.17.1

