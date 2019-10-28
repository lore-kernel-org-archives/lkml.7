Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2003ECA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E568A21479
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="RVD9lhOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732989AbfJ1VtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:49:25 -0400
Received: from vps.xff.cz ([195.181.215.36]:50070 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730592AbfJ1VtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1572299363; bh=yfQ5bNur1qQsSwWai80uin5ZDClxDtOcYUot2/fijL0=;
        h=From:To:Cc:Subject:Date:From;
        b=RVD9lhOKFIWyR8uwdk2pCEi1JXI/uuyWgSwtBUN3we5JB1c5A5vVxcsn92C47QBc3
         nU/lzm4szLyF6lnP6vBtiKuiNZ/DtVMsFUIocfOEhl1LTdROS25HWBRU2SA2j2MLqT
         xjJKew//0G2ek76ewJ6TrFzTUjb3lW3lW3QYv408=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com
Cc:     Ondrej Jirman <megous@megous.com>, stable@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: sunxi: Fix CPU powerdown on A83T
Date:   Mon, 28 Oct 2019 22:49:14 +0100
Message-Id: <20191028214914.3465156-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PRCM_PWROFF_GATING_REG has CPU0 at bit 4 on A83T. So without this
patch, instead of gating the CPU0, the whole cluster was power gated,
when shutting down first CPU in the cluster.

Fixes: 6961275e72a8c1 ("ARM: sun8i: smp: Add support for A83T")
Signed-off-by: Ondrej Jirman <megous@megous.com>
Cc: stable@vger.kernel.org
---
 arch/arm/mach-sunxi/mc_smp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index 239084cf8192..26cbce135338 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -481,14 +481,18 @@ static void sunxi_mc_smp_cpu_die(unsigned int l_cpu)
 static int sunxi_cpu_powerdown(unsigned int cpu, unsigned int cluster)
 {
 	u32 reg;
+	int gating_bit = cpu;
 
 	pr_debug("%s: cluster %u cpu %u\n", __func__, cluster, cpu);
 	if (cpu >= SUNXI_CPUS_PER_CLUSTER || cluster >= SUNXI_NR_CLUSTERS)
 		return -EINVAL;
 
+	if (is_a83t && cpu == 0)
+		gating_bit = 4;
+
 	/* gate processor power */
 	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
-	reg |= PRCM_PWROFF_GATING_REG_CORE(cpu);
+	reg |= PRCM_PWROFF_GATING_REG_CORE(gating_bit);
 	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
 	udelay(20);
 
-- 
2.23.0

