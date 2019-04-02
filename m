Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76408C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 00:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413092146E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 00:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554165662;
	bh=kGlzYNvnx2j57Yy5KzGg35jicf7vTPu7Xw0BB8/0CGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RIAPXeLCbn07mgz8+SlFm5Eh0VWfsDloxDwPf41fVUOfVLcWaTx7SKlL+v5vEzRWu
	 7JCb70WaY0bGt4PHcb39Ch9/Dwu9gNUKvy2L3WLzj19vCE3ldDQLGrQ0zXOvij3Iqo
	 c1wxcQa/k0oUV9IzOP3MaLbKYSzVcaJg96Mxs77g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfDBAlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 20:41:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728710AbfDBAkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 20:40:31 -0400
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A7902147A;
        Tue,  2 Apr 2019 00:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554165630;
        bh=kGlzYNvnx2j57Yy5KzGg35jicf7vTPu7Xw0BB8/0CGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9rm7HGOmK7gVzov3pIGPv1j0+4YWdpfMv7lobaErcBx9wMvCDWgk9pASaEdYV6JZ
         rzf9lS8vmgiDBYtlcwDRF+IhydbGtHwClkQxSS5S66U6z6+ED2dfurWlTPv63r8VPw
         OUnlJbrqmlagl3bw/v1MJqLUh7ByaSPvvyiQ2G1U=
From:   Shuah Khan <shuah@kernel.org>
To:     mchehab@kernel.org, perex@perex.cz, tiwai@suse.com,
        hverkuil@xs4all.nl
Cc:     Shuah Khan <shuah@kernel.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH v15 2/6] media: change au0828 to use Media Device Allocator API
Date:   Mon,  1 Apr 2019 18:40:20 -0600
Message-Id: <2e3ff96655b303471442bc87e3ece42dd632bc3b.1554155703.git.shuah@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1554155701.git.shuah@kernel.org>
References: <cover.1554155701.git.shuah@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Media Device Allocator API to allows multiple drivers share a media device.
This API solves a very common use-case for media devices where one physical
device (an USB stick) provides both audio and video. When such media device
exposes a standard USB Audio class, a proprietary Video class, two or more
independent drivers will share a single physical USB bridge. In such cases,
it is necessary to coordinate access to the shared resource.

Using this API, drivers can allocate a media device with the shared struct
device as the key. Once the media device is allocated by a driver, other
drivers can get a reference to it. The media device is released when all
the references are released.

Change au0828 to use Media Device Allocator API to allocate media device
with the parent usb struct device as the key, so it can be shared with the
snd_usb_audio driver.

Signed-off-by: Shuah Khan <shuah@kernel.org>
---
 drivers/media/usb/au0828/Kconfig       |  2 ++
 drivers/media/usb/au0828/au0828-core.c | 13 +++++--------
 drivers/media/usb/au0828/au0828.h      |  1 +
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/media/usb/au0828/Kconfig b/drivers/media/usb/au0828/Kconfig
index 65fc067eb864..98de6e24329e 100644
--- a/drivers/media/usb/au0828/Kconfig
+++ b/drivers/media/usb/au0828/Kconfig
@@ -2,6 +2,8 @@
 config VIDEO_AU0828
 	tristate "Auvitek AU0828 support"
 	depends on I2C && INPUT && DVB_CORE && USB && VIDEO_V4L2
+	select MEDIA_CONTROLLER
+	select MEDIA_CONTROLLER_DVB
 	select I2C_ALGOBIT
 	select VIDEO_TVEEPROM
 	select VIDEOBUF2_VMALLOC if VIDEO_V4L2
diff --git a/drivers/media/usb/au0828/au0828-core.c b/drivers/media/usb/au0828/au0828-core.c
index 3f8c92a70116..4f8ba6f64d3c 100644
--- a/drivers/media/usb/au0828/au0828-core.c
+++ b/drivers/media/usb/au0828/au0828-core.c
@@ -155,9 +155,7 @@ static void au0828_unregister_media_device(struct au0828_dev *dev)
 	dev->media_dev->disable_source = NULL;
 	mutex_unlock(&mdev->graph_mutex);
 
-	media_device_unregister(dev->media_dev);
-	media_device_cleanup(dev->media_dev);
-	kfree(dev->media_dev);
+	media_device_delete(dev->media_dev, KBUILD_MODNAME, THIS_MODULE);
 	dev->media_dev = NULL;
 #endif
 }
@@ -210,14 +208,10 @@ static int au0828_media_device_init(struct au0828_dev *dev,
 #ifdef CONFIG_MEDIA_CONTROLLER
 	struct media_device *mdev;
 
-	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
+	mdev = media_device_usb_allocate(udev, KBUILD_MODNAME, THIS_MODULE);
 	if (!mdev)
 		return -ENOMEM;
 
-	/* check if media device is already initialized */
-	if (!mdev->dev)
-		media_device_usb_init(mdev, udev, udev->product);
-
 	dev->media_dev = mdev;
 #endif
 	return 0;
@@ -480,6 +474,9 @@ static int au0828_media_device_register(struct au0828_dev *dev,
 		/* register media device */
 		ret = media_device_register(dev->media_dev);
 		if (ret) {
+			media_device_delete(dev->media_dev, KBUILD_MODNAME,
+					    THIS_MODULE);
+			dev->media_dev = NULL;
 			dev_err(&udev->dev,
 				"Media Device Register Error: %d\n", ret);
 			return ret;
diff --git a/drivers/media/usb/au0828/au0828.h b/drivers/media/usb/au0828/au0828.h
index 425c35d16057..57b00de8d3f2 100644
--- a/drivers/media/usb/au0828/au0828.h
+++ b/drivers/media/usb/au0828/au0828.h
@@ -31,6 +31,7 @@
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-fh.h>
 #include <media/media-device.h>
+#include <media/media-dev-allocator.h>
 
 /* DVB */
 #include <media/demux.h>
-- 
2.17.1

