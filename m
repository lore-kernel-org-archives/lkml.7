Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA267C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CC82086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qgslE7PZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfF1FUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 01:20:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54297 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfF1FUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 01:20:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5S5J9pR614360
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 22:19:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5S5J9pR614360
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561699149;
        bh=bnmvHwU0aWg4HT0nhCYsqvndUIFruUlOHrPfoxl2C7Q=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=qgslE7PZZ2p3XBXfMJXeuN7ajUpJ/RnEUfX594kyNbnInG44gpw0DpIdna2sc2D9U
         uszfrn2tOn8xZWNVB3+1lE6TY72gepGIk3a0wzBVgenT2YuUptB2p4kUreY3cB4y4G
         5GUxRC5SipJjL6+DmDr5W4qhXpEib1SuM4fCmpMD+ioNkUX2xD+b5+mw4J7kuLqSBc
         heknjpCkIpxEpttnFi5blxhBqZbsM0mH+4m1gT4h1IzZIfh0qWmohxV/h2IciRSJst
         SnCqwjWaNCDxCjsue/BLd3FcxKq5nezCABxGYl0kpvAttV4eSJtK/BqMZbO40ut1rO
         4pegWAUlV30GQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5S5J8f3614357;
        Thu, 27 Jun 2019 22:19:08 -0700
Date:   Thu, 27 Jun 2019 22:19:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Baoquan He <tipbot@zytor.com>
Message-ID: <tip-f2d08c5d3bcf3f7ef788af122b57a919efa1e9d0@git.kernel.org>
Cc:     hpa@zytor.com, kirill.shutemov@linux.intel.com, bhe@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, bhe@redhat.com,
          kirill.shutemov@linux.intel.com, hpa@zytor.com
In-Reply-To: <20190524073810.24298-2-bhe@redhat.com>
References: <20190524073810.24298-2-bhe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot: Add xloadflags bits to check for 5-level
 paging support
Git-Commit-ID: f2d08c5d3bcf3f7ef788af122b57a919efa1e9d0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f2d08c5d3bcf3f7ef788af122b57a919efa1e9d0
Gitweb:     https://git.kernel.org/tip/f2d08c5d3bcf3f7ef788af122b57a919efa1e9d0
Author:     Baoquan He <bhe@redhat.com>
AuthorDate: Fri, 24 May 2019 15:38:08 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 07:14:59 +0200

x86/boot: Add xloadflags bits to check for 5-level paging support

The current kernel supports 5-level paging mode, and supports dynamically
choosing the paging mode during bootup depending on the kernel image,
hardware and kernel parameter settings. This flexibility brings several
issues to kexec/kdump:

1) Dynamic switching between paging modes requires support in the target
   kernel. This means kexec from a 5-level paging kernel into a kernel
   which does not support mode switching is not possible. So the loader
   needs to be able to analyze the supported paging modes of the kexec
   target kernel.

2) If running on a 5-level paging kernel and the kexec target kernel is a
   4-level paging kernel, the target immage cannot be loaded above the 64TB
   address space limit. But the kexec loader searches for a load area from
   top to bottom which would eventually put the target kernel above 64TB
   when the machine has large enough RAM size. So the loader needs to be
   able to analyze the paging mode of the target kernel to load it at a
   suitable spot in the address space.

Solution:

Add two bits XLF_5LEVEL and XLF_5LEVEL_ENABLED:

 - Bit XLF_5LEVEL indicates whether 5-level paging mode switching support
   is available. (Issue #1)

 - Bit XLF_5LEVEL_ENABLED indicates whether the kernel was compiled with
   full 5-level paging support (CONFIG_X86_5LEVEL=y). (Issue #2)

The loader will use these bits to verify whether the target kernel is
suitable to be kexec'ed to from a 5-level paging kernel and to determine
the constraints of the target kernel load address.

The flags will be used by the kernel kexec subsystem and the userspace
kexec tools.

[ tglx: Massaged changelog ]

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: dyoung@redhat.com
Link: https://lkml.kernel.org/r/20190524073810.24298-2-bhe@redhat.com

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
 
