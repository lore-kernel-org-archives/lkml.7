Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE3DC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B80F206DB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgAFNGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 08:06:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44427 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgAFNGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 08:06:13 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1ioS5B-00052C-E5; Mon, 06 Jan 2020 13:06:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: ohci-da8xx: ensure error return on variable error is set
Date:   Mon,  6 Jan 2020 13:06:09 +0000
Message-Id: <20200106130609.51174-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when an error in da8xx_ohci->oc_gpi occurs causes an
uninitialized error value in variable 'error' to be returned. 
Fix this by ensuring the error variable is set to the error value
in da8xx_ohci->oc_gpi.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: d193abf1c913 ("usb: ohci-da8xx: add vbus and overcurrent gpios")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/host/ohci-da8xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 38183ac438c6..9cdf787055b7 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -415,8 +415,10 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 	}
 
 	da8xx_ohci->oc_gpio = devm_gpiod_get_optional(dev, "oc", GPIOD_IN);
-	if (IS_ERR(da8xx_ohci->oc_gpio))
+	if (IS_ERR(da8xx_ohci->oc_gpio)) {
+		error = PTR_ERR(da8xx_ohci->oc_gpio);
 		goto err;
+	}
 
 	if (da8xx_ohci->oc_gpio) {
 		oc_irq = gpiod_to_irq(da8xx_ohci->oc_gpio);
-- 
2.24.0

