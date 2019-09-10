Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9240C49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B4321881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 15:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405600AbfIJPS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 11:18:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:65400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfIJPS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 11:18:57 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE30318C4275;
        Tue, 10 Sep 2019 15:18:56 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-75.pek2.redhat.com [10.72.12.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCF64196B2;
        Tue, 10 Sep 2019 15:18:52 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        Dave Young <dyoung@redhat.com>, x86@kernel.org,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Kairui Song <kasong@redhat.com>
Subject: [PATCH v3 2/2] x86/kdump: Reserve extra memory when SME or SEV is active
Date:   Tue, 10 Sep 2019 23:13:41 +0800
Message-Id: <20190910151341.14986-3-kasong@redhat.com>
In-Reply-To: <20190910151341.14986-1-kasong@redhat.com>
References: <20190910151341.14986-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Tue, 10 Sep 2019 15:18:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit c7753208a94c ("x86, swiotlb: Add memory encryption support"),
SWIOTLB will be enabled even if there is less than 4G of memory when SME
is active, to support DMA of devices that not support address with the
encrypt bit.

And commit aba2d9a6385a ("iommu/amd: Do not disable SWIOTLB if SME is
active") make the kernel keep SWIOTLB enabled even if there is an IOMMU.

Then commit d7b417fa08d1 ("x86/mm: Add DMA support for SEV memory
encryption") will always force SWIOTLB to be enabled when SEV is active
in all cases.

Now, when either SME or SEV is active, SWIOTLB will be force enabled,
and this is also true for kdump kernel. As a result kdump kernel will
run out of already scarce pre-reserved memory easily.

So when SME/SEV is active, reserve extra memory for SWIOTLB to ensure
kdump kernel have enough memory, except when "crashkernel=size[KMG],high"
is specified or any offset is used. As for the high reservation case, an
extra low memory region will always be reserved and that is enough for
SWIOTLB. Else if the offset format is used, user should be fully aware
of any possible kdump kernel memory requirement and have to organize the
memory usage carefully.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/x86/kernel/setup.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 71f20bb18cb0..ee6a2f1e2226 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -530,7 +530,7 @@ static int __init crashkernel_find_region(unsigned long long *crash_base,
 					  unsigned long long *crash_size,
 					  bool high)
 {
-	unsigned long long base, size;
+	unsigned long long base, size, mem_enc_req = 0;
 
 	base = *crash_base;
 	size = *crash_size;
@@ -561,11 +561,25 @@ static int __init crashkernel_find_region(unsigned long long *crash_base,
 	if (high)
 		goto high_reserve;
 
+	/*
+	 * When SME/SEV is active and not using high reserve,
+	 * it will always required an extra SWIOTLB region.
+	 */
+	if (mem_encrypt_active())
+		mem_enc_req = ALIGN(swiotlb_size_or_default(), SZ_1M);
+
 	base = memblock_find_in_range(CRASH_ALIGN,
-				      CRASH_ADDR_LOW_MAX, size,
+				      CRASH_ADDR_LOW_MAX,
+				      size + mem_enc_req,
 				      CRASH_ALIGN);
-	if (base)
+	if (base) {
+		if (mem_enc_req) {
+			pr_info("Memory encryption is active, crashkernel needs %ldMB extra memory\n",
+				(unsigned long)(mem_enc_req >> 20));
+			size += mem_enc_req;
+		}
 		goto found;
+	}
 
 high_reserve:
 	/* Try high reserve */
-- 
2.21.0

