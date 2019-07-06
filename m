Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E656C468AD
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 09:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777D8216B7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 09:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eng.ucsd.edu header.i=@eng.ucsd.edu header.b="dg+5O6A3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfGFJXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 05:23:49 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33030 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfGFJXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 05:23:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id h10so11387891ljg.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 02:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eng.ucsd.edu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ALgZ6/TH1TMMHtthc8F5W9I7v5d4Oi+UuqN4eyBdrw4=;
        b=dg+5O6A3uPa8xOtRcfFX0oHBjZZWZV5meMagQazqVO4+KShJachCtOw9uhwUsdM5LM
         KEYjIyZskOEqbXsRqnT1N4mdlT4aFScBIFJQH7WYEl/LJMAvvunpegz9vo/mbpjsUeDO
         VXvw3VKSj/qH3kKUOmNJIuwxsgk+QRg9tia5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ALgZ6/TH1TMMHtthc8F5W9I7v5d4Oi+UuqN4eyBdrw4=;
        b=Mnkz8Og0/SH68GKhdNv2odv7nDMmMfuF/4ZpgpmoMezd/W12X+jxn60Q4dlDPya6Uh
         bINbeBrU35mljL0qWeVgm5VROCqeTCaXeoN8jW80A9I6GPf2KVV6jeWyw+1ZZPKZYHDu
         The4OrAZtdkQB58YVfGDHfQaDcJ671/cjWFm9WgxICZCqBSSgVmCATTqgeiZb4aiC7JQ
         W8zhmELDCry6eN9dj+ZlArTa50mlFWst0hSTcYKGGFLA2euorDq7E06pcbEX2RLA0NtL
         5uw6Nz3kr76dEc6VEQ9H4G+cyq72FsF5uy8+ezrIa0Wf3bUBcDY6pFb+xst1PHp5SqMe
         bCsQ==
X-Gm-Message-State: APjAAAUKfqho/s3OItmQR+fJB2Kk2WX6s5F1q+S/0I+VVvv3D18/6Tw+
        +TVh8YCyfrcbXfliW6GgfTmW0w==
X-Google-Smtp-Source: APXvYqw1ntoBeZnHh/HrOwmD43yT4LAlmjebxU5w4jF8XDt6jcy1ycTShdBv5CNWP/NlmqE0uhqfgA==
X-Received: by 2002:a2e:894a:: with SMTP id b10mr3893454ljk.99.1562405026913;
        Sat, 06 Jul 2019 02:23:46 -0700 (PDT)
Received: from luke-XPS-13 (77-255-206-190.adsl.inetia.pl. [77.255.206.190])
        by smtp.gmail.com with ESMTPSA id 137sm2278544ljj.46.2019.07.06.02.23.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Jul 2019 02:23:46 -0700 (PDT)
Date:   Sat, 6 Jul 2019 02:23:43 -0700
From:   Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
To:     hverkuil@xs4all.nl
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH RESEND] media: hdpvr: Add device num check and handling
Message-ID: <20190706092343.GA5462@luke-XPS-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hdpvr device num check and error handling

We need to increment the device count atomically before we checkout a
device to make sure that we do not reach the max count, otherwise we get
out-of-bounds errors as reported by syzbot. 

Reported-and-tested-by: syzbot+aac8d0d7205f112045d2@syzkaller.appspotmail.com
Signed-off-by: Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
---
Changes in V1:
+ add storing of incremented index in dev_num var
+ add bounds check on dev_num and appropriate error handling
- remove attomic_inc_return from inside of hdpvr_register call

 drivers/media/usb/hdpvr/hdpvr-core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/hdpvr/hdpvr-core.c b/drivers/media/usb/hdpvr/hdpvr-core.c
index 29ac7fc5b039..640ef83b57c9 100644
--- a/drivers/media/usb/hdpvr/hdpvr-core.c
+++ b/drivers/media/usb/hdpvr/hdpvr-core.c
@@ -275,6 +275,7 @@ static int hdpvr_probe(struct usb_interface *interface,
 #endif
 	size_t buffer_size;
 	int i;
+	int dev_num;
 	int retval = -ENOMEM;
 
 	/* allocate memory for our device state and initialize it */
@@ -371,9 +372,18 @@ static int hdpvr_probe(struct usb_interface *interface,
 		goto reg_fail;
 	}
 #endif
-
+
+	dev_num = atomic_inc_return(&dev_nr);
+	if (dev_num >= HDPVR_MAX) {
+		v4l2_err(&dev->v4l2_dev,
+			 "max device number reached, device register failed\n");
+		atomic_dec(&dev_nr);
+		retval = -ENODEV;
+		goto reg_fail;
+	}
+
 	retval = hdpvr_register_videodev(dev, &interface->dev,
-				    video_nr[atomic_inc_return(&dev_nr)]);
+				    video_nr[dev_num]);
 	if (retval < 0) {
 		v4l2_err(&dev->v4l2_dev, "registering videodev failed\n");
 		goto reg_fail;
-- 
2.20.1

