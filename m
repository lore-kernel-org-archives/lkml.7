Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F58C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF83216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q/vhKwCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfHVAqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 20:46:46 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:48415 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbfHVAqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566434912; x=1597970912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W6jivi39Nx039cqiIEt94ExvK22lP+LKK4igKnFn5wc=;
  b=Q/vhKwCBv149+sLrnOuMxTshBZISHcJU1dItUx3eL0UdHTSoVuB2qD7b
   eB8XIFcNTwXO5at3xzq/fq2/LqYlfZFC83XOKdsnTlA11uyYiedrMOXv9
   9C4irRpaBc0ZKK4tIA+JrrrtZtlwHRupG+iaTHPkZ4CHt10TeMjBClk7/
   MZTkmTHT1Wk7o34W6VQNM8aMU43bc59IBqjMyesEqunp1yZJ+VDAXBLZf
   65f0KEsAg3pvkbPYFzgrdCkEKJpDs3wFz3b6Se+M0Ep5dPrSig3U6/f/4
   LHO5dRdS9m/1iHEnZA/k9THl3YaFi3Pl/uhyk11/asVWhy5H9Q6RNN9hL
   A==;
IronPort-SDR: mefr6IWNywv8Pt2y/P2Qff+TeMczmP3rEWnIqs3Ry+ZRRvJluV2Aal1YEjpheLw/8DS+VkArAv
 TNoemWO6i2pkPldPWz2eiCEuG490PWQs0Oa6OL1cwyd5gyK0e4INkK0NPfBX4cr4fT0E5MQ/fD
 IIE9AWItqX3/55wfS+I+mFY4fo7qHwOtS+dSLosL52+zLQrbK5ifLIIPMmX87u6WibtteaPDik
 YUwe5yFec/+mCsxPxImTTvSO5smRlTjcb0BgzxPYAD9mi0N58qS8PlglfTPxNv7UIbzteZ3Q5+
 oaU=
X-IronPort-AV: E=Sophos;i="5.64,414,1559491200"; 
   d="scan'208";a="216804437"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2019 08:48:31 +0800
IronPort-SDR: TFj8xW8haJEQcF8lab52/m6cgeB/u/CZRFJ2iRqgi27Ly5IVuR0BCkpvSNEJKgEjt90ITQQF3V
 UseLCDceBYH93tn6TbOLWIma3dxpG0tWIf2L5GpnBuhjTeukFFefSqArUMjbWf3zGNC4M2c//+
 njGczelib+lL86POBf981anDuyPLTiP4g81PzGBj0Ef/oZAWZ4B6pHsxD22UJDg9ammlZhSadW
 87GYqkc1Sb/q/8FCcZZxuTPNNJuCDQc+R74wSZe0dqArOSuzvNqhJpZ0znKYm6qlvu0mP6Fiwc
 4z4+c1x71dEWu0wjGhf3Iqvj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 17:44:05 -0700
IronPort-SDR: cVtLZ2bkSPG6/f67KCiLItzr/tkJQvkc5WnwGvduyhf1QuHxsbx7ec8YojBDcB+TvWk57DK93Z
 YDKy17AIdmh7T7HqVfWEpu34UmuExjX1h0YysJFGsilQ4UQkAGYkK3Pd3JaO+R42zhJIqBzs4I
 1dAqzD4V3jJc4p4kL8aIpkivWY66U40WuRDKtsqsIIBU3UJwILOlKEH6cLsJdSXe4PQwTUlh8S
 8t8WAXbzl67bsf86U2q0snyCz7x2Q5wil+HI0YktaWKZFO3tBGMbLdQ0dmoElKjMCxZfffojVJ
 TFs=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2019 17:46:46 -0700
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
Subject: [PATCH v3 2/3] RISC-V: Issue a tlb page flush if possible
Date:   Wed, 21 Aug 2019 17:46:43 -0700
Message-Id: <20190822004644.25829-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822004644.25829-1-atish.patra@wdc.com>
References: <20190822004644.25829-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If tlbflush request is for page only, there is no need to do a
complete local tlb shootdown.

Just do a local tlb flush for the given address.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/mm/tlbflush.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 36430ee3bed9..9f58b3790baa 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -22,7 +22,10 @@ static void __sbi_tlb_flush_range(struct cpumask *cmask, unsigned long start,
 	}
 
 	if (cpumask_test_cpu(cpuid, cmask) && cpumask_weight(cmask) == 1) {
-		local_flush_tlb_all();
+		if (size <= PAGE_SIZE && size != -1)
+			local_flush_tlb_page(start);
+		else
+			local_flush_tlb_all();
 		goto done;
 	}
 	riscv_cpuid_to_hartid_mask(cmask, &hmask);
-- 
2.21.0

