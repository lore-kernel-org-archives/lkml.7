Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C33FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9652087F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbfCKS4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:56:04 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:51527 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfCKSzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:55:52 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N2EHo-1gv3Ki1VhG-013cSO; Mon, 11 Mar 2019 19:55:34 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com,
        orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com,
        thierry.reding@gmail.com, grygorii.strashko@ti.com,
        ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr,
        yamada.masahiro@socionext.com, jun.nie@linaro.org,
        shawnguo@kernel.org, linux-gpio@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 12/42] drivers: gpio: grgpio: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:54:51 +0100
Message-Id: <1552330521-4276-12-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:s6D93lCp6TjmlwWHE0LPTB3uwfBHWA3wRlbxYC2/ePCwu+67PpY
 40Uu6zN3AEC93yjI2AepCtmDdHKXCSIv4f0iT+Z+JX6goB5glNPfcH67nWwVR/FK6+1FLY+
 G/7yJnoa99c80eDxw5MvgJqfOvxQb0EiOF+UO6ZcmfuTARj7IhIC0nkgaqTQAuewpDnXeSI
 7RxpG1YafXgoekd3rJtYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rozpdole5G0=:eYCGBnHa/yl7Q0RXq2kgVv
 atuNx/fbrkDZHbEWt+SqGExFrhum4lzxLxqnTG5Pp22D1dbCLtcHDKJFMaXVt4Px7YZ5H2Qmh
 WliCa4GdCahHgWBDivvWQ7zT6kol0fU0cUjrr1qNWUtAwsbs4gt1i19jgRPoFPvYJcX5o3IRw
 v4XoQQjP74PxOJABl9b+3TBEwqVdki4D1Drd1YfyZY/eJZaFRQFsJqL32xMWHmXELcB9uPWZg
 +xAEdgz351J7EEpuCs023efOwxvS1iS3nzkLt46+vsG6CvGUAmq6Mu0VU8IvnR+vngptb2nM8
 ONUP9Kl5TbXBaABfFjAQdXKcwfiQvxDTNFSEUia7KcBU9842rEXCozba4mshgPobn3MeRBCOs
 s2dFd3mzY2E/FhrAirCPXqRkzVFKYII/lcjtQ1vgy4Tju/u/TWpveAC7WuvqBdq53PzEcnQjN
 7TD+JClk07D0sIxRaGKLPwz6eV0jATNThkSkjaVRUdfr+gP0NP0YoIdZndSxZUt+/BseYFTQ7
 dGPmUZJn8WYhK9MbwoiNi+ZPCEX8vjjHJAixfNApH8W1geAlO5d1aoMlxiD1MgmeDgE0B/wNk
 BrpFxf0zWSq2lwWd9yJLcyz5WnsfY6gOjDXYYS5UQp9/HXxyrDM8ig2ndx5vgRlBrRZQOj2Fq
 72BLeD11NEXixMpCYgGCqauETBkfOauf0IWcxCvW9IVrawLS5QyYqm/dAOP2k5gOtKiPMoZfM
 TgDHXOgV4zVEq2r1h1ev4t3Bz9pLsB7innDl/g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-grgpio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
index 45b8d6a..09d3dac 100644
--- a/drivers/gpio/gpio-grgpio.c
+++ b/drivers/gpio/gpio-grgpio.c
@@ -333,7 +333,6 @@ static int grgpio_probe(struct platform_device *ofdev)
 	void  __iomem *regs;
 	struct gpio_chip *gc;
 	struct grgpio_priv *priv;
-	struct resource *res;
 	int err;
 	u32 prop;
 	s32 *irqmap;
@@ -344,8 +343,7 @@ static int grgpio_probe(struct platform_device *ofdev)
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
-	regs = devm_ioremap_resource(&ofdev->dev, res);
+	regs = devm_platform_ioremap_resource(&ofdev, 0);
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
-- 
1.9.1

