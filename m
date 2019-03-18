Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EF6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C5B2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901282;
	bh=Ro2sMzDOsqqF5VSCaeKEI3GeyJRCibaJ9b1b57ut50M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gr7+jdam9vIaNKKegW7CxEvahcCYjdt1zC+Dian8IsRBCCNsVHHJ41Y9T8kAWLie8
	 kZ9h8So4JAiWha3XHav4KkY5YpmGgKqOJKA5/DBXI1QMfREx1e5YL28pPmVtmMWFmr
	 2v6fHt6JzEiKV74CeNLXNT6ygTEg/3g9Wl49zCXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfCRJ2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:28:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbfCRJ16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:27:58 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 126B72075C;
        Mon, 18 Mar 2019 09:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901276;
        bh=Ro2sMzDOsqqF5VSCaeKEI3GeyJRCibaJ9b1b57ut50M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TtsMBcE44n3JWaMsZurKO7Kjybv7mtrcSwApvAKPYscghafGNfhHtuemTDDcQPjPf
         +x5FXGSQSZO7CTsXHKcQj1UiLSPBF5ep0iBWKXH2YRh9kZIVPD+KG50oId8bRbZJN2
         mWEbi1/0+I2y4c6vFL9Of44FheKvjJ5Ymg8Tr0Fw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.0 38/43] ALSA: hda/realtek - Reduce click noise on Dell Precision 5820 headphone
Date:   Mon, 18 Mar 2019 10:24:30 +0100
Message-Id: <20190318083716.996089951@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083715.877441740@linuxfoundation.org>
References: <20190318083715.877441740@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>

commit c0ca5eced22215c1e03e3ad479f8fab0bbb30772 upstream.

Dell Precision 5820 with ALC3234 codec (which is equivalent with
ALC255) shows click noises at (runtime) PM resume on the headphone.
The biggest source of the noise comes from the cleared headphone pin
control at resume, which is done via the standard shutup procedure.

Although we have an override of the standard shutup callback to
replace with NOP, this would skip other needed stuff (e.g. the pull
down of headset power).  So, instead, this "fixes" the behavior of
alc_fixup_no_shutup() by introducing spec->no_shutup_pins flag.
When this flag is set, Realtek codec won't call the standard
snd_hda_shutup_pins() & co.  Now alc_fixup_no_shutup() just sets this
flag instead of overriding spec->shutup callback itself.  This allows
us to apply the similar fix for other entries easily if needed in
future.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   57 +++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 23 deletions(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -118,6 +118,7 @@ struct alc_spec {
 	unsigned int has_alc5505_dsp:1;
 	unsigned int no_depop_delay:1;
 	unsigned int done_hp_init:1;
+	unsigned int no_shutup_pins:1;
 
 	/* for PLL fix */
 	hda_nid_t pll_nid;
@@ -476,6 +477,14 @@ static void alc_auto_setup_eapd(struct h
 		set_eapd(codec, *p, on);
 }
 
+static void alc_shutup_pins(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (!spec->no_shutup_pins)
+		snd_hda_shutup_pins(codec);
+}
+
 /* generic shutup callback;
  * just turning off EAPD and a little pause for avoiding pop-noise
  */
@@ -486,7 +495,7 @@ static void alc_eapd_shutup(struct hda_c
 	alc_auto_setup_eapd(codec, false);
 	if (!spec->no_depop_delay)
 		msleep(200);
-	snd_hda_shutup_pins(codec);
+	alc_shutup_pins(codec);
 }
 
 /* generic EAPD initialization */
@@ -814,7 +823,7 @@ static inline void alc_shutup(struct hda
 	if (spec && spec->shutup)
 		spec->shutup(codec);
 	else
-		snd_hda_shutup_pins(codec);
+		alc_shutup_pins(codec);
 }
 
 static void alc_reboot_notify(struct hda_codec *codec)
@@ -2950,7 +2959,7 @@ static void alc269_shutup(struct hda_cod
 			(alc_get_coef0(codec) & 0x00ff) == 0x018) {
 		msleep(150);
 	}
-	snd_hda_shutup_pins(codec);
+	alc_shutup_pins(codec);
 }
 
 static struct coef_fw alc282_coefs[] = {
@@ -3053,14 +3062,15 @@ static void alc282_shutup(struct hda_cod
 	if (hp_pin_sense)
 		msleep(85);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+	if (!spec->no_shutup_pins)
+		snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
 
 	if (hp_pin_sense)
 		msleep(100);
 
 	alc_auto_setup_eapd(codec, false);
-	snd_hda_shutup_pins(codec);
+	alc_shutup_pins(codec);
 	alc_write_coef_idx(codec, 0x78, coef78);
 }
 
@@ -3166,15 +3176,16 @@ static void alc283_shutup(struct hda_cod
 	if (hp_pin_sense)
 		msleep(100);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+	if (!spec->no_shutup_pins)
+		snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
 
 	alc_update_coef_idx(codec, 0x46, 0, 3 << 12);
 
 	if (hp_pin_sense)
 		msleep(100);
 	alc_auto_setup_eapd(codec, false);
-	snd_hda_shutup_pins(codec);
+	alc_shutup_pins(codec);
 	alc_write_coef_idx(codec, 0x43, 0x9614);
 }
 
@@ -3240,14 +3251,15 @@ static void alc256_shutup(struct hda_cod
 	/* NOTE: call this before clearing the pin, otherwise codec stalls */
 	alc_update_coef_idx(codec, 0x46, 0, 3 << 12);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+	if (!spec->no_shutup_pins)
+		snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
 
 	if (hp_pin_sense)
 		msleep(100);
 
 	alc_auto_setup_eapd(codec, false);
-	snd_hda_shutup_pins(codec);
+	alc_shutup_pins(codec);
 }
 
 static void alc225_init(struct hda_codec *codec)
@@ -3334,7 +3346,7 @@ static void alc225_shutup(struct hda_cod
 		msleep(100);
 
 	alc_auto_setup_eapd(codec, false);
-	snd_hda_shutup_pins(codec);
+	alc_shutup_pins(codec);
 }
 
 static void alc_default_init(struct hda_codec *codec)
@@ -3388,14 +3400,15 @@ static void alc_default_shutup(struct hd
 	if (hp_pin_sense)
 		msleep(85);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+	if (!spec->no_shutup_pins)
+		snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
 
 	if (hp_pin_sense)
 		msleep(100);
 
 	alc_auto_setup_eapd(codec, false);
-	snd_hda_shutup_pins(codec);
+	alc_shutup_pins(codec);
 }
 
 static void alc294_hp_init(struct hda_codec *codec)
@@ -3412,8 +3425,9 @@ static void alc294_hp_init(struct hda_co
 
 	msleep(100);
 
-	snd_hda_codec_write(codec, hp_pin, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+	if (!spec->no_shutup_pins)
+		snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
 
 	alc_update_coef_idx(codec, 0x6f, 0x000f, 0);/* Set HP depop to manual mode */
 	alc_update_coefex_idx(codec, 0x58, 0x00, 0x8000, 0x8000); /* HP depop procedure start */
@@ -5007,16 +5021,12 @@ static void alc_fixup_auto_mute_via_amp(
 	}
 }
 
-static void alc_no_shutup(struct hda_codec *codec)
-{
-}
-
 static void alc_fixup_no_shutup(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		struct alc_spec *spec = codec->spec;
-		spec->shutup = alc_no_shutup;
+		spec->no_shutup_pins = 1;
 	}
 }
 
@@ -6677,6 +6687,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1028, 0x0704, "Dell XPS 13 9350", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x0706, "Dell Inspiron 7559", ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER),
 	SND_PCI_QUIRK(0x1028, 0x0725, "Dell Inspiron 3162", ALC255_FIXUP_DELL_SPK_NOISE),
+	SND_PCI_QUIRK(0x1028, 0x0738, "Dell Precision 5820", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x1028, 0x075b, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x075c, "Dell XPS 27 7760", ALC298_FIXUP_SPK_VOLUME),
 	SND_PCI_QUIRK(0x1028, 0x075d, "Dell AIO", ALC298_FIXUP_SPK_VOLUME),


