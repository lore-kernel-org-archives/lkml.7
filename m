Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68EDC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F295218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355209;
	bh=/QZGz7z5fhCmty5EY4iOW2/Afv8wcABSKxXh89aIPE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n0TbV2KKKOiQKk/DTptAaOhzWhDimv0tdIYwnynQTnuf//MEZwP/XZN6R94b1akII
	 7PysgHA15fkO+C1ixgYo0LsjYzO8iY7o7rsFvTxXDaFgxe0AiCiNoJBuY2n6qtRPft
	 uZ7N9os3gb17W4oiyRKU5oIghMohHbUC0nNohZRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfDOTGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbfDOTGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:06:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3028B218FF;
        Mon, 15 Apr 2019 19:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355203;
        bh=/QZGz7z5fhCmty5EY4iOW2/Afv8wcABSKxXh89aIPE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ibMytHWpo4Pa60vvc34KOtI48lLgofs9zD9sDIBxh70UX8rBFI81OxZGmj2JzFY9d
         Db/LAmSea42b8OxGd8gj1qM9yRfEUYWzXlOptZXaLkjfYs1T1Tn9SW3dVUOx4125va
         Qq/HR1J2ObhCZ3iKM0jNGOFW0eaQk3QJR+MbZ8gM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 051/101] ALSA: hda/realtek: Enable headset MIC of Acer TravelMate B114-21 with ALC233
Date:   Mon, 15 Apr 2019 20:58:49 +0200
Message-Id: <20190415183743.260886804@linuxfoundation.org>
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

From: Jian-Hong Pan <jian-hong@endlessm.com>

commit ea5c7eba216e832906e594799b8670f1954a588c upstream.

The Acer TravelMate B114-21 laptop cannot detect and record sound from
headset MIC.  This patch adds the ALC233_FIXUP_ACER_HEADSET_MIC HDA verb
quirk chained with ALC233_FIXUP_ASUS_MIC_NO_PRESENCE pin quirk to fix
this issue.

[ fixed the missing brace and reordered the entry -- tiwai ]

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Reviewed-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5594,6 +5594,7 @@ enum {
 	ALC233_FIXUP_ASUS_MIC_NO_PRESENCE,
 	ALC233_FIXUP_EAPD_COEF_AND_MIC_NO_PRESENCE,
 	ALC233_FIXUP_LENOVO_MULTI_CODECS,
+	ALC233_FIXUP_ACER_HEADSET_MIC,
 	ALC294_FIXUP_LENOVO_MIC_LOCATION,
 	ALC225_FIXUP_DELL_WYSE_MIC_NO_PRESENCE,
 	ALC700_FIXUP_INTEL_REFERENCE,
@@ -6401,6 +6402,16 @@ static const struct hda_fixup alc269_fix
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc233_alc662_fixup_lenovo_dual_codecs,
 	},
+	[ALC233_FIXUP_ACER_HEADSET_MIC] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x45 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x5089 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC233_FIXUP_ASUS_MIC_NO_PRESENCE
+	},
 	[ALC294_FIXUP_LENOVO_MIC_LOCATION] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -6644,6 +6655,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1308, "Acer Aspire Z24-890", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x132a, "Acer TravelMate B114-21", ALC233_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC255_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", ALC275_FIXUP_DELL_XPS),


