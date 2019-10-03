Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAABEC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7073F20700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570119159;
	bh=VOJAS5kmfIvHyD8Ct4Ladu8Yj/Cr74Ixde/fcxvrqQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RH+DpQTmYPxF2b2zJs48dcXCCVJNSzawty40uHeiJH/JD/Jqst0JRVwTqGCjna3YK
	 1rss/kO0cYVoFmQiAiehZW9aAxj7RKrs2D4uD5wFiFvdAh24coVvvWaWtLQ4tgvBSj
	 OPEVS1aBvZS15z8AVsUHlB5uE3OLij4+P70EM6oA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388082AbfJCQMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:12:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728767AbfJCQMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:12:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5FE220700;
        Thu,  3 Oct 2019 16:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119155;
        bh=VOJAS5kmfIvHyD8Ct4Ladu8Yj/Cr74Ixde/fcxvrqQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VlkWtYEYafzQA8rk4NjBtgrMJQqtvTj+yB5neT4Na3NBuxay0j8RlZQWi0qsHLPaZ
         CHaPgFO0QrsUUGEYgMiQO8MX8y7VFru9BAxi1MR/7Rwsg27qk1QcvIr7/44ppYobFO
         A0epNQWj0UvcuJ7KJ4TW92iIth9j1SpvPty3NnL8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Briden <tom@decompile.me.uk>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 146/185] ALSA: hda/realtek - Fixup mute led on HP Spectre x360
Date:   Thu,  3 Oct 2019 17:53:44 +0200
Message-Id: <20191003154511.856254267@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154437.541662648@linuxfoundation.org>
References: <20191003154437.541662648@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Briden <tom@decompile.me.uk>

[ Upstream commit 7f783bd5e215a014a3c98df64bef24c2dc736def ]

This patch adds the mute LED control for HP Spectre x360 Kabylake
model.  The mute LED is controlled via VREF bits on NID 0x1b, so we
need a new fixup function.

Note that this doesn't fix the other issues like the missing speaker
output on the machine.  They will be addressed by later patches.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=189331
Signed-off-by: Tom Briden <tom@decompile.me.uk>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4f35ac2606708..ab7bc7ebb7215 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3611,6 +3611,19 @@ static void alc269_fixup_hp_mute_led_mic2(struct hda_codec *codec,
 	}
 }
 
+static void alc269_fixup_hp_mute_led_mic3(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->mute_led_polarity = 0;
+		spec->mute_led_nid = 0x1b;
+		spec->gen.vmaster_mute.hook = alc269_fixup_mic_mute_hook;
+		spec->gen.vmaster_mute_enum = 1;
+		codec->power_filter = led_power_filter;
+	}
+}
+
 /* update LED status via GPIO */
 static void alc_update_gpio_led(struct hda_codec *codec, unsigned int mask,
 				bool enabled)
@@ -5385,6 +5398,7 @@ enum {
 	ALC269_FIXUP_HP_MUTE_LED,
 	ALC269_FIXUP_HP_MUTE_LED_MIC1,
 	ALC269_FIXUP_HP_MUTE_LED_MIC2,
+	ALC269_FIXUP_HP_MUTE_LED_MIC3,
 	ALC269_FIXUP_HP_GPIO_LED,
 	ALC269_FIXUP_HP_GPIO_MIC1_LED,
 	ALC269_FIXUP_HP_LINE1_MIC1_LED,
@@ -5648,6 +5662,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_hp_mute_led_mic2,
 	},
+	[ALC269_FIXUP_HP_MUTE_LED_MIC3] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_hp_mute_led_mic3,
+	},
 	[ALC269_FIXUP_HP_GPIO_LED] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_hp_gpio_led,
@@ -6502,6 +6520,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x2337, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x221c, "HP EliteBook 755 G2", ALC280_FIXUP_HP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x103c, 0x8256, "HP", ALC221_FIXUP_HP_FRONT_MIC),
+	SND_PCI_QUIRK(0x103c, 0x827e, "HP x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x82bf, "HP", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x82c0, "HP", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
-- 
2.20.1



