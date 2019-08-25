Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31CEC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 21:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C47720674
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 21:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flameeyes-com.20150623.gappssmtp.com header.i=@flameeyes-com.20150623.gappssmtp.com header.b="D7DigmLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfHYV6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 17:58:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45582 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbfHYV6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 17:58:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id q12so13401733wrj.12
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 14:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flameeyes-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UW42jtkGI9ga5NKzOZu2Pn32KJrQje1vsVII5ttdsGQ=;
        b=D7DigmLCgmnQONj3B7oPzzK1Pu5DaLYbOKIX/Y/jSNRaT7L41+sR81ny4MkhNr1sWL
         jG/UEDqSD/OMuBTYVsy4brEmppXcywhP9pEZpbm8UaYeqj5U1kr7rNwNFOEPBpPhLRm5
         ZZAYGDdXl392lsQiBrQLpGBPI7Xa6YXcIr3iNhNIBiJQjjMBz4sGauIItZoB/Hktl3Hu
         PggHFshOOg6qQZuAXCOWxyFr7cnry58acNU1INp7tV/c0l9SdbIRIOwBpy7mBxSe1Kr+
         qNmbsE+kT8tas5kBz0eVlFwbNtGYCDwsRfXpaPATK+W7sgHhGor2C6ARcVrat2cNc6BV
         k2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UW42jtkGI9ga5NKzOZu2Pn32KJrQje1vsVII5ttdsGQ=;
        b=hBWGMOv3QynM7MxBKb0WQcvNLXPo/5ydeU1RAFMy6zPhYGx3GYVfSIZjaszZAbuWde
         YSN77BVe5O+QgO6ES1M5EnLweVaA104tfaZE0GEov+oHyskwW79YOlHx9tWn5LkL6s7y
         Cia3Hq14LZAzL+KxMd5i8Cd5FCW8Xa7nNrMfaSF3wWEQaITTz+yuDRQXKGjWg8OxcqdO
         htd9aPJT48lPs4DvFbYue/Qu4syQp+S5m6VTq7MOcSB8bg9qVV9s1tU2zkIy48lvwGmn
         H4yM5kDLfhcBXncgKnufoc7xEDSgqAThUmCLWLG6SmVGIbVbArrZmYo/ih30WDupgZBe
         GDNQ==
X-Gm-Message-State: APjAAAW1Fz2I0N27vOlrJHdNsSncpyX6oXHUrKBZihPkjiX5DMzVX5Rr
        5CfJ+TMQj5KUME3V6Slg63Jwtol6ky+EEA==
X-Google-Smtp-Source: APXvYqyWKieZNLY5RJOqySyB/umpXTQJR2ChTPpgQImL/+J1tYT3jO47qYTIFwgs3rZgil75E3enLg==
X-Received: by 2002:adf:dfc5:: with SMTP id q5mr19268332wrn.142.1566770322907;
        Sun, 25 Aug 2019 14:58:42 -0700 (PDT)
Received: from localhost ([2a01:4b00:80c6:1000:5b16:35e9:1ce5:7fc9])
        by smtp.gmail.com with ESMTPSA id q18sm9745339wrw.36.2019.08.25.14.58.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2019 14:58:41 -0700 (PDT)
From:   =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>
Subject: [PATCH] cdrom: make debug logging rely on pr_debug and debugfs only.
Date:   Sun, 25 Aug 2019 22:58:33 +0100
Message-Id: <20190825215833.25817-1-flameeyes@flameeyes.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cdrom driver predates debugfs and most of the modern debugging
facilities, so instead it has been includings a module parameter and an
ioctl to enable debug messages.

In 2019, debugfs and dynamic debug makes most of that redundant, and even
confusing when trying to trace things in the dept of the driver.

Signed-off-by: Diego Elio Pettenò <flameeyes@flameeyes.com>
---
 drivers/cdrom/cdrom.c | 270 +++++++++++++++++-------------------------
 1 file changed, 106 insertions(+), 164 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index ac42ae4651ce..7fc94b5f6556 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -247,24 +247,6 @@
 #define REVISION "Revision: 3.20"
 #define VERSION "Id: cdrom.c 3.20 2003/12/17"
 
-/* I use an error-log mask to give fine grain control over the type of
-   messages dumped to the system logs.  The available masks include: */
-#define CD_NOTHING      0x0
-#define CD_WARNING	0x1
-#define CD_REG_UNREG	0x2
-#define CD_DO_IOCTL	0x4
-#define CD_OPEN		0x8
-#define CD_CLOSE	0x10
-#define CD_COUNT_TRACKS 0x20
-#define CD_CHANGER	0x40
-#define CD_DVD		0x80
-
-/* Define this to remove _all_ the debugging messages */
-/* #define ERRLOGMASK CD_NOTHING */
-#define ERRLOGMASK CD_WARNING
-/* #define ERRLOGMASK (CD_WARNING|CD_OPEN|CD_COUNT_TRACKS|CD_CLOSE) */
-/* #define ERRLOGMASK (CD_WARNING|CD_REG_UNREG|CD_DO_IOCTL|CD_OPEN|CD_CLOSE|CD_COUNT_TRACKS) */
-
 #include <linux/atomic.h>
 #include <linux/module.h>
 #include <linux/fs.h>
@@ -286,8 +268,6 @@
 #include <scsi/scsi_common.h>
 #include <scsi/scsi_request.h>
 
-/* used to tell the module to turn on full debugging messages */
-static bool debug;
 /* default compatibility mode */
 static bool autoclose=1;
 static bool autoeject;
@@ -296,7 +276,6 @@ static bool lockdoor = 1;
 static bool check_media_type;
 /* automatically restart mrw format */
 static bool mrw_format_restart = 1;
-module_param(debug, bool, 0);
 module_param(autoclose, bool, 0);
 module_param(autoeject, bool, 0);
 module_param(lockdoor, bool, 0);
@@ -314,20 +293,6 @@ static const char *mrw_format_status[] = {
 
 static const char *mrw_address_space[] = { "DMA", "GAA" };
 
-#if (ERRLOGMASK != CD_NOTHING)
-#define cd_dbg(type, fmt, ...)				\
-do {							\
-	if ((ERRLOGMASK & type) || debug == 1)		\
-		pr_debug(fmt, ##__VA_ARGS__);		\
-} while (0)
-#else
-#define cd_dbg(type, fmt, ...)				\
-do {							\
-	if (0 && (ERRLOGMASK & type) || debug == 1)	\
-		pr_debug(fmt, ##__VA_ARGS__);		\
-} while (0)
-#endif
-
 /* The (cdo->capability & ~cdi->mask & CDC_XXX) construct was used in
    a lot of places. This macro makes the code more clear. */
 #define CDROM_CAN(type) (cdi->ops->capability & ~cdi->mask & (type))
@@ -591,7 +556,7 @@ int register_cdrom(struct cdrom_device_info *cdi)
 	static char banner_printed;
 	const struct cdrom_device_ops *cdo = cdi->ops;
 
-	cd_dbg(CD_OPEN, "entering register_cdrom\n");
+	pr_debug("entering register_cdrom\n");
 
 	if (cdo->open == NULL || cdo->release == NULL)
 		return -EINVAL;
@@ -633,7 +598,7 @@ int register_cdrom(struct cdrom_device_info *cdi)
 
 	WARN_ON(!cdo->generic_packet);
 
-	cd_dbg(CD_REG_UNREG, "drive \"/dev/%s\" registered\n", cdi->name);
+	pr_debug("drive \"/dev/%s\" registered\n", cdi->name);
 	mutex_lock(&cdrom_mutex);
 	list_add(&cdi->list, &cdrom_list);
 	mutex_unlock(&cdrom_mutex);
@@ -643,7 +608,7 @@ int register_cdrom(struct cdrom_device_info *cdi)
 
 void unregister_cdrom(struct cdrom_device_info *cdi)
 {
-	cd_dbg(CD_OPEN, "entering unregister_cdrom\n");
+	pr_debug("entering unregister_cdrom\n");
 
 	mutex_lock(&cdrom_mutex);
 	list_del(&cdi->list);
@@ -652,7 +617,7 @@ void unregister_cdrom(struct cdrom_device_info *cdi)
 	if (cdi->exit)
 		cdi->exit(cdi);
 
-	cd_dbg(CD_REG_UNREG, "drive \"/dev/%s\" unregistered\n", cdi->name);
+	pr_debug("drive \"/dev/%s\" unregistered\n", cdi->name);
 }
 
 int cdrom_get_media_event(struct cdrom_device_info *cdi,
@@ -853,7 +818,7 @@ static int cdrom_ram_open_write(struct cdrom_device_info *cdi)
 	else if (CDF_RWRT == be16_to_cpu(rfd.feature_code))
 		ret = !rfd.curr;
 
-	cd_dbg(CD_OPEN, "can open for random write\n");
+	pr_debug("can open for random write\n");
 	return ret;
 }
 
@@ -943,12 +908,12 @@ static void cdrom_dvd_rw_close_write(struct cdrom_device_info *cdi)
 	struct packet_command cgc;
 
 	if (cdi->mmc3_profile != 0x1a) {
-		cd_dbg(CD_CLOSE, "%s: No DVD+RW\n", cdi->name);
+		pr_debug("%s: No DVD+RW\n", cdi->name);
 		return;
 	}
 
 	if (!cdi->media_written) {
-		cd_dbg(CD_CLOSE, "%s: DVD+RW media clean\n", cdi->name);
+		pr_debug("%s: DVD+RW media clean\n", cdi->name);
 		return;
 	}
 
@@ -995,7 +960,7 @@ static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype *tracks)
 	tracks->cdi = 0;
 	tracks->xa = 0;
 	tracks->error = 0;
-	cd_dbg(CD_COUNT_TRACKS, "entering cdrom_count_tracks\n");
+	pr_debug("entering cdrom_count_tracks\n");
 	/* Grab the TOC header so we can see how many tracks there are */
 	ret = cdi->ops->audio_ioctl(cdi, CDROMREADTOCHDR, &header);
 	if (ret) {
@@ -1023,10 +988,10 @@ static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype *tracks)
 		} else {
 			tracks->audio++;
 		}
-		cd_dbg(CD_COUNT_TRACKS, "track %d: format=%d, ctrl=%d\n",
+		pr_debug("track %d: format=%d, ctrl=%d\n",
 		       i, entry.cdte_format, entry.cdte_ctrl);
 	}
-	cd_dbg(CD_COUNT_TRACKS, "disc has %d tracks: %d=audio %d=data %d=Cd-I %d=XA\n",
+	pr_debug("disc has %d tracks: %d=audio %d=data %d=Cd-I %d=XA\n",
 	       header.cdth_trk1, tracks->audio, tracks->data,
 	       tracks->cdi, tracks->xa);
 }
@@ -1037,21 +1002,21 @@ int open_for_data(struct cdrom_device_info *cdi)
 	int ret;
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	tracktype tracks;
-	cd_dbg(CD_OPEN, "entering open_for_data\n");
+	pr_debug("entering open_for_data\n");
 	/* Check if the driver can report drive status.  If it can, we
 	   can do clever things.  If it can't, well, we at least tried! */
 	if (cdo->drive_status != NULL) {
 		ret = cdo->drive_status(cdi, CDSL_CURRENT);
-		cd_dbg(CD_OPEN, "drive_status=%d\n", ret);
+		pr_debug("drive_status=%d\n", ret);
 		if (ret == CDS_TRAY_OPEN) {
-			cd_dbg(CD_OPEN, "the tray is open...\n");
+			pr_debug("the tray is open...\n");
 			/* can/may i close it? */
 			if (CDROM_CAN(CDC_CLOSE_TRAY) &&
 			    cdi->options & CDO_AUTO_CLOSE) {
-				cd_dbg(CD_OPEN, "trying to close the tray\n");
+				pr_debug("trying to close the tray\n");
 				ret=cdo->tray_move(cdi,0);
 				if (ret) {
-					cd_dbg(CD_OPEN, "bummer. tried to close the tray but failed.\n");
+					pr_debug("bummer. tried to close the tray but failed.\n");
 					/* Ignore the error from the low
 					level driver.  We don't care why it
 					couldn't close the tray.  We only care 
@@ -1061,19 +1026,19 @@ int open_for_data(struct cdrom_device_info *cdi)
 					goto clean_up_and_return;
 				}
 			} else {
-				cd_dbg(CD_OPEN, "bummer. this drive can't close the tray.\n");
+				pr_debug("bummer. this drive can't close the tray.\n");
 				ret=-ENOMEDIUM;
 				goto clean_up_and_return;
 			}
 			/* Ok, the door should be closed now.. Check again */
 			ret = cdo->drive_status(cdi, CDSL_CURRENT);
 			if ((ret == CDS_NO_DISC) || (ret==CDS_TRAY_OPEN)) {
-				cd_dbg(CD_OPEN, "bummer. the tray is still not closed.\n");
-				cd_dbg(CD_OPEN, "tray might not contain a medium\n");
+				pr_debug("bummer. the tray is still not closed.\n");
+				pr_debug("tray might not contain a medium\n");
 				ret=-ENOMEDIUM;
 				goto clean_up_and_return;
 			}
-			cd_dbg(CD_OPEN, "the tray is now closed\n");
+			pr_debug("the tray is now closed\n");
 		}
 		/* the door should be closed now, check for the disc */
 		ret = cdo->drive_status(cdi, CDSL_CURRENT);
@@ -1084,7 +1049,7 @@ int open_for_data(struct cdrom_device_info *cdi)
 	}
 	cdrom_count_tracks(cdi, &tracks);
 	if (tracks.error == CDS_NO_DISC) {
-		cd_dbg(CD_OPEN, "bummer. no disc.\n");
+		pr_debug("bummer. no disc.\n");
 		ret=-ENOMEDIUM;
 		goto clean_up_and_return;
 	}
@@ -1094,34 +1059,34 @@ int open_for_data(struct cdrom_device_info *cdi)
 		if (cdi->options & CDO_CHECK_TYPE) {
 		    /* give people a warning shot, now that CDO_CHECK_TYPE
 		       is the default case! */
-		    cd_dbg(CD_OPEN, "bummer. wrong media type.\n");
-		    cd_dbg(CD_WARNING, "pid %d must open device O_NONBLOCK!\n",
+		    pr_debug("bummer. wrong media type.\n");
+		    pr_debug("pid %d must open device O_NONBLOCK!\n",
 			   (unsigned int)task_pid_nr(current));
 		    ret=-EMEDIUMTYPE;
 		    goto clean_up_and_return;
 		}
 		else {
-		    cd_dbg(CD_OPEN, "wrong media type, but CDO_CHECK_TYPE not set\n");
+		    pr_debug("wrong media type, but CDO_CHECK_TYPE not set\n");
 		}
 	}
 
-	cd_dbg(CD_OPEN, "all seems well, opening the devicen");
+	pr_debug("all seems well, opening the devicen");
 
 	/* all seems well, we can open the device */
 	ret = cdo->open(cdi, 0); /* open for data */
-	cd_dbg(CD_OPEN, "opening the device gave me %d\n", ret);
+	pr_debug("opening the device gave me %d\n", ret);
 	/* After all this careful checking, we shouldn't have problems
 	   opening the device, but we don't want the device locked if 
 	   this somehow fails... */
 	if (ret) {
-		cd_dbg(CD_OPEN, "open device failed\n");
+		pr_debug("open device failed\n");
 		goto clean_up_and_return;
 	}
 	if (CDROM_CAN(CDC_LOCK) && (cdi->options & CDO_LOCK)) {
 			cdo->lock_door(cdi, 1);
-			cd_dbg(CD_OPEN, "door locked\n");
+			pr_debug("door locked\n");
 	}
-	cd_dbg(CD_OPEN, "device opened successfully\n");
+	pr_debug("device opened successfully\n");
 	return ret;
 
 	/* Something failed.  Try to unlock the drive, because some drivers
@@ -1130,10 +1095,10 @@ int open_for_data(struct cdrom_device_info *cdi)
 	This ensures that the drive gets unlocked after a mount fails.  This 
 	is a goto to avoid bloating the driver with redundant code. */ 
 clean_up_and_return:
-	cd_dbg(CD_OPEN, "open failed\n");
+	pr_debug("open failed\n");
 	if (CDROM_CAN(CDC_LOCK) && cdi->options & CDO_LOCK) {
 			cdo->lock_door(cdi, 0);
-			cd_dbg(CD_OPEN, "door unlocked\n");
+			pr_debug("door unlocked\n");
 	}
 	return ret;
 }
@@ -1151,7 +1116,7 @@ int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
 {
 	int ret;
 
-	cd_dbg(CD_OPEN, "entering cdrom_open\n");
+	pr_debug("entering cdrom_open\n");
 
 	/* if this was a O_NONBLOCK open and we should honor the flags,
 	 * do a quick open without drive/disc integrity checks. */
@@ -1177,13 +1142,13 @@ int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
 	if (ret)
 		goto err;
 
-	cd_dbg(CD_OPEN, "Use count for \"/dev/%s\" now %d\n",
+	pr_debug("Use count for \"/dev/%s\" now %d\n",
 	       cdi->name, cdi->use_count);
 	return 0;
 err_release:
 	if (CDROM_CAN(CDC_LOCK) && cdi->options & CDO_LOCK) {
 		cdi->ops->lock_door(cdi, 0);
-		cd_dbg(CD_OPEN, "door unlocked\n");
+		pr_debug("door unlocked\n");
 	}
 	cdi->ops->release(cdi);
 err:
@@ -1199,21 +1164,21 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
 {
         int ret;
 	tracktype tracks;
-	cd_dbg(CD_OPEN, "entering check_for_audio_disc\n");
+	pr_debug("entering check_for_audio_disc\n");
 	if (!(cdi->options & CDO_CHECK_TYPE))
 		return 0;
 	if (cdo->drive_status != NULL) {
 		ret = cdo->drive_status(cdi, CDSL_CURRENT);
-		cd_dbg(CD_OPEN, "drive_status=%d\n", ret);
+		pr_debug("drive_status=%d\n", ret);
 		if (ret == CDS_TRAY_OPEN) {
-			cd_dbg(CD_OPEN, "the tray is open...\n");
+			pr_debug("the tray is open...\n");
 			/* can/may i close it? */
 			if (CDROM_CAN(CDC_CLOSE_TRAY) &&
 			    cdi->options & CDO_AUTO_CLOSE) {
-				cd_dbg(CD_OPEN, "trying to close the tray\n");
+				pr_debug("trying to close the tray\n");
 				ret=cdo->tray_move(cdi,0);
 				if (ret) {
-					cd_dbg(CD_OPEN, "bummer. tried to close tray but failed.\n");
+					pr_debug("bummer. tried to close tray but failed.\n");
 					/* Ignore the error from the low
 					level driver.  We don't care why it
 					couldn't close the tray.  We only care 
@@ -1222,20 +1187,20 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
 					return -ENOMEDIUM;
 				}
 			} else {
-				cd_dbg(CD_OPEN, "bummer. this driver can't close the tray.\n");
+				pr_debug("bummer. this driver can't close the tray.\n");
 				return -ENOMEDIUM;
 			}
 			/* Ok, the door should be closed now.. Check again */
 			ret = cdo->drive_status(cdi, CDSL_CURRENT);
 			if ((ret == CDS_NO_DISC) || (ret==CDS_TRAY_OPEN)) {
-				cd_dbg(CD_OPEN, "bummer. the tray is still not closed.\n");
+				pr_debug("bummer. the tray is still not closed.\n");
 				return -ENOMEDIUM;
 			}	
 			if (ret!=CDS_DISC_OK) {
-				cd_dbg(CD_OPEN, "bummer. disc isn't ready.\n");
+				pr_debug("bummer. disc isn't ready.\n");
 				return -EIO;
 			}	
-			cd_dbg(CD_OPEN, "the tray is now closed\n");
+			pr_debug("the tray is now closed\n");
 		}	
 	}
 	cdrom_count_tracks(cdi, &tracks);
@@ -1253,18 +1218,18 @@ void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	int opened_for_data;
 
-	cd_dbg(CD_CLOSE, "entering cdrom_release\n");
+	pr_debug("entering cdrom_release\n");
 
 	if (cdi->use_count > 0)
 		cdi->use_count--;
 
 	if (cdi->use_count == 0) {
-		cd_dbg(CD_CLOSE, "Use count for \"/dev/%s\" now zero\n",
+		pr_debug("Use count for \"/dev/%s\" now zero\n",
 		       cdi->name);
 		cdrom_dvd_rw_close_write(cdi);
 
 		if ((cdo->capability & CDC_LOCK) && !cdi->keeplocked) {
-			cd_dbg(CD_CLOSE, "Unlocking door!\n");
+			pr_debug("Unlocking door!\n");
 			cdo->lock_door(cdi, 0);
 		}
 	}
@@ -1323,7 +1288,7 @@ static int cdrom_slot_status(struct cdrom_device_info *cdi, int slot)
 	struct cdrom_changer_info *info;
 	int ret;
 
-	cd_dbg(CD_CHANGER, "entering cdrom_slot_status()\n");
+	pr_debug("entering cdrom_slot_status()\n");
 	if (cdi->sanyo_slot)
 		return CDS_NO_INFO;
 	
@@ -1353,7 +1318,7 @@ int cdrom_number_of_slots(struct cdrom_device_info *cdi)
 	int nslots = 1;
 	struct cdrom_changer_info *info;
 
-	cd_dbg(CD_CHANGER, "entering cdrom_number_of_slots()\n");
+	pr_debug("entering cdrom_number_of_slots()\n");
 	/* cdrom_read_mech_status requires a valid value for capacity: */
 	cdi->capacity = 0; 
 
@@ -1374,7 +1339,7 @@ static int cdrom_load_unload(struct cdrom_device_info *cdi, int slot)
 {
 	struct packet_command cgc;
 
-	cd_dbg(CD_CHANGER, "entering cdrom_load_unload()\n");
+	pr_debug("entering cdrom_load_unload()\n");
 	if (cdi->sanyo_slot && slot < 0)
 		return 0;
 
@@ -1403,7 +1368,7 @@ static int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
 	int curslot;
 	int ret;
 
-	cd_dbg(CD_CHANGER, "entering cdrom_select_disc()\n");
+	pr_debug("entering cdrom_select_disc()\n");
 	if (!CDROM_CAN(CDC_SELECT_DISC))
 		return -EDRIVE_CANT_DO_THIS;
 
@@ -1648,7 +1613,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 	switch (ai->type) {
 	/* LU data send */
 	case DVD_LU_SEND_AGID:
-		cd_dbg(CD_DVD, "entering DVD_LU_SEND_AGID\n");
+		pr_debug("entering DVD_LU_SEND_AGID\n");
 		cgc.quiet = 1;
 		setup_report_key(&cgc, ai->lsa.agid, 0);
 
@@ -1660,7 +1625,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		break;
 
 	case DVD_LU_SEND_KEY1:
-		cd_dbg(CD_DVD, "entering DVD_LU_SEND_KEY1\n");
+		pr_debug("entering DVD_LU_SEND_KEY1\n");
 		setup_report_key(&cgc, ai->lsk.agid, 2);
 
 		if ((ret = cdo->generic_packet(cdi, &cgc)))
@@ -1671,7 +1636,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		break;
 
 	case DVD_LU_SEND_CHALLENGE:
-		cd_dbg(CD_DVD, "entering DVD_LU_SEND_CHALLENGE\n");
+		pr_debug("entering DVD_LU_SEND_CHALLENGE\n");
 		setup_report_key(&cgc, ai->lsc.agid, 1);
 
 		if ((ret = cdo->generic_packet(cdi, &cgc)))
@@ -1683,7 +1648,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 
 	/* Post-auth key */
 	case DVD_LU_SEND_TITLE_KEY:
-		cd_dbg(CD_DVD, "entering DVD_LU_SEND_TITLE_KEY\n");
+		pr_debug("entering DVD_LU_SEND_TITLE_KEY\n");
 		cgc.quiet = 1;
 		setup_report_key(&cgc, ai->lstk.agid, 4);
 		cgc.cmd[5] = ai->lstk.lba;
@@ -1702,7 +1667,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		break;
 
 	case DVD_LU_SEND_ASF:
-		cd_dbg(CD_DVD, "entering DVD_LU_SEND_ASF\n");
+		pr_debug("entering DVD_LU_SEND_ASF\n");
 		setup_report_key(&cgc, ai->lsasf.agid, 5);
 		
 		if ((ret = cdo->generic_packet(cdi, &cgc)))
@@ -1713,7 +1678,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 
 	/* LU data receive (LU changes state) */
 	case DVD_HOST_SEND_CHALLENGE:
-		cd_dbg(CD_DVD, "entering DVD_HOST_SEND_CHALLENGE\n");
+		pr_debug("entering DVD_HOST_SEND_CHALLENGE\n");
 		setup_send_key(&cgc, ai->hsc.agid, 1);
 		buf[1] = 0xe;
 		copy_chal(&buf[4], ai->hsc.chal);
@@ -1725,7 +1690,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		break;
 
 	case DVD_HOST_SEND_KEY2:
-		cd_dbg(CD_DVD, "entering DVD_HOST_SEND_KEY2\n");
+		pr_debug("entering DVD_HOST_SEND_KEY2\n");
 		setup_send_key(&cgc, ai->hsk.agid, 3);
 		buf[1] = 0xa;
 		copy_key(&buf[4], ai->hsk.key);
@@ -1740,7 +1705,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 	/* Misc */
 	case DVD_INVALIDATE_AGID:
 		cgc.quiet = 1;
-		cd_dbg(CD_DVD, "entering DVD_INVALIDATE_AGID\n");
+		pr_debug("entering DVD_INVALIDATE_AGID\n");
 		setup_report_key(&cgc, ai->lsa.agid, 0x3f);
 		if ((ret = cdo->generic_packet(cdi, &cgc)))
 			return ret;
@@ -1748,7 +1713,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 
 	/* Get region settings */
 	case DVD_LU_SEND_RPC_STATE:
-		cd_dbg(CD_DVD, "entering DVD_LU_SEND_RPC_STATE\n");
+		pr_debug("entering DVD_LU_SEND_RPC_STATE\n");
 		setup_report_key(&cgc, 0, 8);
 		memset(&rpc_state, 0, sizeof(rpc_state_t));
 		cgc.buffer = (char *) &rpc_state;
@@ -1765,7 +1730,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 
 	/* Set region settings */
 	case DVD_HOST_SEND_RPC_STATE:
-		cd_dbg(CD_DVD, "entering DVD_HOST_SEND_RPC_STATE\n");
+		pr_debug("entering DVD_HOST_SEND_RPC_STATE\n");
 		setup_send_key(&cgc, 0, 6);
 		buf[1] = 6;
 		buf[4] = ai->hrpcs.pdrc;
@@ -1775,7 +1740,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		break;
 
 	default:
-		cd_dbg(CD_WARNING, "Invalid DVD key ioctl (%d)\n", ai->type);
+		pr_debug("Invalid DVD key ioctl (%d)\n", ai->type);
 		return -ENOTTY;
 	}
 
@@ -1907,7 +1872,7 @@ static int dvd_read_bca(struct cdrom_device_info *cdi, dvd_struct *s,
 
 	s->bca.len = buf[0] << 8 | buf[1];
 	if (s->bca.len < 12 || s->bca.len > 188) {
-		cd_dbg(CD_WARNING, "Received invalid BCA length (%d)\n",
+		pr_debug("Received invalid BCA length (%d)\n",
 		       s->bca.len);
 		ret = -EIO;
 		goto out;
@@ -1944,12 +1909,12 @@ static int dvd_read_manufact(struct cdrom_device_info *cdi, dvd_struct *s,
 
 	s->manufact.len = buf[0] << 8 | buf[1];
 	if (s->manufact.len < 0) {
-		cd_dbg(CD_WARNING, "Received invalid manufacture info length (%d)\n",
+		pr_debug("Received invalid manufacture info length (%d)\n",
 		       s->manufact.len);
 		ret = -EIO;
 	} else {
 		if (s->manufact.len > 2048) {
-			cd_dbg(CD_WARNING, "Received invalid manufacture info length (%d): truncating to 2048\n",
+			pr_debug("Received invalid manufacture info length (%d): truncating to 2048\n",
 			       s->manufact.len);
 			s->manufact.len = 2048;
 		}
@@ -1981,7 +1946,7 @@ static int dvd_read_struct(struct cdrom_device_info *cdi, dvd_struct *s,
 		return dvd_read_manufact(cdi, s, cgc);
 		
 	default:
-		cd_dbg(CD_WARNING, ": Invalid DVD structure read requested (%d)\n",
+		pr_debug(": Invalid DVD structure read requested (%d)\n",
 		       s->type);
 		return -EINVAL;
 	}
@@ -2292,7 +2257,7 @@ static int cdrom_ioctl_multisession(struct cdrom_device_info *cdi,
 	u8 requested_format;
 	int ret;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROMMULTISESSION\n");
+	pr_debug("entering CDROMMULTISESSION\n");
 
 	if (!(cdi->ops->capability & CDC_MULTI_SESSION))
 		return -ENOSYS;
@@ -2314,13 +2279,13 @@ static int cdrom_ioctl_multisession(struct cdrom_device_info *cdi,
 	if (copy_to_user(argp, &ms_info, sizeof(ms_info)))
 		return -EFAULT;
 
-	cd_dbg(CD_DO_IOCTL, "CDROMMULTISESSION successful\n");
+	pr_debug("CDROMMULTISESSION successful\n");
 	return 0;
 }
 
 static int cdrom_ioctl_eject(struct cdrom_device_info *cdi)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROMEJECT\n");
+	pr_debug("entering CDROMEJECT\n");
 
 	if (!CDROM_CAN(CDC_OPEN_TRAY))
 		return -ENOSYS;
@@ -2337,7 +2302,7 @@ static int cdrom_ioctl_eject(struct cdrom_device_info *cdi)
 
 static int cdrom_ioctl_closetray(struct cdrom_device_info *cdi)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROMCLOSETRAY\n");
+	pr_debug("entering CDROMCLOSETRAY\n");
 
 	if (!CDROM_CAN(CDC_CLOSE_TRAY))
 		return -ENOSYS;
@@ -2347,7 +2312,7 @@ static int cdrom_ioctl_closetray(struct cdrom_device_info *cdi)
 static int cdrom_ioctl_eject_sw(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROMEJECT_SW\n");
+	pr_debug("entering CDROMEJECT_SW\n");
 
 	if (!CDROM_CAN(CDC_OPEN_TRAY))
 		return -ENOSYS;
@@ -2366,7 +2331,7 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
 	struct cdrom_changer_info *info;
 	int ret;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_MEDIA_CHANGED\n");
+	pr_debug("entering CDROM_MEDIA_CHANGED\n");
 
 	if (!CDROM_CAN(CDC_MEDIA_CHANGED))
 		return -ENOSYS;
@@ -2392,7 +2357,7 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
 static int cdrom_ioctl_set_options(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_SET_OPTIONS\n");
+	pr_debug("entering CDROM_SET_OPTIONS\n");
 
 	/*
 	 * Options need to be in sync with capability.
@@ -2420,7 +2385,7 @@ static int cdrom_ioctl_set_options(struct cdrom_device_info *cdi,
 static int cdrom_ioctl_clear_options(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_CLEAR_OPTIONS\n");
+	pr_debug("entering CDROM_CLEAR_OPTIONS\n");
 
 	cdi->options &= ~(int) arg;
 	return cdi->options;
@@ -2429,7 +2394,7 @@ static int cdrom_ioctl_clear_options(struct cdrom_device_info *cdi,
 static int cdrom_ioctl_select_speed(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_SELECT_SPEED\n");
+	pr_debug("entering CDROM_SELECT_SPEED\n");
 
 	if (!CDROM_CAN(CDC_SELECT_SPEED))
 		return -ENOSYS;
@@ -2439,7 +2404,7 @@ static int cdrom_ioctl_select_speed(struct cdrom_device_info *cdi,
 static int cdrom_ioctl_select_disc(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_SELECT_DISC\n");
+	pr_debug("entering CDROM_SELECT_DISC\n");
 
 	if (!CDROM_CAN(CDC_SELECT_DISC))
 		return -ENOSYS;
@@ -2457,14 +2422,14 @@ static int cdrom_ioctl_select_disc(struct cdrom_device_info *cdi,
 	if (cdi->ops->select_disc)
 		return cdi->ops->select_disc(cdi, arg);
 
-	cd_dbg(CD_CHANGER, "Using generic cdrom_select_disc()\n");
+	pr_debug("Using generic cdrom_select_disc()\n");
 	return cdrom_select_disc(cdi, arg);
 }
 
 static int cdrom_ioctl_reset(struct cdrom_device_info *cdi,
 		struct block_device *bdev)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_RESET\n");
+	pr_debug("entering CDROM_RESET\n");
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -2477,7 +2442,7 @@ static int cdrom_ioctl_reset(struct cdrom_device_info *cdi,
 static int cdrom_ioctl_lock_door(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
-	cd_dbg(CD_DO_IOCTL, "%socking door\n", arg ? "L" : "Unl");
+	pr_debug("%socking door\n", arg ? "L" : "Unl");
 
 	if (!CDROM_CAN(CDC_LOCK))
 		return -EDRIVE_CANT_DO_THIS;
@@ -2493,20 +2458,9 @@ static int cdrom_ioctl_lock_door(struct cdrom_device_info *cdi,
 	return cdi->ops->lock_door(cdi, arg);
 }
 
-static int cdrom_ioctl_debug(struct cdrom_device_info *cdi,
-		unsigned long arg)
-{
-	cd_dbg(CD_DO_IOCTL, "%sabling debug\n", arg ? "En" : "Dis");
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
-	debug = arg ? 1 : 0;
-	return debug;
-}
-
 static int cdrom_ioctl_get_capability(struct cdrom_device_info *cdi)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_GET_CAPABILITY\n");
+	pr_debug("entering CDROM_GET_CAPABILITY\n");
 	return (cdi->ops->capability & ~cdi->mask);
 }
 
@@ -2522,7 +2476,7 @@ static int cdrom_ioctl_get_mcn(struct cdrom_device_info *cdi,
 	struct cdrom_mcn mcn;
 	int ret;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_GET_MCN\n");
+	pr_debug("entering CDROM_GET_MCN\n");
 
 	if (!(cdi->ops->capability & CDC_MCN))
 		return -ENOSYS;
@@ -2532,14 +2486,14 @@ static int cdrom_ioctl_get_mcn(struct cdrom_device_info *cdi,
 
 	if (copy_to_user(argp, &mcn, sizeof(mcn)))
 		return -EFAULT;
-	cd_dbg(CD_DO_IOCTL, "CDROM_GET_MCN successful\n");
+	pr_debug("CDROM_GET_MCN successful\n");
 	return 0;
 }
 
 static int cdrom_ioctl_drive_status(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_DRIVE_STATUS\n");
+	pr_debug("entering CDROM_DRIVE_STATUS\n");
 
 	if (!(cdi->ops->capability & CDC_DRIVE_STATUS))
 		return -ENOSYS;
@@ -2572,7 +2526,7 @@ static int cdrom_ioctl_disc_status(struct cdrom_device_info *cdi)
 {
 	tracktype tracks;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_DISC_STATUS\n");
+	pr_debug("entering CDROM_DISC_STATUS\n");
 
 	cdrom_count_tracks(cdi, &tracks);
 	if (tracks.error)
@@ -2594,13 +2548,13 @@ static int cdrom_ioctl_disc_status(struct cdrom_device_info *cdi)
 		return CDS_DATA_1;
 	/* Policy mode off */
 
-	cd_dbg(CD_WARNING, "This disc doesn't have any tracks I recognize!\n");
+	pr_debug("This disc doesn't have any tracks I recognize!\n");
 	return CDS_NO_INFO;
 }
 
 static int cdrom_ioctl_changer_nslots(struct cdrom_device_info *cdi)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_CHANGER_NSLOTS\n");
+	pr_debug("entering CDROM_CHANGER_NSLOTS\n");
 	return cdi->capacity;
 }
 
@@ -2611,7 +2565,7 @@ static int cdrom_ioctl_get_subchnl(struct cdrom_device_info *cdi,
 	u8 requested, back;
 	int ret;
 
-	/* cd_dbg(CD_DO_IOCTL,"entering CDROMSUBCHNL\n");*/
+	/* pr_debug("entering CDROMSUBCHNL\n");*/
 
 	if (copy_from_user(&q, argp, sizeof(q)))
 		return -EFAULT;
@@ -2631,7 +2585,7 @@ static int cdrom_ioctl_get_subchnl(struct cdrom_device_info *cdi,
 
 	if (copy_to_user(argp, &q, sizeof(q)))
 		return -EFAULT;
-	/* cd_dbg(CD_DO_IOCTL, "CDROMSUBCHNL successful\n"); */
+	/* pr_debug("CDROMSUBCHNL successful\n"); */
 	return 0;
 }
 
@@ -2641,7 +2595,7 @@ static int cdrom_ioctl_read_tochdr(struct cdrom_device_info *cdi,
 	struct cdrom_tochdr header;
 	int ret;
 
-	/* cd_dbg(CD_DO_IOCTL, "entering CDROMREADTOCHDR\n"); */
+	/* pr_debug("entering CDROMREADTOCHDR\n"); */
 
 	if (copy_from_user(&header, argp, sizeof(header)))
 		return -EFAULT;
@@ -2652,7 +2606,7 @@ static int cdrom_ioctl_read_tochdr(struct cdrom_device_info *cdi,
 
 	if (copy_to_user(argp, &header, sizeof(header)))
 		return -EFAULT;
-	/* cd_dbg(CD_DO_IOCTL, "CDROMREADTOCHDR successful\n"); */
+	/* pr_debug("CDROMREADTOCHDR successful\n"); */
 	return 0;
 }
 
@@ -2663,7 +2617,7 @@ static int cdrom_ioctl_read_tocentry(struct cdrom_device_info *cdi,
 	u8 requested_format;
 	int ret;
 
-	/* cd_dbg(CD_DO_IOCTL, "entering CDROMREADTOCENTRY\n"); */
+	/* pr_debug("entering CDROMREADTOCENTRY\n"); */
 
 	if (copy_from_user(&entry, argp, sizeof(entry)))
 		return -EFAULT;
@@ -2680,7 +2634,7 @@ static int cdrom_ioctl_read_tocentry(struct cdrom_device_info *cdi,
 
 	if (copy_to_user(argp, &entry, sizeof(entry)))
 		return -EFAULT;
-	/* cd_dbg(CD_DO_IOCTL, "CDROMREADTOCENTRY successful\n"); */
+	/* pr_debug("CDROMREADTOCENTRY successful\n"); */
 	return 0;
 }
 
@@ -2689,7 +2643,7 @@ static int cdrom_ioctl_play_msf(struct cdrom_device_info *cdi,
 {
 	struct cdrom_msf msf;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROMPLAYMSF\n");
+	pr_debug("entering CDROMPLAYMSF\n");
 
 	if (!CDROM_CAN(CDC_PLAY_AUDIO))
 		return -ENOSYS;
@@ -2704,7 +2658,7 @@ static int cdrom_ioctl_play_trkind(struct cdrom_device_info *cdi,
 	struct cdrom_ti ti;
 	int ret;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROMPLAYTRKIND\n");
+	pr_debug("entering CDROMPLAYTRKIND\n");
 
 	if (!CDROM_CAN(CDC_PLAY_AUDIO))
 		return -ENOSYS;
@@ -2721,7 +2675,7 @@ static int cdrom_ioctl_volctrl(struct cdrom_device_info *cdi,
 {
 	struct cdrom_volctrl volume;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROMVOLCTRL\n");
+	pr_debug("entering CDROMVOLCTRL\n");
 
 	if (!CDROM_CAN(CDC_PLAY_AUDIO))
 		return -ENOSYS;
@@ -2736,7 +2690,7 @@ static int cdrom_ioctl_volread(struct cdrom_device_info *cdi,
 	struct cdrom_volctrl volume;
 	int ret;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROMVOLREAD\n");
+	pr_debug("entering CDROMVOLREAD\n");
 
 	if (!CDROM_CAN(CDC_PLAY_AUDIO))
 		return -ENOSYS;
@@ -2755,7 +2709,7 @@ static int cdrom_ioctl_audioctl(struct cdrom_device_info *cdi,
 {
 	int ret;
 
-	cd_dbg(CD_DO_IOCTL, "doing audio ioctl (start/stop/pause/resume)\n");
+	pr_debug("doing audio ioctl (start/stop/pause/resume)\n");
 
 	if (!CDROM_CAN(CDC_PLAY_AUDIO))
 		return -ENOSYS;
@@ -3048,7 +3002,7 @@ static noinline int mmc_ioctl_cdrom_subchannel(struct cdrom_device_info *cdi,
 	sanitize_format(&q.cdsc_reladdr, &q.cdsc_format, requested);
 	if (copy_to_user((struct cdrom_subchnl __user *)arg, &q, sizeof(q)))
 		return -EFAULT;
-	/* cd_dbg(CD_DO_IOCTL, "CDROMSUBCHNL successful\n"); */
+	/* pr_debug("CDROMSUBCHNL successful\n"); */
 	return 0;
 }
 
@@ -3058,7 +3012,7 @@ static noinline int mmc_ioctl_cdrom_play_msf(struct cdrom_device_info *cdi,
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	struct cdrom_msf msf;
-	cd_dbg(CD_DO_IOCTL, "entering CDROMPLAYMSF\n");
+	pr_debug("entering CDROMPLAYMSF\n");
 	if (copy_from_user(&msf, (struct cdrom_msf __user *)arg, sizeof(msf)))
 		return -EFAULT;
 	cgc->cmd[0] = GPCMD_PLAY_AUDIO_MSF;
@@ -3078,7 +3032,7 @@ static noinline int mmc_ioctl_cdrom_play_blk(struct cdrom_device_info *cdi,
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	struct cdrom_blk blk;
-	cd_dbg(CD_DO_IOCTL, "entering CDROMPLAYBLK\n");
+	pr_debug("entering CDROMPLAYBLK\n");
 	if (copy_from_user(&blk, (struct cdrom_blk __user *)arg, sizeof(blk)))
 		return -EFAULT;
 	cgc->cmd[0] = GPCMD_PLAY_AUDIO_10;
@@ -3103,7 +3057,7 @@ static noinline int mmc_ioctl_cdrom_volume(struct cdrom_device_info *cdi,
 	unsigned short offset;
 	int ret;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROMVOLUME\n");
+	pr_debug("entering CDROMVOLUME\n");
 
 	if (copy_from_user(&volctrl, (struct cdrom_volctrl __user *)arg,
 			   sizeof(volctrl)))
@@ -3172,7 +3126,7 @@ static noinline int mmc_ioctl_cdrom_start_stop(struct cdrom_device_info *cdi,
 					       int cmd)
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
-	cd_dbg(CD_DO_IOCTL, "entering CDROMSTART/CDROMSTOP\n");
+	pr_debug("entering CDROMSTART/CDROMSTOP\n");
 	cgc->cmd[0] = GPCMD_START_STOP_UNIT;
 	cgc->cmd[1] = 1;
 	cgc->cmd[4] = (cmd == CDROMSTART) ? 1 : 0;
@@ -3185,7 +3139,7 @@ static noinline int mmc_ioctl_cdrom_pause_resume(struct cdrom_device_info *cdi,
 						 int cmd)
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
-	cd_dbg(CD_DO_IOCTL, "entering CDROMPAUSE/CDROMRESUME\n");
+	pr_debug("entering CDROMPAUSE/CDROMRESUME\n");
 	cgc->cmd[0] = GPCMD_PAUSE_RESUME;
 	cgc->cmd[8] = (cmd == CDROMRESUME) ? 1 : 0;
 	cgc->data_direction = CGC_DATA_NONE;
@@ -3207,7 +3161,7 @@ static noinline int mmc_ioctl_dvd_read_struct(struct cdrom_device_info *cdi,
 	if (IS_ERR(s))
 		return PTR_ERR(s);
 
-	cd_dbg(CD_DO_IOCTL, "entering DVD_READ_STRUCT\n");
+	pr_debug("entering DVD_READ_STRUCT\n");
 
 	ret = dvd_read_struct(cdi, s, cgc);
 	if (ret)
@@ -3227,7 +3181,7 @@ static noinline int mmc_ioctl_dvd_auth(struct cdrom_device_info *cdi,
 	dvd_authinfo ai;
 	if (!CDROM_CAN(CDC_DVD))
 		return -ENOSYS;
-	cd_dbg(CD_DO_IOCTL, "entering DVD_AUTH\n");
+	pr_debug("entering DVD_AUTH\n");
 	if (copy_from_user(&ai, (dvd_authinfo __user *)arg, sizeof(ai)))
 		return -EFAULT;
 	ret = dvd_do_auth(cdi, &ai);
@@ -3243,7 +3197,7 @@ static noinline int mmc_ioctl_cdrom_next_writable(struct cdrom_device_info *cdi,
 {
 	int ret;
 	long next = 0;
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_NEXT_WRITABLE\n");
+	pr_debug("entering CDROM_NEXT_WRITABLE\n");
 	ret = cdrom_get_next_writable(cdi, &next);
 	if (ret)
 		return ret;
@@ -3257,7 +3211,7 @@ static noinline int mmc_ioctl_cdrom_last_written(struct cdrom_device_info *cdi,
 {
 	int ret;
 	long last = 0;
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_LAST_WRITTEN\n");
+	pr_debug("entering CDROM_LAST_WRITTEN\n");
 	ret = cdrom_get_last_written(cdi, &last);
 	if (ret)
 		return ret;
@@ -3352,8 +3306,6 @@ int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
 		return cdrom_ioctl_reset(cdi, bdev);
 	case CDROM_LOCKDOOR:
 		return cdrom_ioctl_lock_door(cdi, arg);
-	case CDROM_DEBUG:
-		return cdrom_ioctl_debug(cdi, arg);
 	case CDROM_GET_CAPABILITY:
 		return cdrom_ioctl_get_capability(cdi);
 	case CDROM_GET_MCN:
@@ -3379,7 +3331,7 @@ int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
 	}
 
 	/*
-	 * Note: most of the cd_dbg() calls are commented out here,
+	 * Note: most of the pr_debug() calls are commented out here,
 	 * because they fill up the sys log when CD players poll
 	 * the drive.
 	 */
@@ -3429,7 +3381,6 @@ static struct cdrom_sysctl_settings {
 	char	info[CDROM_STR_SIZE];	/* general info */
 	int	autoclose;		/* close tray upon mount, etc */
 	int	autoeject;		/* eject on umount */
-	int	debug;			/* turn on debugging messages */
 	int	lock;			/* lock the door on device open */
 	int	check;			/* check media type */
 } cdrom_sysctl_settings;
@@ -3609,7 +3560,6 @@ static int cdrom_sysctl_handler(struct ctl_table *ctl, int write,
 		/* we only care for 1 or 0. */
 		autoclose        = !!cdrom_sysctl_settings.autoclose;
 		autoeject        = !!cdrom_sysctl_settings.autoeject;
-		debug	         = !!cdrom_sysctl_settings.debug;
 		lockdoor         = !!cdrom_sysctl_settings.lock;
 		check_media_type = !!cdrom_sysctl_settings.check;
 
@@ -3645,13 +3595,6 @@ static struct ctl_table cdrom_table[] = {
 		.mode		= 0644,
 		.proc_handler	= cdrom_sysctl_handler,
 	},
-	{
-		.procname	= "debug",
-		.data		= &cdrom_sysctl_settings.debug,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= cdrom_sysctl_handler,
-	},
 	{
 		.procname	= "lock",
 		.data		= &cdrom_sysctl_settings.lock,
@@ -3703,7 +3646,6 @@ static void cdrom_sysctl_register(void)
 	/* set the defaults */
 	cdrom_sysctl_settings.autoclose = autoclose;
 	cdrom_sysctl_settings.autoeject = autoeject;
-	cdrom_sysctl_settings.debug = debug;
 	cdrom_sysctl_settings.lock = lockdoor;
 	cdrom_sysctl_settings.check = check_media_type;
 }
-- 
2.22.0

