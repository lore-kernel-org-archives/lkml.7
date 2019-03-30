Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDAEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 20:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6162184D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 20:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbfC3UiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 16:38:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57326 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730589AbfC3UiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 16:38:00 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hAKjl-0000VY-Do; Sat, 30 Mar 2019 20:37:57 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jan-Simon Moeller <jansimon.moeller@gmx.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] leds: blinkm: clean up double assignment to data->i2c_addr
Date:   Sat, 30 Mar 2019 20:37:57 +0000
Message-Id: <20190330203757.8877-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently data->i2c_addr is being assigned twice, first with the
value 0x09 and then immediately afterwards with the value 0x08.
The first assignment is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/leds/leds-blinkm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/leds/leds-blinkm.c b/drivers/leds/leds-blinkm.c
index 851c1920b63c..11b771fb933b 100644
--- a/drivers/leds/leds-blinkm.c
+++ b/drivers/leds/leds-blinkm.c
@@ -594,7 +594,6 @@ static int blinkm_probe(struct i2c_client *client,
 		goto exit;
 	}
 
-	data->i2c_addr = 0x09;
 	data->i2c_addr = 0x08;
 	/* i2c addr  - use fake addr of 0x08 initially (real is 0x09) */
 	data->fw_ver = 0xfe;
-- 
2.20.1

