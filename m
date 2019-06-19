Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B220C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2012E20657
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbfFSRSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:18:11 -0400
Received: from sauhun.de ([88.99.104.3]:60004 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfFSRSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:18:11 -0400
Received: from localhost (p5486CF02.dip0.t-ipconnect.de [84.134.207.2])
        by pokefinder.org (Postfix) with ESMTPSA id 553832C353A;
        Wed, 19 Jun 2019 19:18:09 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH] mfd: da9063: occupy second I2C address, too
Date:   Wed, 19 Jun 2019 19:18:06 +0200
Message-Id: <20190619171806.30116-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though we don't use it yet, we should mark the second I2C address
this device is listening to as used.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 drivers/mfd/da9063-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 455de74c0dd2..2133b09f6e7a 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -221,6 +221,8 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	devm_i2c_new_dummy_device(&i2c->dev, i2c->adapter, i2c->addr + 1);
+
 	return da9063_device_init(da9063, i2c->irq);
 }
 
-- 
2.20.1

