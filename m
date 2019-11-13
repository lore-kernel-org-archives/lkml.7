Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D32C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E8C222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfKMLNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 06:13:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:44634 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727211AbfKMLNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 06:13:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31ABBB358;
        Wed, 13 Nov 2019 11:13:06 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Fix incorrect NULL check in create_yamaha_midi_quirk()
Date:   Wed, 13 Nov 2019 12:12:59 +0100
Message-Id: <20191113111259.24123-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 60849562a5db ("ALSA: usb-audio: Fix possible NULL
dereference at create_yamaha_midi_quirk()") added NULL checks in
create_yamaha_midi_quirk(), but there was an overlook.  The code
allows one of either injd or outjd is NULL, but the second if check
made returning -ENODEV if any of them is NULL.  Fix it in a proper
form.

Fixes: 60849562a5db ("ALSA: usb-audio: Fix possible NULL dereference at create_yamaha_midi_quirk()")
Reported-by: Pavel Machek <pavel@denx.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 0bbe1201a6ac..349e1e52996d 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -248,8 +248,8 @@ static int create_yamaha_midi_quirk(struct snd_usb_audio *chip,
 					NULL, USB_MS_MIDI_OUT_JACK);
 	if (!injd && !outjd)
 		return -ENODEV;
-	if (!(injd && snd_usb_validate_midi_desc(injd)) ||
-	    !(outjd && snd_usb_validate_midi_desc(outjd)))
+	if ((injd && !snd_usb_validate_midi_desc(injd)) ||
+	    (outjd && !snd_usb_validate_midi_desc(outjd)))
 		return -ENODEV;
 	if (injd && (injd->bLength < 5 ||
 		     (injd->bJackType != USB_MS_EMBEDDED &&
-- 
2.16.4

