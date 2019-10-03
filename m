Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A68C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 04:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F52222BE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 04:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfJCEjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 00:39:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34992 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfJCEjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 00:39:32 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iFstf-0000FZ-Ft; Thu, 03 Oct 2019 04:39:24 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     kailang@realtek.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] ALSA: hda/realtek: Reduce the Headphone static noise on XPS 9350/9360
Date:   Thu,  3 Oct 2019 12:39:19 +0800
Message-Id: <20191003043919.10960-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Headphone on XPS 9350/9360 produces a background white noise. The The
noise level somehow correlates with "Headphone Mic Boost", when it sets
to 1 the noise disappears. However, doing this has a side effect, which
also decreases the overall headphone volume so I didn't send the patch
upstream.

The noise was bearable back then, but after commit 717f43d81afc ("ALSA:
hda/realtek - Update headset mode for ALC256") the noise exacerbates to
a point it starts hurting ears.

So let's use the workaround to set "Headphone Mic Boost" to 1 and lock
it so it's not touchable by userspace.

Fixes: 717f43d81afc ("ALSA: hda/realtek - Update headset mode for ALC256")
BugLink: https://bugs.launchpad.net/bugs/1654448
BugLink: https://bugs.launchpad.net/bugs/1845810
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b000b36ac3c6..b5c225a56b98 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5358,6 +5358,17 @@ static void alc271_hp_gate_mic_jack(struct hda_codec *codec,
 	}
 }
 
+static void alc256_fixup_dell_xps_13_headphone_noise2(struct hda_codec *codec,
+						      const struct hda_fixup *fix,
+						      int action)
+{
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	snd_hda_codec_amp_stereo(codec, 0x1a, HDA_INPUT, 0, HDA_AMP_VOLMASK, 1);
+	snd_hda_override_wcaps(codec, 0x1a, get_wcaps(codec, 0x1a) & ~AC_WCAP_IN_AMP);
+}
+
 static void alc269_fixup_limit_int_mic_boost(struct hda_codec *codec,
 					     const struct hda_fixup *fix,
 					     int action)
@@ -5822,6 +5833,7 @@ enum {
 	ALC298_FIXUP_DELL_AIO_MIC_NO_PRESENCE,
 	ALC275_FIXUP_DELL_XPS,
 	ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE,
+	ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE2,
 	ALC293_FIXUP_LENOVO_SPK_NOISE,
 	ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY,
 	ALC255_FIXUP_DELL_SPK_NOISE,
@@ -6558,6 +6570,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE
 	},
+	[ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE2] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc256_fixup_dell_xps_13_headphone_noise2,
+		.chained = true,
+		.chain_id = ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE
+	},
 	[ALC293_FIXUP_LENOVO_SPK_NOISE] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_disable_aamix,
@@ -7001,17 +7019,17 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x06de, "Dell", ALC293_FIXUP_DISABLE_AAMIX_MULTIJACK),
 	SND_PCI_QUIRK(0x1028, 0x06df, "Dell", ALC293_FIXUP_DISABLE_AAMIX_MULTIJACK),
 	SND_PCI_QUIRK(0x1028, 0x06e0, "Dell", ALC293_FIXUP_DISABLE_AAMIX_MULTIJACK),
-	SND_PCI_QUIRK(0x1028, 0x0704, "Dell XPS 13 9350", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
+	SND_PCI_QUIRK(0x1028, 0x0704, "Dell XPS 13 9350", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE2),
 	SND_PCI_QUIRK(0x1028, 0x0706, "Dell Inspiron 7559", ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER),
 	SND_PCI_QUIRK(0x1028, 0x0725, "Dell Inspiron 3162", ALC255_FIXUP_DELL_SPK_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x0738, "Dell Precision 5820", ALC269_FIXUP_NO_SHUTUP),
-	SND_PCI_QUIRK(0x1028, 0x075b, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
+	SND_PCI_QUIRK(0x1028, 0x075b, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE2),
 	SND_PCI_QUIRK(0x1028, 0x075c, "Dell XPS 27 7760", ALC298_FIXUP_SPK_VOLUME),
 	SND_PCI_QUIRK(0x1028, 0x075d, "Dell AIO", ALC298_FIXUP_SPK_VOLUME),
 	SND_PCI_QUIRK(0x1028, 0x07b0, "Dell Precision 7520", ALC295_FIXUP_DISABLE_DAC3),
 	SND_PCI_QUIRK(0x1028, 0x0798, "Dell Inspiron 17 7000 Gaming", ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER),
 	SND_PCI_QUIRK(0x1028, 0x080c, "Dell WYSE", ALC225_FIXUP_DELL_WYSE_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1028, 0x082a, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
+	SND_PCI_QUIRK(0x1028, 0x082a, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE2),
 	SND_PCI_QUIRK(0x1028, 0x084b, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB),
 	SND_PCI_QUIRK(0x1028, 0x084e, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB),
 	SND_PCI_QUIRK(0x1028, 0x0871, "Dell Precision 3630", ALC255_FIXUP_DELL_HEADSET_MIC),
-- 
2.17.1

