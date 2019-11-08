Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A567FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F580222C5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214993;
	bh=FJvlhdFxsqprxnNVbN95u0jbEh0Nno/W3yfaEzFlnI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1RnuTRgIykvkAF2sCOlEp4UPMqmk5MullZQQ5aN7S+USaddgrthc+oTmtaK4GHC+e
	 N8DvBnE01BkfnmPRmEYS2ro0LiE88No/VmUR7QHX6aE5iI8IW0hIlbxa05UhOgiE/4
	 qPVYQc1Ro5AuU5NYD5lGrScppGWkcBrni0R6G15I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389774AbfKHMJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:09:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388071AbfKHLjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:39:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7490222C2;
        Fri,  8 Nov 2019 11:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213190;
        bh=FJvlhdFxsqprxnNVbN95u0jbEh0Nno/W3yfaEzFlnI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BpQc1NoqGN1YJc8D0rgEU1T0Fvp5DReOV9424XPYNW5WJ9kBlvo6cSfBfxf+6q8uU
         1RSjLctu06Amw5WnDNqPNyqIQ682Ujhw/gAQ+xvrpsYt24M4pjiuDkq77aJKPzp6T5
         mD8kMR7rEeRyCgIt/nYRR9mLbY1B8AnXZlplZGmo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-mtd@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 080/205] mtd: rawnand: marvell: use regmap_update_bits() for syscon access
Date:   Fri,  8 Nov 2019 06:35:47 -0500
Message-Id: <20191108113752.12502-80-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

[ Upstream commit 88aa3bbfc020d14b13d67af3f5c08aa992d82cd8 ]

The marvell_nfc_init() function fiddles with some bits of a system
controller on Armada 7K/8K. However, it does a read/modify/write
sequence on GENCONF_CLK_GATING_CTRL and GENCONF_ND_CLK_CTRL, which
isn't safe from a concurrency point of view, as the regmap lock isn't
taken accross the read/modify/write sequence. To solve this issue, use
regmap_update_bits().

While at it, since the "reg" variable is no longer needed for the
read/modify/write sequences, get rid of it for the regmap_write() to
GENCONF_SOC_DEVICE_MUX, and directly pass the value to be written as
argument.

Fixes: 02f26ecf8c772 ("mtd: nand: add reworked Marvell NAND controller driver")
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/marvell_nand.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 9c90695a885fe..7a84a8f05b46d 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2710,24 +2710,23 @@ static int marvell_nfc_init(struct marvell_nfc *nfc)
 		struct regmap *sysctrl_base =
 			syscon_regmap_lookup_by_phandle(np,
 							"marvell,system-controller");
-		u32 reg;
 
 		if (IS_ERR(sysctrl_base))
 			return PTR_ERR(sysctrl_base);
 
-		reg = GENCONF_SOC_DEVICE_MUX_NFC_EN |
-		      GENCONF_SOC_DEVICE_MUX_ECC_CLK_RST |
-		      GENCONF_SOC_DEVICE_MUX_ECC_CORE_RST |
-		      GENCONF_SOC_DEVICE_MUX_NFC_INT_EN;
-		regmap_write(sysctrl_base, GENCONF_SOC_DEVICE_MUX, reg);
+		regmap_write(sysctrl_base, GENCONF_SOC_DEVICE_MUX,
+			     GENCONF_SOC_DEVICE_MUX_NFC_EN |
+			     GENCONF_SOC_DEVICE_MUX_ECC_CLK_RST |
+			     GENCONF_SOC_DEVICE_MUX_ECC_CORE_RST |
+			     GENCONF_SOC_DEVICE_MUX_NFC_INT_EN);
 
-		regmap_read(sysctrl_base, GENCONF_CLK_GATING_CTRL, &reg);
-		reg |= GENCONF_CLK_GATING_CTRL_ND_GATE;
-		regmap_write(sysctrl_base, GENCONF_CLK_GATING_CTRL, reg);
+		regmap_update_bits(sysctrl_base, GENCONF_CLK_GATING_CTRL,
+				   GENCONF_CLK_GATING_CTRL_ND_GATE,
+				   GENCONF_CLK_GATING_CTRL_ND_GATE);
 
-		regmap_read(sysctrl_base, GENCONF_ND_CLK_CTRL, &reg);
-		reg |= GENCONF_ND_CLK_CTRL_EN;
-		regmap_write(sysctrl_base, GENCONF_ND_CLK_CTRL, reg);
+		regmap_update_bits(sysctrl_base, GENCONF_ND_CLK_CTRL,
+				   GENCONF_ND_CLK_CTRL_EN,
+				   GENCONF_ND_CLK_CTRL_EN);
 	}
 
 	/* Configure the DMA if appropriate */
-- 
2.20.1

