Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE9BC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D3C20835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfD3Hov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 03:44:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfD3Hou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 03:44:50 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 74112811A9;
        Tue, 30 Apr 2019 07:44:50 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-43.pek2.redhat.com [10.72.12.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD13188EB;
        Tue, 30 Apr 2019 07:44:41 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, akpm@linux-foundation.org, x86@kernel.org,
        hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com, brijesh.singh@amd.com
Subject: [PATCH 1/3 v3] x86/kexec: Do not map the kexec area as decrypted when SEV is active
Date:   Tue, 30 Apr 2019 15:44:19 +0800
Message-Id: <20190430074421.7852-2-lijiang@redhat.com>
In-Reply-To: <20190430074421.7852-1-lijiang@redhat.com>
References: <20190430074421.7852-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 30 Apr 2019 07:44:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a virtual machine panic, also need to dump its memory for analysis.
But, for the SEV virtual machine, the memory is encrypted. To support
the SEV kdump, these changes would be necessary, otherwise, it will not
work.

Lets consider the following situations:

[1] How to load the images(kernel and initrd) when SEV is enabled in the
    first kernel?

    Based on the amd-memory-encryption.txt and SEV's patch series, the
    boot images must be encrypted before guest(VM) can be booted(Please
    see Secure Encrypted Virutualization Key Management 'Launching a
    guest(usage flow)'). Naturally use the similar way to load the images
    (kernel and initrd) to the crash reserved areas, and these areas are
    encrypted when SEV is active.

    That is to say, when SEV is active in the first kernel, need to load
    the kernel and initrd to the encrypted areas, so i made the following
    changes:

    [a] Do not map the kexec area as decrypted when SEV is active.
        Currently, the arch_kexec_post_{alloc,free}_pages() unconditionally
        maps the kexec areas as decrypted. Obviously, for the SEV case, it
        can not work well, need to improve them.

    [b] Set the C-bit in the identity map page table when SEV is active.
        Because the second kernel images(kernel and initrd) are loaded to
        the encrypted areas, in order to correctly access these encrypted
        memory(pages), need to set the C-bit in the identity mapping page
        table when kexec builds the identity mapping page table.

[2] How to dump the old memory in the second kernel?

    Here, it is similar to the SME kdump, if SEV was enabled in the first
    kernel, the old memory is also encrypted, the old memory has to be
    remapped with memory encryption mask in order to access it properly.

    [a] The ioremap_encrypted() is still necessary.
        Used to remap the old memory with memory encryption mask.

    [b] Enable dumping encrypted memory when SEV was active.
        Because the whole memory is encrypted in the first kernel when SEV
        is enabled, that is to say, the notes and elfcorehdr are also
        encrypted, and they are also saved to the encrypted memory.
        Following commit 992b649a3f01 ("kdump, proc/vmcore: Enable kdumping
        encrypted memory with SME enabled"), both SME and SEV cases need to
        be considered and modified correctly.

As above mentioned, currently, the arch_kexec_post_{alloc,free}_pages()
unconditionally maps the kexec area as decrypted. Lets make sure that
arch_kexec_post_{alloc,free}_pages() does not clear the memory encryption
mask from the kexec area when SEV is active.

Co-developed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index ceba408ea982..f60611531d17 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -559,18 +559,33 @@ void arch_kexec_unprotect_crashkres(void)
 	kexec_mark_crashkres(false);
 }
 
+/*
+ * During a traditional boot under SME, SME will encrypt the kernel,
+ * so the SME kexec kernel also needs to be un-encrypted in order to
+ * replicate a normal SME boot.
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
 	 * pages won't be accessed encrypted (initially).
 	 */
 	return set_memory_decrypted((unsigned long)vaddr, pages);
+
 }
 
 void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages)
 {
+	if (sev_active())
+		return;
+
 	/*
 	 * If SME is active we need to reset the pages back to being
 	 * an encrypted mapping before freeing them.
-- 
2.17.1

