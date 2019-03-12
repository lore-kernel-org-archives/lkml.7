Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D900C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC6421734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413470;
	bh=XZz9T2XT3JJuW+QfvO1ssLiLbQjJ0oPDZqb0vLxPm7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jZHuI/8EWQX5PYIfgTZMQeSi+1hmn6bce0h+yB9CbcYJHkaNUlDpUsemrKDBkF+kf
	 5ftYvB1Yop1J7LUoSLNs35rkqZbZhfBkoHsNKenJyTyJS7gOTA3rCiz+tbpLkNXfeC
	 uqijuKuH1uw3kwqi4QgA5aInjeOGoz4DHViTwsH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfCLR5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbfCLRNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:46 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DB16217D4;
        Tue, 12 Mar 2019 17:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410825;
        bh=XZz9T2XT3JJuW+QfvO1ssLiLbQjJ0oPDZqb0vLxPm7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D/eamEqoN6fInYfb3EQsrxZ8X8cW5ZnlSH6gaE/Dy2IksgdXw9pSSlWMq0h5oHe+/
         vTpcQdMOh1lcyLFgp1zovaZ6oTYQZLcHv1b5ou7OV7Tx0CNkI4HXoH6LCQIYZgPIn2
         umeujvLKVehNSyMMkbrUqHpiaoIq6vhIGBuL1S/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>,
        Mao Han <mao_han@c-sky.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 010/149] riscv: fixup max_low_pfn with PFN_DOWN.
Date:   Tue, 12 Mar 2019 10:07:08 -0700
Message-Id: <20190312170350.391174762@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 28198c4639b39899a728ac89aea29d2a7a72562f ]

max_low_pfn should be pfn_size not byte_size.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Signed-off-by: Mao Han <mao_han@c-sky.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/setup.c | 2 +-
 arch/riscv/mm/init.c      | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index b2d26d9d8489..9713d4e8c22b 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -186,7 +186,7 @@ static void __init setup_bootmem(void)
 	BUG_ON(mem_size == 0);
 
 	set_max_mapnr(PFN_DOWN(mem_size));
-	max_low_pfn = memblock_end_of_DRAM();
+	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	setup_initrd();
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 58a522f9bcc3..200a4b315e15 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -29,7 +29,8 @@ static void __init zone_sizes_init(void)
 	unsigned long max_zone_pfns[MAX_NR_ZONES] = { 0, };
 
 #ifdef CONFIG_ZONE_DMA32
-	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(min(4UL * SZ_1G, max_low_pfn));
+	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(min(4UL * SZ_1G,
+			(unsigned long) PFN_PHYS(max_low_pfn)));
 #endif
 	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
 
-- 
2.19.1



