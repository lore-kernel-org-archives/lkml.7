Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DA7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CF42070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfCDXpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:45:31 -0500
Received: from mail.lindev.ch ([5.39.83.55]:46362 "EHLO mail.lindev.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfCDXpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 18:45:30 -0500
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Mar 2019 18:45:30 EST
Received: from lindev.ch (p2E5CB67E.dip0.t-ipconnect.de [46.92.182.126])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bero@lindev.ch)
        by mail.lindev.ch (Postfix) with ESMTPSA id E10043FDD6;
        Tue,  5 Mar 2019 00:39:12 +0100 (CET)
Date:   Tue, 5 Mar 2019 00:38:19 +0100
From:   Bernhard Rosenkraenzer <bero@lindev.ch>
To:     linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, perex@perex.cz, tiwai@suse.com
Subject: [PATCH] Fix speakers on Acer Predator Helios 500 Ryzen laptops
Message-ID: <20190304233818.GA25749@lindev.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Subliminal-Message: Windows and Apple suck. You want to use Linux!
 http://openmandriva.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On an Acer Predator Helios 500 (Ryzen version), the laptop's speakers
don't work out of the box.

The problem can be worked around with hdajackretask, remapping the
"Black Headphone, Right side" pin (0x21) to the Internal speaker.

This patch adds a quirk to change this mapping by default.

Signed-off-by: Bernhard Rosenkraenzer <bero@lindev.ch>


diff -up linux-5.0-rc8/sound/pci/hda/patch_realtek.c.0006~ linux-5.0-rc8/sound/pci/hda/patch_realtek.c
--- linux-5.0-rc8/sound/pci/hda/patch_realtek.c.0006~	2019-02-25 01:46:45.000000000 +0100
+++ linux-5.0-rc8/sound/pci/hda/patch_realtek.c	2019-02-25 17:55:27.032586591 +0100
@@ -1857,6 +1857,7 @@ enum {
 	ALC1220_FIXUP_CLEVO_P950,
 	ALC1220_FIXUP_SYSTEM76_ORYP5,
 	ALC1220_FIXUP_SYSTEM76_ORYP5_PINS,
+	ALC299_FIXUP_PREDATOR_SPK,
 };
 
 static void alc889_fixup_coef(struct hda_codec *codec,
@@ -6627,6 +6628,13 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC285_FIXUP_LENOVO_HEADPHONE_NOISE
 	},
+	[ALC299_FIXUP_PREDATOR_SPK] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x21, 0x90170150 }, /* use as headset mic, without its own jack detect */
+			{ }
+		}
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6643,6 +6651,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_ASPIRE_V5_PINS),
 	SND_PCI_QUIRK(0x1025, 0x102b, "Acer Aspire C24-860", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x106d, "Acer Cloudbook 14", ALC283_FIXUP_CHROME_BOOK),
+	SND_PCI_QUIRK(0x1025, 0x1246, "Acer Predator Helios 500", ALC299_FIXUP_PREDATOR_SPK),
 	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
@@ -7037,6 +7046,7 @@ static const struct hda_model_fixup alc2
 	{.id = ALC255_FIXUP_DELL_HEADSET_MIC, .name = "alc255-dell-headset"},
 	{.id = ALC295_FIXUP_HP_X360, .name = "alc295-hp-x360"},
 	{.id = ALC225_FIXUP_HEADSET_JACK, .name = "alc-sense-combo"},
+	{.id = ALC299_FIXUP_PREDATOR_SPK, .name = "predator-spk"},
 	{}
 };
 #define ALC225_STANDARD_PINS \
@@ -7421,6 +7431,8 @@ static const struct snd_hda_pin_quirk al
 		ALC225_STANDARD_PINS,
 		{0x12, 0xb7a60130},
 		{0x17, 0x90170110}),
+	SND_HDA_PIN_QUIRK(0x10221457, 0x1028, "Acer", ALC299_FIXUP_PREDATOR_SPK,
+		{ 0x21, 0x90170150 }),
 	{}
 };
 
