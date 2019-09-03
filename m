Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06207C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D315F215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFphzrlX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbfICPH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:07:58 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:48349 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbfICPHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:07:54 -0400
Received: by mail-qk1-f202.google.com with SMTP id 11so7556023qkh.15
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zRWSVeb5W05ehvG18tGL2ilvhm06WavygbArZEKUTQI=;
        b=EFphzrlXR0Q3X5gcyhY/QpNLUIKGO6Mu86Y7KiyAnZSAJCuL+nBTfH/jlK5erD7K2r
         W8pEWRT1FseJg9jN2oX0QQ+pK6swlE6nXwrBZ6Wb5ategvz0WdbO4zdMpl4JlgBIHf2v
         IzNy2RHxCVLFsD+LRUIe4g3TZB+8D3g68RwEhZjlWK09mvWkkYF7Yd6gbZ943ljGv0Pe
         1AAxqU/OY+EFee6I23XvaOzyBbuR/9P9VIte/Y05WhkZZKwnXhu3vmyH8723rsuiufZI
         mLPqCZpvo8SV8k8H0mF6pGEksWdC7a3+5KSIrnkafdHCyITOpeyiUevIBhWx42asYq9T
         wNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zRWSVeb5W05ehvG18tGL2ilvhm06WavygbArZEKUTQI=;
        b=ZeYu+RoQIb0M7YhBt6q6txCcz4q4joJ7dP5TFUZlA4qttvgaFU9qYL3pr5kOY/ygBb
         4XXMcIrNfvswppzsI17B2/NoFN28L3/HBORgVlCuU05FdqPf4LhjyedImfoqBwqhs1SR
         Yln74EIirAHXeSc75iE49x8nUNMKxsbUuN8e5Lx4V1+5k3bmMxDLHIGeqlg7Vex9vlcN
         4/AjulLGS8rGcy0keMn69C6WvHGgFWTU2kKsYPp3VCEbRdHlYHBw/6tk+5ZjqddBzfDK
         T8oR/TmENhlfrj1glOe12GxhTjlgvJ7czfGkM77mtOYnzaE+wsPusfvFoqB/r3PZHBgj
         Ibew==
X-Gm-Message-State: APjAAAUHazmlP/MkdBmRYbtZsuAgaJCYBiQerJUA+I8e93Ckdz/MFdLQ
        9C5lHHI7L48TPaoXmhDyZ7aysBrzD3zLUbdlZiVGzKir0l8HttiVPtxZIsL9gs+8Luxy2Qa0dMi
        ABOEm2EL202hw7xy6WPRgfxRwNbG8yDNkagIt44Xdh2T/S9VaAkxu6EA52GP4wwZyPOV7+grDD3
        4=
X-Google-Smtp-Source: APXvYqwXLQ60AAfU9iVgSfT4ANntf+V9n3+Zm6PoQo1JQsqHzpyZDSgMHAEiaguzYB+Iw7z7S32mkOrSiVC1PQ==
X-Received: by 2002:ac8:5296:: with SMTP id s22mr17672802qtn.139.1567523273051;
 Tue, 03 Sep 2019 08:07:53 -0700 (PDT)
Date:   Tue,  3 Sep 2019 16:06:36 +0100
In-Reply-To: <20190903150638.242049-1-maennich@google.com>
Message-Id: <20190903150638.242049-11-maennich@google.com>
Mime-Version: 1.0
References: <20180716122125.175792-1-maco@android.com> <20190903150638.242049-1-maennich@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v4 10/12] usb-storage: remove single-use define for debugging
From:   Matthias Maennich <maennich@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, jeyu@kernel.org,
        joel@joelfernandes.org, lucas.de.marchi@gmail.com,
        maco@android.com, sspatil@google.com, will@kernel.org,
        yamada.masahiro@socionext.com, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB_STORAGE was defined as "usb-storage: " and used in a single location
as argument to printk. In order to be able to use the name
'USB_STORAGE', drop the definition and use the string directly for the
printk call.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Matthias Maennich <maennich@google.com>
---
 drivers/usb/storage/debug.h    | 2 --
 drivers/usb/storage/scsiglue.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/storage/debug.h b/drivers/usb/storage/debug.h
index 6d64f342f587..16ce06039a4d 100644
--- a/drivers/usb/storage/debug.h
+++ b/drivers/usb/storage/debug.h
@@ -29,8 +29,6 @@
 
 #include <linux/kernel.h>
 
-#define USB_STORAGE "usb-storage: "
-
 #ifdef CONFIG_USB_STORAGE_DEBUG
 void usb_stor_show_command(const struct us_data *us, struct scsi_cmnd *srb);
 void usb_stor_show_sense(const struct us_data *us, unsigned char key,
diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index 05b80211290d..df4de8323eff 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -379,7 +379,7 @@ static int queuecommand_lck(struct scsi_cmnd *srb,
 
 	/* check for state-transition errors */
 	if (us->srb != NULL) {
-		printk(KERN_ERR USB_STORAGE "Error in %s: us->srb = %p\n",
+		printk(KERN_ERR "usb-storage: Error in %s: us->srb = %p\n",
 			__func__, us->srb);
 		return SCSI_MLQUEUE_HOST_BUSY;
 	}
-- 
2.23.0.187.g17f5b7556c-goog

