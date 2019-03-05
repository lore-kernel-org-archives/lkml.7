Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68057C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3366920675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F9HZQyPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfCEAvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:51:44 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46862 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEAvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:51:44 -0500
Received: by mail-pf1-f195.google.com with SMTP id g6so4261671pfh.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xtFDP0NyHQVf3wQ/4BEnM3Byem+j8CITtmysXnmiB+w=;
        b=F9HZQyPH/FylBavycB1ngHKkskFl7KqfC6tJvyeKfQPkqZhStmLiSUhgK8Opu4E7mM
         P7Yy4m3jgNB3eSwNr8gFY7pNfmiCJQUPe6ysye6mIKiwm/6+f5uQU1jcpBJ0CbJmZKbd
         lXJ2OXqNDr1GKjExiKOQSwBHzcBO0ge07CyTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xtFDP0NyHQVf3wQ/4BEnM3Byem+j8CITtmysXnmiB+w=;
        b=mmEwlFYWh2RShVyIFZnklE31BXsgWjTPxcEf4zKIixEEXqacjuPf3vAlnierTAX6Rl
         b+kfnQ9scpRUqZXARkG4QQTC2ECcL95CJ4T26/icWR8IFFRjjiFXOvUG2RwJajtiYLpv
         OJDi+e/U0Sr8HgdPCABcujJlBRooqegdyJm0doUIzaJCcmJz6fPDCredphcz9z9fMDOj
         DdaEhily423WWcdLxCgR+mZqPGLaZh8DfzOZ0eRXEQkr9nhENgOZN2Z7H/ySV/ozeH5I
         Jm+dZNrZ1XPEBwAATVvWqsyGChwJQCbMu59AyeaAMqZxcdfCjAkTjcy/cH71qDz3/Bqf
         v0zw==
X-Gm-Message-State: APjAAAUVN8OKIBVstc75JLw30w+JSsusSZ3TYp/eV+eyLSDMqYjjImfx
        B8iG1cqt4g0f3qUPbQtQ+4y/jg==
X-Google-Smtp-Source: AHgI3IaR4TmnOEJH+UgkGwQd/ONyl/qtoVZUu4gsIBQICVOjgb8FPJRFo/PUoey7JSe/JtdsnFRPzQ==
X-Received: by 2002:aa7:8205:: with SMTP id k5mr22338888pfi.86.1551747103252;
        Mon, 04 Mar 2019 16:51:43 -0800 (PST)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:98d2:1663:78dd:3593])
        by smtp.gmail.com with ESMTPSA id c130sm14800562pfb.145.2019.03.04.16.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 16:51:42 -0800 (PST)
From:   RaviChandra Sadineni <ravisadineni@chromium.org>
To:     ravisadineni@chromium.org
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, tbroch@google.com, dnojiri@google.com
Subject: [PATCH V3] cros_ec: Expose sysfile to force battery cut-off on shutdown.
Date:   Mon,  4 Mar 2019 16:51:38 -0800
Message-Id: <20190305005138.129020-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CABXOdTdvMKGHoE5JQBLca_6V+ihRiUedgnyb2or8GraBDsKYWQ@mail.gmail.com>
References: <CABXOdTdvMKGHoE5JQBLca_6V+ihRiUedgnyb2or8GraBDsKYWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On chromebooks, power_manager daemon normally shutsdown(S5) the device
when the battery charge falls below 4% threshold. Chromeos EC then
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

V3: Make battery-cutoff generic and expose 'at-shutdown' flag.
V2: Use kstrtobool() instead of kstrtou8() and add documentation.


.../ABI/testing/sysfs-class-chromeos          | 10 ++++
 drivers/platform/chrome/cros_ec_sysfs.c       | 48 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos

diff --git a/Documentation/ABI/testing/sysfs-class-chromeos b/Documentation/ABI/testing/sysfs-class-chromeos
new file mode 100644
index 000000000000..d5ab22c44977
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-chromeos
@@ -0,0 +1,10 @@
+What:           /sys/class/chromeos/cros_ec/battery-cuttoff
+Date:           February 2019
+Contact:        Ravi Chandra Sadineni <ravisadineni@chromium.org>
+Description:
+                cros_ec battery cuttoff configuration. Only option
+                currently exposed is 'at-shutdown'.
+
+                'at-shutdown' sends a host command to EC requesting
+                battery cutoff on next shutdown. If AC is plugged
+                in before next shutdown, EC ignores the request.
diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index f34a50121064..6ef6b860c818 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -322,14 +322,62 @@ static ssize_t kb_wake_angle_store(struct device *dev,
 	return count;
 }
 
+/* Battery cut-off control */
+static ssize_t battery_cutoff_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct ec_params_battery_cutoff *param;
+	struct cros_ec_command *msg;
+	int ret;
+	struct cros_ec_dev *ec =
+		container_of(dev, struct cros_ec_dev, class_dev);
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
+		kfree(msg);
+		return -EINVAL;
+	}
+
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
+/*
+ * Currently EC does not expose a host command to read the status of
+ * battery cut-off configuration. Also there is no requirement to read
+ * the status of these flags from userland. So marking this attribute as
+ *  write-only.
+ */
+static DEVICE_ATTR_WO(battery_cutoff);
 
 static struct attribute *__ec_attrs[] = {
+	&dev_attr_battery_cutoff.attr,
 	&dev_attr_kb_wake_angle.attr,
 	&dev_attr_reboot.attr,
 	&dev_attr_version.attr,
-- 
2.20.1
story | grep send-email
