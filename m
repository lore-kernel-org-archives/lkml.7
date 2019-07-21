Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B30EC76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 14:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2087F2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 14:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBqKuuq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfGUObT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 10:31:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38869 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfGUObS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 10:31:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so36749768wrr.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 07:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SlN44yZ+yrtVc255qFE/Mw05DdRjj4m2pC0IuctLiw8=;
        b=eBqKuuq01op6Yc3wBo6fy1VgUbRwjSI0BrFBiGhT2W7FBfli6HpkdyokZCyA+18YcD
         nZmWwZTYjSNq2cVEaYMkGe31H93080PjXMGXSfznu6WgD/vsndPqJ7XU2JONC3Kz4A+Z
         9fP4Pm/l9CDFreKbE/RfUjvAK8Lk2LaI5Bn/To24PZ54Qwx2MwRASr3DWwdyDbY7rVso
         UJAQtt0deKpnbk5mr9iy+Pgf+VzuWcK8RVRqAmIpb63jblXr/RAHGXNY7xvNgdR+FTzW
         dy+VB7d8b25MBmScD9f/pPesKlp1sElQwQdG4FczILBWiIKiwXi1rTVmEFP6gguDww4g
         thCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SlN44yZ+yrtVc255qFE/Mw05DdRjj4m2pC0IuctLiw8=;
        b=t3hNB8Uu104zeem78VUaRxK5py+08+HJ/VhnQhfQKtO/0S2D5HZvkfyKOarg9zs+JA
         MwkApRan2Um7hIPLMI8nVSnEp54B2JdQLExrocxLJiIGeZGuw8TcbG/NwKNnBtyOLzhB
         QSyRIDTTBIKPM15CtjxvUuqSBwypgfeVel4eck6qMGjlPTpqfNiU1zKFFn50Zt7UvTjJ
         76llkDk8LdQOoxHMfndIKux8yZa2QVdtdf3NwGp/hBijBCoqwW9Ra9PLN888J7hnUcDU
         L8k3Wzh4cVG5ULflGU6JBBb+CiWbq1qcPuYTiptX4U9mBGqGwFA0u4KxonoMsBkc4xHP
         ZLbg==
X-Gm-Message-State: APjAAAVChEf8MbFV3ygoYMQZRQKNfLY5s+NWPFZuboLMVY6q+6iXnSj8
        GfYq6diRYbitG/NikiD/A64IawS5oyY=
X-Google-Smtp-Source: APXvYqztt7i0fuXDLH+HClLcExwDXqROzTzZz8MEM/v4TcR2Glb1QN+2g6mpi4/Rv14COs5AEJc7AQ==
X-Received: by 2002:adf:e4c3:: with SMTP id v3mr68464361wrm.107.1563719475054;
        Sun, 21 Jul 2019 07:31:15 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h16sm35109360wrv.88.2019.07.21.07.31.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 07:31:14 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: power management through sysfs is only for GOYA
Date:   Sun, 21 Jul 2019 17:31:12 +0300
Message-Id: <20190721143112.26273-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ability of setting power management properties by the system
administrator (through sysfs properties) is only relevant for the GOYA
ASIC. Therefore, move the relevant sysfs properties to the GOYA sysfs
specific file, to make the properties appear in sysfs only for GOYA cards.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 .../ABI/testing/sysfs-driver-habanalabs       |  5 +-
 drivers/misc/habanalabs/goya/goya_hwmgr.c     | 98 +++++++++++++++++++
 drivers/misc/habanalabs/sysfs.c               | 98 -------------------
 3 files changed, 101 insertions(+), 100 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-habanalabs b/Documentation/ABI/testing/sysfs-driver-habanalabs
index 8d1c81cc9167..782df74042ed 100644
--- a/Documentation/ABI/testing/sysfs-driver-habanalabs
+++ b/Documentation/ABI/testing/sysfs-driver-habanalabs
@@ -57,6 +57,7 @@ KernelVersion:  5.1
 Contact:        oded.gabbay@gmail.com
 Description:    Allows the user to set the maximum clock frequency for MME, TPC
                 and IC when the power management profile is set to "automatic".
+                This property is valid only for the Goya ASIC family
 
 What:           /sys/class/habanalabs/hl<n>/ic_clk
 Date:           Jan 2019
@@ -127,8 +128,8 @@ Description:    Power management profile. Values are "auto", "manual". In "auto"
                 the max clock frequency to a low value when there are no user
                 processes that are opened on the device's file. In "manual"
                 mode, the user sets the maximum clock frequency by writing to
-                ic_clk, mme_clk and tpc_clk
-
+                ic_clk, mme_clk and tpc_clk. This property is valid only for
+                the Goya ASIC family
 
 What:           /sys/class/habanalabs/hl<n>/preboot_btl_ver
 Date:           Jan 2019
diff --git a/drivers/misc/habanalabs/goya/goya_hwmgr.c b/drivers/misc/habanalabs/goya/goya_hwmgr.c
index 088692c852b6..a51d836542a1 100644
--- a/drivers/misc/habanalabs/goya/goya_hwmgr.c
+++ b/drivers/misc/habanalabs/goya/goya_hwmgr.c
@@ -230,18 +230,116 @@ static ssize_t ic_clk_curr_show(struct device *dev,
 	return sprintf(buf, "%lu\n", value);
 }
 
+static ssize_t pm_mng_profile_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	if (hl_device_disabled_or_in_reset(hdev))
+		return -ENODEV;
+
+	return sprintf(buf, "%s\n",
+			(hdev->pm_mng_profile == PM_AUTO) ? "auto" :
+			(hdev->pm_mng_profile == PM_MANUAL) ? "manual" :
+			"unknown");
+}
+
+static ssize_t pm_mng_profile_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	if (hl_device_disabled_or_in_reset(hdev)) {
+		count = -ENODEV;
+		goto out;
+	}
+
+	mutex_lock(&hdev->fd_open_cnt_lock);
+
+	if (atomic_read(&hdev->fd_open_cnt) > 0) {
+		dev_err(hdev->dev,
+			"Can't change PM profile while user process is opened on the device\n");
+		count = -EPERM;
+		goto unlock_mutex;
+	}
+
+	if (strncmp("auto", buf, strlen("auto")) == 0) {
+		/* Make sure we are in LOW PLL when changing modes */
+		if (hdev->pm_mng_profile == PM_MANUAL) {
+			atomic_set(&hdev->curr_pll_profile, PLL_HIGH);
+			hl_device_set_frequency(hdev, PLL_LOW);
+			hdev->pm_mng_profile = PM_AUTO;
+		}
+	} else if (strncmp("manual", buf, strlen("manual")) == 0) {
+		/* Make sure we are in LOW PLL when changing modes */
+		if (hdev->pm_mng_profile == PM_AUTO) {
+			flush_delayed_work(&hdev->work_freq);
+			hdev->pm_mng_profile = PM_MANUAL;
+		}
+	} else {
+		dev_err(hdev->dev, "value should be auto or manual\n");
+		count = -EINVAL;
+		goto unlock_mutex;
+	}
+
+unlock_mutex:
+	mutex_unlock(&hdev->fd_open_cnt_lock);
+out:
+	return count;
+}
+
+static ssize_t high_pll_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+
+	if (hl_device_disabled_or_in_reset(hdev))
+		return -ENODEV;
+
+	return sprintf(buf, "%u\n", hdev->high_pll);
+}
+
+static ssize_t high_pll_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct hl_device *hdev = dev_get_drvdata(dev);
+	long value;
+	int rc;
+
+	if (hl_device_disabled_or_in_reset(hdev)) {
+		count = -ENODEV;
+		goto out;
+	}
+
+	rc = kstrtoul(buf, 0, &value);
+
+	if (rc) {
+		count = -EINVAL;
+		goto out;
+	}
+
+	hdev->high_pll = value;
+
+out:
+	return count;
+}
+
+static DEVICE_ATTR_RW(high_pll);
 static DEVICE_ATTR_RW(ic_clk);
 static DEVICE_ATTR_RO(ic_clk_curr);
 static DEVICE_ATTR_RW(mme_clk);
 static DEVICE_ATTR_RO(mme_clk_curr);
+static DEVICE_ATTR_RW(pm_mng_profile);
 static DEVICE_ATTR_RW(tpc_clk);
 static DEVICE_ATTR_RO(tpc_clk_curr);
 
 static struct attribute *goya_dev_attrs[] = {
+	&dev_attr_high_pll.attr,
 	&dev_attr_ic_clk.attr,
 	&dev_attr_ic_clk_curr.attr,
 	&dev_attr_mme_clk.attr,
 	&dev_attr_mme_clk_curr.attr,
+	&dev_attr_pm_mng_profile.attr,
 	&dev_attr_tpc_clk.attr,
 	&dev_attr_tpc_clk_curr.attr,
 	NULL,
diff --git a/drivers/misc/habanalabs/sysfs.c b/drivers/misc/habanalabs/sysfs.c
index 67e3424d4e65..080da09cc3b0 100644
--- a/drivers/misc/habanalabs/sysfs.c
+++ b/drivers/misc/habanalabs/sysfs.c
@@ -102,100 +102,6 @@ void hl_set_max_power(struct hl_device *hdev, u64 value)
 		dev_err(hdev->dev, "Failed to set max power, error %d\n", rc);
 }
 
-static ssize_t pm_mng_profile_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct hl_device *hdev = dev_get_drvdata(dev);
-
-	if (hl_device_disabled_or_in_reset(hdev))
-		return -ENODEV;
-
-	return sprintf(buf, "%s\n",
-			(hdev->pm_mng_profile == PM_AUTO) ? "auto" :
-			(hdev->pm_mng_profile == PM_MANUAL) ? "manual" :
-			"unknown");
-}
-
-static ssize_t pm_mng_profile_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	struct hl_device *hdev = dev_get_drvdata(dev);
-
-	if (hl_device_disabled_or_in_reset(hdev)) {
-		count = -ENODEV;
-		goto out;
-	}
-
-	mutex_lock(&hdev->fd_open_cnt_lock);
-
-	if (atomic_read(&hdev->fd_open_cnt) > 0) {
-		dev_err(hdev->dev,
-			"Can't change PM profile while user process is opened on the device\n");
-		count = -EPERM;
-		goto unlock_mutex;
-	}
-
-	if (strncmp("auto", buf, strlen("auto")) == 0) {
-		/* Make sure we are in LOW PLL when changing modes */
-		if (hdev->pm_mng_profile == PM_MANUAL) {
-			atomic_set(&hdev->curr_pll_profile, PLL_HIGH);
-			hl_device_set_frequency(hdev, PLL_LOW);
-			hdev->pm_mng_profile = PM_AUTO;
-		}
-	} else if (strncmp("manual", buf, strlen("manual")) == 0) {
-		/* Make sure we are in LOW PLL when changing modes */
-		if (hdev->pm_mng_profile == PM_AUTO) {
-			flush_delayed_work(&hdev->work_freq);
-			hdev->pm_mng_profile = PM_MANUAL;
-		}
-	} else {
-		dev_err(hdev->dev, "value should be auto or manual\n");
-		count = -EINVAL;
-		goto unlock_mutex;
-	}
-
-unlock_mutex:
-	mutex_unlock(&hdev->fd_open_cnt_lock);
-out:
-	return count;
-}
-
-static ssize_t high_pll_show(struct device *dev, struct device_attribute *attr,
-				char *buf)
-{
-	struct hl_device *hdev = dev_get_drvdata(dev);
-
-	if (hl_device_disabled_or_in_reset(hdev))
-		return -ENODEV;
-
-	return sprintf(buf, "%u\n", hdev->high_pll);
-}
-
-static ssize_t high_pll_store(struct device *dev, struct device_attribute *attr,
-				const char *buf, size_t count)
-{
-	struct hl_device *hdev = dev_get_drvdata(dev);
-	long value;
-	int rc;
-
-	if (hl_device_disabled_or_in_reset(hdev)) {
-		count = -ENODEV;
-		goto out;
-	}
-
-	rc = kstrtoul(buf, 0, &value);
-
-	if (rc) {
-		count = -EINVAL;
-		goto out;
-	}
-
-	hdev->high_pll = value;
-
-out:
-	return count;
-}
-
 static ssize_t uboot_ver_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
@@ -442,11 +348,9 @@ static DEVICE_ATTR_RO(device_type);
 static DEVICE_ATTR_RO(fuse_ver);
 static DEVICE_ATTR_WO(hard_reset);
 static DEVICE_ATTR_RO(hard_reset_cnt);
-static DEVICE_ATTR_RW(high_pll);
 static DEVICE_ATTR_RO(infineon_ver);
 static DEVICE_ATTR_RW(max_power);
 static DEVICE_ATTR_RO(pci_addr);
-static DEVICE_ATTR_RW(pm_mng_profile);
 static DEVICE_ATTR_RO(preboot_btl_ver);
 static DEVICE_ATTR_WO(soft_reset);
 static DEVICE_ATTR_RO(soft_reset_cnt);
@@ -468,11 +372,9 @@ static struct attribute *hl_dev_attrs[] = {
 	&dev_attr_fuse_ver.attr,
 	&dev_attr_hard_reset.attr,
 	&dev_attr_hard_reset_cnt.attr,
-	&dev_attr_high_pll.attr,
 	&dev_attr_infineon_ver.attr,
 	&dev_attr_max_power.attr,
 	&dev_attr_pci_addr.attr,
-	&dev_attr_pm_mng_profile.attr,
 	&dev_attr_preboot_btl_ver.attr,
 	&dev_attr_soft_reset.attr,
 	&dev_attr_soft_reset_cnt.attr,
-- 
2.17.1

