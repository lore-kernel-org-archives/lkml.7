Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2947C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F11229EB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NdUtwPTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389557AbfGWWf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 18:35:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36135 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389434AbfGWWf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:35:26 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so19846643pfl.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 15:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x0riv3qXFNUHW9aogl2u0KORFwMPTEBgnFJrb7TrTKo=;
        b=NdUtwPTDmyF+MRh1jbsokxVgxD6AafcT12ED5L6Y9I5m2QfLdOnwiR6uwiYtOV9tk0
         h6VY892u4JoMBt9AMQKwRr3HNCU5gkqEMiFHV7K7lGmwXCVIOMPwP+eNArEltUq4Htwk
         hZS5Zxmjtgtn/s7/3OKCx94HAQCliNP+XIaOEFOLyGWmeqk9aYexZPS0KUaFd0cAlQJQ
         SDEKqRKPo4kEiGUAXM+TRKI3qSZr/0FLyRhUmimH4ErvW+ecrpeSW7bbOQVlwkym9WLT
         e1rMnmwknhLBjz5GK9JBdbitBQZl7iFX0SPhBn3UI9mUaXPGBhAsUr5bmwvdaKhKiHrq
         odSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x0riv3qXFNUHW9aogl2u0KORFwMPTEBgnFJrb7TrTKo=;
        b=QuPfRxxtX0kKDV3ZGwIV2ox4fQdz3fURrtQQq3KW9Mqj+nyKpaGg24tT8l6c0ZqPOc
         c0X7MrXD22vexJaBfSBFGsQGcq8smAh+YHfbDBtfjZl7yl2cu6eygJIi6SYeFgDnLwZg
         2skZZVEK3PovOs/h1rP7C1SkbVw9jIutQWThgtr/2M5GMhJvBP2eEehgb2J63lBFz1Kp
         v9/mBq6hiboKE3bCMR7xC1m6S7VfhHth1f4JiG0vOpm5htG2g4mJOBD2YzhfBlXlTffr
         ULxagvxF7+lPCI1/15STPvhDxUTWQfj0V6lZunHSkmxMqjMwXMUygnJ/vMOCRb6MCkDa
         Lphg==
X-Gm-Message-State: APjAAAW0KrrA4L7288RFOrNOGUWm/aiVY6yn9lQP6lYEH7Mo61ccKAc6
        kvtU+kJljycoH/yVvYBNrBjWbw==
X-Google-Smtp-Source: APXvYqwkeWnj9VJarEoWXWZKcZ/pRvGNriNTC5RrGifBufFMtBzss48lhq5w0+ZlOY9imCz35H802g==
X-Received: by 2002:aa7:9481:: with SMTP id z1mr8048059pfk.92.1563921326084;
        Tue, 23 Jul 2019 15:35:26 -0700 (PDT)
Received: from localhost.localdomain ([115.99.187.56])
        by smtp.gmail.com with ESMTPSA id h16sm49036917pfo.34.2019.07.23.15.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 15:35:25 -0700 (PDT)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     agross@kernel.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH v6 1/5] base: soc: Add serial_number attribute to soc
Date:   Wed, 24 Jul 2019 04:05:11 +0530
Message-Id: <20190723223515.27839-2-vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190723223515.27839-1-vaishali.thakkar@linaro.org>
References: <20190723223515.27839-1-vaishali.thakkar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add new attribute named "serial_number" as a standard interface for
user space to acquire the serial number of the device.

For ST-Ericsson SoCs this is exposed by the cryptically named "soc_id"
attribute, but this provides a human readable standardized name for this
property.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
Changes since v5:
	- No code changes, fix diff.context setting for formatting
          patches. Version 5 was adding context at the bottom of
          the file with 'git am'.
Changes since v4:
	- Add Stephen's reviewed-by
Changes since v3:
        - Add Greg's Reviewed-by
Changes since v2:
        - None
Changes since v1:
	- Make comment more clear for the case when serial
	  number is not available
---
 Documentation/ABI/testing/sysfs-devices-soc | 7 +++++++
 drivers/base/soc.c                          | 7 +++++++
 include/linux/sys_soc.h                     | 1 +
 3 files changed, 15 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-soc b/Documentation/ABI/testing/sysfs-devices-soc
index 6d9cc253f2b2..ba3a3fac0ee1 100644
--- a/Documentation/ABI/testing/sysfs-devices-soc
+++ b/Documentation/ABI/testing/sysfs-devices-soc
@@ -26,6 +26,13 @@ Description:
 		Read-only attribute common to all SoCs. Contains SoC family name
 		(e.g. DB8500).
 
+What:		/sys/devices/socX/serial_number
+Date:		January 2019
+contact:	Bjorn Andersson <bjorn.andersson@linaro.org>
+Description:
+		Read-only attribute supported by most SoCs. Contains the SoC's
+		serial number, if available.
+
 What:		/sys/devices/socX/soc_id
 Date:		January 2012
 contact:	Lee Jones <lee.jones@linaro.org>
diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 10b280f30217..b0933b9fe67f 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -33,6 +33,7 @@ static struct bus_type soc_bus_type = {
 
 static DEVICE_ATTR(machine,  S_IRUGO, soc_info_get,  NULL);
 static DEVICE_ATTR(family,   S_IRUGO, soc_info_get,  NULL);
+static DEVICE_ATTR(serial_number, S_IRUGO, soc_info_get,  NULL);
 static DEVICE_ATTR(soc_id,   S_IRUGO, soc_info_get,  NULL);
 static DEVICE_ATTR(revision, S_IRUGO, soc_info_get,  NULL);
 
@@ -57,6 +58,9 @@ static umode_t soc_attribute_mode(struct kobject *kobj,
 	if ((attr == &dev_attr_revision.attr)
 	    && (soc_dev->attr->revision != NULL))
 		return attr->mode;
+	if ((attr == &dev_attr_serial_number.attr)
+	    && (soc_dev->attr->serial_number != NULL))
+		return attr->mode;
 	if ((attr == &dev_attr_soc_id.attr)
 	    && (soc_dev->attr->soc_id != NULL))
 		return attr->mode;
@@ -77,6 +81,8 @@ static ssize_t soc_info_get(struct device *dev,
 		return sprintf(buf, "%s\n", soc_dev->attr->family);
 	if (attr == &dev_attr_revision)
 		return sprintf(buf, "%s\n", soc_dev->attr->revision);
+	if (attr == &dev_attr_serial_number)
+		return sprintf(buf, "%s\n", soc_dev->attr->serial_number);
 	if (attr == &dev_attr_soc_id)
 		return sprintf(buf, "%s\n", soc_dev->attr->soc_id);
 
@@ -87,6 +93,7 @@ static ssize_t soc_info_get(struct device *dev,
 static struct attribute *soc_attr[] = {
 	&dev_attr_machine.attr,
 	&dev_attr_family.attr,
+	&dev_attr_serial_number.attr,
 	&dev_attr_soc_id.attr,
 	&dev_attr_revision.attr,
 	NULL,
diff --git a/include/linux/sys_soc.h b/include/linux/sys_soc.h
index b7c70c3e953f..48ceea867dd6 100644
--- a/include/linux/sys_soc.h
+++ b/include/linux/sys_soc.h
@@ -12,6 +12,7 @@ struct soc_device_attribute {
 	const char *machine;
 	const char *family;
 	const char *revision;
+	const char *serial_number;
 	const char *soc_id;
 	const void *data;
 };
-- 
2.17.1

