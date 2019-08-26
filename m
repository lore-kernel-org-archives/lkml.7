Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F042C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DE620828
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flameeyes-com.20150623.gappssmtp.com header.i=@flameeyes-com.20150623.gappssmtp.com header.b="LjVq6Npx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733000AbfHZPRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:17:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53467 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfHZPQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:16:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id 10so15844175wmp.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 08:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flameeyes-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A14Wz7qnmKVWuxQXr+MT2jgUqmVKqAwpUXqMSVnb0iA=;
        b=LjVq6Npx/N2iNUTjciPMkWC0bj3aHoW4qqhMTuAff+bKZrM9aF5tZZGbo0I0YoJ4Lk
         4AizSkkQ1hRMfHKKV7+t+mR2BjP8vOAx3arhjRb9xDXY9YTapIYqrRFjc+tRSXAQXzJH
         wPUQO2vuGEzWK1QdJhWV08+hpc/3PghWaTdEO4rNfMdFangwbDwO3YOuV8r6MY6Xmna0
         IGUGStooVvq81puqE6Vqr/UWZfGyJv+Eb1+gOu7byPkggV+30ivCvwWbNmiPQDmv1Y/z
         +MOERKhC+Lx9kVjBTF8s5b2QT2VQeJ3YfnXJehisnBImq3rIpoyeoV2KjjxrmdHd4s04
         +InQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A14Wz7qnmKVWuxQXr+MT2jgUqmVKqAwpUXqMSVnb0iA=;
        b=B2hSD0u3kE1XHq+hyH0KJKhPwj/uT5tZX4yFh+76Rse1qHUloVbpGnYh+E5DPQyV29
         vMEYiFc9NB8+2b2dbUW9Y6ZtHst2aWOOuCMNTj2kR/FQ4+XN2ZqrM4252+gA3HoHgSRh
         1iX1/qbQsyEGSTHBMWnRO/2fYUMfRf72wHUAiJfm1Lg7Tm1L6tMz3fA8i7qjFq5fOgNR
         vQR/+5eKclkv94n8czTEH/jnek8LY0JTmH7eYh4hxDF9kKeMneA8m/zX5r/Pfqn2PlYw
         YnoZ+cX3U45J+jylACZjYMkoExTUId2Qa8FpyXEorTTVELZ9g3jD4MWDgM6cqa8RwID1
         pwOg==
X-Gm-Message-State: APjAAAXOvA7FA0CHeBjgaqldX3D5N+49G3N8Nuj1MPe/0RBohNuw7iZI
        i79s2EXMWpCFihVTu/Lw3vw6IQ==
X-Google-Smtp-Source: APXvYqzkkO+g0XpOEDfyc+K/r52rOSlaYYigpWrQOYd/XiREe891/sYIg/zP4KP7fIMR1FfFFAYj9Q==
X-Received: by 2002:a1c:9a4b:: with SMTP id c72mr22053056wme.102.1566832610419;
        Mon, 26 Aug 2019 08:16:50 -0700 (PDT)
Received: from localhost ([2a01:4b00:80c6:1000:5b16:35e9:1ce5:7fc9])
        by smtp.gmail.com with ESMTPSA id e14sm11493046wme.35.2019.08.26.08.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 08:16:49 -0700 (PDT)
From:   =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>
Subject: [PATCH 2/4] cdrom: make debug logging rely on pr_debug and debugfs only.
Date:   Mon, 26 Aug 2019 16:16:38 +0100
Message-Id: <20190826151640.5036-3-flameeyes@flameeyes.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190826151640.5036-1-flameeyes@flameeyes.com>
References: <20190826151640.5036-1-flameeyes@flameeyes.com>
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
 drivers/cdrom/cdrom.c | 174 ++++++++++++++----------------------------
 1 file changed, 57 insertions(+), 117 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index b9a43d0011ef..ec1267d0a5c0 100644
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
@@ -631,7 +596,7 @@ int register_cdrom(struct cdrom_device_info *cdi)
 
 	WARN_ON(!cdo->generic_packet);
 
-	cd_dbg(CD_REG_UNREG, "drive \"/dev/%s\" registered\n", cdi->name);
+	pr_debug("drive \"/dev/%s\" registered\n", cdi->name);
 	mutex_lock(&cdrom_mutex);
 	list_add(&cdi->list, &cdrom_list);
 	mutex_unlock(&cdrom_mutex);
@@ -648,7 +613,7 @@ void unregister_cdrom(struct cdrom_device_info *cdi)
 	if (cdi->exit)
 		cdi->exit(cdi);
 
-	cd_dbg(CD_REG_UNREG, "drive \"/dev/%s\" unregistered\n", cdi->name);
+	pr_debug("drive \"/dev/%s\" unregistered\n", cdi->name);
 }
 
 int cdrom_get_media_event(struct cdrom_device_info *cdi,
@@ -849,7 +814,7 @@ static int cdrom_ram_open_write(struct cdrom_device_info *cdi)
 	else if (CDF_RWRT == be16_to_cpu(rfd.feature_code))
 		ret = !rfd.curr;
 
-	cd_dbg(CD_OPEN, "can open for random write\n");
+	pr_debug("can open for random write\n");
 	return ret;
 }
 
@@ -939,12 +904,12 @@ static void cdrom_dvd_rw_close_write(struct cdrom_device_info *cdi)
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
 
@@ -1018,10 +983,10 @@ static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype *tracks)
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
@@ -1036,16 +1001,16 @@ int open_for_data(struct cdrom_device_info *cdi)
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
@@ -1055,19 +1020,19 @@ int open_for_data(struct cdrom_device_info *cdi)
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
@@ -1078,7 +1043,7 @@ int open_for_data(struct cdrom_device_info *cdi)
 	}
 	cdrom_count_tracks(cdi, &tracks);
 	if (tracks.error == CDS_NO_DISC) {
-		cd_dbg(CD_OPEN, "bummer. no disc.\n");
+		pr_debug("bummer. no disc.\n");
 		ret=-ENOMEDIUM;
 		goto clean_up_and_return;
 	}
@@ -1088,34 +1053,34 @@ int open_for_data(struct cdrom_device_info *cdi)
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
@@ -1124,10 +1089,10 @@ int open_for_data(struct cdrom_device_info *cdi)
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
@@ -1169,13 +1134,13 @@ int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
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
@@ -1195,16 +1160,16 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
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
@@ -1213,20 +1178,20 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
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
@@ -1248,12 +1213,12 @@ void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
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
@@ -1633,7 +1598,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 	switch (ai->type) {
 	/* LU data send */
 	case DVD_LU_SEND_AGID:
-		cd_dbg(CD_DVD, "entering DVD_LU_SEND_AGID\n");
+		pr_debug("entering DVD_LU_SEND_AGID\n");
 		cgc.quiet = 1;
 		setup_report_key(&cgc, ai->lsa.agid, 0);
 
@@ -1645,7 +1610,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		break;
 
 	case DVD_LU_SEND_KEY1:
-		cd_dbg(CD_DVD, "entering DVD_LU_SEND_KEY1\n");
+		pr_debug("entering DVD_LU_SEND_KEY1\n");
 		setup_report_key(&cgc, ai->lsk.agid, 2);
 
 		if ((ret = cdo->generic_packet(cdi, &cgc)))
@@ -1656,7 +1621,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		break;
 
 	case DVD_LU_SEND_CHALLENGE:
-		cd_dbg(CD_DVD, "entering DVD_LU_SEND_CHALLENGE\n");
+		pr_debug("entering DVD_LU_SEND_CHALLENGE\n");
 		setup_report_key(&cgc, ai->lsc.agid, 1);
 
 		if ((ret = cdo->generic_packet(cdi, &cgc)))
@@ -1668,7 +1633,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 
 	/* Post-auth key */
 	case DVD_LU_SEND_TITLE_KEY:
-		cd_dbg(CD_DVD, "entering DVD_LU_SEND_TITLE_KEY\n");
+		pr_debug("entering DVD_LU_SEND_TITLE_KEY\n");
 		cgc.quiet = 1;
 		setup_report_key(&cgc, ai->lstk.agid, 4);
 		cgc.cmd[5] = ai->lstk.lba;
@@ -1687,7 +1652,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		break;
 
 	case DVD_LU_SEND_ASF:
-		cd_dbg(CD_DVD, "entering DVD_LU_SEND_ASF\n");
+		pr_debug("entering DVD_LU_SEND_ASF\n");
 		setup_report_key(&cgc, ai->lsasf.agid, 5);
 		
 		if ((ret = cdo->generic_packet(cdi, &cgc)))
@@ -1698,7 +1663,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 
 	/* LU data receive (LU changes state) */
 	case DVD_HOST_SEND_CHALLENGE:
-		cd_dbg(CD_DVD, "entering DVD_HOST_SEND_CHALLENGE\n");
+		pr_debug("entering DVD_HOST_SEND_CHALLENGE\n");
 		setup_send_key(&cgc, ai->hsc.agid, 1);
 		buf[1] = 0xe;
 		copy_chal(&buf[4], ai->hsc.chal);
@@ -1710,7 +1675,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		break;
 
 	case DVD_HOST_SEND_KEY2:
-		cd_dbg(CD_DVD, "entering DVD_HOST_SEND_KEY2\n");
+		pr_debug("entering DVD_HOST_SEND_KEY2\n");
 		setup_send_key(&cgc, ai->hsk.agid, 3);
 		buf[1] = 0xa;
 		copy_key(&buf[4], ai->hsk.key);
@@ -1725,7 +1690,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 	/* Misc */
 	case DVD_INVALIDATE_AGID:
 		cgc.quiet = 1;
-		cd_dbg(CD_DVD, "entering DVD_INVALIDATE_AGID\n");
+		pr_debug("entering DVD_INVALIDATE_AGID\n");
 		setup_report_key(&cgc, ai->lsa.agid, 0x3f);
 		if ((ret = cdo->generic_packet(cdi, &cgc)))
 			return ret;
@@ -1733,7 +1698,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 
 	/* Get region settings */
 	case DVD_LU_SEND_RPC_STATE:
-		cd_dbg(CD_DVD, "entering DVD_LU_SEND_RPC_STATE\n");
+		pr_debug("entering DVD_LU_SEND_RPC_STATE\n");
 		setup_report_key(&cgc, 0, 8);
 		memset(&rpc_state, 0, sizeof(rpc_state_t));
 		cgc.buffer = (char *) &rpc_state;
@@ -1750,7 +1715,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 
 	/* Set region settings */
 	case DVD_HOST_SEND_RPC_STATE:
-		cd_dbg(CD_DVD, "entering DVD_HOST_SEND_RPC_STATE\n");
+		pr_debug("entering DVD_HOST_SEND_RPC_STATE\n");
 		setup_send_key(&cgc, 0, 6);
 		buf[1] = 6;
 		buf[4] = ai->hrpcs.pdrc;
@@ -1760,7 +1725,7 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		break;
 
 	default:
-		cd_dbg(CD_WARNING, "Invalid DVD key ioctl (%d)\n", ai->type);
+		pr_debug("Invalid DVD key ioctl (%d)\n", ai->type);
 		return -ENOTTY;
 	}
 
@@ -1892,7 +1857,7 @@ static int dvd_read_bca(struct cdrom_device_info *cdi, dvd_struct *s,
 
 	s->bca.len = buf[0] << 8 | buf[1];
 	if (s->bca.len < 12 || s->bca.len > 188) {
-		cd_dbg(CD_WARNING, "Received invalid BCA length (%d)\n",
+		pr_debug("Received invalid BCA length (%d)\n",
 		       s->bca.len);
 		ret = -EIO;
 		goto out;
@@ -1929,12 +1894,12 @@ static int dvd_read_manufact(struct cdrom_device_info *cdi, dvd_struct *s,
 
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
@@ -1966,7 +1931,7 @@ static int dvd_read_struct(struct cdrom_device_info *cdi, dvd_struct *s,
 		return dvd_read_manufact(cdi, s, cgc);
 		
 	default:
-		cd_dbg(CD_WARNING, ": Invalid DVD structure read requested (%d)\n",
+		pr_debug(": Invalid DVD structure read requested (%d)\n",
 		       s->type);
 		return -EINVAL;
 	}
@@ -2423,7 +2388,7 @@ static int cdrom_ioctl_select_disc(struct cdrom_device_info *cdi,
 	if (cdi->ops->select_disc)
 		return cdi->ops->select_disc(cdi, arg);
 
-	cd_dbg(CD_CHANGER, "Using generic cdrom_select_disc()\n");
+	pr_debug("Using generic cdrom_select_disc()\n");
 	return cdrom_select_disc(cdi, arg);
 }
 
@@ -2441,7 +2406,7 @@ static int cdrom_ioctl_reset(struct cdrom_device_info *cdi,
 static int cdrom_ioctl_lock_door(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
-	cd_dbg(CD_DO_IOCTL, "%socking door\n", arg ? "L" : "Unl");
+	pr_debug("%socking door\n", arg ? "L" : "Unl");
 
 	if (!CDROM_CAN(CDC_LOCK))
 		return -EDRIVE_CANT_DO_THIS;
@@ -2457,17 +2422,6 @@ static int cdrom_ioctl_lock_door(struct cdrom_device_info *cdi,
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
 	return (cdi->ops->capability & ~cdi->mask);
@@ -2550,7 +2504,7 @@ static int cdrom_ioctl_disc_status(struct cdrom_device_info *cdi)
 		return CDS_DATA_1;
 	/* Policy mode off */
 
-	cd_dbg(CD_WARNING, "This disc doesn't have any tracks I recognize!\n");
+	pr_debug("This disc doesn't have any tracks I recognize!\n");
 	return CDS_NO_INFO;
 }
 
@@ -2584,7 +2538,6 @@ static int cdrom_ioctl_get_subchnl(struct cdrom_device_info *cdi,
 
 	if (copy_to_user(argp, &q, sizeof(q)))
 		return -EFAULT;
-
 	return 0;
 }
 
@@ -2629,7 +2582,6 @@ static int cdrom_ioctl_read_tocentry(struct cdrom_device_info *cdi,
 
 	if (copy_to_user(argp, &entry, sizeof(entry)))
 		return -EFAULT;
-
 	return 0;
 }
 
@@ -3279,8 +3231,6 @@ int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
 		return cdrom_ioctl_reset(cdi, bdev);
 	case CDROM_LOCKDOOR:
 		return cdrom_ioctl_lock_door(cdi, arg);
-	case CDROM_DEBUG:
-		return cdrom_ioctl_debug(cdi, arg);
 	case CDROM_GET_CAPABILITY:
 		return cdrom_ioctl_get_capability(cdi);
 	case CDROM_GET_MCN:
@@ -3306,7 +3256,7 @@ int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
 	}
 
 	/*
-	 * Note: most of the cd_dbg() calls are commented out here,
+	 * Note: most of the pr_debug() calls are commented out here,
 	 * because they fill up the sys log when CD players poll
 	 * the drive.
 	 */
@@ -3356,7 +3306,6 @@ static struct cdrom_sysctl_settings {
 	char	info[CDROM_STR_SIZE];	/* general info */
 	int	autoclose;		/* close tray upon mount, etc */
 	int	autoeject;		/* eject on umount */
-	int	debug;			/* turn on debugging messages */
 	int	lock;			/* lock the door on device open */
 	int	check;			/* check media type */
 } cdrom_sysctl_settings;
@@ -3536,7 +3485,6 @@ static int cdrom_sysctl_handler(struct ctl_table *ctl, int write,
 		/* we only care for 1 or 0. */
 		autoclose        = !!cdrom_sysctl_settings.autoclose;
 		autoeject        = !!cdrom_sysctl_settings.autoeject;
-		debug	         = !!cdrom_sysctl_settings.debug;
 		lockdoor         = !!cdrom_sysctl_settings.lock;
 		check_media_type = !!cdrom_sysctl_settings.check;
 
@@ -3572,13 +3520,6 @@ static struct ctl_table cdrom_table[] = {
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
@@ -3630,7 +3571,6 @@ static void cdrom_sysctl_register(void)
 	/* set the defaults */
 	cdrom_sysctl_settings.autoclose = autoclose;
 	cdrom_sysctl_settings.autoeject = autoeject;
-	cdrom_sysctl_settings.debug = debug;
 	cdrom_sysctl_settings.lock = lockdoor;
 	cdrom_sysctl_settings.check = check_media_type;
 }
-- 
2.22.0

