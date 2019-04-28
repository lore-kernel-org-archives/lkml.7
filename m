Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E37C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263692075D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="BLfbkACX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfD1Gmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 02:42:51 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:34356 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfD1Gmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 02:42:51 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 3C550DE9
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 06:42:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9lyHaMZ9NyvA for <linux-kernel@vger.kernel.org>;
        Sun, 28 Apr 2019 01:42:49 -0500 (CDT)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 1765DDD6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 01:42:49 -0500 (CDT)
Received: by mail-it1-f200.google.com with SMTP id o197so6892901ito.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 23:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dCtKX+pD+Z8ECSwxAGND0lenK4rzuRAysijRT4r9928=;
        b=BLfbkACXnG8TpTRmYKunbL4CiOzxnkePBMfwtdcdWl/kIXhCjOcI2YON9uEroEIqJI
         ebb9TwPy7EM6XMXLnsSsQhjQisHlXBE3JVTXONzd8U/GgpsYIh/oy2EXZp8sv4VZc6za
         JEQeRFCSmta12GJYWplyzHEv6oUKZT9WW7O2AQviCtzOYS877DSfNTwWb9tV6/BzyjRc
         EmCcVvjh8KvHxHoBAUYIl3vlQKd2q/kDxfxHC9wlKtF46gBX4Wu2wgP68etGawyW/NUV
         evya0qtasnMW0gQ+g8TftViBwUE8QihBzDG7tIqLxo+r9E+JPvUs0o6e6kgZRMUyp4i0
         9WhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dCtKX+pD+Z8ECSwxAGND0lenK4rzuRAysijRT4r9928=;
        b=NBtRHY84Z0rDRpD012jfINj9VXBPlc62UNT1bb/K7PdLclgy79agDMYBCCojZG8deY
         PIVHIs0/fhaNNQbNHnHJHadbjPhnATukzzb+mjkk+aBjyRfno3RnBAvFcql4+2gzLphG
         EaX15jWOfOCDdlTG8KXkhOFQiPXjOjcoUNRZHARLVkUzLX6Uw/b7vUUicP06cLpNoFdi
         K51pdBvx9uwiAz8nyydunDGZC6mmGfUUo4vmG38gKRc/jSDPIV0xxPFEgLU4K/BLFf6k
         ofzKpYf95cAlAVgRUleRCKpr8BUJv3w9X9K3gOwHwpKIeAT6TO98FBYK3OIwsbkBRLGy
         B1lQ==
X-Gm-Message-State: APjAAAUTy67ZpX60X77gJUnMntJFElBM3At0rL/ESxFoaI64czc7jGSS
        Mrl7N2w5fl/5gedZnqarnfvJjQ+MQDh0PUuwslLYWV3DPtUfzQ62uTctsloGEwhG5tA+eRFCfql
        QMA8t70AAyPMU3T5HGshQoHD9tRnq
X-Received: by 2002:a24:ba15:: with SMTP id p21mr16196062itf.66.1556433768778;
        Sat, 27 Apr 2019 23:42:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxUO3Awb5bzEO7UyKRhdDNml7dECRtpXHtvd8+lHTvuTLGI8LZQeT2b8BcU6XhYLp8xz1oo6g==
X-Received: by 2002:a24:ba15:: with SMTP id p21mr16196059itf.66.1556433768619;
        Sat, 27 Apr 2019 23:42:48 -0700 (PDT)
Received: from cs-u-cslp16.dtc.umn.edu (cs-u-cslp16.cs.umn.edu. [128.101.106.40])
        by smtp.gmail.com with ESMTPSA id k131sm4139784iof.82.2019.04.27.23.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Apr 2019 23:42:47 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kees Cook <keescook@chromium.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: usx2y: fix a memory leak bug
Date:   Sun, 28 Apr 2019 01:42:32 -0500
Message-Id: <1556433754-3291-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In usX2Y_In04_init(), a new urb is firstly created through usb_alloc_urb()
and saved to 'usX2Y->In04urb'. Then, a buffer is allocated through
kmalloc() and saved to 'usX2Y->In04Buf'. After the urb is initialized, a
sanity check is performed for the endpoint in the urb by invoking
usb_urb_ep_type_check(). If the check fails, the error code EINVAL will be
returned. In that case, however, the created urb and the allocated buffer
are not freed, leading to memory leaks.

To fix the above issue, free the urb and the buffer if the check fails.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 sound/usb/usx2y/usbusx2y.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index da4a5a5..0817018 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -303,8 +303,11 @@ int usX2Y_In04_init(struct usX2Ydev *usX2Y)
 			 usX2Y->In04Buf, 21,
 			 i_usX2Y_In04Int, usX2Y,
 			 10);
-	if (usb_urb_ep_type_check(usX2Y->In04urb))
+	if (usb_urb_ep_type_check(usX2Y->In04urb)) {
+		kfree(usX2Y->In04Buf);
+		usb_put_urb(usX2Y->In04urb);
 		return -EINVAL;
+	}
 	return usb_submit_urb(usX2Y->In04urb, GFP_KERNEL);
 }
 
-- 
2.7.4

