Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B91C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 16:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5BF22B48
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 16:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578154780;
	bh=Fw0NvdW7287oB2BrjWobdQwsYg6taF1cc9PK7xdCqck=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GQS4qrREM59hEqFe7VxQ4vlAI51tzawx2p+wUHn+jSj7Y1Zo1GFeRczPtVt/Euxo5
	 +rKPYarCfr4kkOHFoqEmcYMT6l0YRbxDLmvvm6OPuOiFvnUPnlUSU//eZdzXlBNjjd
	 UuzfzycOd6NE9NAmA+rVuyFfIqTvmOgZPnZX9r1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgADQTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 11:19:38 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:64249 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgADQTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 11:19:38 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 004GJ8oP011517;
        Sun, 5 Jan 2020 01:19:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 004GJ8oP011517
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578154749;
        bh=zePdzdwBtHIGogzGwb31GcCJQDH95pGUnC9jUQxS7HM=;
        h=From:To:Cc:Subject:Date:From;
        b=byknvfZDG0lGsRXOdRznn+EoyEpsq8f5gVmFqzCl9i/DWD1L/UtG2qOxmD7fV7J9o
         ndlrsiPxxfLchakuSqHOJeSX61UoIJqfALKvUtTFrQMCKlnrheWjX/LFwUBsjyV/IW
         5gDp9vJxXWF3EHbAhmGPSZ1PYbwgT70kYGy1fha4cDXAS14ml2FMJ1BEgDm1yiwAry
         3E80VOhlMqw9Rt8M0Rf0YrW7ER28F0iGmuMAu5ahJmUYiGu+Yzse263s9oLdQTmw9C
         nqtPPuf0v9MWbNuxPevueAtGujd2fy1ZRYy+71G4y5dcI/oJSxlXoS+DWJuVTu+vAs
         yoHwlCl228B6Q==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: most: remove header include path to drivers/staging
Date:   Sun,  5 Jan 2020 01:18:27 +0900
Message-Id: <20200104161827.18960-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to add "ccflags-y += -I $(srctree)/drivers/staging"
just for including <most/core.h>.

Use the #include "..." directive with the correct relative path.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/staging/most/Makefile       | 1 -
 drivers/staging/most/cdev/Makefile  | 1 -
 drivers/staging/most/cdev/cdev.c    | 3 ++-
 drivers/staging/most/configfs.c     | 3 ++-
 drivers/staging/most/core.c         | 3 ++-
 drivers/staging/most/dim2/Makefile  | 1 -
 drivers/staging/most/dim2/dim2.c    | 2 +-
 drivers/staging/most/i2c/Makefile   | 1 -
 drivers/staging/most/i2c/i2c.c      | 2 +-
 drivers/staging/most/net/Makefile   | 1 -
 drivers/staging/most/net/net.c      | 3 ++-
 drivers/staging/most/sound/Makefile | 1 -
 drivers/staging/most/sound/sound.c  | 3 ++-
 drivers/staging/most/usb/Makefile   | 1 -
 drivers/staging/most/usb/usb.c      | 3 ++-
 drivers/staging/most/video/Makefile | 1 -
 drivers/staging/most/video/video.c  | 2 +-
 17 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/most/Makefile b/drivers/staging/most/Makefile
index 85ea5a434ced..20a99ecb37c4 100644
--- a/drivers/staging/most/Makefile
+++ b/drivers/staging/most/Makefile
@@ -2,7 +2,6 @@
 obj-$(CONFIG_MOST) += most_core.o
 most_core-y := core.o
 most_core-y += configfs.o
-ccflags-y += -I $(srctree)/drivers/staging/
 
 obj-$(CONFIG_MOST_CDEV)	+= cdev/
 obj-$(CONFIG_MOST_NET)	+= net/
diff --git a/drivers/staging/most/cdev/Makefile b/drivers/staging/most/cdev/Makefile
index 9f4a8b8c9c27..ef90cd71994a 100644
--- a/drivers/staging/most/cdev/Makefile
+++ b/drivers/staging/most/cdev/Makefile
@@ -2,4 +2,3 @@
 obj-$(CONFIG_MOST_CDEV) += most_cdev.o
 
 most_cdev-objs := cdev.o
-ccflags-y += -I $(srctree)/drivers/staging/
diff --git a/drivers/staging/most/cdev/cdev.c b/drivers/staging/most/cdev/cdev.c
index f880147c82fd..e2ade8eff2d9 100644
--- a/drivers/staging/most/cdev/cdev.c
+++ b/drivers/staging/most/cdev/cdev.c
@@ -16,7 +16,8 @@
 #include <linux/kfifo.h>
 #include <linux/uaccess.h>
 #include <linux/idr.h>
-#include "most/core.h"
+
+#include "../core.h"
 
 #define CHRDEV_REGION_SIZE 50
 
diff --git a/drivers/staging/most/configfs.c b/drivers/staging/most/configfs.c
index 34a9fb53985c..76c9485cb470 100644
--- a/drivers/staging/most/configfs.c
+++ b/drivers/staging/most/configfs.c
@@ -10,7 +10,8 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/configfs.h>
-#include <most/core.h>
+
+#include "core.h"
 
 struct mdev_link {
 	struct config_item item;
diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
index 51a6b41d5b82..7da0db64ffec 100644
--- a/drivers/staging/most/core.c
+++ b/drivers/staging/most/core.c
@@ -21,7 +21,8 @@
 #include <linux/kthread.h>
 #include <linux/dma-mapping.h>
 #include <linux/idr.h>
-#include <most/core.h>
+
+#include "core.h"
 
 #define MAX_CHANNELS	64
 #define STRING_SIZE	80
diff --git a/drivers/staging/most/dim2/Makefile b/drivers/staging/most/dim2/Makefile
index 116f04d69244..861adacf6c72 100644
--- a/drivers/staging/most/dim2/Makefile
+++ b/drivers/staging/most/dim2/Makefile
@@ -2,4 +2,3 @@
 obj-$(CONFIG_MOST_DIM2) += most_dim2.o
 
 most_dim2-objs := dim2.o hal.o sysfs.o
-ccflags-y += -I $(srctree)/drivers/staging/
diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index 64c979155a49..b96faab08b38 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -21,7 +21,7 @@
 #include <linux/sched.h>
 #include <linux/kthread.h>
 
-#include "most/core.h"
+#include "../core.h"
 #include "hal.h"
 #include "errors.h"
 #include "sysfs.h"
diff --git a/drivers/staging/most/i2c/Makefile b/drivers/staging/most/i2c/Makefile
index 2b3769dc19e7..71099dd0f85b 100644
--- a/drivers/staging/most/i2c/Makefile
+++ b/drivers/staging/most/i2c/Makefile
@@ -2,4 +2,3 @@
 obj-$(CONFIG_MOST_I2C) += most_i2c.o
 
 most_i2c-objs := i2c.o
-ccflags-y += -I $(srctree)/drivers/staging/
diff --git a/drivers/staging/most/i2c/i2c.c b/drivers/staging/most/i2c/i2c.c
index 4a4fc1005932..0418f77d4007 100644
--- a/drivers/staging/most/i2c/i2c.c
+++ b/drivers/staging/most/i2c/i2c.c
@@ -14,7 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/err.h>
 
-#include "most/core.h"
+#include "../core.h"
 
 enum { CH_RX, CH_TX, NUM_CHANNELS };
 
diff --git a/drivers/staging/most/net/Makefile b/drivers/staging/most/net/Makefile
index f0ac64dee71b..1582c97eb204 100644
--- a/drivers/staging/most/net/Makefile
+++ b/drivers/staging/most/net/Makefile
@@ -2,4 +2,3 @@
 obj-$(CONFIG_MOST_NET) += most_net.o
 
 most_net-objs := net.o
-ccflags-y += -I $(srctree)/drivers/staging/
diff --git a/drivers/staging/most/net/net.c b/drivers/staging/most/net/net.c
index 6cab1bb8956e..f4c083c3d1f4 100644
--- a/drivers/staging/most/net/net.c
+++ b/drivers/staging/most/net/net.c
@@ -15,7 +15,8 @@
 #include <linux/list.h>
 #include <linux/wait.h>
 #include <linux/kobject.h>
-#include "most/core.h"
+
+#include "../core.h"
 
 #define MEP_HDR_LEN 8
 #define MDP_HDR_LEN 16
diff --git a/drivers/staging/most/sound/Makefile b/drivers/staging/most/sound/Makefile
index a3d086c6ca70..f0cd9d8d213e 100644
--- a/drivers/staging/most/sound/Makefile
+++ b/drivers/staging/most/sound/Makefile
@@ -2,4 +2,3 @@
 obj-$(CONFIG_MOST_SOUND) += most_sound.o
 
 most_sound-objs := sound.o
-ccflags-y += -I $(srctree)/drivers/staging/
diff --git a/drivers/staging/most/sound/sound.c b/drivers/staging/most/sound/sound.c
index 723d0bd1cc21..4f77ef6f459d 100644
--- a/drivers/staging/most/sound/sound.c
+++ b/drivers/staging/most/sound/sound.c
@@ -17,7 +17,8 @@
 #include <sound/pcm_params.h>
 #include <linux/sched.h>
 #include <linux/kthread.h>
-#include <most/core.h>
+
+#include "../core.h"
 
 #define DRIVER_NAME "sound"
 #define STRING_SIZE	80
diff --git a/drivers/staging/most/usb/Makefile b/drivers/staging/most/usb/Makefile
index 83cf2ead7122..c2b207339aec 100644
--- a/drivers/staging/most/usb/Makefile
+++ b/drivers/staging/most/usb/Makefile
@@ -2,4 +2,3 @@
 obj-$(CONFIG_MOST_USB) += most_usb.o
 
 most_usb-objs := usb.o
-ccflags-y += -I $(srctree)/drivers/staging/
diff --git a/drivers/staging/most/usb/usb.c b/drivers/staging/most/usb/usb.c
index 360cb5b7a10b..d471c675f423 100644
--- a/drivers/staging/most/usb/usb.c
+++ b/drivers/staging/most/usb/usb.c
@@ -23,7 +23,8 @@
 #include <linux/dma-mapping.h>
 #include <linux/etherdevice.h>
 #include <linux/uaccess.h>
-#include "most/core.h"
+
+#include "../core.h"
 
 #define USB_MTU			512
 #define NO_ISOCHRONOUS_URB	0
diff --git a/drivers/staging/most/video/Makefile b/drivers/staging/most/video/Makefile
index 2d857d3cbcc8..856175fec8b6 100644
--- a/drivers/staging/most/video/Makefile
+++ b/drivers/staging/most/video/Makefile
@@ -2,4 +2,3 @@
 obj-$(CONFIG_MOST_VIDEO) += most_video.o
 
 most_video-objs := video.o
-ccflags-y += -I $(srctree)/drivers/staging/
diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index 10c1ef7e3a3e..f3d23cc8e19b 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -21,7 +21,7 @@
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-fh.h>
 
-#include "most/core.h"
+#include "../core.h"
 
 #define V4L2_CMP_MAX_INPUT  1
 
-- 
2.17.1

