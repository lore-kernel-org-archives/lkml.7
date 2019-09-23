Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BE2C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7A720882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PzOKP8qA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438368AbfIWQuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:50:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33501 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389516AbfIWQuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:50:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id d22so5438628pls.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8lkjVOpBBtIvnfc8AqZi/EJdsVEqhXIY7s5zuRbnasU=;
        b=PzOKP8qAP9DGrZdJV556JQ6gQrZjskm445fYPVhwBmnFQu/XjhTMoBDvFOS1L9iCUa
         t1+x2fQMIJztXSsdUuiq2MDlf+2xnNomLibHr/2PXyfAnCCwqrapcp3xWCazmAZJZdXF
         zPTw/RhAu16RsLadMNoDbDIoXn7E5GHz/sQ6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8lkjVOpBBtIvnfc8AqZi/EJdsVEqhXIY7s5zuRbnasU=;
        b=dlj6aADNfswyhdDaj7fp9nHKHL7OvbtjXSoMzwW8OVFx8ywJByhj7KpZxMWosprheE
         eCY9Tj1rtgllhl9SspHU1BP5/ZA+a+Uc/1AW4uixNBLmqRlqfA4XwXZSE4Imqx6qi4q9
         vF4kQt4ORkrertfjO8q2HnPnVzMXWXjJjN49KiPH7ulUaueGWqOawO/JRprDqhjCVC1A
         A6G5do9Jb3xAlGYQmp+mrNHmd7SE7xniKmRgltl3w5SwaeJtqG6RAfCcWA6xsyqQ0mHF
         EyprL8lCPieW8so30ab2lJpNnq/67LwY+gDMgf4wpEgs/BMHrHr8OfEPAnhuQpeOa0qx
         rlQQ==
X-Gm-Message-State: APjAAAWd+0/Vc1rMq+Rxz8Sg2cxcnmmyWEY7oNPy0EXIMFK9UpWQpxBt
        otL+dFSPpYBKOowoABSYEUVQPg==
X-Google-Smtp-Source: APXvYqySjXIKtbcZJEIN5DNhGeFoBXP/BrxsEcZ0djdUYK58L9YeTQB1kFHMIfMeneWRMGc0uvDOfw==
X-Received: by 2002:a17:902:6bc7:: with SMTP id m7mr746474plt.60.1569257420183;
        Mon, 23 Sep 2019 09:50:20 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id o195sm16534690pfg.21.2019.09.23.09.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Sep 2019 09:50:19 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Nick Dyer <nick@shmanahar.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jongpil Jung <jongpil19.jung@samsung.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH] Input: atmel_mxt_ts - Disable IRQ across suspend
Date:   Mon, 23 Sep 2019 09:50:04 -0700
Message-Id: <20190923165004.161846-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Across suspend and resume, we are seeing error messages like the following:

atmel_mxt_ts i2c-PRP0001:00: __mxt_read_reg: i2c transfer failed (-121)
atmel_mxt_ts i2c-PRP0001:00: Failed to read T44 and T5 (-121)

This occurs because the driver leaves its IRQ enabled. Upon resume, there
is an IRQ pending, but the interrupt is serviced before both the driver and
the underlying I2C bus have been resumed. This causes EREMOTEIO errors.

Disable the IRQ in suspend, and re-enable it if it was previously enabled
in resume.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 drivers/input/touchscreen/atmel_mxt_ts.c | 33 +++++++++++++++++++-----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 24c4b691b1c9..19cbcd9767e2 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -291,6 +291,7 @@ struct mxt_data {
 	u8 xsize;
 	u8 ysize;
 	bool in_bootloader;
+	bool irq_enabled;
 	u16 mem_size;
 	u8 t100_aux_ampl;
 	u8 t100_aux_area;
@@ -1185,11 +1186,23 @@ static int mxt_t6_command(struct mxt_data *data, u16 cmd_offset,
 	return 0;
 }
 
+static void mxt_enable_irq(struct mxt_data *data)
+{
+	enable_irq(data->irq);
+	data->irq_enabled = true;
+}
+
+static void mxt_disable_irq(struct mxt_data *data)
+{
+	disable_irq(data->irq);
+	data->irq_enabled = false;
+}
+
 static int mxt_acquire_irq(struct mxt_data *data)
 {
 	int error;
 
-	enable_irq(data->irq);
+	mxt_enable_irq(data);
 
 	error = mxt_process_messages_until_invalid(data);
 	if (error)
@@ -1205,7 +1218,7 @@ static int mxt_soft_reset(struct mxt_data *data)
 
 	dev_info(dev, "Resetting device\n");
 
-	disable_irq(data->irq);
+	mxt_disable_irq(data);
 
 	reinit_completion(&data->reset_completion);
 
@@ -2807,7 +2820,7 @@ static int mxt_load_fw(struct device *dev, const char *fn)
 		mxt_free_input_device(data);
 		mxt_free_object_table(data);
 	} else {
-		enable_irq(data->irq);
+		mxt_enable_irq(data);
 	}
 
 	reinit_completion(&data->bl_completion);
@@ -2882,7 +2895,7 @@ static int mxt_load_fw(struct device *dev, const char *fn)
 	data->in_bootloader = false;
 
 disable_irq:
-	disable_irq(data->irq);
+	mxt_disable_irq(data);
 release_firmware:
 	release_firmware(fw);
 	return ret;
@@ -3101,7 +3114,7 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return error;
 	}
 
-	disable_irq(client->irq);
+	mxt_disable_irq(data);
 
 	if (data->reset_gpio) {
 		msleep(MXT_RESET_GPIO_TIME);
@@ -3132,7 +3145,7 @@ static int mxt_remove(struct i2c_client *client)
 {
 	struct mxt_data *data = i2c_get_clientdata(client);
 
-	disable_irq(data->irq);
+	mxt_disable_irq(data);
 	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
 	mxt_free_input_device(data);
 	mxt_free_object_table(data);
@@ -3156,6 +3169,11 @@ static int __maybe_unused mxt_suspend(struct device *dev)
 
 	mutex_unlock(&input_dev->mutex);
 
+	/*
+	 * Disable the IRQ directly since the boolean will be used to restore
+	 * the IRQ state on resume.
+	 */
+	disable_irq(data->irq);
 	return 0;
 }
 
@@ -3168,6 +3186,9 @@ static int __maybe_unused mxt_resume(struct device *dev)
 	if (!input_dev)
 		return 0;
 
+	if (data->irq_enabled)
+		enable_irq(data->irq);
+
 	mutex_lock(&input_dev->mutex);
 
 	if (input_dev->users)
-- 
2.21.0

