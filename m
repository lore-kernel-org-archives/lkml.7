Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3E1C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE03A2190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a7sa0xB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbfGVSDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:03:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37948 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfGVSDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:03:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id y15so17749201pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yIELoiHmUXbL92hfI4jx59Ucqj3uQlhVaER6uive5Ys=;
        b=a7sa0xB7N1zI4giKvX+hX0rZUsGTQ3c97nDQz9rPEqS5bJbiXAOzcsCVWSAE21tV7U
         xxSfAzXEFYiRBTBUp/RzwpwAa7hFrG1Ib9gJJX5DqjkFQGhmQhlLOOfD3BdZ4cVdCKuQ
         aZOgwhswHMeoXf1TpRHtVPRuKBUusrF+g+kCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yIELoiHmUXbL92hfI4jx59Ucqj3uQlhVaER6uive5Ys=;
        b=GZhvMbL2Rmlb9E9FLP0xT91RC4qtgRy1NzhLxR25VzHxUIu6FkqDh22Cq2SgGFeCI7
         GULScjTHijrKx0nn+ongE4QZZjjbvy2MJWreBIHkV/9c8sXCGC65KxYxsKW5SnhHNYvR
         Y9gR9GW0jZrrqp8IFPzOdIAx5oly4qSaaDZH/U6LtO+7HjdbCeggQU3fVTw42BQiPW1F
         eUu0el5P7YrEoktT1oJEqgnGoZUd5gEaC7rFHDMF6pmsqdDdfhYyBvsvFBQ4Ch/i5v6H
         M1wbCEI8ad2k3tOh3kqBpiJeYs3PkHGJonWOiK7oQUmZNkdVuiMm16I9XLe4qbOFFCCY
         69IA==
X-Gm-Message-State: APjAAAVb9QG3iKCH7H14UWnu2EMlhYqrL8Oshv5DiuuG/HDIpqI04Pt0
        n3535eqgKiP0MNCM3UeKBsCjww==
X-Google-Smtp-Source: APXvYqzibWslj1pTQSkPXyE2c+my91uF4qoKosp6UK4IjdzVt6vasU1KnIS+MlF88yziGLDwI41ULw==
X-Received: by 2002:a63:2364:: with SMTP id u36mr70401607pgm.449.1563818582230;
        Mon, 22 Jul 2019 11:03:02 -0700 (PDT)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:98d2:1663:78dd:3593])
        by smtp.gmail.com with ESMTPSA id p187sm62203415pfg.89.2019.07.22.11.03.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 11:03:01 -0700 (PDT)
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, gregkh@linuxfoundation.org,
        ravisadineni@chromium.org, bhe@redhat.com, dyoung@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tbroch@chromium.org
Subject: [PATCH] power:sysfs: Expose device wakeup_event_count.
Date:   Mon, 22 Jul 2019 11:02:58 -0700
Message-Id: <20190722180258.255949-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device level event_count can help user level daemon to track if a
praticular device has seen an wake interrupt during a suspend resume
cycle. Thus expose it via sysfs.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
---
 Documentation/ABI/testing/sysfs-devices-power | 11 ++++++++++
 drivers/base/power/sysfs.c                    | 20 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 1ca04b4f0489..344549f4013f 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -89,6 +89,17 @@ Description:
 		attribute is not present. If the device is not enabled to wake
 		up the system from sleep states, this attribute is empty.
 
+What:		/sys/devices/.../power/wakeup_event_count
+Date:		July 2019
+Contact:	Ravi Chandra sadineni <ravisadineni@chromium.org>
+Description:
+		The /sys/devices/.../wakeup_event_count attribute contains the
+		number of signaled wakeup events associated with the device.
+		This attribute is read-only. If the device is not capable to
+		wake up the system from sleep states, this attribute is not
+		present. If the device is not enabled to wake up the system
+		from sleep states, this attribute is empty.
+
 What:		/sys/devices/.../power/wakeup_active_count
 Date:		September 2010
 Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index f42044d9711c..8dc1235b9784 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -357,6 +357,25 @@ static ssize_t wakeup_count_show(struct device *dev,
 
 static DEVICE_ATTR_RO(wakeup_count);
 
+static ssize_t wakeup_event_count_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	unsigned long count = 0;
+	bool enabled = false;
+
+	spin_lock_irq(&dev->power.lock);
+	if (dev->power.wakeup) {
+		count = dev->power.wakeup->event_count;
+		enabled = true;
+	}
+	spin_unlock_irq(&dev->power.lock);
+	return enabled ? sprintf(buf, "%lu\n", count) : sprintf(buf, "\n");
+}
+
+static DEVICE_ATTR_RO(wakeup_event_count);
+
+
+
 static ssize_t wakeup_active_count_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -561,6 +580,7 @@ static struct attribute *wakeup_attrs[] = {
 #ifdef CONFIG_PM_SLEEP
 	&dev_attr_wakeup.attr,
 	&dev_attr_wakeup_count.attr,
+	&dev_attr_wakeup_event_count.attr,
 	&dev_attr_wakeup_active_count.attr,
 	&dev_attr_wakeup_expire_count.attr,
 	&dev_attr_wakeup_active.attr,
-- 
2.20.1

