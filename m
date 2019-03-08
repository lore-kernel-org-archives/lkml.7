Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38799C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0682C2054F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tl2unvK6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfCHAMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:12:07 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35618 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfCHAMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 19:12:07 -0500
Received: by mail-it1-f195.google.com with SMTP id 188so18865498itb.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 16:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iaLKDxo0uwhel0Mf+OjeSn4ciEkuMwdbGhBvvoMu/xM=;
        b=Tl2unvK6BkzMftMiaCXmG3OGTBGFNn8XmV/28iFv5ZP3VntP3vcCEHBN9zm4YLSWZ8
         MDc2wyoN3rfoFvImZ+uknUb4bzj1B/ZM8O1VI20RxvniKiUKM3Vs5MAgAbldD5677ET6
         9L4Tbb8B78ioeJqcdVSP9hAvw7OG113vMxAwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iaLKDxo0uwhel0Mf+OjeSn4ciEkuMwdbGhBvvoMu/xM=;
        b=PnDBHv6zLir20jKyUxGAyYCHEYUnxFaVi1FmY48om+i579O9/5gg1nYV1YNn+GwqTq
         OzqVWftnrWSdFLlv7FNn2W9g9z/2i9oYMKsIVsbbdYml0ABqp+I5rUHxYxDYQnihrTJu
         l/rfe4kzwSsdtOMjk5X2uIdWOkDeBsBfkFsA22H0E2d+UJp5NdpRds46MvGqUrQETDuF
         yN8WWDsLp1CMIHChqa0c+clvFu0pQ7ubvmFUgxbEGn0SbPfRUdylv7tQuUaHCzJumhpk
         iBGrebSkEIS6ofoGJuWqZLY2r7DwWxY/Iz1Ivb1EyAvmOeJmMrRffC3G8EiKFLB6U9TT
         UW/A==
X-Gm-Message-State: APjAAAXVWD6an59e4iCQi/Mg3MWyuMPr5gtYAKf8BGjwSONiBa0Q0oMR
        7JCrrW2hyieUBaX387JRBx36PQ==
X-Google-Smtp-Source: APXvYqzbcQ3CaB9dhSaCmmViKRD+EkWuPKIiz6lPeHT4BrcQBy7LwH2XRGbjFcenwO6HWDP6Z2qYfg==
X-Received: by 2002:a24:7c0b:: with SMTP id a11mr6868462itd.161.1552003926268;
        Thu, 07 Mar 2019 16:12:06 -0800 (PST)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:98d2:1663:78dd:3593])
        by smtp.gmail.com with ESMTPSA id 68sm3208434itk.40.2019.03.07.16.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 16:12:05 -0800 (PST)
From:   RaviChandra Sadineni <ravisadineni@chromium.org>
X-Google-Original-From: RaviChandra Sadineni <ravisadineni@google.com>
To:     ravisadineni@chromium.org
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4] cros_ec: Expose sysfile to force battery cutoff on shutdown.
Date:   Thu,  7 Mar 2019 16:11:59 -0800
Message-Id: <20190308001159.210832-1-ravisadineni@google.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <404dd7fe-23de-e5c4-48c2-5cd77a14e72b@collabora.com>
References: <404dd7fe-23de-e5c4-48c2-5cd77a14e72b@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: RaviChandra Sadineni <ravisadineni@chromium.org>

On chromebooks, power_manager daemon normally shuts down(S5) the device
when the battery charge falls below 4% threshold. ChromeOS EC then
normally spends an hour in S5 before hibernating. If the battery charge
falls below critical threshold in the mean time, EC does a battery cutoff
instead of hibernating. On some chromebooks, S5 is optimal enough
resulting in EC hibernating without battery cutoff. This results in
battery deep discharging. This is a bad user experience as battery
has to trickle charge before booting when the AC is plugged in the next
time.

This patch exposes a sysfs file for an userland daemon to suggest EC if it
has to do a battery cutoff instead of hibernating when the system enters
S5 next time.

Signed-off-by: RaviChandra Sadineni <ravisadineni@chromium.org>
---
V4: Addressed comments from Enric.
V3: Make battery-cutoff generic and expose 'at-shutdown' flag.
V2: Use kstrtobool() instead of kstrtou8() and add documentation.

.../ABI/testing/sysfs-class-chromeos          | 16 +++++++
 drivers/platform/chrome/cros_ec_sysfs.c       | 47 +++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-chromeos b/Documentation/ABI/testing/sysfs-class-chromeos
index 5819699d66ec..0927704d1629 100644
--- a/Documentation/ABI/testing/sysfs-class-chromeos
+++ b/Documentation/ABI/testing/sysfs-class-chromeos
@@ -30,3 +30,19 @@ Date:		August 2015
 KernelVersion:	4.2
 Description:
 		Show the information about the EC software and hardware.
+
+What:           /sys/class/chromeos/<ec-device-name>/battery_cuttoff
+Date:           February 2019
+Contact:        Ravi Chandra Sadineni <ravisadineni@chromium.org>
+Description:
+                cros_ec battery cuttoff configuration. Only option
+                currently exposed is 'at-shutdown'.
+
+                'at-shutdown' sends a host command to EC requesting
+                battery cutoff on next shutdown. If AC is plugged
+                in before next shutdown, EC ignores the request and
+                resets the flag.
+
+                Currently EC does not expose a host command to read
+                the status of battery cutoff configuration. Thus this
+                flag is write-only.
diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index fe0b7614ae1b..a35e1188f28f 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -308,14 +308,61 @@ static ssize_t kb_wake_angle_store(struct device *dev,
 	return count;
 }
 
+/* Battery cutoff control */
+static ssize_t battery_cutoff_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct ec_params_battery_cutoff *param;
+	struct cros_ec_command *msg;
+	int ret;
+	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
+	char *p;
+	int len;
+
+	msg = kmalloc(sizeof(*msg) + EC_HOST_PARAM_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	param = (struct ec_params_battery_cutoff *)msg->data;
+	msg->command = EC_CMD_BATTERY_CUT_OFF + ec->cmd_offset;
+	msg->version = 1;
+	msg->outsize = sizeof(*param);
+	msg->insize = 0;
+
+	p = memchr(buf, '\n', count);
+	len = p ? p - buf : count;
+
+	if (len == 11 && !strncmp(buf, "at-shutdown", len)) {
+		param->flags = EC_BATTERY_CUTOFF_FLAG_AT_SHUTDOWN;
+	} else {
+		count = -EINVAL;
+		goto exit;
+	}
+
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	if (ret < 0)
+		count = ret;
+exit:
+	kfree(msg);
+	return count;
+}
+
 /* Module initialization */
 
 static DEVICE_ATTR_RW(reboot);
 static DEVICE_ATTR_RO(version);
 static DEVICE_ATTR_RO(flashinfo);
 static DEVICE_ATTR_RW(kb_wake_angle);
+/*
+ * Currently EC does not expose a host command to read the status of
+ * battery cutoff configuration. Also there is no requirement to read
+ * the flag from userland. So marking this attribute as write-only.
+ */
+static DEVICE_ATTR_WO(battery_cutoff);
 
 static struct attribute *__ec_attrs[] = {
+	&dev_attr_battery_cutoff.attr,
 	&dev_attr_kb_wake_angle.attr,
 	&dev_attr_reboot.attr,
 	&dev_attr_version.attr,
-- 
2.20.1

