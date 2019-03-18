Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F72BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8AF204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552902478;
	bh=WUSb7oeTZx0tLp7OqO0UhO3lFp2g3IDXPxl7CRxg7LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gZP7dmWMLgwhiGtG0T8RzYBTcuhIbUxfExLE/qKgBInJzoVJ+nkibr18a8ZfuHi14
	 yAbw+XT6YpiVCHZ/44t+eqYuVlznlPkX1zkXEap/X3fimLY4SYdFG7svwr81skJhhF
	 82GcaWYvfn3Hc8gRDW0ElzvTQOkbxhNX+rbUgct0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfCRJr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbfCRJ2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:28:00 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0B1E2083D;
        Mon, 18 Mar 2019 09:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901279;
        bh=WUSb7oeTZx0tLp7OqO0UhO3lFp2g3IDXPxl7CRxg7LA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tf6B5G4WSyGrme9edVlRR4iWogNS6XMD0ZDYBH82EVtUifNv5nuCnX5JTeD1jLdZH
         VQguMLnZwIK4pm/jtj/I5p/oVfGoBdEPRXvYccVauHNDA7g8r9jP6rXB+d4WL5DAAw
         9c9Hw8nuTdl6kybVLoHuJsgO3dyfBqRr9FMgiuF8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian-Hong Pan <jian-hong@endlessm.com>,
        Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.0 39/43] ALSA: hda/realtek: Enable headset MIC of Acer TravelMate X514-51T with ALC255
Date:   Mon, 18 Mar 2019 10:24:31 +0100
Message-Id: <20190318083717.022702979@linuxfoundation.org>
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

From: Jian-Hong Pan <jian-hong@endlessm.com>

commit cbc05fd6708c1744ee6a61cb4c461ff956d30524 upstream.

The Acer TravelMate X514-51T with ALC255 cannot detect the headset MIC
until ALC255_FIXUP_ACER_HEADSET_MIC quirk applied.  Although, the
internal DMIC uses another module - snd_soc_skl as the driver.  We still
need the NID 0x1a in the quirk to enable the headset MIC.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5671,6 +5671,7 @@ enum {
 	ALC225_FIXUP_HEADSET_JACK,
 	ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
 	ALC285_FIXUP_LENOVO_PC_BEEP_IN_NOISE,
+	ALC255_FIXUP_ACER_HEADSET_MIC,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6637,6 +6638,16 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC285_FIXUP_LENOVO_HEADPHONE_NOISE
 	},
+	[ALC255_FIXUP_ACER_HEADSET_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x03a11130 },
+			{ 0x1a, 0x90a60140 }, /* use as internal mic */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6656,6 +6667,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC255_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", ALC275_FIXUP_DELL_XPS),
 	SND_PCI_QUIRK(0x1028, 0x05bd, "Dell Latitude E6440", ALC292_FIXUP_DELL_E7X),


