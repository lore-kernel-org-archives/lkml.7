Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2FDCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D13222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 13:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="FpmV4qqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442852AbfJRNlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:41:11 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:32393 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfJRNlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 09:41:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 751663F4AF;
        Fri, 18 Oct 2019 15:41:07 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=FpmV4qqT;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id buQpfwo97A_c; Fri, 18 Oct 2019 15:41:05 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 494433F867;
        Fri, 18 Oct 2019 15:41:04 +0200 (CEST)
Received: from localhost.localdomain.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id E2BEB360741;
        Fri, 18 Oct 2019 15:41:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1571406064; bh=gl7W232z/O8M5IoKIAI0qxKeRjBB7lpxVaLyW+A6cJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FpmV4qqToKu/OODpbMKvjk/Ks8ID58YsBebTf0WqQagrxV2ql69Ec+z/eNCgKMFsN
         07jhvs9OvyDHIJ31uPngdfPEutqolyjG8iXv+VriuxsIweToBdLKr2m79qLimUDB3x
         WlDikF04PrJNkDAFB7QukosqijcdsMy60pBR+EPg=
From:   =?UTF-8?q?Thomas=20Hellstr=C3=B6m=20=28VMware=29?= 
        <thomas_os@shipmail.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux@googlegroups.com,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 1/2] x86/cpu/vmware: Use the full form of INL in VMWARE_HYPERCALL
Date:   Fri, 18 Oct 2019 15:40:51 +0200
Message-Id: <20191018134052.3023-2-thomas_os@shipmail.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191018134052.3023-1-thomas_os@shipmail.org>
References: <20191018134052.3023-1-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hellstrom <thellstrom@vmware.com>

LLVM's assembler doesn't accept the short form INL instruction:

  inl (%%dx)

but instead insists on the output register to be explicitly specified.

This was previously fixed for the VMWARE_PORT macro. Fix it also for
the VMWARE_HYPERCALL macro.

Fixes: b4dd4f6e3648 ("Add a header file for hypercall definitions")
Suggested-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
Cc: clang-built-linux@googlegroups.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/vmware.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index e00c9e875933..f5fbe3778aef 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -29,7 +29,8 @@
 
 /* The low bandwidth call. The low word of edx is presumed clear. */
 #define VMWARE_HYPERCALL						\
-	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT ", %%dx; inl (%%dx)", \
+	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT			\
+		      ", %%dx; inl (%%dx), %%eax",			\
 		      "vmcall", X86_FEATURE_VMCALL,			\
 		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
 
-- 
2.21.0

