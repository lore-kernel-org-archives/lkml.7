Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BCFCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07EE205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMG+GuYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfJ2RwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 13:52:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46037 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfJ2RwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:52:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1so10059608pgj.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 10:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WQuaGhw+j/L1GECLdxkL+IQAboSwYNwdTLYnLHvyPs8=;
        b=eMG+GuYW0OmhY6ro8Yeeu1abzM+LR/mzcdQEofubIIHWWpsksdJybinfj19OxIPIfV
         2F/h4pVMuFWoK3OZR3aNK1N4LvBM7hwCpwHrGOrnTBTeA2l5MGwLpBXNxolXYTiNdsZi
         +r4xnfjZcf1F1AD7+FotPnmSKvKT7FJ9ke0Cx0M1wpcO019m9SRWj5DrvPDBk80byObM
         V8J6Fdc6HN4gB319c6v7TulUONDQuiWf8aCtAgkNddCyesnMvBkfqPdePR7LguFh3xTW
         Vr+atD2bGf7HMjywS1koa0GnrKT58QtG6hLSFE5+uuT4djFo80FRXdp2bYwLJ61Wuars
         jJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WQuaGhw+j/L1GECLdxkL+IQAboSwYNwdTLYnLHvyPs8=;
        b=SfhF7WhEsPl1nPtQ8IT49I4NkNQaHEBqtr5yQfrsTWD0Car70YecyxuxlDLo9y2+mZ
         p7bv7TOnJYvRQ3D6rbXo1fH7oAR2iGI2gDHgdNEpuCD9Zt5CCKxVoay3wKRbfwEJG8+Q
         nK+wmX2g2No/+JNNbD6HJsu2iTO+iVmsQCZt3Ua1JGAamuaTQrXUdAknaiJmMgyHgDvt
         a2AJWFMKJ5TSsPpCIct1J7xO94tIYqmOTPNXBkuJj1c55/cYEds2MA2CLBW3lCta+/7V
         Ukj56aGWYBIwlqXaQbd08b3w9vnmyXPqRHObR24TRhAsUJU81K1gTeXnI00xXktuRzky
         Y8dw==
X-Gm-Message-State: APjAAAVSpv5Vav4boDNAWDqvkqiX04OEpF5/4T74QYrIgM8cguxji8wz
        izfJZKHkfB1mfMnqBwdv4fA=
X-Google-Smtp-Source: APXvYqzrSQsPEEJLMY2h97BAVghXEBeEsEuCaCOuF7o17Uq27bil0is02/pulRLMZFnxkezDHUGo2Q==
X-Received: by 2002:a17:90a:1424:: with SMTP id j33mr8490846pja.2.1572371528296;
        Tue, 29 Oct 2019 10:52:08 -0700 (PDT)
Received: from saurav ([117.232.226.35])
        by smtp.gmail.com with ESMTPSA id m17sm8901042pfh.79.2019.10.29.10.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 10:52:07 -0700 (PDT)
Date:   Tue, 29 Oct 2019 23:22:00 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, allison@lohutok.net,
        rfontana@redhat.com, saurav.girepunje@gmail.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH v1] ALSA: usb-audio: sound: usb: usb true/false for bool
 return type
Message-ID: <20191029175200.GA7320@saurav>
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

Changes in v1:

	- Update the patch subject suggested by Takashi Iwai <tiwai@suse.de>

        - Drop "!!" but keep the ternary operator in last return
          statement so that function will return always true/false.
 
 sound/usb/clock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 72e9bdf76115..8d5538063598 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -167,21 +167,21 @@ static bool uac_clock_source_is_valid(struct snd_usb_audio *chip,
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
@@ -193,10 +193,10 @@ static bool uac_clock_source_is_valid(struct snd_usb_audio *chip,
 		dev_warn(&dev->dev,
 			 "%s(): cannot get clock validity for id %d\n",
 			   __func__, source_id);
-		return 0;
+		return false;
 	}
 
-	return !!data;
+	return data ? true :  false;
 }
 
 static int __uac_clock_find_source(struct snd_usb_audio *chip, int entity_id,
-- 
2.20.1

