Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB10C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E255921655
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565957698;
	bh=EO+3AvUKDIdJIchpb9box4zgBDkUpuVnsKHcL1WS8v4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=WR8Orz5Zf4ved2VUxjwFBX9ygAR0seyoE1SL5ljBndvDxdcR1hdzULumlGLAhhf8x
	 Y3FqqzM5u+P8XyyMUzIlROx2JjU3PYo80+k4naGPQOlAGjWzzUdBoNidJGOPgTb8Cy
	 qs57zA0YKsZ+Shft30lP//GMFg6ZxKfKDC+ycJ9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfHPMO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 08:14:56 -0400
Received: from mail-wm1-f98.google.com ([209.85.128.98]:55048 "EHLO
        mail-wm1-f98.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbfHPMO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:14:56 -0400
Received: by mail-wm1-f98.google.com with SMTP id p74so3870603wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 05:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:message-id:date;
        bh=pLS4DxT1dPkt+ilKsw/CiwD4KIIKskFjBYK+1KbWdsE=;
        b=gXgwXlk1lC+E5USiYXIIFELAMbNUd0eiBzXr4myBjImu0AQqQ7fcewotdcJT+bW82J
         LdPPZc9mj1Qof0mLB2PeNT8bNL8ECZX0VjOpu4w/CJwXxymHjj+ZqX5LH6xjD6YuldLc
         yQQ9LegYMZ3gQSFRlWzpixe9YEKDkIOpX6jM3naxjzVanAYUrWO61ltKSoCPxa9x0gLa
         DaV5fKTCciArNeRSxvzraFuz4eW5CmWG2TGvb+tm7La0uq1QKvgj4Nd7PBkZgA7GnnM5
         ludzNMKkv8FJ6J+cuMrtYamH25eDbcZSXmJduDaoa4nlHcBTxl+vAQnmsFeCGkitmIv3
         6JYQ==
X-Gm-Message-State: APjAAAVbXGn3M/gQYyjOmW1GXwymsu+ePUVdMO8+RgzimC9ITfkup/CJ
        JBfgL5FDt0d7JCvrPc3uCzpaWCbEB5mT/RJXt363qdZDt7p3Ql9ZHhWFJxRJ3irbuQ==
X-Google-Smtp-Source: APXvYqySVq6C/xknyvsxzKlqH7UE+qi1NJxPkT+wedb/ovVs8FyUI5SRHDjge/ud7Koip4TsqGPgyJPtw6LB
X-Received: by 2002:a1c:cfc6:: with SMTP id f189mr6938434wmg.18.1565957694085;
        Fri, 16 Aug 2019 05:14:54 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id d8sm90830wro.28.2019.08.16.05.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 05:14:54 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyb89-0003L6-Nv; Fri, 16 Aug 2019 12:14:53 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 184B12743134; Fri, 16 Aug 2019 13:14:53 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        festevam@gmail.com, kernel@pengutronix.de, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mark Brown <broonie@kernel.org>, nicoleotsuka@gmail.com,
        perex@perex.cz, s.hauer@pengutronix.de, shawnguo@kernel.org,
        timur@kernel.org, tiwai@suse.com, Xiubo.Lee@gmail.com
Subject: Applied "ASoC: imx-audmux: Add driver suspend and resume to support MEGA Fast" to the asoc tree
In-Reply-To: <1565931794-7218-1-git-send-email-shengjiu.wang@nxp.com>
X-Patchwork-Hint: ignore
Message-Id: <20190816121453.184B12743134@ypsilon.sirena.org.uk>
Date:   Fri, 16 Aug 2019 13:14:53 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: imx-audmux: Add driver suspend and resume to support MEGA Fast

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 8661ab5b23d6d30d8687fc05bc1dba8f9a64b444 Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Fri, 16 Aug 2019 01:03:14 -0400
Subject: [PATCH] ASoC: imx-audmux: Add driver suspend and resume to support
 MEGA Fast

For i.MX6 SoloX, there is a mode of the SoC to shutdown all power
source of modules during system suspend and resume procedure.
Thus, AUDMUX needs to save all the values of registers before the
system suspend and restore them after the system resume.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://lore.kernel.org/r/1565931794-7218-1-git-send-email-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-audmux.c | 54 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index b2351cd33b0f..16ede3b5cb32 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -23,6 +23,8 @@
 
 static struct clk *audmux_clk;
 static void __iomem *audmux_base;
+static u32 *regcache;
+static u32 reg_max;
 
 #define IMX_AUDMUX_V2_PTCR(x)		((x) * 8)
 #define IMX_AUDMUX_V2_PDCR(x)		((x) * 8 + 4)
@@ -317,8 +319,23 @@ static int imx_audmux_probe(struct platform_device *pdev)
 	if (of_id)
 		pdev->id_entry = of_id->data;
 	audmux_type = pdev->id_entry->driver_data;
-	if (audmux_type == IMX31_AUDMUX)
+
+	switch (audmux_type) {
+	case IMX31_AUDMUX:
 		audmux_debugfs_init();
+		reg_max = 14;
+		break;
+	case IMX21_AUDMUX:
+		reg_max = 6;
+		break;
+	default:
+		dev_err(&pdev->dev, "unsupported version!\n");
+		return -EINVAL;
+	}
+
+	regcache = devm_kzalloc(&pdev->dev, sizeof(u32) * reg_max, GFP_KERNEL);
+	if (!regcache)
+		return -ENOMEM;
 
 	if (of_id)
 		imx_audmux_parse_dt_defaults(pdev, pdev->dev.of_node);
@@ -334,12 +351,47 @@ static int imx_audmux_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int imx_audmux_suspend(struct device *dev)
+{
+	int i;
+
+	clk_prepare_enable(audmux_clk);
+
+	for (i = 0; i < reg_max; i++)
+		regcache[i] = readl(audmux_base + i * 4);
+
+	clk_disable_unprepare(audmux_clk);
+
+	return 0;
+}
+
+static int imx_audmux_resume(struct device *dev)
+{
+	int i;
+
+	clk_prepare_enable(audmux_clk);
+
+	for (i = 0; i < reg_max; i++)
+		writel(regcache[i], audmux_base + i * 4);
+
+	clk_disable_unprepare(audmux_clk);
+
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops imx_audmux_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(imx_audmux_suspend, imx_audmux_resume)
+};
+
 static struct platform_driver imx_audmux_driver = {
 	.probe		= imx_audmux_probe,
 	.remove		= imx_audmux_remove,
 	.id_table	= imx_audmux_ids,
 	.driver	= {
 		.name	= DRIVER_NAME,
+		.pm = &imx_audmux_pm,
 		.of_match_table = imx_audmux_dt_ids,
 	}
 };
-- 
2.20.1

