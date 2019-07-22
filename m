Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EB2C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A49921BF6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 22:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UgtJJ8+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbfGVWdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 18:33:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41060 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfGVWdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 18:33:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so19674083pls.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 15:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4lqL/2aAtzva5ONR2wYj8ExU6ts1LC8Et+7vo27oAws=;
        b=UgtJJ8+GEd2dn01GyvwLu7NPJ9l2xm/KPnrLgHH0dI9GzIlXWZkmA+N1KTUF7r0G1A
         0MKQja2/FoG2oKE40jWNZvGiprQDfFP/jr/BSyVciwNIq95Iu6NjN3gB56GKdx0QgZky
         Kzg4GrGl+/m+dUUTzPW7iP/VH4CLaer9EdwLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4lqL/2aAtzva5ONR2wYj8ExU6ts1LC8Et+7vo27oAws=;
        b=stm6++5t6OLj3/6OPf9NQtqe48JIue59FymbHQKzxr41JanNjtsac6cCmANVcMZWmD
         oUbogmih12+wz765+1R5VrYSRLdkztrn+GHT5+v8jfLe2Sv6zFbb2KrFgdh1G8ymYpw9
         F8HOkqy7DQXAzOHH66nw1uZeqjHow+eIg22P3Q+0jwqUY+yN4kvsO8VYJpWiZcc9jQPh
         lVWEwdpMLVdEJzJMtDLJn+Eq/AlBywB4lVRjUIBk3PwAvJzxZ25sPhau0A1pPxyI5dGf
         /OSt2/L4YYK/Kr+UAEWyxJZetAl2uMOQoJRzqBlYnratdlckbWz5yagNwRWkABa8l6sc
         k//Q==
X-Gm-Message-State: APjAAAXd/+stb/duz9WdpV1bNJLHxoiR7FLE4CwGUyOikhdb5zStBy7f
        N+5jWjKp9iFmXhqtLQSl7WjL9w==
X-Google-Smtp-Source: APXvYqzm077YSy2G+QdxitaH1+UlqZ1igV+SV0DodJuzFm5hgnjFzjAwgaEvzXmLoOOyFMHuzWkCyA==
X-Received: by 2002:a17:902:8ec3:: with SMTP id x3mr76220816plo.313.1563834824000;
        Mon, 22 Jul 2019 15:33:44 -0700 (PDT)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:98d2:1663:78dd:3593])
        by smtp.gmail.com with ESMTPSA id k186sm20614285pga.68.2019.07.22.15.33.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 15:33:43 -0700 (PDT)
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, gregkh@linuxfoundation.org,
        ravisadineni@chromium.org, bhe@redhat.com, dyoung@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tbroch@chromium.org
Subject: [PATCH 2/2 V2] power:sysfs: Expose device wakeup_event_count.
Date:   Mon, 22 Jul 2019 15:33:37 -0700
Message-Id: <20190722223337.36199-3-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722223337.36199-1-ravisadineni@chromium.org>
References: <20190722182451.GB24412@kroah.com>
 <20190722223337.36199-1-ravisadineni@chromium.org>
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
V2: Address comments from patchset 1.

Documentation/ABI/testing/sysfs-devices-power | 11 ++++++++++
 drivers/base/power/sysfs.c                    | 21 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 1ca04b4f0489..abae0e8106d2 100644
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
+		from sleep states, this attribute returns an empty line.
+
 What:		/sys/devices/.../power/wakeup_active_count
 Date:		September 2010
 Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index f42044d9711c..cbb9768b10e8 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -357,6 +357,26 @@ static ssize_t wakeup_count_show(struct device *dev,
 
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
+	if (enabled)
+		return sprintf(buf, "%lu\n", count);
+	else
+		return sprintf(buf, "\n");
+}
+
+static DEVICE_ATTR_RO(wakeup_event_count);
+
 static ssize_t wakeup_active_count_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -561,6 +581,7 @@ static struct attribute *wakeup_attrs[] = {
 #ifdef CONFIG_PM_SLEEP
 	&dev_attr_wakeup.attr,
 	&dev_attr_wakeup_count.attr,
+	&dev_attr_wakeup_event_count.attr,
 	&dev_attr_wakeup_active_count.attr,
 	&dev_attr_wakeup_expire_count.attr,
 	&dev_attr_wakeup_active.attr,
-- 
2.20.1

