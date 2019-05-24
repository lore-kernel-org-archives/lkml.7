Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9CDC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01632184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389130AbfEXHil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 03:38:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388911AbfEXHii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 03:38:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 455BA81F13;
        Fri, 24 May 2019 07:38:38 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-43.pek2.redhat.com [10.72.12.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A3B35B683;
        Fri, 24 May 2019 07:38:30 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 1/3] x86/boot: Add xloadflags bits for 5-level kernel checking
Date:   Fri, 24 May 2019 15:38:08 +0800
Message-Id: <20190524073810.24298-2-bhe@redhat.com>
In-Reply-To: <20190524073810.24298-1-bhe@redhat.com>
References: <20190524073810.24298-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 24 May 2019 07:38:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current kernel supports 5-level paging mode, and supports dynamically
choosing paging mode during bootup according to kernel image, hardware and
kernel parameter setting. This flexibility brings several issues to
kexec/kdump:
1)
Dynamic switching between paging modes requires code change in target
kernel. So we can't do kexec-jumping from 5-level kernel to old 4-level
kernel which lacks the code change.

2)
Kexec jumping from 5-level kernel to 4-level kernel would fail, if kexec
loading puts kernel image above 64 TB of memory. Because kexec loading
searches area to put kernel from top to down in system RAM, the 2nd kernel
will be loaded above 64 TB if the amount of system RAM is bigger than 64
TB. Here no need to worry about kexec_file loading, because it searches
area from bottom to up, and can always find area below 4 GB.

Solution:

Add two bits XLF_5LEVEL and XLF_5LEVEL_ENABLED for 5-level kernel.
- Bit XLF_5LEVEL indicates if 5-level related code is contained in this
  kernel.
- Bit XLF_5LEVEL_ENABLED indicates if CONFIG_X86_5LEVEL=y is set.

a) For issue 1), need check if XLF_5LEVEL is set, otherwise print out error
   message.
  - This checking need be added in kernel, for the code of kexec_file
    loading;
  - And also need be added into kexec_tools utility, for kexec loading.

b) For issue 2), need check if both XLF_5LEVEL and XLF_5LEVEL_ENABLED are
   set, otherwise print out error message.
  - This only need be done in kexec_tools utility, because kexec loading
    does the searching in user space kexec_tools.

So here add XLF_5LEVEL and XLF_5LEVEL_ENABLED into xloadflags. The later
code will check XLF_5LEVEL bit in kexec_file implementation of kernel. And
the kexec_tools code will check both XLF_5LEVEL and XLF_5LEVEL_ENABLED for
kexec loading.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/header.S                | 12 +++++++++++-
 arch/x86/include/uapi/asm/bootparam.h |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 850b8762e889..be19f4199727 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -419,7 +419,17 @@ xloadflags:
 # define XLF4 0
 #endif
 
-			.word XLF0 | XLF1 | XLF23 | XLF4
+#ifdef CONFIG_X86_64
+#ifdef CONFIG_X86_5LEVEL
+#define XLF56 (XLF_5LEVEL|XLF_5LEVEL_ENABLED)
+#else
+#define XLF56 XLF_5LEVEL
+#endif
+#else
+#define XLF56 0
+#endif
+
+			.word XLF0 | XLF1 | XLF23 | XLF4 | XLF56
 
 cmdline_size:   .long   COMMAND_LINE_SIZE-1     #length of the command line,
                                                 #added with boot protocol
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 60733f137e9a..c895df5482c5 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -29,6 +29,8 @@
 #define XLF_EFI_HANDOVER_32		(1<<2)
 #define XLF_EFI_HANDOVER_64		(1<<3)
 #define XLF_EFI_KEXEC			(1<<4)
+#define XLF_5LEVEL			(1<<5)
+#define XLF_5LEVEL_ENABLED		(1<<6)
 
 #ifndef __ASSEMBLY__
 
-- 
2.17.2

