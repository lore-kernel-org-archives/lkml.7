Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AC1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42A0206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHaWf740"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbfGaM7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:59:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52609 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbfGaM7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:59:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so60685043wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=te1PvUfXjbJ9OoO29F6PWVsBnkbGxkv5+wYtbatJV54=;
        b=HHaWf74062QMfobpYr66oOUpUmies/LzfXFRrRRyX1FH4G6GMY6fAIw+VrCW51WifB
         LfW9uWiLZMsMjkXHDJRfBeA/SvxXpQuyLX9dlO2gfoeC+DyftStyIhmZARCHmgvAJil4
         zDFKX5ecH3GXQtZzV55P0zdTlV9Ar8H+1Un6WFbJRludU7C037P6jUaozUoCA27N8M3s
         s3emo/fO+l940WJjAIS1vPbT/zdBiJ4SPvlJEJp+tun4VqO+1m6nak5RAh/XS9/uViOu
         YJ3ajXElOnJUUU7vYIDM3Exw066CV19Lf0TfjtzMhroJQbKw0Ik0SmTcH7xNX5XEraxr
         A3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=te1PvUfXjbJ9OoO29F6PWVsBnkbGxkv5+wYtbatJV54=;
        b=d8gXm2Oa1CcLYy5Rs5fZ6BpFX/nl7ds8NWgU2cF71gZrHks/aaw7E7jjJe5sYLYH1l
         g1sHG392Wa+OFN+7XTe8Ea9YZZ/yiP8ryz2qc8RGE8xzVOsivGe8QfoSyGsG8f7d7W2K
         F4xkrxB5HfH+a5cRupPnpHy2XdKS6bZgEdPRDBrlHZexe/lmuSJvUBK/cDHeJRzxGVTk
         aOuq4CZUaD+GjsPtCERlkXlzvGZMNhjE5imBFul0BEGsP8ufpEe70bRiuLQgO302e/2a
         jUGmJH/mVdxcIzimFHeESWKzzzdH2K2pOMJlrhIRkTsg94nkraIh14uClSwtqK6PsmlJ
         Iu9Q==
X-Gm-Message-State: APjAAAUXR00B0IDTzQvOZiHDGv+G0fnEpXPj2Mpj+EzAQYiIeBPigCM/
        3WkS0hKZZ6MRdzaHjHhis0d3SQvuQBs=
X-Google-Smtp-Source: APXvYqyHRVrdbWCdK9ibK4S/MN9uF6ffL09q6g1kmLzkhdDP2Pcv9I0P+ELvpJszb0DDDIfVyMTivw==
X-Received: by 2002:a1c:c742:: with SMTP id x63mr117168874wmf.0.1564577951874;
        Wed, 31 Jul 2019 05:59:11 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c6sm69247800wma.25.2019.07.31.05.59.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:59:11 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH v3 6/7] habanalabs: change device_setup_cdev() to be more generic
Date:   Wed, 31 Jul 2019 15:59:00 +0300
Message-Id: <20190731125901.20709-7-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190731125901.20709-1-oded.gabbay@gmail.com>
References: <20190731125901.20709-1-oded.gabbay@gmail.com>
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

