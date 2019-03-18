Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64336C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3091B2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901648;
	bh=MWJ9JzHP3kN6wa3SIL4dpXhcPGdIY0BqUirY7m7x82I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=opHcLAwtGIC0O33Q9q60m7qLFW6sGnjus7af1MCsfaSpPWUgWM+b47gkWKcAr/7BU
	 UTrxg/3+1qboSiDxSlyFEZ1/Igqc4/00YRhAUdcnkZjPFIuS+27CK4t7R1JGpJS7G9
	 yeM3NAORpbMfLX6KTh9GRgOhThiLT102rk4YfvOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfCRJeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:34:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728650AbfCRJeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:34:00 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24EDE2075C;
        Mon, 18 Mar 2019 09:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901639;
        bh=MWJ9JzHP3kN6wa3SIL4dpXhcPGdIY0BqUirY7m7x82I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dK9n3Z8XuvFocN6FeWdnAlRpmgmry3ZX42HbhsKdltCAwXcZzPGGFDYQhGM9EJWpa
         zNpJla/aksbi45airFGkgdMYb80Sl78bbH/xnrd35U1S2fgjsJxpbiksuXwpMMSlu4
         kWS7NL7/xIOHTUK75QzVTe26QxqysV4kk4vX8Qx0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Burrell <jeff.burrell@hp.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 42/52] ALSA: hda - add more quirks for HP Z2 G4 and HP Z240
Date:   Mon, 18 Mar 2019 10:25:39 +0100
Message-Id: <20190318084018.488787952@linuxfoundation.org>
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

From: Jaroslav Kysela <perex@perex.cz>

commit 167897f4b32c2bc18b3b6183029a33fb420a114e upstream.

Apply the HP_MIC_NO_PRESENCE fixups for the more HP Z2 G4 and
HP Z240 models.

Reported-by: Jeff Burrell <jeff.burrell@hp.com>
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_conexant.c |    3 +++
 sound/pci/hda/patch_realtek.c  |    6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -936,6 +936,9 @@ static const struct snd_pci_quirk cxt506
 	SND_PCI_QUIRK(0x103c, 0x8299, "HP 800 G3 SFF", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x829a, "HP 800 G3 DM", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x8455, "HP Z2 G4", CXT_FIXUP_HP_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x103c, 0x8456, "HP Z2 G4 SFF", CXT_FIXUP_HP_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x103c, 0x8457, "HP Z2 G4 mini", CXT_FIXUP_HP_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x103c, 0x8458, "HP Z2 G4 mini premium", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x138d, "Asus", CXT_FIXUP_HEADPHONE_MIC_PIN),
 	SND_PCI_QUIRK(0x152d, 0x0833, "OLPC XO-1.5", CXT_FIXUP_OLPC_XO),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo T400", CXT_PINCFG_LENOVO_TP410),
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6670,11 +6670,13 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x103c, 0x2336, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x2337, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
 	SND_PCI_QUIRK(0x103c, 0x221c, "HP EliteBook 755 G2", ALC280_FIXUP_HP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x103c, 0x802e, "HP Z240 SFF", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x103c, 0x802f, "HP Z240", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x820d, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8256, "HP", ALC221_FIXUP_HP_FRONT_MIC),
 	SND_PCI_QUIRK(0x103c, 0x827e, "HP x360", ALC295_FIXUP_HP_X360),
-	SND_PCI_QUIRK(0x103c, 0x82bf, "HP", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x103c, 0x82c0, "HP", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x103c, 0x82bf, "HP G3 mini", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x103c, 0x82c0, "HP G3 mini premium", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x83b9, "HP Spectre x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),


