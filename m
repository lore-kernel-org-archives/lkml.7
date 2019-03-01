Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA68C10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029872084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WbDjzi5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfCATWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:22:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44329 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfCATWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:22:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id a3so11840565pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 11:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S79167DBCzeBBU0K9mw+kQpp+sBB2POydyaY9xJwTiM=;
        b=WbDjzi5nBUOqoA4+ggK1JsEZhNZ7OmJFErNBXKmoUVlzmBq+G65DGhXXZ64398ylpH
         c3+KAPnGSmd92Vl01mfl1VJ5qJAYo0vGlZWOijpxVjAuG0OSbAbGrpc/II2ZZ2/YMbWH
         52eheXbQzs8Q9q8pgcaRAe0gP/EayGgxITTao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S79167DBCzeBBU0K9mw+kQpp+sBB2POydyaY9xJwTiM=;
        b=e/8MqDg1D7lsPenEPXfhtL6Ar9WVpQQq8pTzcVvMXrGoVcQ0CY9/DcDvRuA7VqS00m
         pURY+fpFAPnE4Lv94fyQU4QvdzlV4o5s9BUg4eZdKXXPH7fHb98iVzYzbrul8PNtmQMY
         80pzYot+a2NexnSs7J4qfyA/1bWHJwGvraI+5ChU+0vYbxYXhwIyIPb2IkzYUqaGKKW6
         8s7RJUD8927AjbFiJFdkgCK8DcJjRlvUSAG1PY22Q6S3GG5dFNHfDH4iHCdN6vZby7md
         6PzNXz3OGdq2nWBszTyw4lmw9OmJ1Z/6C1X4dlZ9CBmoWD7Pk9B6Ni/CkRoJZUqMuiaH
         ofAQ==
X-Gm-Message-State: APjAAAUKy5zBU9QXCvG3/uEZ9vZFMENDnRr5NzTgbQodjBcTfAzA1AtV
        LDj94Qmbg82pKfze3TzxuCjSlfVGKNA=
X-Google-Smtp-Source: APXvYqwgvxV/TQEu04Jj1TYHk1HsDw2h41VcbHpW9ZvfZBeG7+phSBEsudjM4t/MNBiRDvchoXAaig==
X-Received: by 2002:a63:6841:: with SMTP id d62mr6403790pgc.133.1551468123033;
        Fri, 01 Mar 2019 11:22:03 -0800 (PST)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:98d2:1663:78dd:3593])
        by smtp.gmail.com with ESMTPSA id l64sm13136130pfj.179.2019.03.01.11.22.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 01 Mar 2019 11:22:02 -0800 (PST)
From:   RaviChandra Sadineni <ravisadineni@chromium.org>
To:     ravisadineni@chromium.org
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, tbroch@google.com, dnojiri@google.com
Subject: [PATCH] cros_ec: Expose sysfile to force battery cut-off on shutdown.
Date:   Fri,  1 Mar 2019 11:21:56 -0800
Message-Id: <20190301192156.253010-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On chromebooks, power_manager daemon normally shutsdown(S5) the device
when the battery charge falls below 4% threshold. ChromeOS EC then
normally spends an hour in S5 before hibernating. If the battery charge
falls below critical threshold in the mean time, EC does a battery cutoff
instead of hibernating. On some chromebooks, S5 is optimal enough
resulting in EC hibernating without battery cut-off. This results in
battery deep-discharging. This is a bad user experience as battery
has to trickle charge before booting when the A.C is plugged in the next
time.

This patch exposes a sysfs file for an userland daemon to suggest EC if it
has to do a battery cut-off instead of hibernating when the system enters
S5 next time.

Signed-off-by: RaviChandra Sadineni <ravisadineni@chromium.org>
---
 drivers/platform/chrome/cros_ec_sysfs.c | 34 +++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index f34a50121064..151c7c143941 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -322,14 +322,48 @@ static ssize_t kb_wake_angle_store(struct device *dev,
 	return count;
 }
 
+/* Battery cut-off control */
+static ssize_t cutoff_battery_at_shutdown_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct ec_params_battery_cutoff *param;
+	struct cros_ec_command *msg;
+	int ret;
+	struct cros_ec_dev *ec = container_of(
+			dev, struct cros_ec_dev, class_dev);
+	uint8_t cutoff_battery;
+
+	if (kstrtou8(buf, 10, &cutoff_battery) || (cutoff_battery != 1))
+		return -EINVAL;
+
+	msg = kmalloc(sizeof(*msg) + EC_HOST_PARAM_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	param = (struct ec_params_battery_cutoff *)msg->data;
+	msg->command = EC_CMD_BATTERY_CUT_OFF + ec->cmd_offset;
+	msg->version = 1;
+	param->flags = EC_BATTERY_CUTOFF_FLAG_AT_SHUTDOWN;
+	msg->outsize = sizeof(*param);
+	msg->insize = 0;
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	kfree(msg);
+	if (ret < 0)
+		return ret;
+	return count;
+}
+
 /* Module initialization */
 
 static DEVICE_ATTR_RW(reboot);
 static DEVICE_ATTR_RO(version);
 static DEVICE_ATTR_RO(flashinfo);
 static DEVICE_ATTR_RW(kb_wake_angle);
+static DEVICE_ATTR_WO(cutoff_battery_at_shutdown);
 
 static struct attribute *__ec_attrs[] = {
+	&dev_attr_cutoff_battery_at_shutdown.attr,
 	&dev_attr_kb_wake_angle.attr,
 	&dev_attr_reboot.attr,
 	&dev_attr_version.attr,
-- 
2.20.1

