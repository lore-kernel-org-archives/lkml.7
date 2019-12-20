Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E2FC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149072146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576834327;
	bh=2IWG2XB69BqHzXFt9VBjFmiioNKdGWnBh2Lll6Jmb6M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kwdi4oBMEAGB2bVe6VwUOv3wSARpFNXer5jQgTc4M2sCSI5/zWmKBmj7YB9a55kvu
	 fgn6ZyjrmTzUGXq63TqITZq4UgW+K4KXkdwM36zZB5kFcP7V3DZWgufPGDp38jhoGF
	 twVjZIIUyBlBg1GKRwc84mA6kndfLLgrml6+igCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfLTJcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 04:32:06 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35564 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfLTJcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 04:32:06 -0500
Received: by mail-lj1-f195.google.com with SMTP id j1so1943879lja.2;
        Fri, 20 Dec 2019 01:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vACzD6DaxQvgtCMU0tnPw1WJ51oVtIqk0pKAR9FuZpU=;
        b=FySB0IZnaU+ESH8XGKR4HwoXuak1WTgE8SPhZAkiDiUF7QIqJIRz4MVTSMJUE1u42T
         Z/hJR0SKqpWsujre0cXxBwwLxYtI99RqvYRBDS0HJYdf26BC3GDs3TmrwWq2LZFzGI7n
         wHmnXiN1F0zqVB6Vf5ONeRtsup9ijMbT9FNllAvJ2ftNkOusvc1cH6HO2acP4WmQeDOG
         pW9r0gUausnDAAS2DrpmGRrO8Wa0nzDVR936dEWlp9dSWoLTC+fy/nkLEBxvg2wLclDP
         OWiDsZDqrnawS/D+/TZPfVBQJqfqEtjSlRYljp+fMk1BLlkKS2BQ+wcYpddBP7EMv3X4
         AeJA==
X-Gm-Message-State: APjAAAW7bodVb8QNmL5QIrHYRGpdsc/jaOpROe8GYwCpxw/uyEC/XbCw
        bdtSnthJen6P6iR05lI+0jI=
X-Google-Smtp-Source: APXvYqx7d4xmf7k72/iB+L72Tyd+ARo47ZmuVxirOZXppNqFPl+yhzLOboPX4ybagaHMNyeKmQuMow==
X-Received: by 2002:a2e:910b:: with SMTP id m11mr9162003ljg.213.1576834323858;
        Fri, 20 Dec 2019 01:32:03 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id z7sm4437120lfa.81.2019.12.20.01.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 01:32:03 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1iiEde-0000L0-4r; Fri, 20 Dec 2019 10:32:02 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>
Subject: [PATCH] ALSA: usb-audio: fix set_format altsetting sanity check
Date:   Fri, 20 Dec 2019 10:31:34 +0100
Message-Id: <20191220093134.1248-1-johan@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to check the return value of usb_altnum_to_altsetting() to
avoid dereferencing a NULL pointer when the requested alternate settings
is missing.

The format altsetting number may come from a quirk table and there does
not seem to be any other validation of it (the corresponding index is
checked however).

Fixes: b099b9693d23 ("ALSA: usb-audio: Avoid superfluous usb_set_interface() calls")
Cc: stable <stable@vger.kernel.org>     # 4.18
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 sound/usb/pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 9c8930bb00c8..73dd9d21bb42 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -506,9 +506,9 @@ static int set_format(struct snd_usb_substream *subs, struct audioformat *fmt)
 	if (WARN_ON(!iface))
 		return -EINVAL;
 	alts = usb_altnum_to_altsetting(iface, fmt->altsetting);
-	altsd = get_iface_desc(alts);
-	if (WARN_ON(altsd->bAlternateSetting != fmt->altsetting))
+	if (WARN_ON(!alts))
 		return -EINVAL;
+	altsd = get_iface_desc(alts);
 
 	if (fmt == subs->cur_audiofmt)
 		return 0;
-- 
2.24.1

