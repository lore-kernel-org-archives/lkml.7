Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6A7C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 00:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2AA02173E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 00:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyahivUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfGBApl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 20:45:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45007 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbfGBApk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 20:45:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so25555110edr.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 17:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f9XoDf2UqqqVQm4eFJ4Eg/g7JLrPNXPmegTV8b0b65c=;
        b=CyahivUA8ly8coHmyiKLvnegSPHmgWJ4cnXAJWYEWTWp1DomBmBPid5QNe434kTCP9
         54k+ymolVc/Swe523+LJJjmPKDK8PsUpW8kGdxgwOvVKraJ1hKZgPt2epINFImSRZcJG
         kmiLcQs+Td5++2Gif2HP3ohW55ZCSrQGHiimvLIbIg7Q34shUxX8lkDQBax7yki52p85
         ValukBaG5zNBarrQnU9BSVPSPa/xLJup9dCtNq+CkbduGw03xj8hTnSXRNmeIgZNaNpd
         YA3uMoMDqtLn7fvyDlu5PdXxlgjMZ74PFrot9pepql5VBZBLi1KKZK2rXsHlu9kQG8l8
         BduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f9XoDf2UqqqVQm4eFJ4Eg/g7JLrPNXPmegTV8b0b65c=;
        b=hE+QC/kiOcUxWRh3tp4hSkJtxrYWY9BgS8E4vQY8h+nrqP3PJh+CuptjyYzmEwAGeO
         A2FtTmqUkPfXyq71ci0LzPMOALITDIT7t4VZOl45mxsS3tWDieSebK3dBRiHWGtmHlWz
         fVX/UXHDreJwcHVOS2t6xPyuE3yCAAEaf6YlBbSPah1PPo/aHqutn3mCgknkL3vyga+/
         8Ht/EEcP2rj6tPTTcpY4SLkJ4aNlaR8om1CQujMMawkGgsrR3qNV3is7tGv19lStSwbz
         XoF3dIw3DjWSPO9GBuFum9+SBw/B6zTiK5ZA34QTEbVfLKlgGLFE2aSv5FBE78Yllg+l
         iWHQ==
X-Gm-Message-State: APjAAAVc4HHLVjDwuxOwbeHO1S8qaEkfkCE4i/YksH6xSTUKEOpJ+NxP
        E5dx7s369uSz07upAy2xu3M=
X-Google-Smtp-Source: APXvYqyjNPdDcoNho/lEzrPtx9sDLllkBmP8SkzFS2xVXN06cJczrhuAw8oEMX4i3wlC+ewUvTuvdQ==
X-Received: by 2002:a17:906:3497:: with SMTP id g23mr26064074ejb.70.1562028338994;
        Mon, 01 Jul 2019 17:45:38 -0700 (PDT)
Received: from localhost.localdomain ([89.100.119.28])
        by smtp.gmail.com with ESMTPSA id x4sm4256392eda.22.2019.07.01.17.45.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 17:45:38 -0700 (PDT)
From:   Nicola Lunghi <nick83ola@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     info@jensverwiebe.de, Nicola Lunghi <nick83ola@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jussi Laako <jussi@sonarnerd.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: fix Line6 Helix audio format rates
Date:   Tue,  2 Jul 2019 01:43:14 +0100
Message-Id: <20190702004439.30131-1-nick83ola@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Line6 Helix and HX stomp don't support retrieving
the number of clock sample rate.

Add a quirk to return the default value of 48Khz.

Signed-off-by: Nicola Lunghi <nick83ola@gmail.com>
---
 sound/usb/format.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index c02b51a82775..05442f6ada62 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -313,10 +313,32 @@ static int parse_audio_format_rates_v2v3(struct snd_usb_audio *chip,
 			      tmp, sizeof(tmp));
 
 	if (ret < 0) {
-		dev_err(&dev->dev,
-			"%s(): unable to retrieve number of sample rates (clock %d)\n",
+		switch (chip->usb_id) {
+		/* LINE 6 HX pedals don't support getting the clock sample rate.
+		 * Set the framerate to 48khz by default
+		 */
+		case USB_ID(0x0E41, 0x4244): /* HELIX */
+		case USB_ID(0x0E41, 0x4246): /* HX STOMP */
+			dev_warn(&dev->dev,
+				"%s(): line6 helix: unable to retrieve number of sample rates. Set it to default value (clock %d).\n",
 				__func__, clock);
-		goto err;
+			fp->nr_rates = 1;
+			fp->rate_min = 48000;
+			fp->rate_max = 48000;
+			fp->rates = SNDRV_PCM_RATE_48000;
+			fp->rate_table = kmalloc(sizeof(int), GFP_KERNEL);
+			if (!fp->rate_table) {
+				ret = -ENOMEM;
+				goto err_free;
+			}
+			fp->rate_table[0] = 48000;
+			return 0;
+		default:
+			dev_err(&dev->dev,
+				"%s(): unable to retrieve number of sample rates (clock %d)\n",
+					__func__, clock);
+			goto err;
+		}
 	}
 
 	nr_triplets = (tmp[1] << 8) | tmp[0];
-- 
2.19.1

