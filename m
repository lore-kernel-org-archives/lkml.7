Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5984C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904B6214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfCLJTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:19:52 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:35403 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfCLJTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:19:49 -0400
Received: from orion.localdomain ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1McZfZ-1gVOcB2UXd-00d2ud; Tue, 12 Mar 2019 10:19:38 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 5/9] drivers: ata: libahci_platform: use devm_platform_ioremap_resource()
Date:   Tue, 12 Mar 2019 10:19:30 +0100
Message-Id: <1552382374-28789-5-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552382374-28789-1-git-send-email-info@metux.net>
References: <1552382374-28789-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:yJo80UzxFeQGn4mOEANaEv3N8XS+LV8pXxqzCyLuavfUd4pHkjn
 zSM0Bbu/1gqZ8/ykMGJVppZJRSYzUIlFrsmVsUkxyhU5fi7SCr77bh2qNymhCBnflQZMzMZ
 2FVrcqlH7MSxertLDG0hOR+lbfR0SLsGQUpiO0Pacs8Uuo44sVvh3+NJGx5+tVpAgvXCIa5
 2B61NpAL2UTjL8a5om2sw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IKHoLh2INEw=:Is4uReW/XilG8EwGXv+m8G
 YAu5sgkEdYi3gC0eh3F/x4EG7hXlhRsxHFAuavTx89cTPwNhLpvN0pjq6Fpgs14qBKNw0S/sv
 JgQz9iiVStPTwyNSPAElBRI+X1dF1o33TcEUwEM7LFppOuSpA3IWlNqvB1rJVXND2qB+0KJF+
 pdCK36gIm028XYBq9rYQ+OYnwb2W9p60TOkT5Mu74WtZmz29wPC+2KcaX1YTx7QKmd29oxziL
 ModhmtH+WfiACMdt/pHvc8sBHo5FZkdPpM9HirQj0qZHAO+xut3Zp4AD+SF3uAsCOKMW5LKwy
 QR/JnCEDy7cCFgkG+mBPxw/MpvgJ/UNHXeyJpJ/NsfeyNqkK4XluVSvZb2YjZjybToBbAeUrb
 JN6cDdRBv2zFXbfgg5QQ96zXcVcJ1T3blMHUkqJf0TyxAYFwarfIYsam++d1Yc94KYCNPcPkQ
 13890JfuD610Q9gTAoNR7/3d/mRLtjaqLkpi6MNHHYDBSZr7saJsbFboLcETSTyZ5zWcmPunm
 adz+wM/bA8dIfrmVEbdU/A/+wNoWsO5Y0XNYdzjpIGtpMN3wW6cxLTJSDqvk+mdMhkWGIOf2c
 5lDjPIbIwtwEuB9neD9i6i+GcaJo02sayjZRp5AlE8Rry9VmDi/vtUqKpMpa9LOxgoo2jccTq
 hCFzBQB7G0Qd4VuE4i1PusbwBYhz47mEUk2C5vyAzUcDNIFDhewDlcfRcfBcVQ1RwPJbpkM7v
 m7ijvQ3h23JQh+KCycNuL6YNFdx8j9U35c87Gw==
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
index 81b1a33..8dc8b9a 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -409,8 +409,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 
 	devres_add(dev, hpriv);
 
-	hpriv->mmio = devm_ioremap_resource(dev,
-			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
+	hpriv->mmio = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hpriv->mmio)) {
 		dev_err(dev, "no mmio space\n");
 		rc = PTR_ERR(hpriv->mmio);
-- 
1.9.1

