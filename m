Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA32C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B577D21D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YG2G917w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfJKRU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 13:20:28 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39068 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfJKRU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 13:20:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id 72so7579247lfh.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 10:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yRAnuRCkSyKVLCAmSQFI503vy2zlzDFLVnB7JdH9NYA=;
        b=YG2G917wONgMF7/nunIQ7oZMLYSO4yERFbgtrrGEcVI/0GoZliITt1DXT/2wnqi+CF
         nLSby7497sMUDNJNz8BM8GgufaNBrKChQt3govrNPY+EBBDgY8Tgmtq526nvH2oVvt6z
         pxM76Mz4ojYUxGPQ8ElCybu9CUWzGEW07cdTvHyn8gV3y3CM8vRYBgmgJ/0i46mqlRoo
         dd6zqdc6heyxg421NxIHmTo9MmVenQcxm0y4iSaQJvebiED4aVejMPUg4zOZx+DqVzck
         BBYRLrr8sl7Y/7Py7xZKLxbM99mWc3jNbhgkk3w5RV3U7NA8n3mm/dfETTjzYiHZtR++
         k5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yRAnuRCkSyKVLCAmSQFI503vy2zlzDFLVnB7JdH9NYA=;
        b=tx67/DKL7j8Y+Gl9e+Cb5RC2Z+e33PfK/PWsKOgcAJZgyqbGnZyqMYT0cONFgu2FCq
         xNDRL7KjXB/+FN/29g4YPI/67quufN4cpGcRbT+fL86cwDx8ciiFH8ShfYu9ve4LtnLF
         6vzlXJbAFj4EUHOhiFcEz3jpmQ2l23RTmUjaRpjgF2yzoei4PBFzvGqvZC4WHUyQPYoL
         rZKKipkkodvnqTySBttOtvmEQcXX+ODIi+VRT/MCo22ji/7Y5VFHgFjuxG24FANxJpvN
         vzCleytKIpKcpgjHGgruD1+XI82zeUvzyVvw+H/EAqH47MTPSMSu1Sa6HnnWzCqioXGZ
         9hlA==
X-Gm-Message-State: APjAAAVzcfJhr3GxN0xrm7wA0PBqxZc6HmGRChJaVAsqIeGvH0EQwXTB
        pcXdvLxRIStifYjUPeo2bWQ=
X-Google-Smtp-Source: APXvYqwucUzyuG6jIHyKVwJBQAORVQ8TiY7up4EYNX13HewXV1Av++AGUNksvlQ6n4BQuxFWjAE92A==
X-Received: by 2002:a19:ee08:: with SMTP id g8mr4738790lfb.117.1570814426189;
        Fri, 11 Oct 2019 10:20:26 -0700 (PDT)
Received: from localhost.localdomain ([192.71.198.209])
        by smtp.googlemail.com with ESMTPSA id e17sm2015491ljj.104.2019.10.11.10.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 10:20:25 -0700 (PDT)
From:   =?UTF-8?q?Szabolcs=20Sz=C5=91ke?= <szszoke.code@gmail.com>
Cc:     szszoke.code@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Manuel Reinhardt <manuel.rhdt@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Ard van Breemen <ard@kwaak.net>,
        Richard Fontana <rfontana@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Disable quirks for BOSS Katana amplifiers
Date:   Fri, 11 Oct 2019 19:19:36 +0200
Message-Id: <20191011171937.8013-1-szszoke.code@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BOSS Katana amplifiers cannot be used for recording or playback if quirks
are applied

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=195223
Signed-off-by: Szabolcs Szőke <szszoke.code@gmail.com>

---
 sound/usb/pcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 33cd26763c0e..daadb0c66eee 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -348,6 +348,9 @@ static int set_sync_ep_implicit_fb_quirk(struct snd_usb_substream *subs,
 		ep = 0x84;
 		ifnum = 0;
 		goto add_sync_ep_from_ifnum;
+	case USB_ID(0x0582, 0x01d8): /* BOSS Katana */
+		/* BOSS Katana amplifiers do not need quirks */
+		return 0;
 	}
 
 	if (attr == USB_ENDPOINT_SYNC_ASYNC &&
-- 
2.20.1
