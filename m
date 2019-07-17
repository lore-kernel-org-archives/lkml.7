Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E42C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE6D421841
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eng.ucsd.edu header.i=@eng.ucsd.edu header.b="GbAckFZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfGQOTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 10:19:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39395 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbfGQOTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 10:19:49 -0400
Received: by mail-lj1-f194.google.com with SMTP id v18so23791041ljh.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 07:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eng.ucsd.edu; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ALgZ6/TH1TMMHtthc8F5W9I7v5d4Oi+UuqN4eyBdrw4=;
        b=GbAckFZo8/FhS/sr0TgjOzcalYCkcrFtP/AfWtc1bYXaMcwMOhHoBYlG+eYqMNRKXF
         EARfkktXu8aBMkttzbAGOJy1LM8bVJX1FK40HivMaxhUz+zRbo4WdGN+OAXNFTjMCKkr
         S8FsublwaWgzchrOJhjHU4uJ7Fzuo5dSJTRug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ALgZ6/TH1TMMHtthc8F5W9I7v5d4Oi+UuqN4eyBdrw4=;
        b=bvx6sZR+KLHi8tG55qi381AVexWWoaaENNJORNxNqzxTTZNUyw5L4Zrd64CN6RTD+Z
         kUcRD6ZOFvqCw72v9yCU3FZ6d7Fet72CBoL1pSeUi5U4wyPI/OG1sQQc3PJtf4uLz7+0
         F0/1NbUHomQOZmcs5yfpeyE6McaGb/jYkmQa4JX78nz2b0333HoX4mqxEg0hMYg+VlRK
         pN1O+X6vDXfSO4VMFc+A5OuaWEPU9Seiec7LcB7uDuRFPPmSPGFcjlW9UPO/DEY+coxi
         039QQJiaXM8XPPJPqeWh3eJqfO2nQSt8fkcPAd0LUD2hh6XJ899bDVptFDvs5e2zJJAL
         uQ6Q==
X-Gm-Message-State: APjAAAW/tmjXHvZvjGmjYInpkf9BXyE62hFdtxPf6EN6CaaTdHnbif24
        o6SKBQImOMv0HjVddDrW5fNXqA==
X-Google-Smtp-Source: APXvYqwBzJU+cWYO8PFAuszGvqL1iHP55OUYcRy+L0Sv2NnLdeDvpD6Z/2RqZi2sbUge04iKjAYLRA==
X-Received: by 2002:a2e:8756:: with SMTP id q22mr21364419ljj.108.1563373187770;
        Wed, 17 Jul 2019 07:19:47 -0700 (PDT)
Received: from [192.168.1.2] (178-37-168-43.adsl.inetia.pl. [178.37.168.43])
        by smtp.gmail.com with ESMTPSA id d3sm3472935lfb.92.2019.07.17.07.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 07:19:47 -0700 (PDT)
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
From:   Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
Subject: [PATCH RESEND] media: hdpvr: Add device num check and handling
Message-ID: <757f11e5-8463-4f48-1f42-1ecf9bd0a86e@eng.ucsd.edu>
Date:   Wed, 17 Jul 2019 07:19:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
