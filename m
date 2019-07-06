Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A410CC0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 16:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B0F2083B
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 16:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562431710;
	bh=lXv0IUjwDee6Mz/14tiR2B9luWiq3nJe/U5UhZnCCSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sFvaXO6jV+ij4IoQZJ/Q+sZBlZOnXGqU6QeAO7KgyPvabUHemq8QDt69PGoVwkDZ2
	 goyNnFK4OnaKktiUskQkxtBTj+L2mRh1dk7OWzBq42N0A2iyBR4l9evdRVxa3Qr/IT
	 W1SypG/fy89uMtjtZaa6N1Dr5M5rjgzT9C1g2UeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfGFQsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 12:48:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfGFQsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 12:48:18 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 559D220836;
        Sat,  6 Jul 2019 16:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562431697;
        bh=lXv0IUjwDee6Mz/14tiR2B9luWiq3nJe/U5UhZnCCSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gxtsvi8sLenV+YlphxC4iuw9Q9kU5MHIMGsHvVKAa0dGl6Z9W5QaloyNIGn2yUy1b
         KkNeUR1Ru8HgxFPthfQO2W/eoXJmAPWQUnwkc78N+MQptH/N9tr769SBC22HqpefoC
         eyW3wzPjdqYCfR/mwrq3rm/pGDH2GojhZ00IhoAk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/3] mfd: ab8500: no need to check return value of debugfs_create functions
Date:   Sat,  6 Jul 2019 18:47:21 +0200
Message-Id: <20190706164722.18766-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190706164722.18766-1-gregkh@linuxfoundation.org>
References: <20190706164722.18766-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mfd/ab8500-debugfs.c | 324 +++++++++++------------------------
 1 file changed, 98 insertions(+), 226 deletions(-)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index d24c6ecccb88..567a34b073dd 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -2644,12 +2644,10 @@ static const struct file_operations ab8500_hwreg_fops = {
 	.owner = THIS_MODULE,
 };
 
-static struct dentry *ab8500_dir;
-static struct dentry *ab8500_gpadc_dir;
-
 static int ab8500_debug_probe(struct platform_device *plf)
 {
-	struct dentry *file;
+	struct dentry *ab8500_dir;
+	struct dentry *ab8500_gpadc_dir;
 	struct ab8500 *ab8500;
 	struct resource *res;
 
@@ -2694,47 +2692,22 @@ static int ab8500_debug_probe(struct platform_device *plf)
 	}
 
 	ab8500_dir = debugfs_create_dir(AB8500_NAME_STRING, NULL);
-	if (!ab8500_dir)
-		goto err;
 
 	ab8500_gpadc_dir = debugfs_create_dir(AB8500_ADC_NAME_STRING,
 					      ab8500_dir);
-	if (!ab8500_gpadc_dir)
-		goto err;
-
-	file = debugfs_create_file("all-bank-registers", S_IRUGO, ab8500_dir,
-				   &plf->dev, &ab8500_bank_registers_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("all-banks", S_IRUGO, ab8500_dir,
-				   &plf->dev, &ab8500_all_banks_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("register-bank",
-				   (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_dir, &plf->dev, &ab8500_bank_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("register-address",
-				   (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_dir, &plf->dev, &ab8500_address_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("register-value",
-				   (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_dir, &plf->dev, &ab8500_val_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("irq-subscribe",
-				   (S_IRUGO | S_IWUSR | S_IWGRP), ab8500_dir,
-				   &plf->dev, &ab8500_subscribe_fops);
-	if (!file)
-		goto err;
+
+	debugfs_create_file("all-bank-registers", S_IRUGO, ab8500_dir,
+			    &plf->dev, &ab8500_bank_registers_fops);
+	debugfs_create_file("all-banks", S_IRUGO, ab8500_dir,
+			    &plf->dev, &ab8500_all_banks_fops);
+	debugfs_create_file("register-bank", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_dir, &plf->dev, &ab8500_bank_fops);
+	debugfs_create_file("register-address", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_dir, &plf->dev, &ab8500_address_fops);
+	debugfs_create_file("register-value", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_dir, &plf->dev, &ab8500_val_fops);
+	debugfs_create_file("irq-subscribe", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_dir, &plf->dev, &ab8500_subscribe_fops);
 
 	if (is_ab8500(ab8500)) {
 		debug_ranges = ab8500_debug_ranges;
@@ -2750,194 +2723,93 @@ static int ab8500_debug_probe(struct platform_device *plf)
 		num_interrupt_lines = AB8540_NR_IRQS;
 	}
 
-	file = debugfs_create_file("interrupts", (S_IRUGO), ab8500_dir,
-				   &plf->dev, &ab8500_interrupts_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("irq-unsubscribe",
-				   (S_IRUGO | S_IWUSR | S_IWGRP), ab8500_dir,
-				   &plf->dev, &ab8500_unsubscribe_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("hwreg", (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_dir, &plf->dev, &ab8500_hwreg_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("all-modem-registers",
-				   (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_dir, &plf->dev, &ab8500_modem_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("bat_ctrl", (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_gpadc_dir, &plf->dev,
-				   &ab8500_gpadc_bat_ctrl_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("btemp_ball", (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_gpadc_dir,
-				   &plf->dev, &ab8500_gpadc_btemp_ball_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("main_charger_v",
-				   (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_gpadc_dir, &plf->dev,
-				   &ab8500_gpadc_main_charger_v_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("acc_detect1",
-				   (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_gpadc_dir, &plf->dev,
-				   &ab8500_gpadc_acc_detect1_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("acc_detect2",
-				   (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_gpadc_dir, &plf->dev,
-				   &ab8500_gpadc_acc_detect2_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("adc_aux1", (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_gpadc_dir, &plf->dev,
-				   &ab8500_gpadc_aux1_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("adc_aux2", (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_gpadc_dir, &plf->dev,
-				   &ab8500_gpadc_aux2_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("main_bat_v", (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_gpadc_dir, &plf->dev,
-				   &ab8500_gpadc_main_bat_v_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("vbus_v", (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_gpadc_dir, &plf->dev,
-				   &ab8500_gpadc_vbus_v_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("main_charger_c",
-				   (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_gpadc_dir, &plf->dev,
-				   &ab8500_gpadc_main_charger_c_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("usb_charger_c",
-				   (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_gpadc_dir,
-				   &plf->dev, &ab8500_gpadc_usb_charger_c_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("bk_bat_v", (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_gpadc_dir, &plf->dev,
-				   &ab8500_gpadc_bk_bat_v_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("die_temp", (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_gpadc_dir, &plf->dev,
-				   &ab8500_gpadc_die_temp_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("usb_id", (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_gpadc_dir, &plf->dev,
-				   &ab8500_gpadc_usb_id_fops);
-	if (!file)
-		goto err;
-
+	debugfs_create_file("interrupts", (S_IRUGO), ab8500_dir, &plf->dev,
+			    &ab8500_interrupts_fops);
+	debugfs_create_file("irq-unsubscribe", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_dir, &plf->dev, &ab8500_unsubscribe_fops);
+	debugfs_create_file("hwreg", (S_IRUGO | S_IWUSR | S_IWGRP), ab8500_dir,
+			    &plf->dev, &ab8500_hwreg_fops);
+	debugfs_create_file("all-modem-registers", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_dir, &plf->dev, &ab8500_modem_fops);
+	debugfs_create_file("bat_ctrl", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_gpadc_dir, &plf->dev,
+			    &ab8500_gpadc_bat_ctrl_fops);
+	debugfs_create_file("btemp_ball", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_gpadc_dir, &plf->dev,
+			    &ab8500_gpadc_btemp_ball_fops);
+	debugfs_create_file("main_charger_v", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_gpadc_dir, &plf->dev,
+			    &ab8500_gpadc_main_charger_v_fops);
+	debugfs_create_file("acc_detect1", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_gpadc_dir, &plf->dev,
+			    &ab8500_gpadc_acc_detect1_fops);
+	debugfs_create_file("acc_detect2", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_gpadc_dir, &plf->dev,
+			    &ab8500_gpadc_acc_detect2_fops);
+	debugfs_create_file("adc_aux1", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_gpadc_dir, &plf->dev,
+			    &ab8500_gpadc_aux1_fops);
+	debugfs_create_file("adc_aux2", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_gpadc_dir, &plf->dev,
+			    &ab8500_gpadc_aux2_fops);
+	debugfs_create_file("main_bat_v", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_gpadc_dir, &plf->dev,
+			    &ab8500_gpadc_main_bat_v_fops);
+	debugfs_create_file("vbus_v", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_gpadc_dir, &plf->dev,
+			    &ab8500_gpadc_vbus_v_fops);
+	debugfs_create_file("main_charger_c", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_gpadc_dir, &plf->dev,
+			    &ab8500_gpadc_main_charger_c_fops);
+	debugfs_create_file("usb_charger_c", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_gpadc_dir, &plf->dev,
+			    &ab8500_gpadc_usb_charger_c_fops);
+	debugfs_create_file("bk_bat_v", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_gpadc_dir, &plf->dev,
+			    &ab8500_gpadc_bk_bat_v_fops);
+	debugfs_create_file("die_temp", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_gpadc_dir, &plf->dev,
+			    &ab8500_gpadc_die_temp_fops);
+	debugfs_create_file("usb_id", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_gpadc_dir, &plf->dev,
+			    &ab8500_gpadc_usb_id_fops);
 	if (is_ab8540(ab8500)) {
-		file = debugfs_create_file("xtal_temp",
-					   (S_IRUGO | S_IWUSR | S_IWGRP),
-					   ab8500_gpadc_dir, &plf->dev,
-					   &ab8540_gpadc_xtal_temp_fops);
-		if (!file)
-			goto err;
-		file = debugfs_create_file("vbattruemeas",
-					   (S_IRUGO | S_IWUSR | S_IWGRP),
-					   ab8500_gpadc_dir, &plf->dev,
-					   &ab8540_gpadc_vbat_true_meas_fops);
-		if (!file)
-			goto err;
-		file = debugfs_create_file("batctrl_and_ibat",
-					(S_IRUGO | S_IWUGO),
-					ab8500_gpadc_dir,
-					&plf->dev,
-					&ab8540_gpadc_bat_ctrl_and_ibat_fops);
-		if (!file)
-			goto err;
-		file = debugfs_create_file("vbatmeas_and_ibat",
-					(S_IRUGO | S_IWUGO),
-					ab8500_gpadc_dir, &plf->dev,
-					&ab8540_gpadc_vbat_meas_and_ibat_fops);
-		if (!file)
-			goto err;
-		file = debugfs_create_file("vbattruemeas_and_ibat",
-				(S_IRUGO | S_IWUGO),
-				ab8500_gpadc_dir,
-				&plf->dev,
-				&ab8540_gpadc_vbat_true_meas_and_ibat_fops);
-		if (!file)
-			goto err;
-		file = debugfs_create_file("battemp_and_ibat",
-			(S_IRUGO | S_IWUGO),
-			ab8500_gpadc_dir,
-			&plf->dev, &ab8540_gpadc_bat_temp_and_ibat_fops);
-		if (!file)
-			goto err;
-		file = debugfs_create_file("otp_calib",
-				(S_IRUGO | S_IWUSR | S_IWGRP),
-				ab8500_gpadc_dir,
-				&plf->dev, &ab8540_gpadc_otp_calib_fops);
-		if (!file)
-			goto err;
+		debugfs_create_file("xtal_temp", (S_IRUGO | S_IWUSR | S_IWGRP),
+				    ab8500_gpadc_dir, &plf->dev,
+				    &ab8540_gpadc_xtal_temp_fops);
+		debugfs_create_file("vbattruemeas", (S_IRUGO | S_IWUSR | S_IWGRP),
+				    ab8500_gpadc_dir, &plf->dev,
+				    &ab8540_gpadc_vbat_true_meas_fops);
+		debugfs_create_file("batctrl_and_ibat", (S_IRUGO | S_IWUGO),
+				    ab8500_gpadc_dir, &plf->dev,
+				    &ab8540_gpadc_bat_ctrl_and_ibat_fops);
+		debugfs_create_file("vbatmeas_and_ibat", (S_IRUGO | S_IWUGO),
+				    ab8500_gpadc_dir, &plf->dev,
+				    &ab8540_gpadc_vbat_meas_and_ibat_fops);
+		debugfs_create_file("vbattruemeas_and_ibat", (S_IRUGO | S_IWUGO),
+				    ab8500_gpadc_dir, &plf->dev,
+				    &ab8540_gpadc_vbat_true_meas_and_ibat_fops);
+		debugfs_create_file("battemp_and_ibat", (S_IRUGO | S_IWUGO),
+				    ab8500_gpadc_dir, &plf->dev,
+				    &ab8540_gpadc_bat_temp_and_ibat_fops);
+		debugfs_create_file("otp_calib", (S_IRUGO | S_IWUSR | S_IWGRP),
+				    ab8500_gpadc_dir, &plf->dev,
+				    &ab8540_gpadc_otp_calib_fops);
 	}
-	file = debugfs_create_file("avg_sample", (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_gpadc_dir, &plf->dev,
-				   &ab8500_gpadc_avg_sample_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("trig_edge", (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_gpadc_dir, &plf->dev,
-				   &ab8500_gpadc_trig_edge_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("trig_timer", (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_gpadc_dir, &plf->dev,
-				   &ab8500_gpadc_trig_timer_fops);
-	if (!file)
-		goto err;
-
-	file = debugfs_create_file("conv_type", (S_IRUGO | S_IWUSR | S_IWGRP),
-				   ab8500_gpadc_dir, &plf->dev,
-				   &ab8500_gpadc_conv_type_fops);
-	if (!file)
-		goto err;
+	debugfs_create_file("avg_sample", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_gpadc_dir, &plf->dev,
+			    &ab8500_gpadc_avg_sample_fops);
+	debugfs_create_file("trig_edge", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_gpadc_dir, &plf->dev,
+			    &ab8500_gpadc_trig_edge_fops);
+	debugfs_create_file("trig_timer", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_gpadc_dir, &plf->dev,
+			    &ab8500_gpadc_trig_timer_fops);
+	debugfs_create_file("conv_type", (S_IRUGO | S_IWUSR | S_IWGRP),
+			    ab8500_gpadc_dir, &plf->dev,
+			    &ab8500_gpadc_conv_type_fops);
 
 	return 0;
-
-err:
-	debugfs_remove_recursive(ab8500_dir);
-	dev_err(&plf->dev, "failed to create debugfs entries.\n");
-
-	return -ENOMEM;
 }
 
 static struct platform_driver ab8500_debug_driver = {
-- 
2.22.0

