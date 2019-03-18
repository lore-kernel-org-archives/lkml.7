Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74645C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBF9217D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901652;
	bh=6Ej/IQUpkK+p/VJohZ6K68yYY7l9B7E2rHXZjpszpyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0d13oOkxJ9H1aoaBT9kDA+BN9S2AqRyr6gyTHgcVr40qt8ezjXeXcsxjyh7+O4XkK
	 gt9uxzhmwTOHOi/4SmnJGZi+wgusJ1BIMFMFrEL4FybSSz7Neu7ZhosSMKcSx6Jq4J
	 doTwXIzMdWcA2whZJn2EwvPo+cg737LrpT4G7pfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfCRJeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:34:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728954AbfCRJeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:34:07 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A31EB2087C;
        Mon, 18 Mar 2019 09:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901646;
        bh=6Ej/IQUpkK+p/VJohZ6K68yYY7l9B7E2rHXZjpszpyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bVbxWBNzhdEPVZ4S3mhwqkKhHVzVjektKLf5+tQxvit0yYmzK/NT+jxueLK/DN9DK
         83v8DSnZrrkDdWLO+iig5J+v9QYF5EkDsDvIKApBpZ8xcElAqF/XICx/gw9LnLtAab
         /ZOBZIO+LfcsWrhnDhP3tC6MS2ut5COjvQDN3YZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 44/52] ALSA: hda/realtek - Reduce click noise on Dell Precision 5820 headphone
Date:   Mon, 18 Mar 2019 10:25:41 +0100
Message-Id: <20190318084018.714246524@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084013.532280682@linuxfoundation.org>
References: <20190318084013.532280682@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
 
@@ -6596,6 +6606,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1028, 0x0704, "Dell XPS 13 9350", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x0706, "Dell Inspiron 7559", ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER),
 	SND_PCI_QUIRK(0x1028, 0x0725, "Dell Inspiron 3162", ALC255_FIXUP_DELL_SPK_NOISE),
+	SND_PCI_QUIRK(0x1028, 0x0738, "Dell Precision 5820", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x1028, 0x075b, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x075c, "Dell XPS 27 7760", ALC298_FIXUP_SPK_VOLUME),
 	SND_PCI_QUIRK(0x1028, 0x075d, "Dell AIO", ALC298_FIXUP_SPK_VOLUME),


