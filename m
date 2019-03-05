Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61845C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CFD20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QxQcp+/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfCEAxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:53:08 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35231 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEAxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:53:08 -0500
Received: by mail-pg1-f193.google.com with SMTP id e17so4323401pgd.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z0G4lu4Oy+9bnec0MeOSPu0m1GerKTNq+AVRoAJ4Q/k=;
        b=QxQcp+/ffDul5ZlgoCvLH0QU5ELnGI3MCKttVW8fRleETGH6MbT77qsB3yDyj8LKwh
         Ay1LAnIV9gc1MvXFzyHtFwGEpC/8lAj/0zXu2geT34P9uNrvpVm01bZqgMvbu2U4p+8q
         CdNSQZXSRAEOLugQaySeJ8275b9jFncosaBZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z0G4lu4Oy+9bnec0MeOSPu0m1GerKTNq+AVRoAJ4Q/k=;
        b=c+qynXIrGErVrBoJXUs4hKg81lt/o8JLsr7V2jCIs9sgv2+mKoXyjUGT91loKDLn1v
         5jRySfETUiGFb5x8dKSjDRJzV0tyOS7pV7R5z+pDKmy9cATCI+QUmhGzYquKtclNv0gm
         PR2JtzP8A7FcoUIS9mnl2V3QWajq22a+7pt3t+GKJJYIBWHGReuaz0k/Tiy5TtmCZk1w
         vtxGMAtVlEejUffDN3Hf3fts23ATG72BISo3aAKO9WSSR/jLIKtQfyqyoWyzPBq5JZxO
         Iu7jOk2Aul5W4+8euYOvOGaCr+ABctppqL53wYYfnApOLXqe1p9xsKIInfKLCaAtGV4T
         nxqg==
X-Gm-Message-State: APjAAAVLX3KSDeUTLvgovUIOj5wr6hirnb+ixFyY6d2zP2USsbti+0cJ
        cDfzWOyQrzguWHOMBl0BLoSXRw==
X-Google-Smtp-Source: APXvYqwsmRzmhhSAIUncxJymgjooB3M9ca1OlB+wT8fsGcVgjTbFZ7HIIN1zb4sR8vy1HbJwaS1o9Q==
X-Received: by 2002:a65:6548:: with SMTP id a8mr21216702pgw.103.1551747187674;
        Mon, 04 Mar 2019 16:53:07 -0800 (PST)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:98d2:1663:78dd:3593])
        by smtp.gmail.com with ESMTPSA id g71sm14102911pfg.157.2019.03.04.16.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 16:53:07 -0800 (PST)
From:   RaviChandra Sadineni <ravisadineni@chromium.org>
To:     ravisadineni@chromium.org
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, tbroch@google.com, dnojiri@google.com
Subject: [PATCH V3] cros_ec: Expose sysfile to force battery cut-off on shutdown.
Date:   Mon,  4 Mar 2019 16:53:00 -0800
Message-Id: <20190305005300.129464-1-ravisadineni@chromium.org>
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
