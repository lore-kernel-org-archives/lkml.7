Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813ADC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F02F218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LfcUThih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfFSPYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:24:13 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:40858 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfFSPYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:24:13 -0400
Received: by mail-qk1-f202.google.com with SMTP id c1so14660695qkl.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 08:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8JkBGLTmIvJ3qsE79AaFBP8DQoZLm77gpsr17OF6DbA=;
        b=LfcUThih9a14fTjhWiK2T4bwmz+w0Twk6p4g4B+vyf/QxY73hWvRImoKSI6TQas9t5
         lrCONVWXx/t8Gu8Ag9QO6bkt+GUHStvWCvV53z2hhA4QEVf+muQtZezlYMkxpV3gGMup
         9AdYd5qPjYKO4+4iFYt4ZHf3i8CxutQU5EOQ7SemKJxaJ0tvSADEbKcaNQIcvp3eQxXa
         2TlhU6OANOoAaCRuG8CWzNJn05El/MjdYvKGnkJaANrCfa3vPedp1RnZDKB9PnBVO/pc
         XXmlWDF9ggjQ1n7fzipBcTpDPP3h4MtwlNB7mbrmLjEyFULNmKXLBKhidGc6KrGSCzCv
         IG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8JkBGLTmIvJ3qsE79AaFBP8DQoZLm77gpsr17OF6DbA=;
        b=KZAfaa0tX+KOBogPSGcozaYUjXCIPYnbALf6fVUXsmVRroMv4gwyN5SrcRfXZKHAMO
         0T1kwlX856VkAR5fp1DmLaeGgLPrU6e3VLMLlHIjZzXZ0RKCSLJv3GUL27ZXpLukgyXD
         wrb8+y85MmrimDGFkObBw4Zi51ykjn/weQi+SugJ2PYttCrGUBC2g5cEPlR2lC+zHCTH
         6MUh2RzDVXQv/aL2zgPyTe8cnVxJDPX3xa2VaKlO6oBsupsuEs5lDAC9OWBS7j+DQVkl
         S2wH2nW/npeoH0nJgEeE70h4vs9rurcFNaeVzkQJNttIJY6FOWvA/K+uF5DUTjGsQtyL
         8C0Q==
X-Gm-Message-State: APjAAAX04CLnSmN+obi/EwkeVMabOMQzedbUGWSHm6KQAwTFSevYX8OP
        4DM8a/JTD6lCvPnXB6Hm3H+AbB5zYicUIKAZ
X-Google-Smtp-Source: APXvYqy0SZQS1AL6A/Ot5Mo5MT4g/NFmCrgVXvyqFGi3mhXJRMnt8rsSeUUIYH6SgI+DXkRVh75mFMrQRMwm7Akw
X-Received: by 2002:ac8:2834:: with SMTP id 49mr88206358qtq.326.1560957851972;
 Wed, 19 Jun 2019 08:24:11 -0700 (PDT)
Date:   Wed, 19 Jun 2019 17:24:07 +0200
Message-Id: <6d36cd9fd0a0102a438cafa903dcf3d6fc44937f.1560957802.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH RESUBMIT] media: pvrusb2: use a different format for warnings
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Mike Isely <isely@pobox.com>, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        syzbot+af8f8d2ac0d39b0ed3a0@syzkaller.appspotmail.com,
        syzbot+170a86bf206dd2c6217e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the pvrusb2 driver detects that there's something wrong with the
device, it prints a warning message. Right now those message are
printed in two different formats:

1. ***WARNING*** message here
2. WARNING: message here

There's an issue with the second format. Syzkaller recognizes it as a
message produced by a WARN_ON(), which is used to indicate a bug in the
kernel. However pvrusb2 prints those warnings to indicate an issue with
the device, not the bug in the kernel.

This patch changes the pvrusb2 driver to consistently use the first
warning message format. This will unblock syzkaller testing of this
driver.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: syzbot+af8f8d2ac0d39b0ed3a0@syzkaller.appspotmail.com
Reported-by: syzbot+170a86bf206dd2c6217e@syzkaller.appspotmail.com
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c      | 4 ++--
 drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c | 6 +++---
 drivers/media/usb/pvrusb2/pvrusb2-std.c      | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
index 816c85786c2a..191439109788 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
@@ -1680,7 +1680,7 @@ static int pvr2_decoder_enable(struct pvr2_hdw *hdw,int enablefl)
 	}
 	if (!hdw->flag_decoder_missed) {
 		pvr2_trace(PVR2_TRACE_ERROR_LEGS,
-			   "WARNING: No decoder present");
+			   "***WARNING*** No decoder present");
 		hdw->flag_decoder_missed = !0;
 		trace_stbit("flag_decoder_missed",
 			    hdw->flag_decoder_missed);
@@ -2366,7 +2366,7 @@ struct pvr2_hdw *pvr2_hdw_create(struct usb_interface *intf,
 	if (hdw_desc->flag_is_experimental) {
 		pvr2_trace(PVR2_TRACE_INFO, "**********");
 		pvr2_trace(PVR2_TRACE_INFO,
-			   "WARNING: Support for this device (%s) is experimental.",
+			   "***WARNING*** Support for this device (%s) is experimental.",
 							      hdw_desc->description);
 		pvr2_trace(PVR2_TRACE_INFO,
 			   "Important functionality might not be entirely working.");
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c b/drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c
index 8f023085c2d9..43e54bdbd4aa 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c
@@ -343,11 +343,11 @@ static int i2c_hack_cx25840(struct pvr2_hdw *hdw,
 
 	if ((ret != 0) || (*rdata == 0x04) || (*rdata == 0x0a)) {
 		pvr2_trace(PVR2_TRACE_ERROR_LEGS,
-			   "WARNING: Detected a wedged cx25840 chip; the device will not work.");
+			   "***WARNING*** Detected a wedged cx25840 chip; the device will not work.");
 		pvr2_trace(PVR2_TRACE_ERROR_LEGS,
-			   "WARNING: Try power cycling the pvrusb2 device.");
+			   "***WARNING*** Try power cycling the pvrusb2 device.");
 		pvr2_trace(PVR2_TRACE_ERROR_LEGS,
-			   "WARNING: Disabling further access to the device to prevent other foul-ups.");
+			   "***WARNING*** Disabling further access to the device to prevent other foul-ups.");
 		// This blocks all further communication with the part.
 		hdw->i2c_func[0x44] = NULL;
 		pvr2_hdw_render_useless(hdw);
diff --git a/drivers/media/usb/pvrusb2/pvrusb2-std.c b/drivers/media/usb/pvrusb2/pvrusb2-std.c
index 6b651f8b54df..37dc299a1ca2 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-std.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-std.c
@@ -353,7 +353,7 @@ struct v4l2_standard *pvr2_std_create_enum(unsigned int *countptr,
 		bcnt = pvr2_std_id_to_str(buf,sizeof(buf),fmsk);
 		pvr2_trace(
 			PVR2_TRACE_ERROR_LEGS,
-			"WARNING: Failed to classify the following standard(s): %.*s",
+			"***WARNING*** Failed to classify the following standard(s): %.*s",
 			bcnt,buf);
 	}
 
-- 
2.22.0.410.gd8fdbe21b5-goog

