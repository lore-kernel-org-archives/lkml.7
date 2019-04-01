Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE50C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6DE2192C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138415;
	bh=0LLvCzSM1HZr6MkupSvWfqSgFvgAaSoSfdB6ISePh/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z3VojhlWEICcQVt5WkxB/1yn3HKZ6u3t2cF6L7INXGLKdu0d5E0NhX/6x/f6jAPkl
	 Bfwh5yEoDEZU8x/IS3AhRy+m6kagmrStoKWngawMHNANnrBfO/oBF2kEEANASWKyzR
	 BDkmmBoDHkBER1dMgXXFHT5wZpLrVYo6rsC46scM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfDARGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729308AbfDARGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:06:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AEC621925;
        Mon,  1 Apr 2019 17:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138411;
        bh=0LLvCzSM1HZr6MkupSvWfqSgFvgAaSoSfdB6ISePh/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=upUpYUN2SNk4Actr/HOIRKAovzc/2dSnpTqXi1N6zjGuUOgMO70V6ougTMlsAA6Bc
         Zej1ny5eH2CvgD0Oy95KBHhLel5gD7JnbJ+oQ0Wct7VLRTG78jtZ06GypdqAC+sDYS
         EOuhxeQ11L0KPx5L4XDkZrgikSYefvOlJMiHyK1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.0 059/146] ALSA: hda/realtek: merge alc_fixup_headset_jack to alc295_fixup_chromebook
Date:   Mon,  1 Apr 2019 19:01:11 +0200
Message-Id: <20190401170053.665334054@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaroslav Kysela <perex@perex.cz>

commit c8a9afa632f0fd45731d3353525faf1fdb362c89 upstream.

The ALC225_FIXUP_HEADSET_JACK fixup can be merged to alc295_fixup_chromebook.
There are no other users for ALC225_FIXUP_HEADSET_JACK other than
the chromebook hardware.

Fixes: 10f5b1b85ed1 ("ALSA: hda/realtek - Fixed Headset Mic JD not stable")
Cc: Kailang Yang <kailang@realtek.com>
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   43 ++++++++++++------------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5489,7 +5489,7 @@ static void alc_headset_btn_callback(str
 	jack->jack->button_state = report;
 }
 
-static void alc_fixup_headset_jack(struct hda_codec *codec,
+static void alc295_fixup_chromebook(struct hda_codec *codec,
 				    const struct hda_fixup *fix, int action)
 {
 
@@ -5499,6 +5499,16 @@ static void alc_fixup_headset_jack(struc
 						    alc_headset_btn_callback);
 		snd_hda_jack_add_kctl(codec, 0x55, "Headset Jack", false,
 				      SND_JACK_HEADSET, alc_headset_btn_keymap);
+		switch (codec->core.vendor_id) {
+		case 0x10ec0295:
+			alc_update_coef_idx(codec, 0x4a, 0x8000, 1 << 15); /* Reset HP JD */
+			alc_update_coef_idx(codec, 0x4a, 0x8000, 0 << 15);
+			break;
+		case 0x10ec0236:
+			alc_update_coef_idx(codec, 0x1b, 0x8000, 1 << 15); /* Reset HP JD */
+			alc_update_coef_idx(codec, 0x1b, 0x8000, 0 << 15);
+			break;
+		}
 		break;
 	case HDA_FIXUP_ACT_INIT:
 		switch (codec->core.vendor_id) {
@@ -5519,26 +5529,6 @@ static void alc_fixup_headset_jack(struc
 	}
 }
 
-static void alc295_fixup_chromebook(struct hda_codec *codec,
-				    const struct hda_fixup *fix, int action)
-{
-
-	switch (action) {
-	case HDA_FIXUP_ACT_PRE_PROBE:
-		switch (codec->core.vendor_id) {
-		case 0x10ec0295:
-			alc_update_coef_idx(codec, 0x4a, 0x8000, 1 << 15); /* Reset HP JD */
-			alc_update_coef_idx(codec, 0x4a, 0x8000, 0 << 15);
-			break;
-		case 0x10ec0236:
-			alc_update_coef_idx(codec, 0x1b, 0x8000, 1 << 15); /* Reset HP JD */
-			alc_update_coef_idx(codec, 0x1b, 0x8000, 0 << 15);
-			break;
-		}
-		break;
-	}
-}
-
 static void alc_fixup_disable_mic_vref(struct hda_codec *codec,
 				  const struct hda_fixup *fix, int action)
 {
@@ -5688,7 +5678,6 @@ enum {
 	ALC294_FIXUP_ASUS_MIC,
 	ALC294_FIXUP_ASUS_HEADSET_MIC,
 	ALC294_FIXUP_ASUS_SPK,
-	ALC225_FIXUP_HEADSET_JACK,
 	ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
 	ALC285_FIXUP_LENOVO_PC_BEEP_IN_NOISE,
 	ALC255_FIXUP_ACER_HEADSET_MIC,
@@ -6635,9 +6624,9 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC294_FIXUP_ASUS_HEADSET_MIC
 	},
-	[ALC225_FIXUP_HEADSET_JACK] = {
+	[ALC295_FIXUP_CHROME_BOOK] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = alc_fixup_headset_jack,
+		.v.func = alc295_fixup_chromebook,
 	},
 	[ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
@@ -6669,12 +6658,6 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC
 	},
-	[ALC295_FIXUP_CHROME_BOOK] = {
-		.type = HDA_FIXUP_FUNC,
-		.v.func = alc295_fixup_chromebook,
-		.chained = true,
-		.chain_id = ALC225_FIXUP_HEADSET_JACK
-	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {


