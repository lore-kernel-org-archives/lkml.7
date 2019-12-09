Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13225C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE72F206D3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfLIS4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:56:13 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:10589 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLIS4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:56:13 -0500
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQr4OGUPX+1JiWAnI+L0="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 46.0.2 DYNA|AUTH)
        with ESMTPSA id R01a59vB9IswbS2
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 9 Dec 2019 19:54:58 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20Perrochaud?= 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] NFC: nxp-nci: Fix probing without ACPI
Date:   Mon,  9 Dec 2019 19:53:43 +0100
Message-Id: <20191209185343.215893-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_acpi_dev_add_driver_gpios() returns -ENXIO if CONFIG_ACPI
is disabled (e.g. on device tree platforms).
In this case, nxp-nci will silently fail to probe.

The other NFC drivers only log a debug message if
devm_acpi_dev_add_driver_gpios() fails.
Do the same in nxp-nci to fix this problem.

Fixes: ad0acfd69add ("NFC: nxp-nci: Get rid of code duplication in ->probe()")
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/nfc/nxp-nci/i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index 4d1909aecd6c..9f60e4dc5a90 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -278,7 +278,7 @@ static int nxp_nci_i2c_probe(struct i2c_client *client,
 
 	r = devm_acpi_dev_add_driver_gpios(dev, acpi_nxp_nci_gpios);
 	if (r)
-		return r;
+		dev_dbg(dev, "Unable to add GPIO mapping table\n");
 
 	phy->gpiod_en = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
 	if (IS_ERR(phy->gpiod_en)) {
-- 
2.24.0

