Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CA8C2D0C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 00:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28932073B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 00:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfLLAM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 19:12:57 -0500
Received: from vegas.theobroma-systems.com ([144.76.126.164]:52765 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727067AbfLLAM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 19:12:57 -0500
Received: from 212-186-62-102.cable.dynamic.surfer.at ([212.186.62.102]:35684 helo=cm.fritz.box)
        by mail.theobroma-systems.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <christoph.muellner@theobroma-systems.com>)
        id 1ifC6A-0002dD-Ow; Thu, 12 Dec 2019 01:12:54 +0100
From:   christoph.muellner@theobroma-systems.com
Cc:     =?UTF-8?q?Christoph=20M=C3=BCllner?= 
        <christoph.muellner@theobroma-systems.com>,
        Till Harbaum <till@harbaum.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: tiny-usb: Correct I2C fault codes.
Date:   Thu, 12 Dec 2019 01:12:50 +0100
Message-Id: <20191212001251.85344-1-christoph.muellner@theobroma-systems.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Müllner <christoph.muellner@theobroma-systems.com>

This patch changes the I2C fault codes according to the specified
values in Documentation/i2c/fault-codes.

Signed-off-by: Christoph Müllner <christoph.muellner@theobroma-systems.com>
---
 drivers/i2c/busses/i2c-tiny-usb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tiny-usb.c b/drivers/i2c/busses/i2c-tiny-usb.c
index 43e3603489ee..7279ca0eaa2d 100644
--- a/drivers/i2c/busses/i2c-tiny-usb.c
+++ b/drivers/i2c/busses/i2c-tiny-usb.c
@@ -84,7 +84,7 @@ static int usb_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs, int num)
 				     pmsg->buf, pmsg->len) != pmsg->len) {
 				dev_err(&adapter->dev,
 					"failure reading data\n");
-				ret = -EREMOTEIO;
+				ret = -EIO;
 				goto out;
 			}
 		} else {
@@ -94,7 +94,7 @@ static int usb_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs, int num)
 				      pmsg->buf, pmsg->len) != pmsg->len) {
 				dev_err(&adapter->dev,
 					"failure writing data\n");
-				ret = -EREMOTEIO;
+				ret = -EIO;
 				goto out;
 			}
 		}
@@ -102,13 +102,13 @@ static int usb_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs, int num)
 		/* read status */
 		if (usb_read(adapter, CMD_GET_STATUS, 0, 0, pstatus, 1) != 1) {
 			dev_err(&adapter->dev, "failure reading status\n");
-			ret = -EREMOTEIO;
+			ret = -EIO;
 			goto out;
 		}
 
 		dev_dbg(&adapter->dev, "  status = %d\n", *pstatus);
 		if (*pstatus == STATUS_ADDRESS_NAK) {
-			ret = -EREMOTEIO;
+			ret = -ENXIO;
 			goto out;
 		}
 	}
-- 
2.23.0

