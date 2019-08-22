Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10043C3A5A0
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77DD22DD3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KmyX33VL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbfHVAqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 20:46:47 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:34532 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729959AbfHVAqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566434912; x=1597970912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dc8CWzo9n0Qcuo3KBA83ogvDOo4Pn0dNrAEn4x3C39Y=;
  b=KmyX33VL0Hrc96lBiAYmaNstUE2Zkcmp6I4S5F5d4fFJDYp9zsJ9BqO8
   NgL9b48WRgxvVNrdDtMIH7q2DbnTuAMB3An6gOnXwRecQnHhCj8/tk5M3
   4wX4Ii74K5i6l1jiYMPXbkcCCUPALaMjvZJz5xptJAXuFf4RsavsG6nNO
   L9nn2leQuhkdvFvgmMwuPCLaXRSva2xN4+Bfs5BNmYQHEH+sIcXTQJdac
   jsahD7a+S1Rgf5CWOklg9BRwj8jaFUhVkt0T/ux2lTfa9syXkpn5Y3jE1
   K/Svw5Ok7mNGG8A6q/sz/AVmfsE7STPjbrPuvTWs5DXcTyirfBCF796nN
   g==;
IronPort-SDR: CCBGAt2ZWTRSjt0XvSBOr3TWCuciIrM4Tlx4qneWL0tusUituzUjwNHE+Ndya0JtXwtyZxhDt4
 vKeOoHh/6ismfz3S0hDHQLf7IG7rruTZ/qme0C6L5V9nz/4BIejr1zc1hMAegGAx7fnQasSyPV
 v1iAQ7ygPIJwRDwM3rAjLLCUCss8ipbZsmfajKl1JlT5R6Y88OuPXtoiVWbIaBiZ3wZ5uFmwjG
 2DIDGA03gh9Ab1cyDF+FnXBPktHyThq2pdLmTy/nocdZ1CA9qiHsDPskQvoBD6lX8UP1g19cGm
 7s8=
X-IronPort-AV: E=Sophos;i="5.64,414,1559491200"; 
   d="scan'208";a="216804435"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2019 08:48:31 +0800
IronPort-SDR: 0fNsv38YaDBbY8ZH+03mSnEyDRakFjPrH4Q0S9jWSv/9REKX/i9J865Vu11N/nlY4j58EnnYnt
 oNNYPwsnQn00lIpvu+Oeg8JMVs0BJkvqbAUW4Qu9j/nw9JTWaJGJYVfd7EDNgIVOD5mkoTVoHg
 f7RseMVvZyBuaTD2BuNQxwM1/Y61nyj7jUikJ9nXZShLlYtJKdW8iiuMlcbS44hmbhkQr9G/Q4
 opvjp5bNBVJviOjCuaSsmEY1+1uD5vX2PqhRz+hewdsoIOlZQb4jxrK4CdU0UXCOHrcCHXUkQX
 b2Jccn2qLYewaawTbwF/a+6u
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 17:44:05 -0700
IronPort-SDR: K6C88eai+9nEsr+QmFtqCIfF3a0criYQcYq3mHZZ3xxksUkCfr2YySl9AbHVCM57uQ6msb+dVC
 j79MQ1hMD/OOjLr4e3ax8hRxpLMlU0QHV6VhB8U+KMUW1bbEAue0oeN2fX0MiNc5KM3kODsObA
 Ijq/o4JEBChVG+uJfuU39wARr6qvaejl49x6IjakcY9IxlKLAN61fkeeuzPOsQ+O0EiLw4fuA/
 Sxn0+Wn8l2Z63AmV/nB/LCN9T4jlUcZl5yiaCAgPlvnJJ8H70DrL8xnZdVOFKOq9M/AkcOkgm3
 6qQ=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2019 17:46:45 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <Anup.Patel@wdc.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH v3 1/3] RISC-V: Issue a local tlbflush if possible.
Date:   Wed, 21 Aug 2019 17:46:42 -0700
Message-Id: <20190822004644.25829-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822004644.25829-1-atish.patra@wdc.com>
References: <20190822004644.25829-1-atish.patra@wdc.com>
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
 arch/riscv/mm/tlbflush.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index df93b26f1b9d..36430ee3bed9 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -2,6 +2,7 @@
 
 #include <linux/mm.h>
 #include <linux/smp.h>
+#include <linux/sched.h>
 #include <asm/sbi.h>
 
 void flush_tlb_all(void)
@@ -13,9 +14,23 @@ static void __sbi_tlb_flush_range(struct cpumask *cmask, unsigned long start,
 		unsigned long size)
 {
 	struct cpumask hmask;
+	unsigned int cpuid = get_cpu();
 
+	if (!cmask) {
+		riscv_cpuid_to_hartid_mask(cpu_online_mask, &hmask);
+		goto issue_sfence;
+	}
+
+	if (cpumask_test_cpu(cpuid, cmask) && cpumask_weight(cmask) == 1) {
+		local_flush_tlb_all();
+		goto done;
+	}
 	riscv_cpuid_to_hartid_mask(cmask, &hmask);
+
+issue_sfence:
 	sbi_remote_sfence_vma(hmask.bits, start, size);
+done:
+	put_cpu();
 }
 
 void flush_tlb_mm(struct mm_struct *mm)
-- 
2.21.0

