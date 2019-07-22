Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8DBC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BAAB218C9
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfGVR2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:28:03 -0400
Received: from sauhun.de ([88.99.104.3]:42308 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731445AbfGVR02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:26:28 -0400
Received: from localhost (p54B33E22.dip0.t-ipconnect.de [84.179.62.34])
        by pokefinder.org (Postfix) with ESMTPSA id 5942D4A149E;
        Mon, 22 Jul 2019 19:26:26 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] mfd: bcm590xx: convert to i2c_new_dummy_device
Date:   Mon, 22 Jul 2019 19:26:11 +0200
Message-Id: <20190722172623.4166-5-wsa+renesas@sang-engineering.com>
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

 drivers/mfd/bcm590xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
index 1aeb5e498d91..bfac5dc091ca 100644
--- a/drivers/mfd/bcm590xx.c
+++ b/drivers/mfd/bcm590xx.c
@@ -61,11 +61,11 @@ static int bcm590xx_i2c_probe(struct i2c_client *i2c_pri,
 	}
 
 	/* Secondary I2C slave address is the base address with A(2) asserted */
-	bcm590xx->i2c_sec = i2c_new_dummy(i2c_pri->adapter,
+	bcm590xx->i2c_sec = i2c_new_dummy_device(i2c_pri->adapter,
 					  i2c_pri->addr | BIT(2));
-	if (!bcm590xx->i2c_sec) {
+	if (IS_ERR(bcm590xx->i2c_sec)) {
 		dev_err(&i2c_pri->dev, "failed to add secondary I2C device\n");
-		return -ENODEV;
+		return PTR_ERR(bcm590xx->i2c_sec);
 	}
 	i2c_set_clientdata(bcm590xx->i2c_sec, bcm590xx);
 
-- 
2.20.1

