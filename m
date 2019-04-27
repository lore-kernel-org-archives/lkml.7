Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54F0C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48AB206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfD0PPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:15:14 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60588 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbfD0PPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:10 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0000zA-ED; Sat, 27 Apr 2019 16:15:07 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0004O2-7i; Sat, 27 Apr 2019 16:15:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Takashi Iwai" <tiwai@suse.de>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.447335859@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 006/202] ALSA: usb-audio: Avoid access before bLength
 check in build_audio_procunit()
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit f4351a199cc120ff9d59e06d02e8657d08e6cc46 upstream.

The parser for the processing unit reads bNrInPins field before the
bLength sanity check, which may lead to an out-of-bound access when a
malformed descriptor is given.  Fix it by assignment after the bLength
check.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/usb/mixer.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1787,7 +1787,7 @@ static int build_audio_procunit(struct m
 				char *name)
 {
 	struct uac_processing_unit_descriptor *desc = raw_desc;
-	int num_ins = desc->bNrInPins;
+	int num_ins;
 	struct usb_mixer_elem_info *cval;
 	struct snd_kcontrol *kctl;
 	int i, err, nameid, type, len;
@@ -1802,7 +1802,13 @@ static int build_audio_procunit(struct m
 		0, NULL, default_value_info
 	};
 
-	if (desc->bLength < 13 || desc->bLength < 13 + num_ins ||
+	if (desc->bLength < 13) {
+		usb_audio_err(state->chip, "invalid %s descriptor (id %d)\n", name, unitid);
+		return -EINVAL;
+	}
+
+	num_ins = desc->bNrInPins;
+	if (desc->bLength < 13 + num_ins ||
 	    desc->bLength < num_ins + uac_processing_unit_bControlSize(desc, state->mixer->protocol)) {
 		usb_audio_err(state->chip, "invalid %s descriptor (id %d)\n", name, unitid);
 		return -EINVAL;

