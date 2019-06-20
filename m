Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B0AC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA906205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 10:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xxHk8xXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731419AbfFTKCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 06:02:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44007 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730879AbfFTKCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 06:02:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5KA1qVg907457
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 20 Jun 2019 03:01:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5KA1qVg907457
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561024913;
        bh=M7GPgZsa7PhK3DrEQvFUD11F6DsGLRIeded88uI8Aak=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=xxHk8xXTQ8xxOPHSKGvp/B8MD+lZxVCrqQ6KxsILjLUjlFg8RY23XffZgPkxeakYN
         1Y0AhOjnlt3dh6G/vNzrkLN+T8+TbHiElEP3D2mR8ZW1Uqiui8AS794qz2SXN6vd49
         QeQHjiH/wcvABR42yJMpqEe4f31/EAcLXz3+JzKBS035nodBEISHo7jGAYAyZU3umQ
         VfNnu7HwijE7iJBFrv7QWllpAPJUWQW61mKQYcl/VBKk4pESVjOnSVO/MAoJAg00Qk
         Vs+MnUU2YdmeYy1RNMXgC+ArOMPbTZuLjocm4DWC9I35v+3/kZ8HZnbrlzhTxiYlZn
         NbQP0XeX0sP5g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5KA1qq8907450;
        Thu, 20 Jun 2019 03:01:52 -0700
Date:   Thu, 20 Jun 2019 03:01:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Lianbo Jiang <tipbot@zytor.com>
Message-ID: <tip-1a79c1b8a04153c4c387518967ce851f89e22733@git.kernel.org>
Cc:     lijiang@redhat.com, mingo@kernel.org, tglx@linutronix.de,
        bp@suse.de, akpm@linux-foundation.org, thomas.lendacky@amd.com,
        kirill.shutemov@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        brijesh.singh@amd.com, mingo@redhat.com
Reply-To: kirill.shutemov@linux.intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, x86@kernel.org,
          brijesh.singh@amd.com, mingo@redhat.com, lijiang@redhat.com,
          mingo@kernel.org, tglx@linutronix.de, akpm@linux-foundation.org,
          bp@suse.de, thomas.lendacky@amd.com
In-Reply-To: <20190430074421.7852-2-lijiang@redhat.com>
References: <20190430074421.7852-2-lijiang@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/kdump] x86/kexec: Do not map kexec area as decrypted when
 SEV is active
Git-Commit-ID: 1a79c1b8a04153c4c387518967ce851f89e22733
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

Commit-ID:  1a79c1b8a04153c4c387518967ce851f89e22733
Gitweb:     https://git.kernel.org/tip/1a79c1b8a04153c4c387518967ce851f89e22733
Author:     Lianbo Jiang <lijiang@redhat.com>
AuthorDate: Tue, 30 Apr 2019 15:44:19 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 20 Jun 2019 10:06:46 +0200

x86/kexec: Do not map kexec area as decrypted when SEV is active

When a virtual machine panics, its memory needs to be dumped for
analysis. With memory encryption in the picture, special care must be
taken when loading a kexec/kdump kernel in a SEV guest.

A SEV guest starts and runs fully encrypted. In order to load a kexec
kernel and initrd, arch_kexec_post_{alloc,free}_pages() need to not map
areas as decrypted unconditionally but differentiate whether the kernel
is running as a SEV guest and if so, leave kexec area encrypted.

 [ bp: Reduce commit message to the relevant information pertaining to
   this commit only. ]

Co-developed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: bhe@redhat.com
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: dyoung@redhat.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: kexec@lists.infradead.org
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190430074421.7852-2-lijiang@redhat.com
---
 arch/x86/kernel/machine_kexec_64.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index ceba408ea982..3b38449028e0 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -559,8 +559,20 @@ void arch_kexec_unprotect_crashkres(void)
 	kexec_mark_crashkres(false);
 }
 
+/*
+ * During a traditional boot under SME, SME will encrypt the kernel,
+ * so the SME kexec kernel also needs to be un-encrypted in order to
+ * replicate a normal SME boot.
+ *
+ * During a traditional boot under SEV, the kernel has already been
+ * loaded encrypted, so the SEV kexec kernel needs to be encrypted in
+ * order to replicate a normal SEV boot.
+ */
 int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
 {
+	if (sev_active())
+		return 0;
+
 	/*
 	 * If SME is active we need to be sure that kexec pages are
 	 * not encrypted because when we boot to the new kernel the
@@ -571,6 +583,9 @@ int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
 
 void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages)
 {
+	if (sev_active())
+		return;
+
 	/*
 	 * If SME is active we need to reset the pages back to being
 	 * an encrypted mapping before freeing them.
