Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7B6C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9C4208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564577087;
	bh=7reqGB1oneZIvnBYyl+e01KzuP0iwc/xUA6OSeWmXBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fv1U2vXceknfMzALDpjQjm+1l0gkuN2kCAOh8b1YKXP3XLJ5GqxQjGzA0O36k6ceB
	 2L9UDteSYQH0FsadAYgD+nDYOrlJP/uNN1R1kbi3u4KQNZfEB/oyaP0Jtjmd9itFRw
	 XHlKJqnbAq2J5SZqxyLOQBNM3p9SAodzKx+fkjiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387944AbfGaMoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbfGaMoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:44:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AD9C208E3;
        Wed, 31 Jul 2019 12:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564577042;
        bh=7reqGB1oneZIvnBYyl+e01KzuP0iwc/xUA6OSeWmXBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1uw509b3gXm5yAW7uuB6EetTqGB8HhRpSMLiG7Ppjay2X6HdPFbCqVbsExJkmR5cy
         SlAEWEwBJhVHks+EvZdNNwwSNTheqZqcu/Icf1qd42ezG8Z2bh0MlIj3YrHzX2XqPl
         kJ95oL8TKrHzSGo/l1xsd/hFpBh/5pCbywFgNusM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 01/10] driver core: add dev_groups to all drivers
Date:   Wed, 31 Jul 2019 14:43:40 +0200
Message-Id: <20190731124349.4474-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731124349.4474-1-gregkh@linuxfoundation.org>
References: <20190731124349.4474-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Add the ability for the driver core to create and remove a list of
attribute groups automatically when the device is bound/unbound from a
specific driver.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/dd.c      | 14 ++++++++++++++
 include/linux/device.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 994a90747420..d811e60610d3 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -554,9 +554,16 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 			goto probe_failed;
 	}
 
+	if (device_add_groups(dev, drv->dev_groups)) {
+		dev_err(dev, "device_add_groups() failed\n");
+		goto dev_groups_failed;
+	}
+
 	if (test_remove) {
 		test_remove = false;
 
+		device_remove_groups(dev, drv->dev_groups);
+
 		if (dev->bus->remove)
 			dev->bus->remove(dev);
 		else if (drv->remove)
@@ -584,6 +591,11 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		 drv->bus->name, __func__, dev_name(dev), drv->name);
 	goto done;
 
+dev_groups_failed:
+	if (dev->bus->remove)
+		dev->bus->remove(dev);
+	else if (drv->remove)
+		drv->remove(dev);
 probe_failed:
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
@@ -1114,6 +1126,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 
 		pm_runtime_put_sync(dev);
 
+		device_remove_groups(dev, drv->dev_groups);
+
 		if (dev->bus && dev->bus->remove)
 			dev->bus->remove(dev);
 		else if (drv->remove)
diff --git a/include/linux/device.h b/include/linux/device.h
index c330b75c6c57..98c00b71b598 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -262,6 +262,8 @@ enum probe_type {
  * @resume:	Called to bring a device from sleep mode.
  * @groups:	Default attributes that get created by the driver core
  *		automatically.
+ * @dev_groups:	Additional attributes attached to device instance once the
+ *		it is bound to the driver.
  * @pm:		Power management operations of the device which matched
  *		this driver.
  * @coredump:	Called when sysfs entry is written to. The device driver
@@ -296,6 +298,7 @@ struct device_driver {
 	int (*suspend) (struct device *dev, pm_message_t state);
 	int (*resume) (struct device *dev);
 	const struct attribute_group **groups;
+	const struct attribute_group **dev_groups;
 
 	const struct dev_pm_ops *pm;
 	void (*coredump) (struct device *dev);
-- 
2.22.0

