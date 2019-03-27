Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C4BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4CC2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732499AbfC0Fgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:36:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfC0Fgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:36:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 40C8037E8B;
        Wed, 27 Mar 2019 05:36:54 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-53.pek2.redhat.com [10.72.12.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09FD65C640;
        Wed, 27 Mar 2019 05:36:45 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, akpm@linux-foundation.org, x86@kernel.org,
        hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com, brijesh.singh@amd.com
Subject: [PATCH 1/3 v2] x86/kexec: Do not map the kexec area as decrypted when SEV is active
Date:   Wed, 27 Mar 2019 13:36:27 +0800
Message-Id: <20190327053629.17935-2-lijiang@redhat.com>
In-Reply-To: <20190327053629.17935-1-lijiang@redhat.com>
References: <20190327053629.17935-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 27 Mar 2019 05:36:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the arch_kexec_post_{alloc,free}_pages() unconditionally
maps the kexec area as decrypted. This works fine when SME is active.
Because in SME, the first kernel is loaded in decrypted area by the
BIOS, so the second kernel must be also loaded into the decrypted
memory.

When SEV is active, the first kernel is loaded into the encrypted
area, so the second kernel must be also loaded into the encrypted
memory. Lets make sure that arch_kexec_post_{alloc,free}_pages()
does not clear the memory encryption mask from the kexec area when
SEV is active.

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

