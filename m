Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB76DC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B36A2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578431906;
	bh=JSQJpSpeWdGOn3za1FT2blqLBIwU4lLAhJ3G6jHouxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w3NWX0yaBOPPYb+UrNKEVlSb0wf9JmJqWdm0ivvDWZEkvPYGOMbBCBmcLohhKkxaP
	 FtaqEJcbbTLwdaiB5NAPsdun+JIMYWGPMWoYYe7I/LUf7suN6q5Ct1ccD77DxSCOOB
	 RKbZVUewSAbhiha7a+BpuKD/6a/+VZF21x/qRuPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgAGVSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:18:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:50922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728999AbgAGVFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:05:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBC8C2081E;
        Tue,  7 Jan 2020 21:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578431107;
        bh=JSQJpSpeWdGOn3za1FT2blqLBIwU4lLAhJ3G6jHouxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DtBOWMDoi5ovsba8cvby+5RH+ayY2wClTFpSlL+GiYJcmulXNAlZThFBxhtG3aJhW
         6ewVv2tnOQLD48HE5cHAb3q5tCnZbSXdVNc2gD0duDMBcmcWmb8JscKzzNlmcb9I6U
         Rc5bmIYXmBZTdJgMkXIjb9Q004QGpa7DtsHUUUww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 035/115] ALSA: hda/realtek - Add Bass Speaker and fixed dac for bass speaker
Date:   Tue,  7 Jan 2020 21:54:05 +0100
Message-Id: <20200107205301.441928404@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205240.283674026@linuxfoundation.org>
References: <20200107205240.283674026@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

[ Upstream commit e79c22695abd3b75a6aecf4ea4b9607e8d82c49c ]

Dell has new platform which has dual speaker connecting.
They want dual speaker which use same dac for output.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/229c7efa2b474a16b7d8a916cd096b68@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 019dee96dbaa..9cd0cef9ec27 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5705,6 +5705,8 @@ enum {
 	ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC,
 	ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE,
 	ALC294_FIXUP_ASUS_INTSPK_GPIO,
+	ALC289_FIXUP_DELL_SPK2,
+	ALC289_FIXUP_DUAL_SPK,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6775,6 +6777,21 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC
 	},
+	[ALC289_FIXUP_DELL_SPK2] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x17, 0x90170130 }, /* bass spk */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_DELL4_MIC_NO_PRESENCE
+	},
+	[ALC289_FIXUP_DUAL_SPK] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_speaker2_to_dac1,
+		.chained = true,
+		.chain_id = ALC289_FIXUP_DELL_SPK2
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6847,6 +6864,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1028, 0x08ad, "Dell WYSE AIO", ALC225_FIXUP_DELL_WYSE_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x08ae, "Dell WYSE NB", ALC225_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0935, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB),
+	SND_PCI_QUIRK(0x1028, 0x097e, "Dell Precision", ALC289_FIXUP_DUAL_SPK),
+	SND_PCI_QUIRK(0x1028, 0x097d, "Dell Precision", ALC289_FIXUP_DUAL_SPK),
 	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
-- 
2.20.1



