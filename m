Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BFBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B1C218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257311;
	bh=oSCveWRf0n+ygoLavqxzh0UXlrl6IiiT9g5knvyb/RQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PlAMFKeQjlQLniqtvFyez8NOsosc/3w3MRdOIArkWZrlgnIN+ZL17vCvrRuTm4MGc
	 iJ9mkxvE3cuUl+aHeZTOVM+T4zBEg8GaCdzUITzx1ajoQ9vjW5FLS38HnieDPS6K8b
	 AwQkh34z0hjctXHXvuAxsZo8fYasQULVvPJt7fl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390918AbfCVMVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390737AbfCVMVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:21:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 648032054F;
        Fri, 22 Mar 2019 12:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257305;
        bh=oSCveWRf0n+ygoLavqxzh0UXlrl6IiiT9g5knvyb/RQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fQ+s+sz/Y8ZRvaAJqBUI8ZKIem8/dimgNK6DIE5i2W6A4dkBZWz8Wu9g6pobnyAJH
         vThxuvWxoBHcbY9Vux0LapSS8mGjSWxjIFhtCc+0EdtUZQqSak5AR9rJUXtr/g5rZo
         6JTdWxhE3DuTKWOzLnxIy8bFYFum4i/+dUDLdfDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell Currey <ruscur@russell.cc>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 5.0 160/238] powerpc/kvm: Save and restore host AMR/IAMR/UAMOR
Date:   Fri, 22 Mar 2019 12:16:19 +0100
Message-Id: <20190322111307.740167373@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

commit c3c7470c75566a077c8dc71dcf8f1948b8ddfab4 upstream.

When the hash MMU is active the AMR, IAMR and UAMOR are used for
pkeys. The AMR is directly writable by user space, and the UAMOR masks
those writes, meaning both registers are effectively user register
state. The IAMR is used to create an execute only key.

Also we must maintain the value of at least the AMR when running in
process context, so that any memory accesses done by the kernel on
behalf of the process are correctly controlled by the AMR.

Although we are correctly switching all registers when going into a
guest, on returning to the host we just write 0 into all regs, except
on Power9 where we restore the IAMR correctly.

This could be observed by a user process if it writes the AMR, then
runs a guest and we then return immediately to it without
rescheduling. Because we have written 0 to the AMR that would have the
effect of granting read/write permission to pages that the process was
trying to protect.

In addition, when using the Radix MMU, the AMR can prevent inadvertent
kernel access to userspace data, writing 0 to the AMR disables that
protection.

So save and restore AMR, IAMR and UAMOR.

Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
Cc: stable@vger.kernel.org # v4.16+
Signed-off-by: Russell Currey <ruscur@russell.cc>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -58,6 +58,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 #define STACK_SLOT_DAWR		(SFS-56)
 #define STACK_SLOT_DAWRX	(SFS-64)
 #define STACK_SLOT_HFSCR	(SFS-72)
+#define STACK_SLOT_AMR		(SFS-80)
+#define STACK_SLOT_UAMOR	(SFS-88)
 /* the following is used by the P9 short path */
 #define STACK_SLOT_NVGPRS	(SFS-152)	/* 18 gprs */
 
@@ -726,11 +728,9 @@ BEGIN_FTR_SECTION
 	mfspr	r5, SPRN_TIDR
 	mfspr	r6, SPRN_PSSCR
 	mfspr	r7, SPRN_PID
-	mfspr	r8, SPRN_IAMR
 	std	r5, STACK_SLOT_TID(r1)
 	std	r6, STACK_SLOT_PSSCR(r1)
 	std	r7, STACK_SLOT_PID(r1)
-	std	r8, STACK_SLOT_IAMR(r1)
 	mfspr	r5, SPRN_HFSCR
 	std	r5, STACK_SLOT_HFSCR(r1)
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
@@ -738,11 +738,18 @@ BEGIN_FTR_SECTION
 	mfspr	r5, SPRN_CIABR
 	mfspr	r6, SPRN_DAWR
 	mfspr	r7, SPRN_DAWRX
+	mfspr	r8, SPRN_IAMR
 	std	r5, STACK_SLOT_CIABR(r1)
 	std	r6, STACK_SLOT_DAWR(r1)
 	std	r7, STACK_SLOT_DAWRX(r1)
+	std	r8, STACK_SLOT_IAMR(r1)
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
 
+	mfspr	r5, SPRN_AMR
+	std	r5, STACK_SLOT_AMR(r1)
+	mfspr	r6, SPRN_UAMOR
+	std	r6, STACK_SLOT_UAMOR(r1)
+
 BEGIN_FTR_SECTION
 	/* Set partition DABR */
 	/* Do this before re-enabling PMU to avoid P7 DABR corruption bug */
@@ -1631,22 +1638,25 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_3
 	mtspr	SPRN_PSPB, r0
 	mtspr	SPRN_WORT, r0
 BEGIN_FTR_SECTION
-	mtspr	SPRN_IAMR, r0
 	mtspr	SPRN_TCSCR, r0
 	/* Set MMCRS to 1<<31 to freeze and disable the SPMC counters */
 	li	r0, 1
 	sldi	r0, r0, 31
 	mtspr	SPRN_MMCRS, r0
 END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
-8:
 
-	/* Save and reset AMR and UAMOR before turning on the MMU */
+	/* Save and restore AMR, IAMR and UAMOR before turning on the MMU */
+	ld	r8, STACK_SLOT_IAMR(r1)
+	mtspr	SPRN_IAMR, r8
+
+8:	/* Power7 jumps back in here */
 	mfspr	r5,SPRN_AMR
 	mfspr	r6,SPRN_UAMOR
 	std	r5,VCPU_AMR(r9)
 	std	r6,VCPU_UAMOR(r9)
-	li	r6,0
-	mtspr	SPRN_AMR,r6
+	ld	r5,STACK_SLOT_AMR(r1)
+	ld	r6,STACK_SLOT_UAMOR(r1)
+	mtspr	SPRN_AMR, r5
 	mtspr	SPRN_UAMOR, r6
 
 	/* Switch DSCR back to host value */
@@ -1746,11 +1756,9 @@ BEGIN_FTR_SECTION
 	ld	r5, STACK_SLOT_TID(r1)
 	ld	r6, STACK_SLOT_PSSCR(r1)
 	ld	r7, STACK_SLOT_PID(r1)
-	ld	r8, STACK_SLOT_IAMR(r1)
 	mtspr	SPRN_TIDR, r5
 	mtspr	SPRN_PSSCR, r6
 	mtspr	SPRN_PID, r7
-	mtspr	SPRN_IAMR, r8
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 
 #ifdef CONFIG_PPC_RADIX_MMU


