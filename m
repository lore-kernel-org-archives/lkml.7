Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436ACC4CECC
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 12:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD84214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 12:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netforce.ua header.i=@netforce.ua header.b="PipIVkOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfIOMoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 08:44:25 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33530 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfIOMoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 08:44:24 -0400
Received: by mail-lf1-f68.google.com with SMTP id y127so2115432lfc.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 05:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netforce.ua; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MFj5Gh6TGZA1arOapAJ2tmpTqH/CJaSifKu4rw3SbJg=;
        b=PipIVkOF2Dqa/X61x5eYjgo9Fh8ef1m5QJ331U36vW22ClfNxvNqkcXj/v4JWkfq+C
         Q42U83HjNsovM4bbXNuCjFf/kg3hNp+Wwegb0UI0DZEOpLovXPVqWPcKLPqcMN7tIMzW
         mTL84UN1Mpn5fEP9SFUUPJgvhEl6FsMT31pIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MFj5Gh6TGZA1arOapAJ2tmpTqH/CJaSifKu4rw3SbJg=;
        b=ZIdcPcaJKQk8hPM1Fic2C0sxYbCGbctJNLX+R2wogsg3GXujVRZX0inBeroY1crVl9
         iK2GKjm46vA4U0yFuYWQ4TLMFJ/I89wvqUrtS6hkZJtdaSAnetywIANySBmhjch0i1oB
         zfdnpElaO6qbvUk8EAoHzMZ/6va8g1uF4s9j9XpKZslrTzNBW3+L5CeKcErZYOCtv7T0
         p07Rl6lV3RanbcPR2qt5KVq7B2OAd3768Zun3ASpJjBaRAznmguYYjnyLKPSgT6OUOfc
         zVMAp7UPE2ny2H60HfzhfeHBQCt7vtzC9T1QiTz9564DQuUbT1LB2MDyzTCue5AU+Cp6
         H22g==
X-Gm-Message-State: APjAAAUlSPlAnXF+a5vcRSTzXvZdf9KyNqtjApifCcrqjSbR0okA/ivc
        fmUvWi5cbZ88rd9Hwn9FL/4vzt9GT1o=
X-Google-Smtp-Source: APXvYqwPfJiyb6VwO8HmojQIrfBxm93gekDw9na/dZ90/f4+oy8hhpzP9igR0I8qLC4eYLZWbVQRdA==
X-Received: by 2002:a19:2d19:: with SMTP id k25mr37919346lfj.76.1568551462691;
        Sun, 15 Sep 2019 05:44:22 -0700 (PDT)
Received: from rhea.localdomain ([37.46.255.109])
        by smtp.gmail.com with ESMTPSA id 77sm7819743ljf.85.2019.09.15.05.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 05:44:22 -0700 (PDT)
From:   ilya.pshonkin@netforce.ua
To:     ilya.pshonkin@netforce.ua
Cc:     Sudokamikaze <sudokamikaze@protonmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Tony Das <tdas444@gmail.com>,
        Olek Poplavsky <woodenbits@gmail.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amade@asmblr.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jussi Laako <jussi@sonarnerd.net>,
        Udo Eberhardt <udo.eberhardt@thesycon.de>,
        Manuel Reinhardt <manuel.rhdt@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Add Hiby device family to quirks for native DSD support
Date:   Sun, 15 Sep 2019 15:43:59 +0300
Message-Id: <20190915124400.6244-1-ilya.pshonkin@netforce.ua>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudokamikaze <sudokamikaze@protonmail.com>

This patch adds quirk VID ID for Hiby portable players family with native DSD playback support

Signed-off-by: Sudokamikaze <sudokamikaze@protonmail.com>
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

