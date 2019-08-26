Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FF7C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A4E20828
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flameeyes-com.20150623.gappssmtp.com header.i=@flameeyes-com.20150623.gappssmtp.com header.b="svnyPSAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732982AbfHZPQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:16:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40749 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732960AbfHZPQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:16:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id c3so15697988wrd.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 08:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flameeyes-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PRsLeO8FIWrB//Ma4pse3QtgP26sqDLp0rUz7nxZoZw=;
        b=svnyPSAztO+ZjudSEZff4HhDC9tEkDEKHZnUkNq8nghgJA0dOuKYz6mQCSznH4eeTU
         JduwkxCp/t8I3o0RJjVrXQiGDhxVjT30/XtKTZFI0lrPzadTMrJNErrYfoK+Y/oYamXm
         qmLIhYYEs/DLDTjQ4mfLIM5APKDyjhZr7ykNhL6CThv4IqeHY0hEruuYHVJfCzsNS+j3
         49iXN4Klcorf4aGVS5G44L/XFecpjmKeCq9H6Vx6iH1C1/rUmA4oUUQRdjFbiIom57Tj
         gKYB3L6sNwsxK1SKUyfL0FBXElZTm58R4MO7l6ATvlp7/v/RrkXYHEULnOtfwAGt6v4A
         QVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PRsLeO8FIWrB//Ma4pse3QtgP26sqDLp0rUz7nxZoZw=;
        b=Z5tL2qxFg6WrpEh9nRmGugPMXRf9k4UleHLy1oYCdR5SSE+ZWee0zyvHWd2puYqkBy
         9Gaq9o8+/rO/vVXqE9iFkDxNRhNTKYOzhRD2oo9cB86NHbUnAD+t5ySajCfahqrG/ooA
         wt1A+Ls7Onet4n62IaKTasufyO8arK8I5fDx4kjtHp5tu5Ze9xpOCJKY8+cq/auxcA/G
         8rh1IVGpvn9gf07wQupUhg71t+AD+FCxR3Kk8lUW63zLR80CCl6pbZQ+96kANRn5hjHf
         WSnOF18pFyShouqvEQutrdlfL3nL3SjOZVnBfFEskg/pMSCy3/i11T5F9yGZs9H4bmK/
         OBDQ==
X-Gm-Message-State: APjAAAXhV3MQNFLjmRUKhNQbD429BXmYkT9aEasS6mIixBG+fVsKUTqy
        mg+cDQS/mgD1/P9Gh7keWy5ne/s++YklVg==
X-Google-Smtp-Source: APXvYqy416abKbA1Nwhj7IkM221BeCCWPRm32LLGbTetGKA9jXpwbXsJVrrOvIn/+pDdx9640Q7PHg==
X-Received: by 2002:adf:ea01:: with SMTP id q1mr23829903wrm.271.1566832612773;
        Mon, 26 Aug 2019 08:16:52 -0700 (PDT)
Received: from localhost ([2a01:4b00:80c6:1000:5b16:35e9:1ce5:7fc9])
        by smtp.gmail.com with ESMTPSA id o14sm21389135wrg.64.2019.08.26.08.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 08:16:52 -0700 (PDT)
From:   =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>
Subject: [PATCH 4/4] cdrom: support Beurer GL50 evo CD-on-a-chip devices.
Date:   Mon, 26 Aug 2019 16:16:40 +0100
Message-Id: <20190826151640.5036-5-flameeyes@flameeyes.com>
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

The Beurer GL50 evo uses a Cygnal/Cypress-manufactured CD-on-a-chip that
only accepts a subset of SCSI commands.

Most of the not-implemented commands are fine to fail, but a few,
particularly around the MMC or Audio commands, will put the device into an
unrecoverable state, so they need to be avoided at all costs.

In addition to adding a new vendor entry to sr_vendor, this required gating
a few functions in the cdrom driver to not even try sending the command
when the capability is not present.

Signed-off-by: Diego Elio Pettenò <flameeyes@flameeyes.com>
---
 drivers/cdrom/cdrom.c    | 13 ++++++++++++-
 drivers/scsi/sr_vendor.c | 18 ++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 732aa7115ebd..97542587b720 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -953,6 +953,12 @@ static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype *tracks)
 	tracks->cdi = 0;
 	tracks->xa = 0;
 	tracks->error = 0;
+
+	if (!CDROM_CAN(CDC_PLAY_AUDIO)) {
+		tracks->error = CDS_NO_INFO;
+		return;
+	}
+
 	/* Grab the TOC header so we can see how many tracks there are */
 	ret = cdi->ops->audio_ioctl(cdi, CDROMREADTOCHDR, &header);
 	if (ret) {
@@ -1116,7 +1122,9 @@ int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
 		ret = open_for_data(cdi);
 		if (ret)
 			goto err;
-		cdrom_mmc3_profile(cdi);
+		if (CDROM_CAN(CDC_GENERIC_PACKET)) {
+			cdrom_mmc3_profile(cdi);
+		}
 		if (mode & FMODE_WRITE) {
 			ret = -EROFS;
 			if (cdrom_open_write(cdi))
@@ -2770,6 +2778,9 @@ int cdrom_get_last_written(struct cdrom_device_info *cdi, long *last_written)
 	   it doesn't give enough information or fails. then we return
 	   the toc contents. */
 use_toc:
+	if (!CDROM_CAN(CDC_PLAY_AUDIO))
+		return -ENOSYS;
+
 	toc.cdte_format = CDROM_MSF;
 	toc.cdte_track = CDROM_LEADOUT;
 	if ((ret = cdi->ops->audio_ioctl(cdi, CDROMREADTOCENTRY, &toc)))
diff --git a/drivers/scsi/sr_vendor.c b/drivers/scsi/sr_vendor.c
index e3b0ce25162b..b5e76869d473 100644
--- a/drivers/scsi/sr_vendor.c
+++ b/drivers/scsi/sr_vendor.c
@@ -61,6 +61,7 @@
 #define VENDOR_NEC             2
 #define VENDOR_TOSHIBA         3
 #define VENDOR_WRITER          4	/* pre-scsi3 writers */
+#define VENDOR_CYGNAL_85ED     5	/* CD-on-a-chip */
 
 #define VENDOR_TIMEOUT	30*HZ
 
@@ -99,6 +100,23 @@ void sr_vendor_init(Scsi_CD *cd)
 	} else if (!strncmp(vendor, "TOSHIBA", 7)) {
 		cd->vendor = VENDOR_TOSHIBA;
 
+	} else if (!strncmp(vendor, "Beurer", 6) &&
+		   !strncmp(model, "Gluco Memory", 12)) {
+		/* The Beurer GL50 evo uses a Cygnal/Cypress-manufactured
+		   CD-on-a-chip that only accepts a subset of SCSI commands.
+		   Most of the not-implemented commands are fine to fail, but a
+		   few, particularly around the MMC or Audio commands, will put
+		   the device into an unrecoverable state, so they need to be
+		   avoided at all costs.
+		*/
+		cd->vendor = VENDOR_CYGNAL_85ED;
+		cd->cdi.mask |= (
+			CDC_MULTI_SESSION |
+			CDC_CLOSE_TRAY | CDC_OPEN_TRAY |
+			CDC_LOCK |
+			CDC_GENERIC_PACKET |
+			CDC_PLAY_AUDIO
+			);
 	}
 #endif
 }
-- 
2.22.0

