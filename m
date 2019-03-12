Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CAFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D3B214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfCLJUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:20:17 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:48083 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfCLJTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:19:51 -0400
Received: from orion.localdomain ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MPK73-1hQMzO2hW1-00PchT; Tue, 12 Mar 2019 10:19:39 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 9/9] drivers: ata: sata_rcar: use devm_platform_ioremap_resource()
Date:   Tue, 12 Mar 2019 10:19:34 +0100
Message-Id: <1552382374-28789-9-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552382374-28789-1-git-send-email-info@metux.net>
References: <1552382374-28789-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:p6NaebDa9bnEWsbT9tRBkkg8wrRrhbn7egAQTAezJJ4gmE8aehS
 7gKeniFSEQ+wu+KTSqMRFokaELbxvyjVp+6r7CVocJ0aRqSO+8ozb3zS1ekBM7fKzupJB23
 J3xhIpAyaScsQOnUaTF7pV3MIEPXC3okB//xc+MGXSukPDIOxEzmp1nvdSmNGRtD1LJJwwG
 YVe51YHMy0D2uCAUOeBnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oVuaafSdmIE=:VptspbdO+7lrZHBHUQkIlj
 CizZA2Pn5F5X3cbRUs+AYp7rGJOOhg1AomWm4ExHPyjThc80ejD6/h/+9D56iU2XYiJZVfc/P
 QXEPDENHLt3mdLUIqZmOeoindDMAJ9BsBQhpObB5jFTU/nJKwIshQ6rsotsgkq6d7LK836V4q
 b+WEAyMlJkuoQjPbVuc52DNUDMas/6ZNaKIC/IF7hAlx1CY4fUrMNOAbAEVzE0sc5eo+PEP8H
 2/1N+KA1KBLgqqE9WDHDINUIaydebja0spsZuTCIGfMLtsywJzObWQHt4fFD11fcn76CCAgBb
 Ktdvjk8PI2Jkp6RNBhGWomJlSiZaE0dnjhvwfhiHha13FUSbxXFVNtzZiK0COiQs3xo/CnrpS
 mMM6zfEkw3PkMZDbjVSLbaMC7IktfyX15l6rPe5QGBAK6+/Jw5rvYM8P/Ge2eJgiyDQfyXWOX
 fqdCcMdnkUubSdRqoRz+bkF6wvOOTIvTxazzw0F3W4t+aqba0zobAOidShfOP7C3enXgCzdqy
 Wc+KBKzrvxdBrMwdeTCrUU8rDfUroGdcSb1Lm3niCJwGRz0YI4JsrSeDrArN4cW3VluBaCCpN
 VoqQ4tOgWKrPl0c565tovTYwG+JUI/ozhVz+1gwveXwvqQfb4B80MKKvQAv27SsuM1ZeaF7mp
 5tQGLT+x5kyJtlkMy8/GKpM2i46nIeTW29DQcJH1JsGm33Pm+VuNBGXzYRRHgB/ojn0DRspe2
 gVsMSb5jA7mivbV7A6c4IF8rJFhSdM+sWzsxQA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/sata_rcar.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index 59b2317..293cc62 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -886,7 +886,6 @@ static int sata_rcar_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ata_host *host;
 	struct sata_rcar_priv *priv;
-	struct resource *mem;
 	int irq;
 	int ret = 0;
 
@@ -916,8 +915,7 @@ static int sata_rcar_probe(struct platform_device *pdev)
 
 	host->private_data = priv;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(dev, mem);
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base)) {
 		ret = PTR_ERR(priv->base);
 		goto err_pm_put;
-- 
1.9.1

