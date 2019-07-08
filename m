Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E10BC606BA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509AB21670
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaTwLTP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbfGHOLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:11:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52997 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbfGHOLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:11:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so15972823wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 07:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=eJ0S/Raol8XcxvKWX+Ed75gL5bHK9WT/BojiEGZktq8=;
        b=iaTwLTP8yo4gu3s3vUMaO0xfNrFuPKWd58eUeO7/WPOqyE8rXHxPWWTZVsP0ugAvQz
         bIscIRJmkioV+y5ARNd6IrHZ3mcnpsq5lLfRe98lYleY+fitB3Eg8EJRzQdDJonZHGkH
         nbe43B903XvBHeaAfaUStxuybAFoCt2G0hhTLOlhYVI5/2yTWZyxwNe/44jpTObaR+bU
         TtwoYzwB1AEUTt03LDnfiDBZBRGdoIC1apXrIoyzwTfuLCnioV8AwWv9G7Ug+6oT/PKK
         AwSvIgRZtyh8AMm8+4UaSrTNW4y22bMQREz1dG9mtxeYNG6gk/qgbH+WzshN6wbiv4AU
         Ekjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=eJ0S/Raol8XcxvKWX+Ed75gL5bHK9WT/BojiEGZktq8=;
        b=j+FgNQ+2rI7N9b34uv/JOORiMR0ThVRDA0aE48PZ0ro8nFiSGSwhg5AEr4mm7v8CoD
         FVFCseLLsKq5R3Qs1vH5Bh5AmCJ9M2+WsI2+/Vq0Tk7uHsXS53nIhrSwGtCnuPBE1zL2
         kOgcaMfsPWqngt9w3HX7iHykEgWKq9tTQZ0lwPxKTXszlX+bG7JhpyOsImH29n205y8r
         jbEGdbshUzz6dZzn7WloegChLvTiOYmKdbawoRW2hNb5QMhsQtaJ8hLW5npca3zMf9gh
         RwlNZ/sb4kF0gYsCx0caFBAP+WYLJawfcH6p6jTvZ/YO6pWAn/j7xZiTp5sjPxbvEKV/
         lx1A==
X-Gm-Message-State: APjAAAWI8dRykU0schxXjV4tECHEarfOQg25asFmCPlKSu4RdqBmGMLm
        3O7G8ZK32tr++QfSX5g02+mCDuWJcLY=
X-Google-Smtp-Source: APXvYqxovVxqH0khiD29A8w+5kC97us+A87KL80NHv/3HvI71zrLoamCHLx4W113ekjuYY2L3qHDLQ==
X-Received: by 2002:a1c:dc46:: with SMTP id t67mr15838307wmg.159.1562595104111;
        Mon, 08 Jul 2019 07:11:44 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id e3sm4629258wrt.93.2019.07.08.07.11.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 07:11:43 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: remove write_open_cnt property
Date:   Mon,  8 Jul 2019 17:11:41 +0300
Message-Id: <20190708141141.15300-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property has attempted to show the number of open file descriptors on
the device. This was a stupid and futile attempt so remove this property
completely.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 Documentation/ABI/testing/sysfs-driver-habanalabs |  9 +--------
 drivers/misc/habanalabs/sysfs.c                   | 10 ----------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-habanalabs b/Documentation/ABI/testing/sysfs-driver-habanalabs
index f433fc6db3c6..8d1c81cc9167 100644
--- a/Documentation/ABI/testing/sysfs-driver-habanalabs
+++ b/Documentation/ABI/testing/sysfs-driver-habanalabs
@@ -186,11 +186,4 @@ What:           /sys/class/habanalabs/hl<n>/uboot_ver
 Date:           Jan 2019
 KernelVersion:  5.1
 Contact:        oded.gabbay@gmail.com
-Description:    Version of the u-boot running on the device's CPU
-
-What:           /sys/class/habanalabs/hl<n>/write_open_cnt
-Date:           Jan 2019
-KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
-Description:    Displays the total number of user processes that are currently
-                opened on the device's file
+Description:    Version of the u-boot running on the device's CPU
\ No newline at end of file
diff --git a/drivers/misc/habanalabs/sysfs.c b/drivers/misc/habanalabs/sysfs.c
index 25eb46d29d88..67e3424d4e65 100644
--- a/drivers/misc/habanalabs/sysfs.c
+++ b/drivers/misc/habanalabs/sysfs.c
@@ -351,14 +351,6 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 	return sprintf(buf, "%s\n", str);
 }
 
-static ssize_t write_open_cnt_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct hl_device *hdev = dev_get_drvdata(dev);
-
-	return sprintf(buf, "%d\n", hdev->user_ctx ? 1 : 0);
-}
-
 static ssize_t soft_reset_cnt_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -461,7 +453,6 @@ static DEVICE_ATTR_RO(soft_reset_cnt);
 static DEVICE_ATTR_RO(status);
 static DEVICE_ATTR_RO(thermal_ver);
 static DEVICE_ATTR_RO(uboot_ver);
-static DEVICE_ATTR_RO(write_open_cnt);
 
 static struct bin_attribute bin_attr_eeprom = {
 	.attr = {.name = "eeprom", .mode = (0444)},
@@ -488,7 +479,6 @@ static struct attribute *hl_dev_attrs[] = {
 	&dev_attr_status.attr,
 	&dev_attr_thermal_ver.attr,
 	&dev_attr_uboot_ver.attr,
-	&dev_attr_write_open_cnt.attr,
 	NULL,
 };
 
-- 
2.17.1

