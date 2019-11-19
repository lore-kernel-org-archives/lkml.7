Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0F9C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A4222317
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flameeyes-com.20150623.gappssmtp.com header.i=@flameeyes-com.20150623.gappssmtp.com header.b="hZSoa+i7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfKSVhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 16:37:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46278 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfKSVhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 16:37:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id b3so25688004wrs.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 13:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flameeyes-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R1v6jei2+smOpO/lPVxq55FmAnu1W+lEkKGBufTcw6E=;
        b=hZSoa+i7vo9hvX2AHPQ4+JbrH7osRbDC0Ak7JW2iiBBAzQvmbNXrcU/SYG3HfVbcgu
         1ukf5ZaR1jtgJU0+QBEMB18YcSXeTM146r42Q2f3e4mUWFd8KjYYvetUEmB+6ZQd52nc
         rOEs1SJKibHi21rUYZp1gZBtdJECFf3M7tjVKbyHdGQcoeK04cCSL8BdfNquuxSbIGns
         Ak8Fc6EOO/K7gsy0w9YQwyGedQa7jm22s25o+6JGDt+R747OW3+/MSWsxJCb9eMNRhST
         69j1BeESEIqAieiQBuLvY+EIGqgAIMTv+MaDy2N8Ls59j5Haq2HGvHkATH6lpvPBHOAm
         agqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R1v6jei2+smOpO/lPVxq55FmAnu1W+lEkKGBufTcw6E=;
        b=WV7pIa3FNWdX10tUI2+CLr2XLctGfpGiugulTsOmacy86DmWBhXKK/OGbSrBQkXcJZ
         gXrCu90bIXsHKKWGXuYnDFRdQkqPVKBGEUC/axV0M5xjlQSk0S2LlpFUzixQaGHgNkCw
         SHZ8vkWpscERv6amU2zGd7NoKEvl4X68xM/KI1IXI/6u8kgOtU0BxSYnXlEo7GlH8MIv
         Yv0GOGy/XL5gJFK2zvg1p7IzDue56LhDKcVXIcTWjpLE9kvHGlBONWKAzzgOo1Vgv6Yn
         /nSxY1LkAUUM0L/PTtNVNLwpBbcdXyQtSz0oSmJnK48MI55SlW6GYNa3mMidPepRLkhO
         p2/Q==
X-Gm-Message-State: APjAAAWHo1LXrKrDK8Euu+43qjzXqsF8s+xJZ54sfxMjkKIVxtu22EpF
        vps/LEcbZ8qy3frCuxue658okg==
X-Google-Smtp-Source: APXvYqxsYfsmW5gQiC6VpYKyR++2rIKlDLXMDCRFGY4HA1WqGtvm5N9Zbi7MTOKijIKh++cCkP6HpA==
X-Received: by 2002:adf:c00a:: with SMTP id z10mr39513868wre.81.1574199452788;
        Tue, 19 Nov 2019 13:37:32 -0800 (PST)
Received: from localhost ([2a01:4b00:80c6:1000:283d:d5ff:fee6:36c5])
        by smtp.gmail.com with ESMTPSA id w11sm32617693wra.83.2019.11.19.13.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 13:37:31 -0800 (PST)
From:   =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 1/2] cdrom: respect device capabilities during opening action
Date:   Tue, 19 Nov 2019 21:37:08 +0000
Message-Id: <20191119213709.10900-1-flameeyes@flameeyes.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading the TOC only works if the device can play audio, otherwise
these commands fail (and possibly bring the device to an unhealthy
state.)

Similarly, cdrom_mmc3_profile() should only be called if the device
supports generic packet commands.

To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Diego Elio Pettenò <flameeyes@flameeyes.com>
---
 drivers/cdrom/cdrom.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index ac42ae4651ce..eebdcbef0578 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -996,6 +996,12 @@ static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype *tracks)
 	tracks->xa = 0;
 	tracks->error = 0;
 	cd_dbg(CD_COUNT_TRACKS, "entering cdrom_count_tracks\n");
+
+	if (!CDROM_CAN(CDC_PLAY_AUDIO)) {
+		tracks->error = CDS_NO_INFO;
+		return;
+	}
+
 	/* Grab the TOC header so we can see how many tracks there are */
 	ret = cdi->ops->audio_ioctl(cdi, CDROMREADTOCHDR, &header);
 	if (ret) {
@@ -1162,7 +1168,8 @@ int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
 		ret = open_for_data(cdi);
 		if (ret)
 			goto err;
-		cdrom_mmc3_profile(cdi);
+		if (CDROM_CAN(CDC_GENERIC_PACKET))
+			cdrom_mmc3_profile(cdi);
 		if (mode & FMODE_WRITE) {
 			ret = -EROFS;
 			if (cdrom_open_write(cdi))
@@ -2882,6 +2889,9 @@ int cdrom_get_last_written(struct cdrom_device_info *cdi, long *last_written)
 	   it doesn't give enough information or fails. then we return
 	   the toc contents. */
 use_toc:
+	if (!CDROM_CAN(CDC_PLAY_AUDIO))
+		return -ENOSYS;
+
 	toc.cdte_format = CDROM_MSF;
 	toc.cdte_track = CDROM_LEADOUT;
 	if ((ret = cdi->ops->audio_ioctl(cdi, CDROMREADTOCENTRY, &toc)))
-- 
2.23.0

