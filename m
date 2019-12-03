Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C04C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47B22068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="T5CKLPD+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BcqBHJDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfLCMg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:36:58 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:38755 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726491AbfLCMg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:36:57 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4D9A86DE1;
        Tue,  3 Dec 2019 07:36:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 Dec 2019 07:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=kjWpovueN8CzO
        esF420v4iyncH+ByIeT2cD2JH7lblI=; b=T5CKLPD+spFW1igauzqE8+IrNWikW
        3Qpwh1ZRCcALvz/non+Glg6hMwkFrcuiwUKm+hH/VYqi4+LsHT6KHwapzeUscqVX
        /TfiaKF4XP3cYYmqmMJXctkmVNRRNdjd6Ln11PKkS2ByUB3K36tbmmQjFRu0RYSF
        H20rNf86NBR+qA2HcmhEvmr20cdh28hZQTQEvhMfZdcwfCQU9n3ozSwp9vhrQ0dv
        3OF4XUaXAcgt1kNzi1qAZJBBGhjezLsdVaQyf/bkiALhU7T3UHOIgrU7NCoP7Zz6
        c/COaXQQ/MkNBULbVDPuK09r1Yzfo2tyfajG//5CQfx6GnLk/A0XBLDEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=kjWpovueN8CzOesF420v4iyncH+ByIeT2cD2JH7lblI=; b=BcqBHJDT
        yycSW8cZYYAuQlu9+h6RthTMirtCmI0XXsToehA55RFutmDylPvqP0ZMcsgL+pde
        gAmyug5sfJUE/GTJtJIMQ7u4EqopvX1BxaCS5aLlJwVrhHnF2d9mteSUfuhPzxv7
        VXnbz8cOwJ2rNVNKUwhP7nyHt8Ft2k+0tC7VAslYvXSpig9qLgHxx1pMIEldqvBy
        fT4GluyakCab7XezF6etV6UWTG85wO/h3KJzMLuLvRLyG6OsCeQHgzWTcBsMqbXs
        dewHBqiCTV85CVRofrfrLknR/b46JCysWtEvi6IH51tSH2WRm7iiiVcfpmHeQcle
        fgBCfjZQ0fc5wQ==
X-ME-Sender: <xms:6FbmXWT95O0CWteAxP0WBCn_xYNd5W4NOhsmjX-u2al4BB7Y-fRcuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhgurhgv
    ficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucfkphepudduke
    drvdduuddrledvrddufeenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegr
    jhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:6FbmXWrXU8yHp46kF_4pgnAJRlwoG_pjs2BFWskoVY-ypp7GFOGotw>
    <xmx:6FbmXeA_Wqa4mgPsSOWUnL8Ccrt6T627QzZo__dl4wTkMd67Q4joDA>
    <xmx:6FbmXTuwT9yS-HHx-s_iWbEG_7IdG4C07T_lxzlv19YdOw9rpxGwmQ>
    <xmx:6FbmXYIiMhg-sBX9RKzSZAn-GYTlCTs8clJBvNx1K9pwKMQeKimy3w>
Received: from mistburn.lan (unknown [118.211.92.13])
        by mail.messagingengine.com (Postfix) with ESMTPA id E0C8630600AA;
        Tue,  3 Dec 2019 07:36:51 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     openipmi-developer@lists.sourceforge.net
Cc:     minyard@acm.org, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Haiyue Wang <haiyue.wang@linux.intel.com>
Subject: [PATCH 3/3] ipmi: kcs: aspeed: Implement v2 bindings
Date:   Tue,  3 Dec 2019 23:08:25 +1030
Message-Id: <4e9def3a71d67a190982f22dbfe723ad42ca3661.1575376664.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.5630f63168ad5cddf02e9796106f8e086c196907.1575376664.git-series.andrew@aj.id.au>
References: <cover.5630f63168ad5cddf02e9796106f8e086c196907.1575376664.git-series.andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The v2 bindings allow us to extract the resources from the devicetree.
The table in the driver is retained to derive the channel index, which
removes the need for kcs_chan property from the v1 bindings. The v2
bindings allow us to reduce the number of warnings generated by the
existing devicetree nodes.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
---
 drivers/char/ipmi/kcs_bmc_aspeed.c | 144 +++++++++++++++++++++++++-----
 1 file changed, 121 insertions(+), 23 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index e3dd09022589..509e0d3c6eb1 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -12,6 +12,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/poll.h>
 #include <linux/regmap.h>
@@ -233,38 +234,133 @@ static const struct kcs_ioreg ast_kcs_bmc_ioregs[KCS_CHANNEL_MAX] = {
 	{ .idr = LPC_IDR4, .odr = LPC_ODR4, .str = LPC_STR4 },
 };
 
-static int aspeed_kcs_probe(struct platform_device *pdev)
+static struct kcs_bmc *aspeed_kcs_probe_of_v1(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
 	struct aspeed_kcs_bmc *priv;
-	struct kcs_bmc *kcs_bmc;
-	u32 chan, addr;
+	struct device_node *np;
+	struct kcs_bmc *kcs;
+	u32 channel;
+	u32 slave;
 	int rc;
 
-	rc = of_property_read_u32(dev->of_node, "kcs_chan", &chan);
-	if ((rc != 0) || (chan == 0 || chan > KCS_CHANNEL_MAX)) {
-		dev_err(dev, "no valid 'kcs_chan' configured\n");
-		return -ENODEV;
+	np = pdev->dev.of_node;
+
+	rc = of_property_read_u32(np, "kcs_chan", &channel);
+	if ((rc != 0) || (channel == 0 || channel > KCS_CHANNEL_MAX)) {
+		dev_err(&pdev->dev, "no valid 'kcs_chan' configured\n");
+		return ERR_PTR(-EINVAL);
 	}
 
-	rc = of_property_read_u32(dev->of_node, "kcs_addr", &addr);
+	kcs = kcs_bmc_alloc(&pdev->dev, sizeof(struct aspeed_kcs_bmc), channel);
+	if (!kcs)
+		return ERR_PTR(-ENOMEM);
+
+	priv = kcs_bmc_priv(kcs);
+	priv->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
+	if (IS_ERR(priv->map)) {
+		dev_err(&pdev->dev, "Couldn't get regmap\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	rc = of_property_read_u32(np, "kcs_addr", &slave);
 	if (rc) {
-		dev_err(dev, "no valid 'kcs_addr' configured\n");
-		return -ENODEV;
+		dev_err(&pdev->dev, "no valid 'kcs_addr' configured\n");
+		return ERR_PTR(-EINVAL);
 	}
 
-	kcs_bmc = kcs_bmc_alloc(dev, sizeof(*priv), chan);
-	if (!kcs_bmc)
-		return -ENOMEM;
+	kcs->ioreg = ast_kcs_bmc_ioregs[channel - 1];
+	aspeed_kcs_set_address(kcs, slave);
+
+	return 0;
+}
+
+static int aspeed_kcs_calculate_channel(const struct kcs_ioreg *regs)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ast_kcs_bmc_ioregs); i++) {
+		if (!memcmp(&ast_kcs_bmc_ioregs[i], regs, sizeof(*regs)))
+			return i + 1;
+	}
+
+	return -EINVAL;
+}
+
+static struct kcs_bmc *aspeed_kcs_probe_of_v2(struct platform_device *pdev)
+{
+	struct aspeed_kcs_bmc *priv;
+	struct device_node *np;
+	struct kcs_ioreg ioreg;
+	struct kcs_bmc *kcs;
+	const __be32 *reg;
+	int channel;
+	u32 slave;
+	int rc;
 
-	priv = kcs_bmc_priv(kcs_bmc);
-	priv->map = syscon_node_to_regmap(dev->parent->of_node);
+	np = pdev->dev.of_node;
+
+	/* Don't translate addresses, we want offsets for the regmaps */
+	reg = of_get_address(np, 0, NULL, NULL);
+	if (!reg)
+		return ERR_PTR(-EINVAL);
+	ioreg.idr = be32_to_cpup(reg);
+
+	reg = of_get_address(np, 1, NULL, NULL);
+	if (!reg)
+		return ERR_PTR(-EINVAL);
+	ioreg.odr = be32_to_cpup(reg);
+
+	reg = of_get_address(np, 2, NULL, NULL);
+	if (!reg)
+		return ERR_PTR(-EINVAL);
+	ioreg.str = be32_to_cpup(reg);
+
+	channel = aspeed_kcs_calculate_channel(&ioreg);
+	if (channel < 0)
+		return ERR_PTR(channel);
+
+	kcs = kcs_bmc_alloc(&pdev->dev, sizeof(struct aspeed_kcs_bmc), channel);
+	if (!kcs)
+		return ERR_PTR(-ENOMEM);
+
+	kcs->ioreg = ioreg;
+
+	priv = kcs_bmc_priv(kcs);
+	priv->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
 	if (IS_ERR(priv->map)) {
-		dev_err(dev, "Couldn't get regmap\n");
-		return -ENODEV;
+		dev_err(&pdev->dev, "Couldn't get regmap\n");
+		return ERR_PTR(-ENODEV);
 	}
 
-	kcs_bmc->ioreg = ast_kcs_bmc_ioregs[chan - 1];
+	rc = of_property_read_u32(np, "slave-reg", &slave);
+	if (rc)
+		return ERR_PTR(rc);
+
+	aspeed_kcs_set_address(kcs, slave);
+
+	return kcs;
+}
+
+static int aspeed_kcs_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct kcs_bmc *kcs_bmc;
+	struct device_node *np;
+	int rc;
+
+	np = pdev->dev.of_node;
+	if (of_device_is_compatible(np, "aspeed,ast2400-kcs-bmc") ||
+			of_device_is_compatible(np, "aspeed,ast2500-kcs-bmc"))
+		kcs_bmc = aspeed_kcs_probe_of_v1(pdev);
+	else if (of_device_is_compatible(np, "aspeed,ast2400-kcs-bmc-v2") ||
+			of_device_is_compatible(np, "aspeed,ast2500-kcs-bmc-v2"))
+		kcs_bmc = aspeed_kcs_probe_of_v2(pdev);
+	else
+		return -EINVAL;
+
+	if (IS_ERR(kcs_bmc))
+		return PTR_ERR(kcs_bmc);
+
 	kcs_bmc->io_inputb = aspeed_kcs_inb;
 	kcs_bmc->io_outputb = aspeed_kcs_outb;
 
@@ -274,7 +370,6 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, kcs_bmc);
 
-	aspeed_kcs_set_address(kcs_bmc, addr);
 	aspeed_kcs_enable_channel(kcs_bmc, true);
 
 	rc = misc_register(&kcs_bmc->miscdev);
@@ -283,9 +378,10 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 		return rc;
 	}
 
-	pr_info("channel=%u addr=0x%x idr=0x%x odr=0x%x str=0x%x\n",
-		chan, addr,
-		kcs_bmc->ioreg.idr, kcs_bmc->ioreg.odr, kcs_bmc->ioreg.str);
+	dev_dbg(&pdev->dev,
+		"Probed KCS device %d (IDR=0x%x, ODR=0x%x, STR=0x%x)\n",
+		kcs_bmc->channel, kcs_bmc->ioreg.idr, kcs_bmc->ioreg.odr,
+		kcs_bmc->ioreg.str);
 
 	return 0;
 }
@@ -302,6 +398,8 @@ static int aspeed_kcs_remove(struct platform_device *pdev)
 static const struct of_device_id ast_kcs_bmc_match[] = {
 	{ .compatible = "aspeed,ast2400-kcs-bmc" },
 	{ .compatible = "aspeed,ast2500-kcs-bmc" },
+	{ .compatible = "aspeed,ast2400-kcs-bmc-v2" },
+	{ .compatible = "aspeed,ast2500-kcs-bmc-v2" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ast_kcs_bmc_match);
-- 
git-series 0.9.1
