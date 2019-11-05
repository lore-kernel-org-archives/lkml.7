Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D53C5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132B1217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7otIGjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfKEXhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:37:04 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39972 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbfKEXhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 18:37:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id 15so15744839pgt.7;
        Tue, 05 Nov 2019 15:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jbOa8JF4MBQR2lZ6+xvcROFm9Impr2oKxSGxSOq96pg=;
        b=T7otIGjNM+rxJdQzdyBGLkV3wlSlK0ERKVBdMp3P/gK3s8k6YB+I9PX7WzR8GXVgPY
         FsORAyvugQ6ORE7htS3hSbnu6mVPwgJ5be3ZCjHR7OYWjOlp9F1CX23SX7pjXwoluPMh
         WEctsoRPF2XL7IV3Dnt249ls5LKiykIvFKx8LsdSwsfwXg4Hwi6AuBTpWNSWoGHBTwl6
         sbLonNw5C5GbYtxU8DGyl93/qHK/zUp+qP3cr6lpPzXNHR51cXMHYniT0Tt0AuBcnuoC
         vDTD3T5tfU4Ryc5DIDSAfRwjVavmYUq1TFL7QbVKwuu7WujskeUg5vOzIjOQNpTmzs5p
         gsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jbOa8JF4MBQR2lZ6+xvcROFm9Impr2oKxSGxSOq96pg=;
        b=ICHwwKcWwVhwEMEt7VkLaNf0aHOLS5Lu8AyDPMpRL2sUBu7WEZHmF+FKs3uOe6wFOs
         8sdDh2jumUupoG4ojpawUvjUUmJIQtb0lI5rtFbLdg09r3l+9gr+BkAfoayVGw9sAdPZ
         cHRRCZTGbluP93tJKI4zV1ULnBBd22LCDkshHrkn3qLHwDWCguZxVG/M1qy85UV4ji1U
         fSDhARonZuEkK7LtADCYzXrh+gnCnKiiRRNMhd7EYwL24WtiV9FXFQOGfUthwMcLUbPX
         RzIu6QEN0OOOquzky+E3QaEbmnlo/d8TYT0mNuG5nMeAiSVKvCRAq1/SFSibfKRSzm5H
         yUfw==
X-Gm-Message-State: APjAAAWWSuMKcGij5u7eCw+3Ja1VhOlyRZ3pSALu7/jPquI4no+Ivs94
        9mseGOG/RrFHvbLdSBK4CE8=
X-Google-Smtp-Source: APXvYqy6TnDZoAcLevkCQceDlWjiDNaPRoDljt1Fyg09m4mm28L5Wnv+mQ2DQxrQ9qKmM8wKNTktYg==
X-Received: by 2002:a17:90a:25e1:: with SMTP id k88mr2298501pje.14.1572997022758;
        Tue, 05 Nov 2019 15:37:02 -0800 (PST)
Received: from debian.net.fpt ([2405:4800:58f7:3f8f:27cb:abb4:d0bd:49cb])
        by smtp.gmail.com with ESMTPSA id y22sm13641688pfn.6.2019.11.05.15.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 15:37:01 -0800 (PST)
From:   Phong Tran <tranmanphong@gmail.com>
To:     syzbot+495dab1f175edc9c2f13@syzkaller.appspotmail.com
Cc:     2pi@mok.nu, alex.theissen@me.com, andreyknvl@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH] usb: appledisplay: fix use-after-free in bl_get_brightness
Date:   Wed,  6 Nov 2019 06:36:52 +0700
Message-Id: <20191105233652.21033-1-tranmanphong@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <00000000000042d60805933945b5@google.com>
References: <00000000000042d60805933945b5@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In context of USB disconnect, the delaywork trigger and calling
appledisplay_bl_get_brightness() and the msgdata was freed.

add the checking return value of usb_control_msg() and only update the
data while the retval is valid.

Reported-by: syzbot+495dab1f175edc9c2f13@syzkaller.appspotmail.com
Reported-and-tested-by:
syzbot+495dab1f175edc9c2f13@syzkaller.appspotmail.com

https://groups.google.com/d/msg/syzkaller-bugs/dRmkh2UYusY/l2a6Mg3FAQAJ

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 drivers/usb/misc/appledisplay.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/appledisplay.c b/drivers/usb/misc/appledisplay.c
index ac92725458b5..3e3dfa5a3954 100644
--- a/drivers/usb/misc/appledisplay.c
+++ b/drivers/usb/misc/appledisplay.c
@@ -164,7 +164,8 @@ static int appledisplay_bl_get_brightness(struct backlight_device *bd)
 		0,
 		pdata->msgdata, 2,
 		ACD_USB_TIMEOUT);
-	brightness = pdata->msgdata[1];
+	if (retval >= 0)
+		brightness = pdata->msgdata[1];
 	mutex_unlock(&pdata->sysfslock);
 
 	if (retval < 0)
-- 
2.20.1

