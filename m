Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9358CC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 03:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697F02087B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 03:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfDUDz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 23:55:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48338 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfDUDzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 23:55:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3918C37EEF;
        Sun, 21 Apr 2019 03:55:55 +0000 (UTC)
Received: from localhost (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B6E15D9C9;
        Sun, 21 Apr 2019 03:55:53 +0000 (UTC)
X-Mailbox-Line: From dyoung@redhat.com Sun Apr 21 11:53:03 2019
Message-ID: <20190421035303.669870129@redhat.com>
User-Agent: quilt/0.66
Date:   Sun, 21 Apr 2019 11:51:00 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, vgoyal@redhat.com, bhe@redhat.com,
        piliu@redhat.com, Yinghai Lu <yinghai@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH 2/2] X86/kdump: fall back to reserve high crashkernel memory
References: <20190421035058.943630505@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sun, 21 Apr 2019 03:55:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crashkernel=xM tries to reserve crashkernel memory under 4G, which
is enough for usual cases.  But this could fail sometimes, for example
one tries to reserve a big chunk like 2G, it is possible to fail.

So let the crashkernel=xM just fall back to use high memory in case it
fails to find a suitable low range.  Do not set the ,high as default
because it allocs extra low memory for DMA buffers and swiotlb, this is
not always necessary for all machines. Typically like crashkernel=128M
usually work with low reservation under 4G, so still keep <4G as default.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt |    7 +++++--
 arch/x86/kernel/setup.c                         |   22 ++++++++++++++--------
 2 files changed, 19 insertions(+), 10 deletions(-)

--- linux-x86.orig/arch/x86/kernel/setup.c
+++ linux-x86/arch/x86/kernel/setup.c
@@ -541,21 +541,27 @@ static void __init reserve_crashkernel(v
 	}
 
 	/* 0 means: find the address automatically */
-	if (crash_base <= 0) {
+	if (!crash_base) {
 		/*
 		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
-		 * as old kexec-tools loads bzImage below that, unless
-		 * "crashkernel=size[KMG],high" is specified.
+		 * as crashkernel=x,high allocs memory over 4G, also allocs
+		 * 256M extra low memory for DMA buffers and swiotlb.
+		 * but the extra memory is not required for all machines.
+		 * So prefer low memory first, and fallback to high memory
+		 * unless "crashkernel=size[KMG],high" is specified.
 		 */
-		crash_base = memblock_find_in_range(CRASH_ALIGN,
-						    high ? CRASH_ADDR_HIGH_MAX
-							 : CRASH_ADDR_LOW_MAX,
-						    crash_size, CRASH_ALIGN);
+		if (!high)
+			crash_base = memblock_find_in_range(CRASH_ALIGN,
+						CRASH_ADDR_LOW_MAX,
+						crash_size, CRASH_ALIGN);
+		if (!crash_base)
+			crash_base = memblock_find_in_range(CRASH_ALIGN,
+						CRASH_ADDR_HIGH_MAX,
+						crash_size, CRASH_ALIGN);
 		if (!crash_base) {
 			pr_info("crashkernel reservation failed - No suitable area found.\n");
 			return;
 		}
-
 	} else {
 		unsigned long long start;
 
--- linux-x86.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-x86/Documentation/admin-guide/kernel-parameters.txt
@@ -704,8 +704,11 @@
 			upon panic. This parameter reserves the physical
 			memory region [offset, offset + size] for that kernel
 			image. If '@offset' is omitted, then a suitable offset
-			is selected automatically. Check
-			Documentation/kdump/kdump.txt for further details.
+			is selected automatically.
+			[KNL, x86_64] select a region under 4G first, and
+			fallback to reserve region above 4G in case without
+			'@offset'.
+			See Documentation/kdump/kdump.txt for further details.
 
 	crashkernel=range1:size1[,range2:size2,...][@offset]
 			[KNL] Same as above, but depends on the memory


