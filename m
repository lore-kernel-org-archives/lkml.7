Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E40C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43ADE2173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flameeyes-com.20150623.gappssmtp.com header.i=@flameeyes-com.20150623.gappssmtp.com header.b="tLl6pI0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732971AbfHZPQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:16:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35631 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbfHZPQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:16:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id k2so15722594wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 08:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flameeyes-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AKv02NC+t84N34g/dila6xYXjLRlMmfRjoWVkq8Jcrw=;
        b=tLl6pI0yeXll7rzUXfoVX0MJHjqIEQu4MRbuI88X8p+vstOkDLsYf6JGMZsriBc3fU
         coPrhgh+1fBw+LJR0hMuz9DOYOFWVsMLZXiZnMfOzjhDvtcywKIEp0BHUCJ/sYFM38E8
         +gSASRHC9MPTZ8/6RsQWqUWujRd90JjRUBhPsM9epKj2zvhHsMfOpn/ZSei2Z6Xtcssq
         hLQRc46mni54IyGO1eBUp3r9vfVzNfR/jULZnK3RIQk3NeOiSFymfwPn5L40cMcbhOs7
         uEd7biH4RNG7JQjMKz6q1Lp0+hgIeKx+fkzIkL+sWHWWvVAscvIP2WzZhuIK8GsZd4CM
         Lw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AKv02NC+t84N34g/dila6xYXjLRlMmfRjoWVkq8Jcrw=;
        b=swN72JJL22rGYk7zaOMRxpuqF9q7ZVOljuwxQRptbu7kW4J4xoZJ7P8Fv59ChGHkiB
         KdY1i5Jtmf+oIaN7tFwlN5K6U1Q4C5SDNfXhNmEsvKmvnm7IE/Q30C/ueMRPdhN2oHO5
         Rmn0hwZK2AzqDEGzOBcBtdsz9T6qMvfMzmxgen5ImiHf7Aq5Oi9LC73cuPgAN77kqZQb
         dIGUzY/+Tnw6R36laVf34L9wDsjdVN8LJf0W9FhzJDZq+knaKp3uGfGd82Wrrwy1yKdl
         anks7X/DxvsYpLpi6598KTosAT9ptsJQ+NOXtikX2nd48w8g7nvagemPA+h8WP3t5J9L
         Lrdw==
X-Gm-Message-State: APjAAAUEdzvd//sW4OLrJjnxk7n8uSIoO5FChWW3HsnavbJha/Ve3fRg
        BDQqhgOA94L7tKx2e2WCGJ/2/plZ3ssEEg==
X-Google-Smtp-Source: APXvYqzRDfmP6qOmgqKqSLmPtVF7HQyEuwhEPTByTwDh5tbAX1cw6PBhXANpBKAIG9pjp4P58Up9wQ==
X-Received: by 2002:a5d:5543:: with SMTP id g3mr23524924wrw.166.1566832608923;
        Mon, 26 Aug 2019 08:16:48 -0700 (PDT)
Received: from localhost ([2a01:4b00:80c6:1000:5b16:35e9:1ce5:7fc9])
        by smtp.gmail.com with ESMTPSA id o11sm9849772wrw.19.2019.08.26.08.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 08:16:48 -0700 (PDT)
From:   =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 1/4] cdrom: remove entering/exiting debug message logs.
Date:   Mon, 26 Aug 2019 16:16:37 +0100
Message-Id: <20190826151640.5036-2-flameeyes@flameeyes.com>
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

Nowadays, ftrace function and function_graph tracers provide the same level
of information, in a more standard and complete format.

Cc: Joe Perches <joe@perches.com>
Signed-off-by: Diego Elio Pettenò <flameeyes@flameeyes.com>
---
 drivers/cdrom/cdrom.c | 79 ++-----------------------------------------
 1 file changed, 3 insertions(+), 76 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index ac42ae4651ce..b9a43d0011ef 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -591,8 +591,6 @@ int register_cdrom(struct cdrom_device_info *cdi)
 	static char banner_printed;
 	const struct cdrom_device_ops *cdo = cdi->ops;
 
-	cd_dbg(CD_OPEN, "entering register_cdrom\n");
-
 	if (cdo->open == NULL || cdo->release == NULL)
 		return -EINVAL;
 	if (!banner_printed) {
@@ -643,8 +641,6 @@ int register_cdrom(struct cdrom_device_info *cdi)
 
 void unregister_cdrom(struct cdrom_device_info *cdi)
 {
-	cd_dbg(CD_OPEN, "entering unregister_cdrom\n");
-
 	mutex_lock(&cdrom_mutex);
 	list_del(&cdi->list);
 	mutex_unlock(&cdrom_mutex);
@@ -995,7 +991,6 @@ static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype *tracks)
 	tracks->cdi = 0;
 	tracks->xa = 0;
 	tracks->error = 0;
-	cd_dbg(CD_COUNT_TRACKS, "entering cdrom_count_tracks\n");
 	/* Grab the TOC header so we can see how many tracks there are */
 	ret = cdi->ops->audio_ioctl(cdi, CDROMREADTOCHDR, &header);
 	if (ret) {
@@ -1037,7 +1032,6 @@ int open_for_data(struct cdrom_device_info *cdi)
 	int ret;
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	tracktype tracks;
-	cd_dbg(CD_OPEN, "entering open_for_data\n");
 	/* Check if the driver can report drive status.  If it can, we
 	   can do clever things.  If it can't, well, we at least tried! */
 	if (cdo->drive_status != NULL) {
@@ -1151,8 +1145,6 @@ int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
 {
 	int ret;
 
-	cd_dbg(CD_OPEN, "entering cdrom_open\n");
-
 	/* if this was a O_NONBLOCK open and we should honor the flags,
 	 * do a quick open without drive/disc integrity checks. */
 	cdi->use_count++;
@@ -1199,7 +1191,6 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
 {
         int ret;
 	tracktype tracks;
-	cd_dbg(CD_OPEN, "entering check_for_audio_disc\n");
 	if (!(cdi->options & CDO_CHECK_TYPE))
 		return 0;
 	if (cdo->drive_status != NULL) {
@@ -1253,8 +1244,6 @@ void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	int opened_for_data;
 
-	cd_dbg(CD_CLOSE, "entering cdrom_release\n");
-
 	if (cdi->use_count > 0)
 		cdi->use_count--;
 
@@ -1323,7 +1312,6 @@ static int cdrom_slot_status(struct cdrom_device_info *cdi, int slot)
 	struct cdrom_changer_info *info;
 	int ret;
 
-	cd_dbg(CD_CHANGER, "entering cdrom_slot_status()\n");
 	if (cdi->sanyo_slot)
 		return CDS_NO_INFO;
 	
@@ -1353,7 +1341,6 @@ int cdrom_number_of_slots(struct cdrom_device_info *cdi)
 	int nslots = 1;
 	struct cdrom_changer_info *info;
 
-	cd_dbg(CD_CHANGER, "entering cdrom_number_of_slots()\n");
 	/* cdrom_read_mech_status requires a valid value for capacity: */
 	cdi->capacity = 0; 
 
@@ -1374,7 +1361,6 @@ static int cdrom_load_unload(struct cdrom_device_info *cdi, int slot)
 {
 	struct packet_command cgc;
 
-	cd_dbg(CD_CHANGER, "entering cdrom_load_unload()\n");
 	if (cdi->sanyo_slot && slot < 0)
 		return 0;
 
@@ -1403,7 +1389,6 @@ static int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
 	int curslot;
 	int ret;
 
-	cd_dbg(CD_CHANGER, "entering cdrom_select_disc()\n");
 	if (!CDROM_CAN(CDC_SELECT_DISC))
 		return -EDRIVE_CANT_DO_THIS;
 
@@ -2292,8 +2277,6 @@ static int cdrom_ioctl_multisession(struct cdrom_device_info *cdi,
 	u8 requested_format;
 	int ret;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROMMULTISESSION\n");
-
 	if (!(cdi->ops->capability & CDC_MULTI_SESSION))
 		return -ENOSYS;
 
@@ -2314,14 +2297,11 @@ static int cdrom_ioctl_multisession(struct cdrom_device_info *cdi,
 	if (copy_to_user(argp, &ms_info, sizeof(ms_info)))
 		return -EFAULT;
 
-	cd_dbg(CD_DO_IOCTL, "CDROMMULTISESSION successful\n");
 	return 0;
 }
 
 static int cdrom_ioctl_eject(struct cdrom_device_info *cdi)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROMEJECT\n");
-
 	if (!CDROM_CAN(CDC_OPEN_TRAY))
 		return -ENOSYS;
 	if (cdi->use_count != 1 || cdi->keeplocked)
@@ -2337,8 +2317,6 @@ static int cdrom_ioctl_eject(struct cdrom_device_info *cdi)
 
 static int cdrom_ioctl_closetray(struct cdrom_device_info *cdi)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROMCLOSETRAY\n");
-
 	if (!CDROM_CAN(CDC_CLOSE_TRAY))
 		return -ENOSYS;
 	return cdi->ops->tray_move(cdi, 0);
@@ -2347,8 +2325,6 @@ static int cdrom_ioctl_closetray(struct cdrom_device_info *cdi)
 static int cdrom_ioctl_eject_sw(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROMEJECT_SW\n");
-
 	if (!CDROM_CAN(CDC_OPEN_TRAY))
 		return -ENOSYS;
 	if (cdi->keeplocked)
@@ -2366,8 +2342,6 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
 	struct cdrom_changer_info *info;
 	int ret;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_MEDIA_CHANGED\n");
-
 	if (!CDROM_CAN(CDC_MEDIA_CHANGED))
 		return -ENOSYS;
 
@@ -2392,8 +2366,6 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
 static int cdrom_ioctl_set_options(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_SET_OPTIONS\n");
-
 	/*
 	 * Options need to be in sync with capability.
 	 * Too late for that, so we have to check each one separately.
@@ -2420,8 +2392,6 @@ static int cdrom_ioctl_set_options(struct cdrom_device_info *cdi,
 static int cdrom_ioctl_clear_options(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_CLEAR_OPTIONS\n");
-
 	cdi->options &= ~(int) arg;
 	return cdi->options;
 }
@@ -2429,8 +2399,6 @@ static int cdrom_ioctl_clear_options(struct cdrom_device_info *cdi,
 static int cdrom_ioctl_select_speed(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_SELECT_SPEED\n");
-
 	if (!CDROM_CAN(CDC_SELECT_SPEED))
 		return -ENOSYS;
 	return cdi->ops->select_speed(cdi, arg);
@@ -2439,8 +2407,6 @@ static int cdrom_ioctl_select_speed(struct cdrom_device_info *cdi,
 static int cdrom_ioctl_select_disc(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_SELECT_DISC\n");
-
 	if (!CDROM_CAN(CDC_SELECT_DISC))
 		return -ENOSYS;
 
@@ -2464,8 +2430,6 @@ static int cdrom_ioctl_select_disc(struct cdrom_device_info *cdi,
 static int cdrom_ioctl_reset(struct cdrom_device_info *cdi,
 		struct block_device *bdev)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_RESET\n");
-
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 	if (!CDROM_CAN(CDC_RESET))
@@ -2506,7 +2470,6 @@ static int cdrom_ioctl_debug(struct cdrom_device_info *cdi,
 
 static int cdrom_ioctl_get_capability(struct cdrom_device_info *cdi)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_GET_CAPABILITY\n");
 	return (cdi->ops->capability & ~cdi->mask);
 }
 
@@ -2522,8 +2485,6 @@ static int cdrom_ioctl_get_mcn(struct cdrom_device_info *cdi,
 	struct cdrom_mcn mcn;
 	int ret;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_GET_MCN\n");
-
 	if (!(cdi->ops->capability & CDC_MCN))
 		return -ENOSYS;
 	ret = cdi->ops->get_mcn(cdi, &mcn);
@@ -2532,15 +2493,12 @@ static int cdrom_ioctl_get_mcn(struct cdrom_device_info *cdi,
 
 	if (copy_to_user(argp, &mcn, sizeof(mcn)))
 		return -EFAULT;
-	cd_dbg(CD_DO_IOCTL, "CDROM_GET_MCN successful\n");
 	return 0;
 }
 
 static int cdrom_ioctl_drive_status(struct cdrom_device_info *cdi,
 		unsigned long arg)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_DRIVE_STATUS\n");
-
 	if (!(cdi->ops->capability & CDC_DRIVE_STATUS))
 		return -ENOSYS;
 	if (!CDROM_CAN(CDC_SELECT_DISC) ||
@@ -2572,8 +2530,6 @@ static int cdrom_ioctl_disc_status(struct cdrom_device_info *cdi)
 {
 	tracktype tracks;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_DISC_STATUS\n");
-
 	cdrom_count_tracks(cdi, &tracks);
 	if (tracks.error)
 		return tracks.error;
@@ -2600,7 +2556,6 @@ static int cdrom_ioctl_disc_status(struct cdrom_device_info *cdi)
 
 static int cdrom_ioctl_changer_nslots(struct cdrom_device_info *cdi)
 {
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_CHANGER_NSLOTS\n");
 	return cdi->capacity;
 }
 
@@ -2611,8 +2566,6 @@ static int cdrom_ioctl_get_subchnl(struct cdrom_device_info *cdi,
 	u8 requested, back;
 	int ret;
 
-	/* cd_dbg(CD_DO_IOCTL,"entering CDROMSUBCHNL\n");*/
-
 	if (copy_from_user(&q, argp, sizeof(q)))
 		return -EFAULT;
 
@@ -2631,7 +2584,7 @@ static int cdrom_ioctl_get_subchnl(struct cdrom_device_info *cdi,
 
 	if (copy_to_user(argp, &q, sizeof(q)))
 		return -EFAULT;
-	/* cd_dbg(CD_DO_IOCTL, "CDROMSUBCHNL successful\n"); */
+
 	return 0;
 }
 
@@ -2641,8 +2594,6 @@ static int cdrom_ioctl_read_tochdr(struct cdrom_device_info *cdi,
 	struct cdrom_tochdr header;
 	int ret;
 
-	/* cd_dbg(CD_DO_IOCTL, "entering CDROMREADTOCHDR\n"); */
-
 	if (copy_from_user(&header, argp, sizeof(header)))
 		return -EFAULT;
 
@@ -2652,7 +2603,7 @@ static int cdrom_ioctl_read_tochdr(struct cdrom_device_info *cdi,
 
 	if (copy_to_user(argp, &header, sizeof(header)))
 		return -EFAULT;
-	/* cd_dbg(CD_DO_IOCTL, "CDROMREADTOCHDR successful\n"); */
+
 	return 0;
 }
 
@@ -2663,8 +2614,6 @@ static int cdrom_ioctl_read_tocentry(struct cdrom_device_info *cdi,
 	u8 requested_format;
 	int ret;
 
-	/* cd_dbg(CD_DO_IOCTL, "entering CDROMREADTOCENTRY\n"); */
-
 	if (copy_from_user(&entry, argp, sizeof(entry)))
 		return -EFAULT;
 
@@ -2680,7 +2629,7 @@ static int cdrom_ioctl_read_tocentry(struct cdrom_device_info *cdi,
 
 	if (copy_to_user(argp, &entry, sizeof(entry)))
 		return -EFAULT;
-	/* cd_dbg(CD_DO_IOCTL, "CDROMREADTOCENTRY successful\n"); */
+
 	return 0;
 }
 
@@ -2689,8 +2638,6 @@ static int cdrom_ioctl_play_msf(struct cdrom_device_info *cdi,
 {
 	struct cdrom_msf msf;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROMPLAYMSF\n");
-
 	if (!CDROM_CAN(CDC_PLAY_AUDIO))
 		return -ENOSYS;
 	if (copy_from_user(&msf, argp, sizeof(msf)))
@@ -2704,8 +2651,6 @@ static int cdrom_ioctl_play_trkind(struct cdrom_device_info *cdi,
 	struct cdrom_ti ti;
 	int ret;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROMPLAYTRKIND\n");
-
 	if (!CDROM_CAN(CDC_PLAY_AUDIO))
 		return -ENOSYS;
 	if (copy_from_user(&ti, argp, sizeof(ti)))
@@ -2721,8 +2666,6 @@ static int cdrom_ioctl_volctrl(struct cdrom_device_info *cdi,
 {
 	struct cdrom_volctrl volume;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROMVOLCTRL\n");
-
 	if (!CDROM_CAN(CDC_PLAY_AUDIO))
 		return -ENOSYS;
 	if (copy_from_user(&volume, argp, sizeof(volume)))
@@ -2736,8 +2679,6 @@ static int cdrom_ioctl_volread(struct cdrom_device_info *cdi,
 	struct cdrom_volctrl volume;
 	int ret;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROMVOLREAD\n");
-
 	if (!CDROM_CAN(CDC_PLAY_AUDIO))
 		return -ENOSYS;
 
@@ -2755,8 +2696,6 @@ static int cdrom_ioctl_audioctl(struct cdrom_device_info *cdi,
 {
 	int ret;
 
-	cd_dbg(CD_DO_IOCTL, "doing audio ioctl (start/stop/pause/resume)\n");
-
 	if (!CDROM_CAN(CDC_PLAY_AUDIO))
 		return -ENOSYS;
 	ret = check_for_audio_disc(cdi, cdi->ops);
@@ -3048,7 +2987,6 @@ static noinline int mmc_ioctl_cdrom_subchannel(struct cdrom_device_info *cdi,
 	sanitize_format(&q.cdsc_reladdr, &q.cdsc_format, requested);
 	if (copy_to_user((struct cdrom_subchnl __user *)arg, &q, sizeof(q)))
 		return -EFAULT;
-	/* cd_dbg(CD_DO_IOCTL, "CDROMSUBCHNL successful\n"); */
 	return 0;
 }
 
@@ -3058,7 +2996,6 @@ static noinline int mmc_ioctl_cdrom_play_msf(struct cdrom_device_info *cdi,
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	struct cdrom_msf msf;
-	cd_dbg(CD_DO_IOCTL, "entering CDROMPLAYMSF\n");
 	if (copy_from_user(&msf, (struct cdrom_msf __user *)arg, sizeof(msf)))
 		return -EFAULT;
 	cgc->cmd[0] = GPCMD_PLAY_AUDIO_MSF;
@@ -3078,7 +3015,6 @@ static noinline int mmc_ioctl_cdrom_play_blk(struct cdrom_device_info *cdi,
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
 	struct cdrom_blk blk;
-	cd_dbg(CD_DO_IOCTL, "entering CDROMPLAYBLK\n");
 	if (copy_from_user(&blk, (struct cdrom_blk __user *)arg, sizeof(blk)))
 		return -EFAULT;
 	cgc->cmd[0] = GPCMD_PLAY_AUDIO_10;
@@ -3103,8 +3039,6 @@ static noinline int mmc_ioctl_cdrom_volume(struct cdrom_device_info *cdi,
 	unsigned short offset;
 	int ret;
 
-	cd_dbg(CD_DO_IOCTL, "entering CDROMVOLUME\n");
-
 	if (copy_from_user(&volctrl, (struct cdrom_volctrl __user *)arg,
 			   sizeof(volctrl)))
 		return -EFAULT;
@@ -3172,7 +3106,6 @@ static noinline int mmc_ioctl_cdrom_start_stop(struct cdrom_device_info *cdi,
 					       int cmd)
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
-	cd_dbg(CD_DO_IOCTL, "entering CDROMSTART/CDROMSTOP\n");
 	cgc->cmd[0] = GPCMD_START_STOP_UNIT;
 	cgc->cmd[1] = 1;
 	cgc->cmd[4] = (cmd == CDROMSTART) ? 1 : 0;
@@ -3185,7 +3118,6 @@ static noinline int mmc_ioctl_cdrom_pause_resume(struct cdrom_device_info *cdi,
 						 int cmd)
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
-	cd_dbg(CD_DO_IOCTL, "entering CDROMPAUSE/CDROMRESUME\n");
 	cgc->cmd[0] = GPCMD_PAUSE_RESUME;
 	cgc->cmd[8] = (cmd == CDROMRESUME) ? 1 : 0;
 	cgc->data_direction = CGC_DATA_NONE;
@@ -3207,8 +3139,6 @@ static noinline int mmc_ioctl_dvd_read_struct(struct cdrom_device_info *cdi,
 	if (IS_ERR(s))
 		return PTR_ERR(s);
 
-	cd_dbg(CD_DO_IOCTL, "entering DVD_READ_STRUCT\n");
-
 	ret = dvd_read_struct(cdi, s, cgc);
 	if (ret)
 		goto out;
@@ -3227,7 +3157,6 @@ static noinline int mmc_ioctl_dvd_auth(struct cdrom_device_info *cdi,
 	dvd_authinfo ai;
 	if (!CDROM_CAN(CDC_DVD))
 		return -ENOSYS;
-	cd_dbg(CD_DO_IOCTL, "entering DVD_AUTH\n");
 	if (copy_from_user(&ai, (dvd_authinfo __user *)arg, sizeof(ai)))
 		return -EFAULT;
 	ret = dvd_do_auth(cdi, &ai);
@@ -3243,7 +3172,6 @@ static noinline int mmc_ioctl_cdrom_next_writable(struct cdrom_device_info *cdi,
 {
 	int ret;
 	long next = 0;
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_NEXT_WRITABLE\n");
 	ret = cdrom_get_next_writable(cdi, &next);
 	if (ret)
 		return ret;
@@ -3257,7 +3185,6 @@ static noinline int mmc_ioctl_cdrom_last_written(struct cdrom_device_info *cdi,
 {
 	int ret;
 	long last = 0;
-	cd_dbg(CD_DO_IOCTL, "entering CDROM_LAST_WRITTEN\n");
 	ret = cdrom_get_last_written(cdi, &last);
 	if (ret)
 		return ret;
-- 
2.22.0

