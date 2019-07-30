Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D273AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C0420651
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAzhOB2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbfG3Jrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:47:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40068 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731973AbfG3Jri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:47:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so65015082wrl.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 02:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=te1PvUfXjbJ9OoO29F6PWVsBnkbGxkv5+wYtbatJV54=;
        b=rAzhOB2nGZy/qrrgtwLHsWsCbB/tOk5PSdRPUjPPlQL2udB2ZhGEIk/fgdT6VR039F
         nssXnfeQW7aToO21DckkvnaWWulMFsCAb5iF/J0msFxsjgPJO/VhPF1463wDsNkLJj/F
         nxtBK068ySDxvLdB/buG0kmDgaujQCHTkaUjmHrQooAA9n/fPhxEfvdLEGzuJxJLWZFr
         P0pg+4AJLEgMvPYtMdzJOwIcEx7Q7xjAtPogQjxA4DaYB+4YQsBAqiD1znOawAmRgHDG
         NiIJRFU30OC/7WaZtbGDaInpfaJhO/AJTg5s78DMdpaXvY1PQLa5+iHuTzN4jlz6+BpD
         mKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=te1PvUfXjbJ9OoO29F6PWVsBnkbGxkv5+wYtbatJV54=;
        b=A8o5caMhnpjMYJ5tM0ewuhPqv0OykhjNcbYWJ4MOviZLOWh7s57iej+xJ7w7VKiAYq
         UeoBMmjDf4VSPW1R2+Tvyy0JE/Z8Ay0aMR/HDWwTnhJO/Co2/IqicN68pXbKD5yKyAZ7
         7m2RgoJCaSKA6ZDMiZFaR2JceP3nngPBGtzZ/1QLGSWPPc1WoGcba4t/rWrUgzSSlGIm
         +qJB1+Y3QT0m1AR2w6tVEpoitn5l6TOy7mkYfIi+7ZIoh72bD+bDK3VIC1OPyFymGAP9
         0RDVaWKfozr/8zI/hxM4aqsuj62D2tlAaHHBl969KJTCMxkNQWUXi3FIXggs11j7cYBs
         LjYg==
X-Gm-Message-State: APjAAAXmqxQcY00TdMZ8be+wUTzVpT7J/yF2TdgCFCPU2i1GQ3UG6Vyb
        wjUqF5b3ank9VfFwZMSivNbBeote9wQ=
X-Google-Smtp-Source: APXvYqzX+qLYUwcbiXTUxBeqivGKDfvNXyM2DEwnP1Y3JCBgp+gPILL8E0E03k39S7m8Mfa8RuGMlw==
X-Received: by 2002:a05:6000:187:: with SMTP id p7mr3891873wrx.189.1564480056095;
        Tue, 30 Jul 2019 02:47:36 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id k124sm105967360wmk.47.2019.07.30.02.47.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 02:47:35 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH v2 6/7] habanalabs: change device_setup_cdev() to be more generic
Date:   Tue, 30 Jul 2019 12:47:23 +0300
Message-Id: <20190730094724.18691-7-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190730094724.18691-1-oded.gabbay@gmail.com>
References: <20190730094724.18691-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch re-factors the device_setup_cdev() function to make it more
generic. It doesn't manipulate members of the driver's internal device
structure but instead works only on the arguments that are sent to it.

This is in preparation for using this function to create an additional
char device per ASIC.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c | 47 +++++++++++++++++---------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index 926c85ff068f..60c779648f92 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -131,48 +131,43 @@ static const struct file_operations hl_ops = {
  * @hdev: pointer to habanalabs device structure
  * @hclass: pointer to the class object of the device
  * @minor: minor number of the specific device
- * @fpos : file operations to install for this device
+ * @fpos: file operations to install for this device
+ * @name: name of the device as it will appear in the filesystem
+ * @cdev: pointer to the char device object that will be created
+ * @dev: pointer to the device object that will be created
  *
  * Create a cdev and a Linux device for habanalabs's device. Need to be
  * called at the end of the habanalabs device initialization process,
  * because this function exposes the device to the user
  */
 static int device_setup_cdev(struct hl_device *hdev, struct class *hclass,
-				int minor, const struct file_operations *fops)
+				int minor, const struct file_operations *fops,
+				char *name, struct cdev *cdev,
+				struct device **dev)
 {
 	int err, devno = MKDEV(hdev->major, minor);
-	struct cdev *hdev_cdev = &hdev->cdev;
-	char *name;
-
-	name = kasprintf(GFP_KERNEL, "hl%d", hdev->id);
-	if (!name)
-		return -ENOMEM;
 
-	cdev_init(hdev_cdev, fops);
-	hdev_cdev->owner = THIS_MODULE;
-	err = cdev_add(hdev_cdev, devno, 1);
+	cdev_init(cdev, fops);
+	cdev->owner = THIS_MODULE;
+	err = cdev_add(cdev, devno, 1);
 	if (err) {
 		pr_err("Failed to add char device %s\n", name);
-		goto err_cdev_add;
+		return err;
 	}
 
-	hdev->dev = device_create(hclass, NULL, devno, NULL, "%s", name);
-	if (IS_ERR(hdev->dev)) {
+	*dev = device_create(hclass, NULL, devno, NULL, "%s", name);
+	if (IS_ERR(*dev)) {
 		pr_err("Failed to create device %s\n", name);
-		err = PTR_ERR(hdev->dev);
+		err = PTR_ERR(*dev);
 		goto err_device_create;
 	}
 
-	dev_set_drvdata(hdev->dev, hdev);
-
-	kfree(name);
+	dev_set_drvdata(*dev, hdev);
 
 	return 0;
 
 err_device_create:
-	cdev_del(hdev_cdev);
-err_cdev_add:
-	kfree(name);
+	cdev_del(cdev);
 	return err;
 }
 
@@ -875,9 +870,17 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 int hl_device_init(struct hl_device *hdev, struct class *hclass)
 {
 	int i, rc, cq_ready_cnt;
+	char *name;
+
+	name = kasprintf(GFP_KERNEL, "hl%d", hdev->id);
+	if (!name)
+		return -ENOMEM;
 
 	/* Create device */
-	rc = device_setup_cdev(hdev, hclass, hdev->id, &hl_ops);
+	rc = device_setup_cdev(hdev, hclass, hdev->id, &hl_ops, name,
+				&hdev->cdev, &hdev->dev);
+
+	kfree(name);
 
 	if (rc)
 		goto out_disabled;
-- 
2.17.1

