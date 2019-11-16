Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E06C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7276B21847
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921610;
	bh=tWAdVYLHMTE3vCjickhx0yIbPKCzlQ9aZb9fEW8zGJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=che4h0IEnKCccch2vtADza6LoRAhTqgoMmb4Ljb8BUMmHGb8Mq/mp9KOVLfGYiy+e
	 67hiRa6tpoEatIOrGkVLqQ1CfOtGTNdJJ4/YiC8oq98b1FtSvpsY/bCHu4Zej79NfT
	 4G1c2PN6FfAnQvkOJcGg4W0q4KLuEh5qOfIHJfUY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbfKPQ0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:26:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbfKPPlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:41:49 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76A1720740;
        Sat, 16 Nov 2019 15:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573918908;
        bh=tWAdVYLHMTE3vCjickhx0yIbPKCzlQ9aZb9fEW8zGJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PsDgNx1/Zz+s7btb/9po9WQmWRgId7hT13cx4Rlyjs73E0bMVQNlO82Z9h/yCRNmB
         B3nIC//z3KYLnSz6LPoytVG0Io3UBKbHVXQsLMQNfTRNzHg0M6/eY+35DEaDaXOmyL
         LeP4cPMevZv5NjzZWhr/GC3LaMcQdbhxM+OxX5Cw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julien Folly <julien.folly@gmail.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 032/237] w1: IAD Register is yet readable trough iad sys file. Fix snprintf (%u for unsigned, count for max size).
Date:   Sat, 16 Nov 2019 10:37:47 -0500
Message-Id: <20191116154113.7417-32-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Folly <julien.folly@gmail.com>

[ Upstream commit 6eaafbb6998e999467cf78a76e155ee00e372b14 ]

IAD Register is yet readable trough the "iad" sys file.

A write to the "iad" sys file enables or disables the current
measurement, but it was not possible to get the measured value by
reading it.
Fix: %u in snprintf for unsigned values (vdd and vad)
Fix: Avoid possibles overflows (Usage of the 'count' variables)

Signed-off-by: Julien Folly <julien.folly@gmail.com>
Acked-by: Evgeniy Polyakov <zbr@ioremap.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/w1/slaves/w1_ds2438.c | 66 +++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 14 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index bf641a191d077..7c4e33dbee4d5 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -186,8 +186,8 @@ static int w1_ds2438_change_config_bit(struct w1_slave *sl, u8 mask, u8 value)
 	return -1;
 }
 
-static uint16_t w1_ds2438_get_voltage(struct w1_slave *sl,
-				      int adc_input, uint16_t *voltage)
+static int w1_ds2438_get_voltage(struct w1_slave *sl,
+				 int adc_input, uint16_t *voltage)
 {
 	unsigned int retries = W1_DS2438_RETRIES;
 	u8 w1_buf[DS2438_PAGE_SIZE + 1 /*for CRC*/];
@@ -235,6 +235,25 @@ static uint16_t w1_ds2438_get_voltage(struct w1_slave *sl,
 	return ret;
 }
 
+static int w1_ds2438_get_current(struct w1_slave *sl, int16_t *voltage)
+{
+	u8 w1_buf[DS2438_PAGE_SIZE + 1 /*for CRC*/];
+	int ret;
+
+	mutex_lock(&sl->master->bus_mutex);
+
+	if (w1_ds2438_get_page(sl, 0, w1_buf) == 0) {
+		/* The voltage measured across current sense resistor RSENS. */
+		*voltage = (((int16_t) w1_buf[DS2438_CURRENT_MSB]) << 8) | ((int16_t) w1_buf[DS2438_CURRENT_LSB]);
+		ret = 0;
+	} else
+		ret = -1;
+
+	mutex_unlock(&sl->master->bus_mutex);
+
+	return ret;
+}
+
 static ssize_t iad_write(struct file *filp, struct kobject *kobj,
 			 struct bin_attribute *bin_attr, char *buf,
 			 loff_t off, size_t count)
@@ -257,6 +276,27 @@ static ssize_t iad_write(struct file *filp, struct kobject *kobj,
 	return ret;
 }
 
+static ssize_t iad_read(struct file *filp, struct kobject *kobj,
+			struct bin_attribute *bin_attr, char *buf,
+			loff_t off, size_t count)
+{
+	struct w1_slave *sl = kobj_to_w1_slave(kobj);
+	int ret;
+	int16_t voltage;
+
+	if (off != 0)
+		return 0;
+	if (!buf)
+		return -EINVAL;
+
+	if (w1_ds2438_get_current(sl, &voltage) == 0) {
+		ret = snprintf(buf, count, "%i\n", voltage);
+	} else
+		ret = -EIO;
+
+	return ret;
+}
+
 static ssize_t page0_read(struct file *filp, struct kobject *kobj,
 			  struct bin_attribute *bin_attr, char *buf,
 			  loff_t off, size_t count)
@@ -272,9 +312,13 @@ static ssize_t page0_read(struct file *filp, struct kobject *kobj,
 
 	mutex_lock(&sl->master->bus_mutex);
 
+	/* Read no more than page0 size */
+	if (count > DS2438_PAGE_SIZE)
+		count = DS2438_PAGE_SIZE;
+
 	if (w1_ds2438_get_page(sl, 0, w1_buf) == 0) {
-		memcpy(buf, &w1_buf, DS2438_PAGE_SIZE);
-		ret = DS2438_PAGE_SIZE;
+		memcpy(buf, &w1_buf, count);
+		ret = count;
 	} else
 		ret = -EIO;
 
@@ -289,7 +333,6 @@ static ssize_t temperature_read(struct file *filp, struct kobject *kobj,
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
 	int ret;
-	ssize_t c = PAGE_SIZE;
 	int16_t temp;
 
 	if (off != 0)
@@ -298,8 +341,7 @@ static ssize_t temperature_read(struct file *filp, struct kobject *kobj,
 		return -EINVAL;
 
 	if (w1_ds2438_get_temperature(sl, &temp) == 0) {
-		c -= snprintf(buf + PAGE_SIZE - c, c, "%d\n", temp);
-		ret = PAGE_SIZE - c;
+		ret = snprintf(buf, count, "%i\n", temp);
 	} else
 		ret = -EIO;
 
@@ -312,7 +354,6 @@ static ssize_t vad_read(struct file *filp, struct kobject *kobj,
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
 	int ret;
-	ssize_t c = PAGE_SIZE;
 	uint16_t voltage;
 
 	if (off != 0)
@@ -321,8 +362,7 @@ static ssize_t vad_read(struct file *filp, struct kobject *kobj,
 		return -EINVAL;
 
 	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VAD, &voltage) == 0) {
-		c -= snprintf(buf + PAGE_SIZE - c, c, "%d\n", voltage);
-		ret = PAGE_SIZE - c;
+		ret = snprintf(buf, count, "%u\n", voltage);
 	} else
 		ret = -EIO;
 
@@ -335,7 +375,6 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
 	int ret;
-	ssize_t c = PAGE_SIZE;
 	uint16_t voltage;
 
 	if (off != 0)
@@ -344,15 +383,14 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
 		return -EINVAL;
 
 	if (w1_ds2438_get_voltage(sl, DS2438_ADC_INPUT_VDD, &voltage) == 0) {
-		c -= snprintf(buf + PAGE_SIZE - c, c, "%d\n", voltage);
-		ret = PAGE_SIZE - c;
+		ret = snprintf(buf, count, "%u\n", voltage);
 	} else
 		ret = -EIO;
 
 	return ret;
 }
 
-static BIN_ATTR(iad, S_IRUGO | S_IWUSR | S_IWGRP, NULL, iad_write, 1);
+static BIN_ATTR(iad, S_IRUGO | S_IWUSR | S_IWGRP, iad_read, iad_write, 0);
 static BIN_ATTR_RO(page0, DS2438_PAGE_SIZE);
 static BIN_ATTR_RO(temperature, 0/* real length varies */);
 static BIN_ATTR_RO(vad, 0/* real length varies */);
-- 
2.20.1

