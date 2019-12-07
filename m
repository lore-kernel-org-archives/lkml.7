Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDE9C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 22:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68BF206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 22:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="DwhmzTgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfLGWuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 17:50:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46445 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfLGWuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 17:50:01 -0500
Received: by mail-pf1-f195.google.com with SMTP id y14so5223585pfm.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 14:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=lL+1PRskYMs2R8IhafHrkXHNGmWtEsk3V5MLoBd8+zY=;
        b=DwhmzTgcKmnOBPVF0IjpaSQlVwQ4sIrkmeLbE3VWvbZ97Tkj0feHuKEpNuI0VsvcSD
         KaA6vhX0ftaetj1cNLOJN6vBeWR+t3PqP6r6HGxlDpdQwnoIAO+VcY/fT4o+v8wpQaER
         WVBnWDGG82IuOKQDh7VsUblhCG44KUfpdiGPfPMKDAzmThmKScGWDvs8MAI4l1ep33WP
         ty6SDX5JzDO3+dkxfieBloSXg3wg5uJ5tW4OcDfpsZE/E41kef6PxCewCvQdmz+Lm+dL
         0zVtmLx191aByueJrGeEjyxQT/YwUF2Fl8lV7QdFXIStWJLKfxM2OSTx8CddO6iyYpap
         XkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lL+1PRskYMs2R8IhafHrkXHNGmWtEsk3V5MLoBd8+zY=;
        b=sqIpdxwr8sRcbG3C5BmbWeTk7w8MoIzUPKkQtS4Yb9v8sXEzYOBriWM0wOv/ZhoTHU
         ngKcuR+JK+TvDkNsDwVTnmImSMv9aOKawKcyQF6OmqH2o2Al69wRe4+bT1q7WsIfUwLh
         PvPpLZu+ZLL848VYyC6RcQ4keSJ8L+u+0Ks71JiqAjRRsaG/v6hY1g4XX9eJg0ijvMq+
         fWVwxNGPj5agBFK/sUsQM6JTthZ1KhOGA81wTpzPTGB+JDsHdtLX6mnPWEEM6KoUWhw2
         oBfeiIfc9cr7ews/2K9HNCPwN6A2AabKqXSqllwYmv3yHSm8sDLg88UZksVYNPx7aa4p
         /Whw==
X-Gm-Message-State: APjAAAW6MdtfCbimP9ZyNvGh9V6ZWm7xpPSAXRlWb5gWypJad1wBKGTW
        yjxZZwUQZqsS9OCmCFtuQVSDHyEB5HyXEQ==
X-Google-Smtp-Source: APXvYqwGQDo739d6dIOpL5JSCvp4GW1cBrkgeXp/wmM8/PMERqSFA/jOs/yhBO6I0yrKn0/7RPqhQw==
X-Received: by 2002:a63:5221:: with SMTP id g33mr11340616pgb.68.1575759000761;
        Sat, 07 Dec 2019 14:50:00 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id s11sm19995747pgo.85.2019.12.07.14.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 14:49:59 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] ALSA: echoaudio: simplify get_audio_levels
Date:   Sat,  7 Dec 2019 14:49:53 -0800
Message-Id: <20191207224953.25944-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The loop optimizer seems to go astray here, and produces some warnings
that don't seem valid.

Still, the code can be simplified -- just clear the whole array at the
beginning, and fill in whatever values are valid on the platform.

Warnings before this change (GCC 8.2.0 ARM allmodconfig):

In file included from ../sound/pci/echoaudio/gina24.c:115:
../sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_vumeters_get':
../sound/pci/echoaudio/echoaudio_dsp.c:647:9: warning: iteration 1073741824 invokes undefined behavior [-Waggressive-loop-optimizations]
In file included from ../sound/pci/echoaudio/layla24.c:112:
../sound/pci/echoaudio/echoaudio.c: In function 'snd_echo_vumeters_get':
../sound/pci/echoaudio/echoaudio_dsp.c:658:9: warning: iteration 1073741824 invokes undefined behavior [-Waggressive-loop-optimizations]
../sound/pci/echoaudio/echoaudio_dsp.c:647:9: warning: iteration 1073741824 invokes undefined behavior [-Waggressive-loop-optimizations]

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 sound/pci/echoaudio/echoaudio_dsp.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio_dsp.c b/sound/pci/echoaudio/echoaudio_dsp.c
index 50d4a87a6bb34..f02f5b1568dee 100644
--- a/sound/pci/echoaudio/echoaudio_dsp.c
+++ b/sound/pci/echoaudio/echoaudio_dsp.c
@@ -635,36 +635,30 @@ This function assumes there are no more than 16 in/out busses or pipes
 Meters is an array [3][16][2] of long. */
 static void get_audio_meters(struct echoaudio *chip, long *meters)
 {
-	int i, m, n;
+	unsigned int i, m, n;
 
-	m = 0;
-	n = 0;
-	for (i = 0; i < num_busses_out(chip); i++, m++) {
+	for (i = 0 ; i < 96; i++)
+		meters[i] = 0;
+
+	for (m = 0, n = 0, i = 0; i < num_busses_out(chip); i++, m++) {
 		meters[n++] = chip->comm_page->vu_meter[m];
 		meters[n++] = chip->comm_page->peak_meter[m];
 	}
-	for (; n < 32; n++)
-		meters[n] = 0;
 
 #ifdef ECHOCARD_ECHO3G
 	m = E3G_MAX_OUTPUTS;	/* Skip unused meters */
 #endif
 
-	for (i = 0; i < num_busses_in(chip); i++, m++) {
+	for (n = 32, i = 0; i < num_busses_in(chip); i++, m++) {
 		meters[n++] = chip->comm_page->vu_meter[m];
 		meters[n++] = chip->comm_page->peak_meter[m];
 	}
-	for (; n < 64; n++)
-		meters[n] = 0;
-
 #ifdef ECHOCARD_HAS_VMIXER
-	for (i = 0; i < num_pipes_out(chip); i++, m++) {
+	for (n = 64, i = 0; i < num_pipes_out(chip); i++, m++) {
 		meters[n++] = chip->comm_page->vu_meter[m];
 		meters[n++] = chip->comm_page->peak_meter[m];
 	}
 #endif
-	for (; n < 96; n++)
-		meters[n] = 0;
 }
 
 
-- 
2.11.0

