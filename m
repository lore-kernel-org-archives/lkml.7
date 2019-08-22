Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1E3C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDA621726
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y+9S9KAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbfHVH7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 03:59:04 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:20003 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731019AbfHVH67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 03:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566460739; x=1597996739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8phmIoE0V9/kOpVUv4HvROJtbVLacwF1vHNNlNefEhM=;
  b=Y+9S9KAoRuLCHYqBNSe6btK4FFi7DgjeOXb9tUEnmbVIkFDkK+2/AFKG
   eLy4QU+LIWHAtLGHQU1ZW3eG5tQ4ki81I34RVECQsEuoglNUA/3JLlz7U
   m9Hx3ujUq57LessR3AyBqqBbNEWZR9ELws5Ncf2uucQ9dwhEudslJIktP
   dy6LR+XfLQ1eMPdllHzi+0o0dqMRnxgoVxAcGH5z8hA2DkoiBhgTgHM1Y
   ayfvcpxAQMKbyBH0JZAY962Z29c/LcZGCMlaBPw2LiP/liiOjE/H00B8k
   sZDCMQt33uY1W6E6sgnTWq9QREIz+0wqn/XtTJQ7KPDkjeEdVOyCRwdA8
   Q==;
IronPort-SDR: AK3GUitXrROvlKPLM10m6FeksFpZWnZ0rozC+VxprfBdJ79Q9+nZTDqkp34ariyKOA0A3JFGAn
 aQbjgEbvE44P/+1MQiQulIPb0Yevtgs68CLtoo969flCb9ocI3pnZRNsW3jp9GuPX3uczuqGyE
 +a5tQ1obULVyMeAX6SMOo94VNETQGoyoqPp5SDU/gF5Z6XLPc2bwEboTdeyIRXR0tdXKSaKdYh
 Qn2FYq25dzc/luLwxhvKg61c6QbiWEzdUTZCUg0N2LBGvZVjTNih/RXhfePGdJ5MI6vdc4yjC/
 Pn8=
X-IronPort-AV: E=Sophos;i="5.64,415,1559491200"; 
   d="scan'208";a="116397482"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2019 15:58:59 +0800
IronPort-SDR: NdDRvRVEfnFuy3SuGPxVuUt0RGQAv0zWICK1t51mwiGyJSOelfCLDAq5jnWC3z357lcKuHP8Jg
 YayzV8es1mS/1czfY+Nup9hHvOVIT0H+4dBHiB3vBNCS5wBszxcbgGeo576/xs5UKTAv6ooAj5
 aRbkZIrcW3Ept2038VSMXwuQEBhu5wIqsGW5tWi819pCUiz+2z9zL3PEkOThz2vngXwmaNTrN2
 92wC1E65i2TDN6//oXCwh0OjOW28qArRfX0RgpWcUWehtWGazSL8T0M20/7A5DiUP4JYxFhLoC
 ND2Pk7trd30fRbojQGcDJ0+R
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 00:56:19 -0700
IronPort-SDR: NyAzBNUkbXZSDc3CCgXO4invnzF3pGfNKGTLFadKLNzd3Ur7CPuE7ulisiOMKLtzfBDYC9RyG2
 LMaHafEx98U1VaOYEcC0cnvWNpqWA0FB3j4/VMAC1q8O6EemE5bv+FgKtERY0oa9WJzNeyKU+Z
 g8DVracyX2mKSutvG8FA+QR0bcfzMFM12hYAGW4KAyYhJEzizxfuokO7UPLqF/iodhLhAxJD1Q
 5JaglGPag+ntRC2KrnYzUYenP7GCEmKCBCxy07yj4eWOlbfQVNbYp9LH3jeXttyGBwMbWYuITv
 PYQ=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Aug 2019 00:58:59 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@lst.de>, Anup Patel <Anup.Patel@wdc.com>
Subject: [PATCH v4 2/3] RISC-V: Issue a local tlbflush if possible.
Date:   Thu, 22 Aug 2019 00:51:50 -0700
Message-Id: <20190822075151.24838-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822075151.24838-1-atish.patra@wdc.com>
References: <20190822075151.24838-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In RISC-V, tlb flush happens via SBI which is expensive. If the local
cpu is the only cpu in cpumask, there is no need to invoke a SBI call.

Just do a local flush and return.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/mm/tlbflush.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 1293b8017ee0..8172fbf46123 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -2,6 +2,7 @@
 
 #include <linux/mm.h>
 #include <linux/smp.h>
+#include <linux/sched.h>
 #include <asm/sbi.h>
 
 void flush_tlb_all(void)
@@ -9,16 +10,30 @@ void flush_tlb_all(void)
 	sbi_remote_sfence_vma(NULL, 0, -1);
 }
 
+/*
+ * This function must not be called with cmask being null.
+ * Kernel may panic if cmask is NULL.
+ */
 static void __sbi_tlb_flush_range(struct cpumask *cmask, unsigned long start,
 		unsigned long size)
 {
 	struct cpumask hmask;
+	unsigned int cpuid;
 
 	if (cpumask_empty(cmask))
 		return;
 
-	riscv_cpuid_to_hartid_mask(cmask, &hmask);
-	sbi_remote_sfence_vma(hmask.bits, start, size);
+	cpuid = get_cpu();
+
+	if (cpumask_any_but(cmask, cpuid) >= nr_cpu_ids) {
+		/* local cpu is the only cpu present in cpumask */
+		local_flush_tlb_all();
+	} else {
+		riscv_cpuid_to_hartid_mask(cmask, &hmask);
+		sbi_remote_sfence_vma(cpumask_bits(&hmask), start, size);
+	}
+
+	put_cpu();
 }
 
 void flush_tlb_mm(struct mm_struct *mm)
-- 
2.21.0

