Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AB3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870AF2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfCKS7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:59:23 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:34513 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbfCKSzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:55:53 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MOiU5-1hQJUd3HoN-00Q8xd; Mon, 11 Mar 2019 19:55:36 +0100
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
Subject: [PATCH 15/42] drivers: gpio: janz-ttl: use devm_platform_ioremap_resource()
Date:   Mon, 11 Mar 2019 19:54:54 +0100
Message-Id: <1552330521-4276-15-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552330521-4276-1-git-send-email-info@metux.net>
References: <1552330521-4276-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:ve+tfx0VASc3CTP5uMOzIY8ePUZgihkSjeCOvuvAjT8dkoVTiRm
 VUi+BG6kbJMrxoBeQLrQr1J03ad0hJiTiE8vuZnHNJ2SODG8GPESBKAtWn0Uj+DIHN0RoMm
 vuVNuZu/AjPgQB39tKGcUujjJqNDpzwjpquZv+l25efUXAOALTbp4SpTiVQtjg2o34jSdPu
 rJtVubtlLO/8/ELLJsGeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Nt2KbzM0omc=:Zqqi7tRCkx6cMUo4bqynKL
 f+zLOzgaSUeZqWpK+vntExIfoMW9b8R/BhbQbF5t/395nRp006frrm0IovMaEct+Q4UsUXHF0
 VemDjZVAAdElU0YGFMwZQ1QAp8M4I5w0ITdYHj+nb+FTZRH1RUhXsQ6D9q4OaPtTnXZFPmOWz
 CdcH3B5TPNibam12uci0TPQIQg7HVbnagsbFn/dLJth/DpVV/5MVFGbSxQMPSAXX4sqvUXXWp
 d2fltZEaR+CGIAbGI10kuL28WFp30uvyrdrvqIuc1qDDzMZI6i5raU2mc2D0GD8B4Kn6OyJLl
 AvEXokuDHaq3FDc4hZSGpGCfg9diiL3/597xijqJGWe1SVdvX0ePFsxU8m1umHp522rkrIt6x
 5Lu8UVNq+YU7tC0IfW9WtXIayrA24ecRh+VrbS6rsmcC/LfWEmOb9yQATz8j/wqQDI3HQAcii
 h50R+PfkkxfdlOSnFap6Dd9Dyo62ZJ3lhzD47A20JwUwKlm94wdkOh5ls2gQ9XLeUS30syo66
 dHsMYAtGH4OhFPbKRmDaugLpForHKr1w9avpCrbV4Pzb+qL36pAzoTtS+/stggjNpexHIOqAB
 5u0urf8KADob7BL3rfJPhd+JcntwMmcWM8Imx7kc8K/dcl8zQThd9FmpEAU/yUXXv+pc9kaXf
 ZFZNmukW2sSEO6o0tQKgn0Z1MwpD9Fibit4iLvQ3pVASBvQSC/VoSZs0d3A19Wb+9Cs3waoBZ
 fKNW2YQwB9nRfPktORVkZmi/sPklO/xhH0nAVA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/gpio/gpio-janz-ttl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-janz-ttl.c b/drivers/gpio/gpio-janz-ttl.c
index 6b9bf8b..b97a911 100644
--- a/drivers/gpio/gpio-janz-ttl.c
+++ b/drivers/gpio/gpio-janz-ttl.c
@@ -147,7 +147,6 @@ static int ttl_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ttl_module *mod;
 	struct gpio_chip *gpio;
-	struct resource *res;
 	int ret;
 
 	pdata = dev_get_platdata(&pdev->dev);
@@ -164,8 +163,7 @@ static int ttl_probe(struct platform_device *pdev)
 	spin_lock_init(&mod->lock);
 
 	/* get access to the MODULbus registers for this module */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mod->regs = devm_ioremap_resource(dev, res);
+	mod->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mod->regs))
 		return PTR_ERR(mod->regs);
 
-- 
1.9.1

