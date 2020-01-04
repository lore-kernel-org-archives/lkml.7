Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A670C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 10:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65644222C4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 10:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="PycqFIRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgADKc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 05:32:59 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:24730 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgADKc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 05:32:59 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47qdQK0RByzGW;
        Sat,  4 Jan 2020 11:32:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578133977; bh=KrUZOzPx+jkYrJb5d97gjEnjK5otl1taF0f+W4/qFdk=;
        h=Date:From:Subject:To:Cc:From;
        b=PycqFIRzHPPdgrNXcLUfEEc/uVxW1chMbmWmM+wuclIU4yAfKKt4kb7BTGU5dYukm
         pQ5+zVHJAzsROLAJ/IVgxHKHexAbs/049txhWTIuc3Rogl8iRSFRApG5lmm9VFTgeq
         IOi/IIb+QnFhKiIAEfvFDTCC++Fz5pxGUNvygIOnVExH2i5zK/2A4Jh6tI1F8URLVl
         68LtjYgI+K5VSkuPcUz8gU9vaPJ2pSOhgo9Tos9zI16ixroAaKzpXI6hWq5rhzbVGL
         zuusFIgxhc+8BKHkKAuQkhSFJ0vyMXOiXiZPVpSPj1fhCxu9kcW6uOcspUoMigJjxO
         4Y5qlzEqYzBQw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Sat, 04 Jan 2020 11:32:56 +0100
Message-Id: <d05ad8998ac476aafe471d723856b16df8eec97f.1578133241.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] regmap-i2c: constify regmap_bus structures
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/base/regmap/regmap-i2c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index ac9b31c57967..008f8da69d97 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -43,7 +43,7 @@ static int regmap_smbus_byte_reg_write(void *context, unsigned int reg,
 	return i2c_smbus_write_byte_data(i2c, reg, val);
 }
 
-static struct regmap_bus regmap_smbus_byte = {
+static const struct regmap_bus regmap_smbus_byte = {
 	.reg_write = regmap_smbus_byte_reg_write,
 	.reg_read = regmap_smbus_byte_reg_read,
 };
@@ -79,7 +79,7 @@ static int regmap_smbus_word_reg_write(void *context, unsigned int reg,
 	return i2c_smbus_write_word_data(i2c, reg, val);
 }
 
-static struct regmap_bus regmap_smbus_word = {
+static const struct regmap_bus regmap_smbus_word = {
 	.reg_write = regmap_smbus_word_reg_write,
 	.reg_read = regmap_smbus_word_reg_read,
 };
@@ -115,7 +115,7 @@ static int regmap_smbus_word_write_swapped(void *context, unsigned int reg,
 	return i2c_smbus_write_word_swapped(i2c, reg, val);
 }
 
-static struct regmap_bus regmap_smbus_word_swapped = {
+static const struct regmap_bus regmap_smbus_word_swapped = {
 	.reg_write = regmap_smbus_word_write_swapped,
 	.reg_read = regmap_smbus_word_read_swapped,
 };
@@ -197,7 +197,7 @@ static int regmap_i2c_read(void *context,
 		return -EIO;
 }
 
-static struct regmap_bus regmap_i2c = {
+static const struct regmap_bus regmap_i2c = {
 	.write = regmap_i2c_write,
 	.gather_write = regmap_i2c_gather_write,
 	.read = regmap_i2c_read,
@@ -239,7 +239,7 @@ static int regmap_i2c_smbus_i2c_read(void *context, const void *reg,
 		return -EIO;
 }
 
-static struct regmap_bus regmap_i2c_smbus_i2c_block = {
+static const struct regmap_bus regmap_i2c_smbus_i2c_block = {
 	.write = regmap_i2c_smbus_i2c_write,
 	.read = regmap_i2c_smbus_i2c_read,
 	.max_raw_read = I2C_SMBUS_BLOCK_MAX,
-- 
2.20.1

