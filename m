Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4D1C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF67420880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355219;
	bh=xM3lO0D/WMjPUUXa5Kb+MEXDxyEQ3e930JfPQ5fvUxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EUGF9k4bbF8r4So6tAJqKk7qrq2EEJtL+54vJBXDSR6D/jdQrCHv/BmjKGuZY7RuT
	 XYxSpyeb/QRRkBQj59gogLdNgU0j6Hj6ARkFpQLUKLz52BEd03ATb22O2E0zvmL+JJ
	 AsUw+RQm0FWCJhxhrm97IlSLEagsV20u/U4EkInI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbfDOTGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:06:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730040AbfDOTGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:06:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4B09218A1;
        Mon, 15 Apr 2019 19:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355206;
        bh=xM3lO0D/WMjPUUXa5Kb+MEXDxyEQ3e930JfPQ5fvUxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uoqg/rQdGw1T3TgIgXyUCymuC54zplhqYGdhihpd76pJnhKaIBT4kaYcz+supn3iS
         9KKzqWEZi3ZFriFJ3FH0B0LXGmU8WcjWryQ4+c7w4ZBMWFnEzaPceGNx7rxxR2kXOJ
         DoJZFfLw6K3mqJu+nw6HufAepw8u4i1FvFkaKoUo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Sailer <rs@tuxedocomputers.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 052/101] ALSA: hda/realtek - Add quirk for Tuxedo XC 1509
Date:   Mon, 15 Apr 2019 20:58:50 +0200
Message-Id: <20190415183743.306586922@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Sailer <rs@tuxedocomputers.com>

commit 80690a276f444a68a332136d98bfea1c338bc263 upstream.

This adds a SND_PCI_QUIRK(...) line for the Tuxedo XC 1509.

The Tuxedo XC 1509 and the System76 oryp5 are the same barebone
notebooks manufactured by Clevo. To name the fixups both use after the
actual underlying hardware, this patch also changes System76_orpy5
to clevo_pb51ed in 2 enum symbols and one function name,
matching the other pci_quirk entries which are also named after the
device ODM.

Fixes: 7f665b1c3283 ("ALSA: hda/realtek - Headset microphone and internal speaker support for System76 oryp5")
Signed-off-by: Richard Sailer <rs@tuxedocomputers.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1864,8 +1864,8 @@ enum {
 	ALC887_FIXUP_BASS_CHMAP,
 	ALC1220_FIXUP_GB_DUAL_CODECS,
 	ALC1220_FIXUP_CLEVO_P950,
-	ALC1220_FIXUP_SYSTEM76_ORYP5,
-	ALC1220_FIXUP_SYSTEM76_ORYP5_PINS,
+	ALC1220_FIXUP_CLEVO_PB51ED,
+	ALC1220_FIXUP_CLEVO_PB51ED_PINS,
 };
 
 static void alc889_fixup_coef(struct hda_codec *codec,
@@ -2070,7 +2070,7 @@ static void alc1220_fixup_clevo_p950(str
 static void alc_fixup_headset_mode_no_hp_mic(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action);
 
-static void alc1220_fixup_system76_oryp5(struct hda_codec *codec,
+static void alc1220_fixup_clevo_pb51ed(struct hda_codec *codec,
 				     const struct hda_fixup *fix,
 				     int action)
 {
@@ -2322,18 +2322,18 @@ static const struct hda_fixup alc882_fix
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc1220_fixup_clevo_p950,
 	},
-	[ALC1220_FIXUP_SYSTEM76_ORYP5] = {
+	[ALC1220_FIXUP_CLEVO_PB51ED] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = alc1220_fixup_system76_oryp5,
+		.v.func = alc1220_fixup_clevo_pb51ed,
 	},
-	[ALC1220_FIXUP_SYSTEM76_ORYP5_PINS] = {
+	[ALC1220_FIXUP_CLEVO_PB51ED_PINS] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
 			{ 0x19, 0x01a1913c }, /* use as headset mic, without its own jack detect */
 			{}
 		},
 		.chained = true,
-		.chain_id = ALC1220_FIXUP_SYSTEM76_ORYP5,
+		.chain_id = ALC1220_FIXUP_CLEVO_PB51ED,
 	},
 };
 
@@ -2411,8 +2411,9 @@ static const struct snd_pci_quirk alc882
 	SND_PCI_QUIRK(0x1558, 0x9501, "Clevo P950HR", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1558, 0x95e1, "Clevo P95xER", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1558, 0x95e2, "Clevo P950ER", ALC1220_FIXUP_CLEVO_P950),
-	SND_PCI_QUIRK(0x1558, 0x96e1, "System76 Oryx Pro (oryp5)", ALC1220_FIXUP_SYSTEM76_ORYP5_PINS),
-	SND_PCI_QUIRK(0x1558, 0x97e1, "System76 Oryx Pro (oryp5)", ALC1220_FIXUP_SYSTEM76_ORYP5_PINS),
+	SND_PCI_QUIRK(0x1558, 0x96e1, "System76 Oryx Pro (oryp5)", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
+	SND_PCI_QUIRK(0x1558, 0x97e1, "System76 Oryx Pro (oryp5)", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
+	SND_PCI_QUIRK(0x1558, 0x65d1, "Tuxedo Book XC1509", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
 	SND_PCI_QUIRK_VENDOR(0x1558, "Clevo laptop", ALC882_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x161f, 0x2054, "Medion laptop", ALC883_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Y530", ALC882_FIXUP_LENOVO_Y530),


