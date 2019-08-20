Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A37C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D244E22DD6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfHTMgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:36:04 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:42861 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729967AbfHTMgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:36:00 -0400
Received: from orion.localdomain ([95.117.23.32]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M7KG2-1huZBr0qDc-007iuL; Tue, 20 Aug 2019 14:35:51 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 5/9] drivers: ata: libahci_platform: use devm_platform_ioremap_resource()
Date:   Tue, 20 Aug 2019 14:35:44 +0200
Message-Id: <1566304548-19972-5-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1566304548-19972-1-git-send-email-info@metux.net>
References: <1566304548-19972-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:E53USeu0msk8V5JROorIHFiw3hhReQm1qeQl+190LDziCoEZe/q
 e51UrpeLsIFx9XrX0aHBeif5Danuxs5BuvDzxtGL4l4a9+XloRNHawuRIEJ+JOkEbmt3Z8C
 MwTdltLxsRdpr0ieB+e1OyFfM5EusTZXxXkW+R65zbClBUyprwMxPEpz/1li5OhFvDpieFq
 hTNb4vv3W58v46DpXqBtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:59+lD87P/+o=:9QytcjZkcB6aQuq2+wkjhD
 7V/UbSs6LuZJMicjDLLtzsdXWFSfgp5ZzlqcoWwnfqk5BWXcwNirOeBhZrK8QgSAep4pEZT3R
 ErmHCg/1Q6n7GibuGVXliab2UkJgQV9rcmlE5WdZzNqJ6x2uMlDa7gC5FvDhhbxD3PJg+Gu55
 Q4On8KNmik5d+2NdrkRWO3daGtzZ9qEnFK/b+DoipR6qr9UftKO7qHTYTx4+n2hOdAvtdgwjD
 wVGOvzlrfBcR/TwHNOGBD/j6LM+S9owklOU1WZwADLVuKnOiuXS5Zch40ukvx3vP1I1OMUGPW
 vzUasehQnQQmGf+ZPsdKrL54vmzbO6QYIgaQ/n/6wzqElPHikO8NoWOBD0pfsx6Qnisbb1nD5
 eRZGBxffeYrUXikdZYTpfm4ycG1Lh05EwZyUKPG8P/Q+4tmJkbrgRhYWjzNnW7lRp48rEXORY
 0bMN4CdqRztlZVv87tA310ACRtn+95lwyDf7kVT+XaXe/j92/dkFOoCJlLKa0fgrXMQVcR/Do
 HeU61AZEmua8ENAd41Pk59kCy4IoQeo2gusg4rOCZXHBf9iT0AiG0N1WTC/hENiaPyZqxOsCg
 H89IpQlpW3sljzwGKWFhQWrVDT/ZVVzA0/9nsKLNqVbGsmHzq/SWav6Gfki5M4kYWiXI52BJO
 xc8WqEJM0kx2/l2wm0CzFRhn8g/jBPJpozOhXseN0+epzVRTUCvqz1ukXMR/bHbp0pxzT6xmw
 fy5l9k0jgne8wCnLflPx4BEMdiTYWeyVyWdpVOh1mk66U9B/Mptd70wMwWSaofHOpza9DzlqH
 lSWO8j1V+OpAgYscJTRfac+Un6XfA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/libahci_platform.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 9e9583a..3d84be8 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -408,8 +408,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 
 	devres_add(dev, hpriv);
 
-	hpriv->mmio = devm_ioremap_resource(dev,
-			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
+	hpriv->mmio = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hpriv->mmio)) {
 		rc = PTR_ERR(hpriv->mmio);
 		goto err_out;
-- 
1.9.1

