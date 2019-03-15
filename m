Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4157C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDA321872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfCOKce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:32:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728676AbfCOKce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:32:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D11D630842A0;
        Fri, 15 Mar 2019 10:32:33 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-223.pek2.redhat.com [10.72.12.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 953665C21F;
        Fri, 15 Mar 2019 10:32:19 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        akpm@linux-foundation.org, dyoung@redhat.com,
        brijesh.singh@amd.com, thomas.lendacky@amd.com, bhe@redhat.com
Subject: [PATCH 1/3] kexec: Do not map the kexec area as decrypted when SEV is active
Date:   Fri, 15 Mar 2019 18:32:01 +0800
Message-Id: <20190315103203.13128-2-lijiang@redhat.com>
In-Reply-To: <20190315103203.13128-1-lijiang@redhat.com>
References: <20190315103203.13128-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 15 Mar 2019 10:32:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the arch_kexec_post_{alloc,free}_pages unconditionally
maps the kexec area as decrypted. This works fine when SME is active.
Because in SME, the first kernel is loaded in decrypted area by the
BIOS, so the second kernel must be also loaded into the decrypted
memory.

When SEV is active, the first kernel is loaded into the encrypted
area, so the second kernel must be also loaded into the encrypted
memory. Lets make sure that arch_kexec_post_{alloc,free}_pages does
not clear the memory encryption mask from the kexec area when SEV
is active.

Co-developed-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index ceba408ea982..bcebf4993da4 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -566,7 +566,10 @@ int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
 	 * not encrypted because when we boot to the new kernel the
 	 * pages won't be accessed encrypted (initially).
 	 */
-	return set_memory_decrypted((unsigned long)vaddr, pages);
+	if (sme_active())
+		return set_memory_decrypted((unsigned long)vaddr, pages);
+
+	return 0;
 }
 
 void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages)
@@ -575,5 +578,6 @@ void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages)
 	 * If SME is active we need to reset the pages back to being
 	 * an encrypted mapping before freeing them.
 	 */
-	set_memory_encrypted((unsigned long)vaddr, pages);
+	if (sme_active())
+		set_memory_encrypted((unsigned long)vaddr, pages);
 }
-- 
2.17.1

