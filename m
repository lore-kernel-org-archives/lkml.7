Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A2EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241FA218FE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138968;
	bh=sl3yInsOSfGs0C6ydbuAmL/T5RO5dhFVwkIH51u0EiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wQ++skZaLANaobDpGnVEwbO8bhFl9rtC1hAodjcZJboyymX1mz4TbNELDic9aWRg+
	 /O4MDq1TRf79Kf2fafgHDXpSwdtaoD8RSzHDPA4JiHQdeXsrAqxDQevznkxXuBn3tJ
	 R9jRyXHl33lzTp/20fmV+A/Sv5AzDmWBn3EqyIL8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbfDARQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:16:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730962AbfDARQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:16:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 662EE206C0;
        Mon,  1 Apr 2019 17:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138959;
        bh=sl3yInsOSfGs0C6ydbuAmL/T5RO5dhFVwkIH51u0EiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rDrfdJjvHHBmwvX31SWZeGWIV9Y4bwkDZnGHLctOi7ZNSw/UZjpfLeqCVHolPUsuC
         liYKz0McerTwE/ew+MiGT0ybFpCjx/2qnTEpnuClS0wUIkk1xCb4dk6d2/piWpYR/1
         FGTqUJHe6N7cueFIpO8RuZITC9Goki/3Re+tpHM8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bernhard Rosenkraenzer <bero@lindev.ch>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 069/134] ALSA: hda/realtek - Fix speakers on Acer Predator Helios 500 Ryzen laptops
Date:   Mon,  1 Apr 2019 19:01:45 +0200
Message-Id: <20190401170050.912818366@linuxfoundation.org>
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

From: Bernhard Rosenkraenzer <bero@lindev.ch>

commit e2a829b3da01b9b32c4d0291d042b8a6e2a98ca3 upstream.

On an Acer Predator Helios 500 (Ryzen version), the laptop's speakers
don't work out of the box.

The problem can be worked around with hdajackretask, remapping the
"Black Headphone, Right side" pin (0x21) to the Internal speaker.

This patch adds a quirk to change this mapping by default.

[ corrected ALC299_FIXUP_PREDATOR_SPK definition and adapted for the
  latest tree by tiwai ]

Signed-off-by: Bernhard Rosenkraenzer <bero@lindev.ch>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5618,6 +5618,7 @@ enum {
 	ALC225_FIXUP_WYSE_DISABLE_MIC_VREF,
 	ALC286_FIXUP_ACER_AIO_HEADSET_MIC,
 	ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
+	ALC299_FIXUP_PREDATOR_SPK,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6613,6 +6614,13 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
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
@@ -6631,6 +6639,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1025, 0x106d, "Acer Cloudbook 14", ALC283_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x1025, 0x1099, "Acer Aspire E5-523G", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x110e, "Acer Aspire ES1-432", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1025, 0x1246, "Acer Predator Helios 500", ALC299_FIXUP_PREDATOR_SPK),
 	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
@@ -7027,6 +7036,7 @@ static const struct hda_model_fixup alc2
 	{.id = ALC255_FIXUP_DUMMY_LINEOUT_VERB, .name = "alc255-dummy-lineout"},
 	{.id = ALC255_FIXUP_DELL_HEADSET_MIC, .name = "alc255-dell-headset"},
 	{.id = ALC295_FIXUP_HP_X360, .name = "alc295-hp-x360"},
+	{.id = ALC299_FIXUP_PREDATOR_SPK, .name = "predator-spk"},
 	{}
 };
 #define ALC225_STANDARD_PINS \


