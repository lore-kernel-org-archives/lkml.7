Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E231AC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75B22154A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574886849;
	bh=2IvSz474/nJsAxoQnDH2bnp3mXZ8JqDaEXq3s1C68uU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VYfzAQCLJMCh309xIoI1WVqQc/KYgC/7KXKJINU1xpR0FccZWkuEuFqVY9Q/zio2H
	 X+gvVaPS801eAHn7cLysKkp+4BHa9iNd5QySo4pa5sTj5hDkeHvg+lSJpk7vCLER5t
	 WH2gXET4hXlc2VkTPiBLx/5v67aWf2738S4kfcFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfK0UeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:34:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbfK0UeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:34:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07F8220866;
        Wed, 27 Nov 2019 20:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574886843;
        bh=2IvSz474/nJsAxoQnDH2bnp3mXZ8JqDaEXq3s1C68uU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tLdp4ja3qeRjOPi1MFI3KQlVBF0UwSPdIT9x1SzLdlgrzIcNBekPCbgHXOzTiTv0V
         +2lcdsXka/JQXjN/vkJka7ZkhELDh252chfaIAOsVlZVewq+reFEWwCmkS4F7pnlIs
         nKNjRLwPB37CKL3PUtyC7u3gC51hqDnjjj/GOPeU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleksij Rempel <linux@rempel-privat.de>,
        Darren Hart <dvhart@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 015/132] asus-wmi: provide access to ALS control
Date:   Wed, 27 Nov 2019 21:30:06 +0100
Message-Id: <20191127202912.084782439@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksij Rempel <linux@rempel-privat.de>

[ Upstream commit aca234f6378864d85514be558746c0ea6eabfa8e ]

Asus Zenbook ux31a is providing ACPI0008 interface for ALS
(Ambient Light Sensor), which is accessible for OS => Win 7.
This sensor can be used with iio/acpi-als driver.
Since it is disabled by default, we should use asus-wmi
interface to enable it.

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
Signed-off-by: Darren Hart <dvhart@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-wmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index a2174f01d3122..2dee91537123e 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -117,6 +117,7 @@ MODULE_LICENSE("GPL");
 #define ASUS_WMI_DEVID_LED6		0x00020016
 
 /* Backlight and Brightness */
+#define ASUS_WMI_DEVID_ALS_ENABLE	0x00050001 /* Ambient Light Sensor */
 #define ASUS_WMI_DEVID_BACKLIGHT	0x00050011
 #define ASUS_WMI_DEVID_BRIGHTNESS	0x00050012
 #define ASUS_WMI_DEVID_KBD_BACKLIGHT	0x00050021
@@ -1759,6 +1760,7 @@ ASUS_WMI_CREATE_DEVICE_ATTR(touchpad, 0644, ASUS_WMI_DEVID_TOUCHPAD);
 ASUS_WMI_CREATE_DEVICE_ATTR(camera, 0644, ASUS_WMI_DEVID_CAMERA);
 ASUS_WMI_CREATE_DEVICE_ATTR(cardr, 0644, ASUS_WMI_DEVID_CARDREADER);
 ASUS_WMI_CREATE_DEVICE_ATTR(lid_resume, 0644, ASUS_WMI_DEVID_LID_RESUME);
+ASUS_WMI_CREATE_DEVICE_ATTR(als_enable, 0644, ASUS_WMI_DEVID_ALS_ENABLE);
 
 static ssize_t store_cpufv(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
@@ -1785,6 +1787,7 @@ static struct attribute *platform_attributes[] = {
 	&dev_attr_cardr.attr,
 	&dev_attr_touchpad.attr,
 	&dev_attr_lid_resume.attr,
+	&dev_attr_als_enable.attr,
 	NULL
 };
 
@@ -1805,6 +1808,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
 		devid = ASUS_WMI_DEVID_TOUCHPAD;
 	else if (attr == &dev_attr_lid_resume.attr)
 		devid = ASUS_WMI_DEVID_LID_RESUME;
+	else if (attr == &dev_attr_als_enable.attr)
+		devid = ASUS_WMI_DEVID_ALS_ENABLE;
 
 	if (devid != -1)
 		ok = !(asus_wmi_get_devstate_simple(asus, devid) < 0);
-- 
2.20.1



