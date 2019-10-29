Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD20CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE3D214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N478fBlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbfJ2IfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 04:35:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33636 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728892AbfJ2IfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 04:35:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id u23so9040045pgo.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 01:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lf5s6Fz7leqrQMKj0V75R9m9lTLSurFPPz+2KwV5ePI=;
        b=N478fBlO32UC62rsQLpqYQg4ISJscCpnddi7FsAoBSPy9+yzNYdJrPT7MIUkMBikZN
         jrRS23f1wxXWb4MlnpX0rfF6wRl5UtCkmMK7O2afrn9esHONx7RaSn5GiaLYrFoCj0Zf
         b3ZqgIoJcFsu4Fm45xrGvPC/qlQTH3hgOI+I+/FsmNhndFingDZPDSDLSQqpfTTKwoRD
         QoJLpwdwLtj/7/nA+7XzHEp8+W3Rzl0byPBmiCmoW25t5RtxxoIwUd6LTadK4Uflbbmh
         kdqEwvfSyYrnscOPd3dcssaCW/SoQrkRrtKb9673BtUfsGM9c1c2cnjBU85TsdpqVSov
         BcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lf5s6Fz7leqrQMKj0V75R9m9lTLSurFPPz+2KwV5ePI=;
        b=pv0nww1ooED/QZAL6gvqx+wfAwJn8oDFcz2YFPy9mM8rnaEW0koB6ue94xfTHh8XOV
         NHAnEi/lfBlRgm44kPoBJFhRGXs50lF6Y1JuA5bl5habkM2VmsxBXb+xOipcTcO88Nc4
         NgpYRR5YFS9gjQ2k2lLhiqRSaQHJk9NB8PtqDtZ81pLp42kSmbrd5qILW8+bPYY+6XLC
         brE19k0JDufr/vIi0/nri51rGI2/QLhpwT6GnMXWryTAvL1D+xuGizWJ6E66flf+35+V
         icM0A0bgJmHlgln1a9DINUMWBd4BGHrAY5UNZaS+/XBluyOeisc4vUzaysKWUGFaU5Yw
         ZkUA==
X-Gm-Message-State: APjAAAV8NbcytezwdMHbCwNftrhs0HyHKiRMmuQL0cNNdTVRCo6Zkoq/
        wjf8f4c1fnY/qNBkRN27ZIk=
X-Google-Smtp-Source: APXvYqxHvyzfdMzTQ+OctWZ3zxXIPKkxBy6EqVnmpCrpy6kXaaZ/n0qKELoChdao34GKE6IFxkMnIA==
X-Received: by 2002:a62:3896:: with SMTP id f144mr2610163pfa.254.1572338118506;
        Tue, 29 Oct 2019 01:35:18 -0700 (PDT)
Received: from saurav ([27.62.167.137])
        by smtp.gmail.com with ESMTPSA id c6sm11830289pfj.59.2019.10.29.01.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 01:35:17 -0700 (PDT)
Date:   Tue, 29 Oct 2019 14:05:11 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, rfontana@redhat.com,
        saurav.girepunje@gmail.com, gregkh@linuxfoundation.org,
        allison@lohutok.net, tglx@linutronix.de,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] usb: clock.c : usb true/false for bool return type
Message-ID: <20191029083509.GA8293@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use true/false for bool type return in uac_clock_source_is_valid().

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 sound/usb/clock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 6b8c14f9b5d4..8b8ab83fac0d 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -165,21 +165,21 @@ static bool uac_clock_source_is_valid(struct snd_usb_audio *chip,
 			snd_usb_find_clock_source_v3(chip->ctrl_intf, source_id);
 
 		if (!cs_desc)
-			return 0;
+			return false;
 		bmControls = le32_to_cpu(cs_desc->bmControls);
 	} else { /* UAC_VERSION_1/2 */
 		struct uac_clock_source_descriptor *cs_desc =
 			snd_usb_find_clock_source(chip->ctrl_intf, source_id);
 
 		if (!cs_desc)
-			return 0;
+			return false;
 		bmControls = cs_desc->bmControls;
 	}
 
 	/* If a clock source can't tell us whether it's valid, we assume it is */
 	if (!uac_v2v3_control_is_readable(bmControls,
 				      UAC2_CS_CONTROL_CLOCK_VALID))
-		return 1;
+		return true;
 
 	err = snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0), UAC2_CS_CUR,
 			      USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
@@ -191,10 +191,10 @@ static bool uac_clock_source_is_valid(struct snd_usb_audio *chip,
 		dev_warn(&dev->dev,
 			 "%s(): cannot get clock validity for id %d\n",
 			   __func__, source_id);
-		return 0;
+		return false;
 	}
 
-	return !!data;
+	return !!data ? true :  false;
 }
 
 static int __uac_clock_find_source(struct snd_usb_audio *chip, int entity_id,
-- 
2.20.1

