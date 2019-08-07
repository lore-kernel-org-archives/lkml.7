Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDC6C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660D321923
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbfHGJJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 05:09:12 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37792 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfHGJJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 05:09:12 -0400
Received: by mail-yw1-f67.google.com with SMTP id u141so32062658ywe.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 02:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cYG9qyve6yyxmV+AOeRIzDv8dPpq2DUERiyZ5aq12Zs=;
        b=SKUZRpOVwQ5AJTF4pNeoHjGAH0DH0tWhObE/Z2r75vnr1z0YSUCOdOxJsVj4tyNtsC
         oVyKF9WI8Wnt30tcwHnoESftooaL1OSgnTQCzDtgEHDFR07LWpVks78EQdYgV1hiQaQ8
         uJVpII/jr5hg6Kh9Z6WP/6/KKehvo5EXWdZ6C4V4VsZadJTIO+8IxGvzHg8huk6VXKas
         //HOfUvrfhGVbjsECpaTmlscyUxH3BzdJC66Gj8z0DuavoLtB+vTVnkf76UAdRA99HIh
         +xstTCKnLYkwb9cjP9DsH0AnObetUa9ps1yl5BULXYajm014OjFIQsCUtPap+LIWyZWs
         782A==
X-Gm-Message-State: APjAAAWDRKL88/K6eii+E0Er9zQf/r9f1xrPouCRjonIlbuO4ihxST3u
        eN0OL2lCTaaSSh/EMKKhBNk=
X-Google-Smtp-Source: APXvYqwNxPXEUwt4w+RyJ6UmqNqlXasDRygpmijmshd7FwsVJpuUzLPrT2DBiLP7P/OjcBZnCgqR0g==
X-Received: by 2002:a81:47d5:: with SMTP id u204mr5374829ywa.145.1565168951718;
        Wed, 07 Aug 2019 02:09:11 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id 193sm369421ywh.89.2019.08.07.02.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Aug 2019 02:09:11 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] ALSA: hiface: fix multiple memory leak bugs
Date:   Wed,  7 Aug 2019 04:08:51 -0500
Message-Id: <1565168932-6337-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hiface_pcm_init(), 'rt' is firstly allocated through kzalloc(). Later
on, hiface_pcm_init_urb() is invoked to initialize 'rt->out_urbs[i]'. In
hiface_pcm_init_urb(), 'rt->out_urbs[i].buffer' is allocated through
kzalloc().  However, if hiface_pcm_init_urb() fails, both 'rt' and
'rt->out_urbs[i].buffer' are not deallocated, leading to memory leak bugs.
Also, 'rt->out_urbs[i].buffer' is not deallocated if snd_pcm_new() fails.

To fix the above issues, free 'rt' and 'rt->out_urbs[i].buffer'.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 sound/usb/hiface/pcm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/usb/hiface/pcm.c b/sound/usb/hiface/pcm.c
index 14fc1e1..c406497 100644
--- a/sound/usb/hiface/pcm.c
+++ b/sound/usb/hiface/pcm.c
@@ -600,14 +600,13 @@ int hiface_pcm_init(struct hiface_chip *chip, u8 extra_freq)
 		ret = hiface_pcm_init_urb(&rt->out_urbs[i], chip, OUT_EP,
 				    hiface_pcm_out_urb_handler);
 		if (ret < 0)
-			return ret;
+			goto error;
 	}
 
 	ret = snd_pcm_new(chip->card, "USB-SPDIF Audio", 0, 1, 0, &pcm);
 	if (ret < 0) {
-		kfree(rt);
 		dev_err(&chip->dev->dev, "Cannot create pcm instance\n");
-		return ret;
+		goto error;
 	}
 
 	pcm->private_data = rt;
@@ -620,4 +619,10 @@ int hiface_pcm_init(struct hiface_chip *chip, u8 extra_freq)
 
 	chip->pcm = rt;
 	return 0;
+
+error:
+	for (i = 0; i < PCM_N_URBS; i++)
+		kfree(rt->out_urbs[i].buffer);
+	kfree(rt);
+	return ret;
 }
-- 
2.7.4

