Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6963C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE42620656
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfF1E45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 00:56:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:19089 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbfF1E45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 00:56:57 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 295CAA1E14ACAA62F426;
        Fri, 28 Jun 2019 12:56:54 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 28 Jun 2019
 12:56:44 +0800
From:   Zhihao@vger.kernel.org, Cheng@vger.kernel.org
To:     <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
        <david@sigma-star.at>, <boris.brezillon@free-electrons.com>,
        <yi.zhang@huawei.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>
Subject: [PATCH RFC] mtd: ubi: Add fastmap sysfs attribute
Date:   Fri, 28 Jun 2019 13:02:23 +0800
Message-ID: <1561698143-5027-1-git-send-email-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhihao Cheng <chengzhihao1@huawei.com>

The UBI device can be attached to a MTD device via fastmap by set
CONFIG_MTD_UBI_FASTMAP to 'y' (If there already exists a fastmap on the
UBI device). To support some debugging scenarios, attaching process by
fastmap can be confirmed in dmesg. If the UBI device is attached by
fastmap, logs like following will appear in dmesg:

  ubi0: attached by fastmap

If multiple UBI devices are attached to multiple MTD devices at the same
time, how to distinguish which UBI devices are successfully attached by
fastmap? Extracting attaching information for each UBI device one by one
from dmesg is a way. A better method is to record fastmap existence in
sysfs, so it can be obtained by userspace tools.

This patch exposes fastmap on sysfs. Suppose you attach an UBI device to a
MTD device by fastmap: if fastmap equals to '1', that is, the fastmap
generated before last detaching operation is confirmed valid. Else, there
may be some problems with old fastmap. Besides, userspace tool can also
check whether the fastmap updating triggered by other operations (such as
resize volume) is successful by reading this sysfs attribute.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 Documentation/ABI/stable/sysfs-class-ubi | 15 +++++++++++++++
 drivers/mtd/ubi/build.c                  |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-class-ubi b/Documentation/ABI/stable/sysfs-class-ubi
index a6b3240..1d96cf0 100644
--- a/Documentation/ABI/stable/sysfs-class-ubi
+++ b/Documentation/ABI/stable/sysfs-class-ubi
@@ -116,6 +116,21 @@ Description:
 		device, and "0\n" if it is cleared. UBI devices mark themselves
 		as read-only when they detect an unrecoverable error.
 
+What:		/sys/class/ubi/ubiX/fastmap
+Date:		June 2019
+KernelVersion:	5.2
+Contact:	linux-mtd@lists.infradead.org
+Description:
+		Contains ASCII "1\n" if there exists a fastmap on UBI device,
+		and "0\n" if there not exists a fastmap on UBI device. After
+		attaching the UBI device to a MTD device via fastmap, userspace
+		tool can sense that there is a fastmap on UBI device  by
+		checking sysfs attribute 'fastmap', that is, the fastmap
+		generated before last detaching operation is valid. In addition,
+		userspace tool can also check whether the fastmap updating
+		triggered by volume operation is successful by reading this
+		sysfs attribute.
+
 What:		/sys/class/ubi/ubiX/total_eraseblocks
 Date:		July 2006
 KernelVersion:	2.6.22
diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index d636bbe..7cce44f 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -140,6 +140,8 @@ static struct device_attribute dev_mtd_num =
 	__ATTR(mtd_num, S_IRUGO, dev_attribute_show, NULL);
 static struct device_attribute dev_ro_mode =
 	__ATTR(ro_mode, S_IRUGO, dev_attribute_show, NULL);
+static struct device_attribute dev_fastmap =
+	__ATTR(fastmap, S_IRUGO, dev_attribute_show, NULL);
 
 /**
  * ubi_volume_notify - send a volume change notification.
@@ -378,6 +380,8 @@ static ssize_t dev_attribute_show(struct device *dev,
 		ret = sprintf(buf, "%d\n", ubi->mtd->index);
 	else if (attr == &dev_ro_mode)
 		ret = sprintf(buf, "%d\n", ubi->ro_mode);
+	else if (attr == &dev_fastmap)
+		ret = sprintf(buf, "%d\n", ubi->fm ? 1 : 0);
 	else
 		ret = -EINVAL;
 
@@ -398,6 +402,7 @@ static struct attribute *ubi_dev_attrs[] = {
 	&dev_bgt_enabled.attr,
 	&dev_mtd_num.attr,
 	&dev_ro_mode.attr,
+	&dev_fastmap.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(ubi_dev);
-- 
2.7.4

