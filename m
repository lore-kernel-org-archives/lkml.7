Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59FBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8588C214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfCLJU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:20:27 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:42555 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfCLJTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:19:48 -0400
Received: from orion.localdomain ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MeUPU-1gTTsD30lw-00aYsI; Tue, 12 Mar 2019 10:19:37 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linus.walleij@linaro.org, linux-ide@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 2/9] drivers: ata: ahci_seattle: use devm_platform_ioremap_resource()
Date:   Tue, 12 Mar 2019 10:19:27 +0100
Message-Id: <1552382374-28789-2-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552382374-28789-1-git-send-email-info@metux.net>
References: <1552382374-28789-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Di13Jip8xEGvSp6mzn349XBink/bXtPmF08DrpPdbMeRgT036OW
 vgH7ZsaEJcB21tUMuqNidPfuWvmO2CnaJgUMeFTGXsHwKXs11yVIZ3R0EsconIomWT9ZVPV
 E4R3NggPezf8Fl3sBS7rXIb5R1wQ12jZh+W43nWqNXmMVtgCtpCo3jf080qdZZ7Sy1kgeEt
 NWyeRuVKQ01OHrC1/pmIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F3mLKTxXFsk=:Yc1RaDIKCS8zGDZg0NMHwW
 aLYm3dQpbtsgDJjlTFSXLMNGX9y71bfX3vhNi9lybznAMIYbtEDH3XCWuetGAlRGYvr7UqR+j
 G1eyfLyKQabUE3ST5AcIyYnUs0BfvizupDFCZcBUn04M4QxcLSw5r6AhfG3SzKMi375PPpZua
 JmzXNa5tHOCieF1h2bs9tpx5pcIE0W3n3/S1UChxHtdtVY7HKYAurY3G2foaMjjPI2mP78rJY
 pATV5AO9n12J1vKJcE4YuwrvtYX76nBc87j8sbCwmKhQug6dkhqNdVog6xKI2HL/tqM1AmYC5
 VNKiB0kT9N0AslO4f/NjlCRHb6vHf0KysX6u0tz/hFDFYMw/wozygTGnIe7u57s4hN/WxksJK
 ZLl3t+8r4hQJYjLzVKYNBVFEliNIhjTqJOcdVMqud7BdIem6THX1x0deYYdOHYOUSKvhdV8sg
 5CADgFgkpjoA5IbrkIPdxkI8zPHbqVY+XdgzWJAR2BOy5d/sB0EJcgG+fLBxBpVOUa5J/lids
 aNb3hzBUfs931+1cxF74DgfuMUPWxsnr54Df7HBAkVe/L1JH50buTxj7SCgOh6vWmYkYKtBaX
 0K3tdbGsT0WCVAIt8EpiuNYtLquNYvRcRoLyXTpUx/qWz4KBDCUfGWWxb6icm726WpmqOMLTV
 c/eNeGae9kQ94wyr0h82ea8Fp/fs89oUI6zThsZIEll596X3MPUsbtMn48+ubZb9sLp6POytC
 5Gp/U+p0+CibUhjtg2AVfl6ujfWCBecmxMbWKA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new helper that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/ahci_seattle.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_seattle.c b/drivers/ata/ahci_seattle.c
index e57b6f9..9a10d81 100644
--- a/drivers/ata/ahci_seattle.c
+++ b/drivers/ata/ahci_seattle.c
@@ -140,8 +140,7 @@ static const struct ata_port_info *ahci_seattle_get_port_info(
 	if (!plat_data)
 		return &ahci_port_info;
 
-	plat_data->sgpio_ctrl = devm_ioremap_resource(dev,
-			      platform_get_resource(pdev, IORESOURCE_MEM, 1));
+	plat_data->sgpio_ctrl = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(plat_data->sgpio_ctrl))
 		return &ahci_port_info;
 
-- 
1.9.1

