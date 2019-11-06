Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D229C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A8E2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbfKFL7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 06:59:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:38930 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728716AbfKFL7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:59:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02267B162;
        Wed,  6 Nov 2019 11:59:00 +0000 (UTC)
Message-ID: <1573040577.3090.22.camel@suse.com>
Subject: Re: [PATCH] usb: appledisplay: fix use-after-free in
 bl_get_brightness
From:   Oliver Neukum <oneukum@suse.com>
To:     Phong Tran <tranmanphong@gmail.com>,
        syzbot+495dab1f175edc9c2f13@syzkaller.appspotmail.com
Cc:     2pi@mok.nu, alex.theissen@me.com, andreyknvl@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Wed, 06 Nov 2019 12:42:57 +0100
In-Reply-To: <20191105233652.21033-1-tranmanphong@gmail.com>
References: <00000000000042d60805933945b5@google.com>
         <20191105233652.21033-1-tranmanphong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 06.11.2019, 06:36 +0700 schrieb Phong Tran:
> In context of USB disconnect, the delaywork trigger and calling
> appledisplay_bl_get_brightness() and the msgdata was freed.
> 
> add the checking return value of usb_control_msg() and only update the
> data while the retval is valid.

Hi,

I am afraid there are some issues with your patch. First, let me stress
that you found the right place to fix an issue and you partially fixed
an issue. But the the fix you applied is incomplete and left another
issue open.

Your patch still allows doing IO to a device that may already be bound
to another driver. That is bad, especially as the buffer is already
free. Yes, if IO is failing, you have fixed that narrow issue.
But it need not fail.

If you look into appledisplay_probe() you will see that it can fail
because backlight_device_register() fails. The error handling will
thereupon kill the URB and free memory. But it will not kill an already
scheduled work. The scheduled work will then call usb_control_msg()
on pdata->msgdata, which has been freed. If that IO fails, all is well.
If not, the issue still exists.

Secondly, your error check is off by 2. You are checking only for
usb_control_msg() failing. But it can return only one byte instead
of two. If that happens, the value you return is stale, although
the buffer is correctly allocated.

	Regards
		Oliver

The correct fix for both issues would be:

#syz test: https://github.com/google/kasan.git e0bd8d79

From 2497a62bdbeb9bd94f690c22d96dd1b8cf22861f Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oneukum@suse.com>
Date: Wed, 6 Nov 2019 12:36:28 +0100
Subject: [PATCH] appledisplay: fix error handling in the scheduled work

The work item can operate on

1. stale memory left over from the last transfer
the actual length of the data transfered needs to be checked
2. memory already freed
the error handling in appledisplay_probe() needs
to cancel the work in that case

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/usb/misc/appledisplay.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/appledisplay.c b/drivers/usb/misc/appledisplay.c
index ac92725458b5..ba1eaabc7796 100644
--- a/drivers/usb/misc/appledisplay.c
+++ b/drivers/usb/misc/appledisplay.c
@@ -164,7 +164,12 @@ static int appledisplay_bl_get_brightness(struct backlight_device *bd)
 		0,
 		pdata->msgdata, 2,
 		ACD_USB_TIMEOUT);
-	brightness = pdata->msgdata[1];
+	if (retval < 2) {
+		if (retval >= 0)
+			retval = -EMSGSIZE;
+	} else {
+		brightness = pdata->msgdata[1];
+	}
 	mutex_unlock(&pdata->sysfslock);
 
 	if (retval < 0)
@@ -299,6 +304,7 @@ static int appledisplay_probe(struct usb_interface *iface,
 	if (pdata) {
 		if (pdata->urb) {
 			usb_kill_urb(pdata->urb);
+			cancel_delayed_work_sync(&pdata->work);
 			if (pdata->urbdata)
 				usb_free_coherent(pdata->udev, ACD_URB_BUFFER_LEN,
 					pdata->urbdata, pdata->urb->transfer_dma);
-- 
2.16.4


