Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DF7C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 04:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549CD217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 04:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfHZEqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 00:46:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbfHZEqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 00:46:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F50C8980E7;
        Mon, 26 Aug 2019 04:45:59 +0000 (UTC)
Received: from wlc-trust-99.pek2.redhat.com (wlc-trust-99.pek2.redhat.com [10.72.3.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F18366092D;
        Mon, 26 Aug 2019 04:45:52 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        Dave Young <dyoung@redhat.com>, x86@kernel.org,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Kairui Song <kasong@redhat.com>
Subject: [PATCH v2] x86/kdump: Reserve extra memory when SME or SEV is active
Date:   Mon, 26 Aug 2019 12:45:35 +0800
Message-Id: <20190826044535.9646-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Mon, 26 Aug 2019 04:45:59 +0000 (UTC)
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
Update from V1:
- Use mem_encrypt_active() instead of "sme_active() || sev_active()"
- Don't reserve extra memory when ",high" or "@offset" is used, and
  don't print redundant message.
- Fix coding style problem

 arch/x86/kernel/setup.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index bbe35bf879f5..221beb10c55d 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -528,7 +528,7 @@ static int __init reserve_crashkernel_low(void)
 
 static void __init reserve_crashkernel(void)
 {
-	unsigned long long crash_size, crash_base, total_mem;
+	unsigned long long crash_size, crash_base, total_mem, mem_enc_req;
 	bool high = false;
 	int ret;
 
@@ -550,6 +550,15 @@ static void __init reserve_crashkernel(void)
 		return;
 	}
 
+	/*
+	 * When SME/SEV is active, it will always required an extra SWIOTLB
+	 * region.
+	 */
+	if (mem_encrypt_active())
+		mem_enc_req = ALIGN(swiotlb_size_or_default(), SZ_1M);
+	else
+		mem_enc_req = 0;
+
 	/* 0 means: find the address automatically */
 	if (!crash_base) {
 		/*
@@ -563,11 +572,19 @@ static void __init reserve_crashkernel(void)
 		if (!high)
 			crash_base = memblock_find_in_range(CRASH_ALIGN,
 						CRASH_ADDR_LOW_MAX,
-						crash_size, CRASH_ALIGN);
-		if (!crash_base)
+						crash_size + mem_enc_req,
+						CRASH_ALIGN);
+		/*
+		 * For high reservation, an extra low memory for SWIOTLB will
+		 * always be reserved later, so no need to reserve extra
+		 * memory for memory encryption case here.
+		 */
+		if (!crash_base) {
+			mem_enc_req = 0;
 			crash_base = memblock_find_in_range(CRASH_ALIGN,
 						CRASH_ADDR_HIGH_MAX,
 						crash_size, CRASH_ALIGN);
+		}
 		if (!crash_base) {
 			pr_info("crashkernel reservation failed - No suitable area found.\n");
 			return;
@@ -575,6 +592,7 @@ static void __init reserve_crashkernel(void)
 	} else {
 		unsigned long long start;
 
+		mem_enc_req = 0;
 		start = memblock_find_in_range(crash_base,
 					       crash_base + crash_size,
 					       crash_size, 1 << 20);
@@ -583,6 +601,13 @@ static void __init reserve_crashkernel(void)
 			return;
 		}
 	}
+
+	if (mem_enc_req) {
+		pr_info("Memory encryption is active, crashkernel needs %ldMB extra memory\n",
+			(unsigned long)(mem_enc_req >> 20));
+		crash_size += mem_enc_req;
+	}
+
 	ret = memblock_reserve(crash_base, crash_size);
 	if (ret) {
 		pr_err("%s: Error reserving crashkernel memblock.\n", __func__);
-- 
2.21.0

