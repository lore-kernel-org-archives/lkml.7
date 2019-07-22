Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A24AC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8BB218C9
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbfGVR2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:28:21 -0400
Received: from sauhun.de ([88.99.104.3]:42314 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731432AbfGVR00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:26:26 -0400
Received: from localhost (p54B33E22.dip0.t-ipconnect.de [84.179.62.34])
        by pokefinder.org (Postfix) with ESMTPSA id AE4F54A148F;
        Mon, 22 Jul 2019 19:26:24 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] mfd: 88pm800: convert to i2c_new_dummy_device
Date:   Mon, 22 Jul 2019 19:26:08 +0200
Message-Id: <20190722172623.4166-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
ERRPTR which we use in error handling.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

 drivers/mfd/88pm800.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index f2d9fb4c4e8e..4e8d0d6b9b5c 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -425,10 +425,10 @@ static int pm800_pages_init(struct pm80x_chip *chip)
 		return -ENODEV;
 
 	/* PM800 block power page */
-	subchip->power_page = i2c_new_dummy(client->adapter,
+	subchip->power_page = i2c_new_dummy_device(client->adapter,
 					    subchip->power_page_addr);
-	if (subchip->power_page == NULL) {
-		ret = -ENODEV;
+	if (IS_ERR(subchip->power_page)) {
+		ret = PTR_ERR(subchip->power_page);
 		goto out;
 	}
 
@@ -444,10 +444,10 @@ static int pm800_pages_init(struct pm80x_chip *chip)
 	i2c_set_clientdata(subchip->power_page, chip);
 
 	/* PM800 block GPADC */
-	subchip->gpadc_page = i2c_new_dummy(client->adapter,
+	subchip->gpadc_page = i2c_new_dummy_device(client->adapter,
 					    subchip->gpadc_page_addr);
-	if (subchip->gpadc_page == NULL) {
-		ret = -ENODEV;
+	if (IS_ERR(subchip->gpadc_page)) {
+		ret = PTR_ERR(subchip->gpadc_page);
 		goto out;
 	}
 
-- 
2.20.1

