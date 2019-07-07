Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F0AC0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 08:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3363206A3
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 08:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtK4rURu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfGGI2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 04:28:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36171 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfGGI2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 04:28:20 -0400
Received: by mail-ed1-f65.google.com with SMTP id k21so11713343edq.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 01:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G0Y4cjzHcvVmq7KzUPJtwccJDPm0PfTiZlto8ZH/pcY=;
        b=RtK4rURu7nLX5Xm5CJI5KcPO8pT1dFNz89scG04MqjKRRPCfo09V7gJM5OrXuVL+mW
         iPncJ22lQ30pMj8eqEJ5ETrFw4zOyW/8ReKLWPP+uG/2MmbutDotykioZGPj75U3n9sJ
         WhtRTFAVAkx+dY/otRi2D+e+UoRGLwxCcMR1S0qZvWFiAjYNO6uo9gJItnKT2cVEy1vu
         lzRwOMmwYARZw1QzLRE9z+KUkXOByH3GAdAVETVY32l1fRiofyZ06VttaMw6armI83I2
         eddp0QS3BMww5M+P7YaQaTd/ORM8jCKSIWLGCTadqc65oGtX9Soop5ZYWTHLYgFVqaZh
         roEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G0Y4cjzHcvVmq7KzUPJtwccJDPm0PfTiZlto8ZH/pcY=;
        b=CCQpTSriBXIF3FzFalo3VjgjFl+2k3kMcMru4d9Pl+UB6V+9NOPA4efg5RUPpRIvku
         jHS5ej42VHtQXCpC0NF/Wzg7lHsFDvi0ioAeaqGLjrImEdNpOc8WDr95BECAqViNEnZt
         RQmeZMHaVya88isBHdn5xeDQhwHq6F0joSvUSfhKY7Kz7VsTDN3eVOE12IeWzMI3RCPp
         5rsmTX9i+ev2i9qBSxQSq7rOqgmDTsVHchxMms6cXOQMU3QjGEvL826G1vKLxaIVRAed
         nYKnvZTM6YPLy6wkZ10oMIdpWQ3OhZQQo2q7W4JJISEqHGiJjIxyrJ4W7mg6aXiygK3I
         bONw==
X-Gm-Message-State: APjAAAUU4anecP1SVvRDeatdt2Fngg3OVIcE+xAdQWhDaXabuThRX1Lo
        B5l4VRmEj0Dv+jUQZEdDDWs=
X-Google-Smtp-Source: APXvYqz3d0o/dxMwjKXSjP1Hn81Xq3lQXc01OhqkuNRzl+3D7bHeT3vTeiabg41E4MLogAZUnAa8hg==
X-Received: by 2002:a17:906:3956:: with SMTP id g22mr11068919eje.292.1562488098545;
        Sun, 07 Jul 2019 01:28:18 -0700 (PDT)
Received: from localhost.localdomain ([89.100.119.28])
        by smtp.gmail.com with ESMTPSA id z16sm2659249eji.31.2019.07.07.01.28.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 01:28:17 -0700 (PDT)
From:   Nicola Lunghi <nick83ola@gmail.com>
To:     alsa-devel@alsa-project.org
Cc:     Nicola Lunghi <nick83ola@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Jussi Laako <jussi@sonarnerd.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ALSA: usb-audio: fix Line6 Helix audio format rates
Date:   Sun,  7 Jul 2019 09:27:34 +0100
Message-Id: <20190707082734.25829-1-nick83ola@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Line6 Helix and HX stomp devices don't support retrieving
the number of clock sample rate.

Add a quirk to set it to 48Khz by default.

Signed-off-by: Nicola Lunghi <nick83ola@gmail.com>
---
 sound/usb/format.c | 46 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/sound/usb/format.c b/sound/usb/format.c
index c02b51a82775..31780dfb8eb9 100644
--- a/sound/usb/format.c
+++ b/sound/usb/format.c
@@ -285,6 +285,33 @@ static int parse_uac2_sample_rate_range(struct snd_usb_audio *chip,
 	return nr_rates;
 }
 
+/* Line6 Helix series don't support the UAC2_CS_RANGE usb function
+ * call. Return a static table of known clock rates.
+ */
+static int line6_parse_audio_format_rates_quirk(struct snd_usb_audio *chip,
+						struct audioformat *fp)
+{
+	switch (chip->usb_id) {
+	case USB_ID(0x0E41, 0x4241): /* Line6 Helix */
+	case USB_ID(0x0E41, 0x4242): /* Line6 Helix Rack */
+	case USB_ID(0x0E41, 0x4244): /* Line6 Helix LT */
+	case USB_ID(0x0E41, 0x4246): /* Line6 HX-Stomp */
+		/* supported rates: 48Khz */
+		kfree(fp->rate_table);
+		fp->rate_table = kmalloc(sizeof(int), GFP_KERNEL);
+		if (!fp->rate_table)
+			return -ENOMEM;
+		fp->nr_rates = 1;
+		fp->rate_min = 48000;
+		fp->rate_max = 48000;
+		fp->rates = SNDRV_PCM_RATE_48000;
+		fp->rate_table[0] = 48000;
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
 /*
  * parse the format descriptor and stores the possible sample rates
  * on the audioformat table (audio class v2 and v3).
@@ -294,7 +321,7 @@ static int parse_audio_format_rates_v2v3(struct snd_usb_audio *chip,
 {
 	struct usb_device *dev = chip->dev;
 	unsigned char tmp[2], *data;
-	int nr_triplets, data_size, ret = 0;
+	int nr_triplets, data_size, ret, ret_l6 = 0;
 	int clock = snd_usb_clock_find_source(chip, fp->protocol,
 					      fp->clock, false);
 
@@ -313,9 +340,22 @@ static int parse_audio_format_rates_v2v3(struct snd_usb_audio *chip,
 			      tmp, sizeof(tmp));
 
 	if (ret < 0) {
-		dev_err(&dev->dev,
-			"%s(): unable to retrieve number of sample rates (clock %d)\n",
+		/* line6 helix devices don't support UAC2_CS_CONTROL_SAM_FREQ call */
+		ret_l6 = line6_parse_audio_format_rates_quirk(chip, fp);
+		if (ret_l6 == -ENODEV) {
+			/* no line6 device found continue showing the error */
+			dev_err(&dev->dev,
+				"%s(): unable to retrieve number of sample rates (clock %d)\n",
+				__func__, clock);
+			goto err;
+		}
+		if (ret_l6 == 0) {
+			dev_info(&dev->dev,
+				"%s(): unable to retrieve number of sample rates: set it to a predefined value (clock %d).\n",
 				__func__, clock);
+			return 0;
+		}
+		ret = ret_l6;
 		goto err;
 	}
 
-- 
2.19.1

