Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4311DC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D53A2190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GpNZJR9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfGXRoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:44:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37351 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbfGXRoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:44:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id i70so10839688pgd.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 10:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=G9lU49cG6/hRnITUPOSlcSQtjOd+e+yyzQPDpfsDei4=;
        b=GpNZJR9U0PPJITNoGTIWWRn9Vn2XsEGbDyCmcGNwNF/sz55/o9KD0J2KYwqn17K2/R
         quDfeMA02NxFMytG/JlVYEjXXp9GoQDPu18Ip0y5OLR6w6RqdFSA+jaRvHGxFhYgGvBf
         Mp5SoOL8xgjx/tRjCjSDExhwsXBC9tIrox4TA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G9lU49cG6/hRnITUPOSlcSQtjOd+e+yyzQPDpfsDei4=;
        b=j8VTg+fS6kFOyCMONwLEoN1SNy8Hsl0Mx7/V+oKEyF3YH3A/fMfNbl59ntBydL0Evh
         Ropb2PoLZLvtqDXmMPxnMYwmwM5i5Mp4aUE7bNaOBr6M2FlDHQhczjGpL2h25Xrdrgad
         YQHJKx/jfoCsGHbkh2jvkbyMvuCj5I1CKgE4HHPN2Xo/E+IAGKQ6+s46jrrlL3V6ZqgP
         YIgEwTVBxvSbLQZ5HN0cm7Wf/uxo1ceBjMjXVofMQwTa+oIR77YJcUTOtEIWCn/xsFEL
         Z8j6sT0OvzWjotEI34wv/nQonABpUik6A7R93SDS+keIj0ob6vp5SL9XQWFP3pPjlCVP
         sWZw==
X-Gm-Message-State: APjAAAVe1Hmtq1C5xGiyNn922BjAeGv3ZpHrZDFmuWc9uDNwy3qqYkNo
        GI5gWqQYxPvjQmjXa9Z5EuD47A==
X-Google-Smtp-Source: APXvYqynKJOgBLJ2ScfUkrL4/wbBb46E+bEiGcikbv9Bf0NuWSITesqAcKvvSAmBQ9OeNtScMC9nGQ==
X-Received: by 2002:a17:90a:7148:: with SMTP id g8mr21874597pjs.51.1563990244431;
        Wed, 24 Jul 2019 10:44:04 -0700 (PDT)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:98d2:1663:78dd:3593])
        by smtp.gmail.com with ESMTPSA id r6sm37620080pgl.74.2019.07.24.10.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Jul 2019 10:44:03 -0700 (PDT)
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, gregkh@linuxfoundation.org,
        ravisadineni@chromium.org, bhe@redhat.com, dyoung@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tbroch@chromium.org, trong@google.com
Subject: [PATCH 1/2] power: sysfs: Add link to wakeup class device.
Date:   Wed, 24 Jul 2019 10:43:54 -0700
Message-Id: <20190724174355.255314-2-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190724174355.255314-1-ravisadineni@chromium.org>
References: <20190724174355.255314-1-ravisadineni@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://patchwork.kernel.org/patch/11045069/ creates a virtual device
under wakeup class for each wake capable device exposing all related
sysfs attributes. But there isn't a symlink from the actual device
node to these virtual devices. This patch creates a symlink from the
actual device to the corresponding wakeup_source device under wakeup
class.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
---
 drivers/base/power/power.h  |  2 ++
 drivers/base/power/sysfs.c  | 25 +++++++++++++++++++++++++
 drivers/base/power/wakeup.c |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index c511def48b48..32b0f5c080a9 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -67,6 +67,8 @@ extern void dpm_sysfs_remove(struct device *dev);
 extern void rpm_sysfs_remove(struct device *dev);
 extern int wakeup_sysfs_add(struct device *dev);
 extern void wakeup_sysfs_remove(struct device *dev);
+extern void wakeup_source_sysfs_link_add(struct device *dev);
+extern void wakeup_source_sysfs_link_remove(struct device *dev);
 extern int pm_qos_sysfs_add_resume_latency(struct device *dev);
 extern void pm_qos_sysfs_remove_resume_latency(struct device *dev);
 extern int pm_qos_sysfs_add_flags(struct device *dev);
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index d713738ce796..fbbdb7b16ac5 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -95,6 +95,7 @@
 const char power_group_name[] = "power";
 EXPORT_SYMBOL_GPL(power_group_name);
 
+static const char wakeup_source_symlink_name[] = "wakeup_source";
 static const char ctrl_auto[] = "auto";
 static const char ctrl_on[] = "on";
 
@@ -679,6 +680,30 @@ int dpm_sysfs_add(struct device *dev)
 	return rc;
 }
 
+void wakeup_source_sysfs_link_add(struct device *dev)
+{
+	struct wakeup_source *ws;
+	int err;
+
+	ws = dev->power.wakeup;
+	if (ws && ws->dev) {
+		err = sysfs_add_link_to_group(&dev->kobj, power_group_name,
+			&ws->dev->kobj, wakeup_source_symlink_name);
+		if (err) {
+			dev_err(dev,
+				"could not add %s symlink err %d\n",
+				wakeup_source_symlink_name,
+				err);
+		}
+	}
+}
+
+void wakeup_source_sysfs_link_remove(struct device *dev)
+{
+	sysfs_remove_link_from_group(&dev->kobj, power_group_name,
+		wakeup_source_symlink_name);
+}
+
 int wakeup_sysfs_add(struct device *dev)
 {
 	return sysfs_merge_group(&dev->kobj, &pm_wakeup_attr_group);
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index fe779fe13a7f..87dfe401b035 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -270,6 +270,7 @@ static int device_wakeup_attach(struct device *dev, struct wakeup_source *ws)
 	if (dev->power.wakeirq)
 		device_wakeup_attach_irq(dev, dev->power.wakeirq);
 	spin_unlock_irq(&dev->power.lock);
+	wakeup_source_sysfs_link_add(dev);
 	return 0;
 }
 
@@ -391,6 +392,7 @@ static struct wakeup_source *device_wakeup_detach(struct device *dev)
 	ws = dev->power.wakeup;
 	dev->power.wakeup = NULL;
 	spin_unlock_irq(&dev->power.lock);
+	wakeup_source_sysfs_link_remove(dev);
 	return ws;
 }
 
-- 
2.20.1

