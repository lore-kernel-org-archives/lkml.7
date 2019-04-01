Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C617C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D24A20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138934;
	bh=A6H/Q/UhgiEs9X3If5/pYebu355iuiHbuj0l+lCirL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RPUqALkhaotnrvI4gR90i7Sz7LJCF1e8T96BLrM28Mfd1IBCaCgpx3g3A0QriHe+b
	 GzzAbnDxwbT8jqrY2lNZwIw8sork3wwv7Qqa3ArpWf88JZ8wn4mdfndaDwx6kH5lT1
	 A6LGxg1Sa48Dy7wAgqjihCAjNlj6niFwatSy7uPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbfDARPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:15:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728648AbfDARPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:15:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18FC9206C0;
        Mon,  1 Apr 2019 17:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138929;
        bh=A6H/Q/UhgiEs9X3If5/pYebu355iuiHbuj0l+lCirL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qATHdtYQfj6L6nzdUA7sl9q4jpLMLChNQq6C9zeFal3CzPKTA4359PMEjT5ay+XNA
         T5MVRIV3iG+41wgmuPoT6iL8LrfWsHdApiDRWtlQkSUz6XgwBwZ/PkrHIQKIodp8fi
         uLnrC1URCeuByl9fbAFoAKGMm3uxMGZzKaI9WgkU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 061/134] ALSA: hda/realtek - Add support headset mode for DELL WYSE AIO
Date:   Mon,  1 Apr 2019 19:01:37 +0200
Message-Id: <20190401170050.278038794@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

From: Kailang Yang <kailang@realtek.com>

commit 136824efaab2c095fc911048f7c7ddeda258c965 upstream.

This patch will enable WYSE AIO for Headset mode.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5613,6 +5613,9 @@ enum {
 	ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
 	ALC285_FIXUP_LENOVO_PC_BEEP_IN_NOISE,
 	ALC255_FIXUP_ACER_HEADSET_MIC,
+	ALC225_FIXUP_DELL_WYSE_AIO_MIC_NO_PRESENCE,
+	ALC225_FIXUP_WYSE_AUTO_MUTE,
+	ALC225_FIXUP_WYSE_DISABLE_MIC_VREF,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6567,6 +6570,28 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC
 	},
+	[ALC225_FIXUP_DELL_WYSE_AIO_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x16, 0x01011020 }, /* Rear Line out */
+			{ 0x19, 0x01a1913c }, /* use as Front headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC225_FIXUP_WYSE_AUTO_MUTE
+	},
+	[ALC225_FIXUP_WYSE_AUTO_MUTE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_auto_mute_via_amp,
+		.chained = true,
+		.chain_id = ALC225_FIXUP_WYSE_DISABLE_MIC_VREF
+	},
+	[ALC225_FIXUP_WYSE_DISABLE_MIC_VREF] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_disable_mic_vref,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6631,6 +6656,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1028, 0x0871, "Dell Precision 3630", ALC255_FIXUP_DELL_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0872, "Dell Precision 3630", ALC255_FIXUP_DELL_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0873, "Dell Precision 3930", ALC255_FIXUP_DUMMY_LINEOUT_VERB),
+	SND_PCI_QUIRK(0x1028, 0x08ad, "Dell WYSE AIO", ALC225_FIXUP_DELL_WYSE_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0935, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB),
 	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),


