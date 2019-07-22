Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3066DC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E3922296
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbfGVR0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:26:07 -0400
Received: from sauhun.de ([88.99.104.3]:42110 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731280AbfGVR0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:26:04 -0400
Received: from localhost (p54B33E22.dip0.t-ipconnect.de [84.179.62.34])
        by pokefinder.org (Postfix) with ESMTPSA id 75FFD4A1491;
        Mon, 22 Jul 2019 19:26:02 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] extcon: extcon-max77843: convert to i2c_new_dummy_device
Date:   Mon, 22 Jul 2019 19:26:01 +0200
Message-Id: <20190722172601.3506-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722172601.3506-1-wsa+renesas@sang-engineering.com>
References: <20190722172601.3506-1-wsa+renesas@sang-engineering.com>
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

 drivers/extcon/extcon-max77843.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max77843.c
index a343a6ef3506..e6b50ca83008 100644
--- a/drivers/extcon/extcon-max77843.c
+++ b/drivers/extcon/extcon-max77843.c
@@ -774,12 +774,12 @@ static int max77843_init_muic_regmap(struct max77693_dev *max77843)
 {
 	int ret;
 
-	max77843->i2c_muic = i2c_new_dummy(max77843->i2c->adapter,
+	max77843->i2c_muic = i2c_new_dummy_device(max77843->i2c->adapter,
 			I2C_ADDR_MUIC);
-	if (!max77843->i2c_muic) {
+	if (IS_ERR(max77843->i2c_muic)) {
 		dev_err(&max77843->i2c->dev,
 				"Cannot allocate I2C device for MUIC\n");
-		return -ENOMEM;
+		return PTR_ERR(max77843->i2c_muic);
 	}
 
 	i2c_set_clientdata(max77843->i2c_muic, max77843);
-- 
2.20.1

