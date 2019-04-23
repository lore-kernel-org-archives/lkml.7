Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5029C10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 01:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4C42077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 01:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfDWBad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 21:30:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729062AbfDWBad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 21:30:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93D0C30ADBA6;
        Tue, 23 Apr 2019 01:30:32 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FAB160141;
        Tue, 23 Apr 2019 01:30:23 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, akpm@linux-foundation.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com
Subject: [PATCH 1/3 v11] x86/e820, resource: add a new I/O resource descriptor 'IORES_DESC_RESERVED'
Date:   Tue, 23 Apr 2019 09:30:05 +0800
Message-Id: <20190423013007.17838-2-lijiang@redhat.com>
In-Reply-To: <20190423013007.17838-1-lijiang@redhat.com>
References: <20190423013007.17838-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 23 Apr 2019 01:30:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing kexec_file_load(), the first kernel needs to pass the e820
reserved ranges to the second kernel, because some devices may use it
in kdump kernel, such as PCI devices.

But, the kernel can not exactly match the e820 reserved ranges when
walking through the iomem resources via the 'IORES_DESC_NONE', because
there are several types of e820 that are described as the 'IORES_DESC_NONE'
type. Please refer to the e820_type_to_iores_desc().

Therefore, add a new I/O resource descriptor 'IORES_DESC_RESERVED' for
the iomem resources search interfaces. It is helpful to exactly match
the reserved resource ranges when walking through iomem resources.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/kernel/e820.c | 2 +-
 include/linux/ioport.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

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
-- 
2.17.1

