Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95897C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF2422CEA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620807;
	bh=T6X5eR2XhJprV6XznDa1AjWyiWhDWpBUUCRPWS0OZuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jE8mZZlQJ/69ncmEjeKAqovOyvheH9M573yOeXJY2B06ihfyGvqMUWcmhnHU+iylM
	 N+TGF0YVDMMoHADKNx5lhnP5vknT0DfaQibzwpxmpDDQ6U1P/XL0llSgj9/Jo1p5PT
	 BkPjMLhaS1JqggWXFgzKrqaMYk/VIiRUNaphwqFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390686AbfIDSN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390669AbfIDSNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:13:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E40E22CEA;
        Wed,  4 Sep 2019 18:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620803;
        bh=T6X5eR2XhJprV6XznDa1AjWyiWhDWpBUUCRPWS0OZuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C4e2PVWZVujLx4kOzCzz7FpEcJpX2JWoUsE2S/E/DRZyGmkYffRmU5eyQ+u1V4eyv
         1b8OKXFAYeZudyR37vcJN9CtJW5U3V/PwhKaMVyW915bVztwP83xLmzxg0nxUM/d24
         metUte/chnmJy3GWqoR2k5Jikk+RArsC6yjXRRmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.2 060/143] ALSA: usb-audio: Check mixer unit bitmap yet more strictly
Date:   Wed,  4 Sep 2019 19:53:23 +0200
Message-Id: <20190904175316.421126487@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175314.206239922@linuxfoundation.org>
References: <20190904175314.206239922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit f9f0e9ed350e15d51ad07364b4cf910de50c472a upstream.

The bmControls (for UAC1) or bmMixerControls (for UAC2/3) bitmap has a
variable size depending on both input and output pins.  Its size is to
fit with input * output bits.  The problem is that the input size
can't be determined simply from the unit descriptor itself but it
needs to parse the whole connected sources.  Although the
uac_mixer_unit_get_channels() tries to check some possible overflow of
this bitmap, it's incomplete due to the lack of the  evaluation of
input pins.

For covering possible overflows, this patch adds the bitmap overflow
check in the loop of input pins in parse_audio_mixer_unit().

Fixes: 0bfe5e434e66 ("ALSA: usb-audio: Check mixer unit descriptors more strictly")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/mixer.c |   36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -739,7 +739,6 @@ static int uac_mixer_unit_get_channels(s
 				       struct uac_mixer_unit_descriptor *desc)
 {
 	int mu_channels;
-	void *c;
 
 	if (desc->bLength < sizeof(*desc))
 		return -EINVAL;
@@ -762,13 +761,6 @@ static int uac_mixer_unit_get_channels(s
 		break;
 	}
 
-	if (!mu_channels)
-		return 0;
-
-	c = uac_mixer_unit_bmControls(desc, state->mixer->protocol);
-	if (c - (void *)desc + (mu_channels - 1) / 8 >= desc->bLength)
-		return 0; /* no bmControls -> skip */
-
 	return mu_channels;
 }
 
@@ -2009,6 +2001,31 @@ static int parse_audio_feature_unit(stru
  * Mixer Unit
  */
 
+/* check whether the given in/out overflows bmMixerControls matrix */
+static bool mixer_bitmap_overflow(struct uac_mixer_unit_descriptor *desc,
+				  int protocol, int num_ins, int num_outs)
+{
+	u8 *hdr = (u8 *)desc;
+	u8 *c = uac_mixer_unit_bmControls(desc, protocol);
+	size_t rest; /* remaining bytes after bmMixerControls */
+
+	switch (protocol) {
+	case UAC_VERSION_1:
+	default:
+		rest = 1; /* iMixer */
+		break;
+	case UAC_VERSION_2:
+		rest = 2; /* bmControls + iMixer */
+		break;
+	case UAC_VERSION_3:
+		rest = 6; /* bmControls + wMixerDescrStr */
+		break;
+	}
+
+	/* overflow? */
+	return c + (num_ins * num_outs + 7) / 8 + rest > hdr + hdr[0];
+}
+
 /*
  * build a mixer unit control
  *
@@ -2137,6 +2154,9 @@ static int parse_audio_mixer_unit(struct
 		if (err < 0)
 			return err;
 		num_ins += iterm.channels;
+		if (mixer_bitmap_overflow(desc, state->mixer->protocol,
+					  num_ins, num_outs))
+			break;
 		for (; ich < num_ins; ich++) {
 			int och, ich_has_controls = 0;
 


