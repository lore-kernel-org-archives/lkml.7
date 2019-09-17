Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE06BC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0591206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 07:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netforce.ua header.i=@netforce.ua header.b="vKzM+Hbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404509AbfIQHtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 03:49:52 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45305 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfIQHtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 03:49:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id r134so2014513lff.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 00:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netforce.ua; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ankm3LCZEaJD3BWJKIMuewTTlEirw0P6hVdl8ocB80s=;
        b=vKzM+Hbc3bGuttUwBZEJv443RDSwKnGtbmymNt+olccFjQqqh5swLf8DYx0dPG3G0L
         3JysYPqqjGtrXdC7oHPepKQqQh/mIWXFZsf4L1Xbcq59BK6RiYAGUZ9K4BI1WiRUQgcH
         wpAuC32IP7YqeFEi7sfHhs7ONvjv1OSr/duwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ankm3LCZEaJD3BWJKIMuewTTlEirw0P6hVdl8ocB80s=;
        b=JTb1mNJavFy+ERCP/SdcTBz2YbokPzT5dkCopodfgRdtTh4UvQG92Iut5yUgkQnJDz
         +Sy9vUGkInjhIdCRLM6Ez1z4bKb+4yVykliMHLCqTIROYueFbL0GcVGXzr2tRswrpWTH
         Uof5qm6c3H4FmOLiqwk5nIDxohnP49txN33jZWnn6iw2pZo38Xkl7joCfchTV7ci5HIM
         +s+WTgPiSRflWuTZ6bNeYpeRsuRMzbT7fe65QPw42QSryc+TJ/d2A/1KATlzfAmS8wUS
         EfD32pOATQSfhUkcTwpb96h14nGt2UIy3vHBXH12a5R08h+deEgcf52T2FRPwmWI03xK
         1HvQ==
X-Gm-Message-State: APjAAAUWoiDXk5uzYf14APSvtJUzQsi21RdjwmKfJhXfMrVgL7rTftRV
        moRD2iSuFjeol7QWdKe5Y0VZSg==
X-Google-Smtp-Source: APXvYqx8VdH4sWRxk7OR+GjT8WaGAKs1L/dw8/Wbee8fdjRDoMTqIJd3Z2BFHlCKXFAd/hrmm9Zelw==
X-Received: by 2002:ac2:4902:: with SMTP id n2mr1343367lfi.0.1568706590256;
        Tue, 17 Sep 2019 00:49:50 -0700 (PDT)
Received: from rhea.localdomain ([37.46.255.109])
        by smtp.gmail.com with ESMTPSA id j22sm263563lja.4.2019.09.17.00.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 00:49:49 -0700 (PDT)
From:   ilya.pshonkin@netforce.ua
To:     ilya.pshonkin@netforce.ua
Cc:     Ilya Pshonkin <sudokamikaze@protonmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jussi Laako <jussi@sonarnerd.net>,
        Olek Poplavsky <woodenbits@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Manuel Reinhardt <manuel.rhdt@gmail.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amade@asmblr.net>,
        Udo Eberhardt <udo.eberhardt@thesycon.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Add Hiby device family to quirks for native DSD support
Date:   Tue, 17 Sep 2019 10:49:34 +0300
Message-Id: <20190917074937.157802-1-ilya.pshonkin@netforce.ua>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Pshonkin <sudokamikaze@protonmail.com>

This patch adds quirk VID ID for Hiby portable players family with native DSD playback support

Signed-off-by: Ilya Pshonkin <sudokamikaze@protonmail.com>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 78858918cbc1..64a8d73972e3 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1655,6 +1655,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
 	case 0x152a:  /* Thesycon devices */
 	case 0x25ce:  /* Mytek devices */
 	case 0x2ab6:  /* T+A devices */
+	case 0xc502:  /* HiBy devices */
 		if (fp->dsd_raw)
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
-- 
2.23.0

