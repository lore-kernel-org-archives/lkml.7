Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99047C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 17:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA7920866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 17:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alumni-chalmers-se.20150623.gappssmtp.com header.i=@alumni-chalmers-se.20150623.gappssmtp.com header.b="CgtyfogB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgABRQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 12:16:57 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33116 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgABRQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 12:16:57 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so33371782lji.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 09:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alumni-chalmers-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=/LNnVCi/tzD+lehzuQdRtYTIPZ1Mc+i/sOxugMx3Djg=;
        b=CgtyfogBxkPY246Nyql36knXkxj5+l3ytNlJAZm6YVRfhNsXC0pU+oIf2Yn3mYkEaV
         OQpRC3VK3JZfJYCCN68ErKLlC0OUzRiVkVe/yU2RNLPpf7+idyGQ3OXqjtiXA6H6RTpH
         1bffQPli4g8YHD0qIjd2wyddFuKgyUwcAHEcIn/uYMedpEcxVq8KHjx/qzKnXTi+p/SU
         q9EmvVskXew6igu45N/V78mVP5JtsHPultL/KqoVUslvQLz9AsiIPtvuR+ZsQbaRmuNp
         lktU3URtOQMyzxZayp9xn2KdCvry4OMKLB9typr2f9cKP2bRjwH73Zr86gdts+ZjPLiM
         ovhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=/LNnVCi/tzD+lehzuQdRtYTIPZ1Mc+i/sOxugMx3Djg=;
        b=H1dTzlcdpSk+nRcvyJ0DY6KGkbZ3z/Wpsliymqi+CGHXkyRa6xyUl519jhgHXqVEUk
         4RtMVx/3YQ+XAliux+e67KqbGSun0d3bbQvl3jewaIqeTefsYbuzkwgOJDB4fTw96Hss
         RapMyPVd0ILIt53TljK05+PjQiwOItrkkzo5bXeP1IHtlvnVAkREplwAWK0dqD/OkB0r
         saB+AWGT7pGCf2Z+sAlKJBT7HXpO/JzbrmJylYiYuLTDzlYtGHOlCzLCA1IsLjAtbUBv
         BXjQ96q4MALRgtOB8BsbC2h/Sfy8S5ch1MLdYzdDo1zo2+SfQrC+aJMKAQIQ7eEshbXv
         KhWA==
X-Gm-Message-State: APjAAAV0I7HasVgx/JBJ8Hdn1H2YEXLuJRVrcSqcxi64F+sjOpFfZIAR
        oj+DFv6wop1klp8n60vo7J7qMpPC1xA=
X-Google-Smtp-Source: APXvYqySqErkRCz7LQqxqAs6BcKy0nzt2T/uUFiYLKLcX0CdVD9mkB5xmWBk2TcQUECoFDLOigm5SQ==
X-Received: by 2002:a2e:978c:: with SMTP id y12mr43102817lji.167.1577985414925;
        Thu, 02 Jan 2020 09:16:54 -0800 (PST)
Received: from newline.site (h-173-139.A785.priv.bahnhof.se. [98.128.173.139])
        by smtp.gmail.com with ESMTPSA id y10sm23042372ljm.93.2020.01.02.09.16.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2020 09:16:54 -0800 (PST)
From:   Arseniy Lartsev <arseniy@alumni.chalmers.se>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: add implicit feedback quirk for Yamaha P-125
Date:   Thu, 02 Jan 2020 18:16:52 +0100
Message-ID: <6288884.Nqi5ZcYBqQ@newline.site>
User-Agent: KMail/5.3.2 (Linux/4.4.27-2-default; KDE/5.26.0; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This digital piano has audio playback function with implicit feedback
endpoint.

On this device in particular, if USB host sends samples slightly too fast due
to lack of synchronization (50% chance of that happening), playback will fail
after a few minutes. This patch fixes the problem.

The feedback endpoint is, in fact, very nearly standard-compliant, but
set_sync_endpoint function currently uses different logic for feedback
endpoint discovery - the patch also adds a comment to clarify this behaviour.

Signed-off-by: Arseniy Lartsev <arseniy@alumni.chalmers.se>
---
 sound/usb/pcm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 9c8930b..47ccea6 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -351,6 +351,10 @@ static int set_sync_ep_implicit_fb_quirk(struct 
snd_usb_substream *subs,
 	case USB_ID(0x0582, 0x01d8): /* BOSS Katana */
 		/* BOSS Katana amplifiers do not need quirks */
 		return 0;
+	case USB_ID(0x0499, 0x1718): /* Yamaha P-125 digital piano */
+		ep = 0x86;
+		ifnum = 2;
+		goto add_sync_ep_from_ifnum;
 	}
 
 	if (attr == USB_ENDPOINT_SYNC_ASYNC &&
@@ -427,6 +431,21 @@ static int set_sync_endpoint(struct snd_usb_substream 
*subs,
 	if (err > 0)
 		return 0;
 
+	/*
+	 * Actually, what USB 2.0 standard says is this:
+	 *
+	 * A feedback endpoint (explicit or implicit) needs to be associated with
+	 * one (or more) isochronous data endpoints to which it provides feedback
+	 * service. <...> The first data endpoint and the feedback endpoint must
+	 * have the same endpoint number (and opposite direction). This ensures
+	 * that a data endpoint can uniquely identify its feedback endpoint by
+	 * searching for the first feedback endpoint that has an endpoint number
+	 * equal or less than its own endpoint number.
+	 *
+	 * However, it looks like hardware vendors never follow this except by
+	 * accident, so we may as well give up on it too. Look for a feedback
+	 * endpoint as a second endpoint on the same interface.
+	 */
 	if (altsd->bNumEndpoints < 2)
 		return 0;
 
-- 
2.10.0


