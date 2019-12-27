Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2ECC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 06:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A57206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 06:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="YrwbpXmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfL0G5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 01:57:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45444 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfL0G5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 01:57:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so11378247pls.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 22:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PnkNvUFtvzbbYcE5CwfaCD/l1qPrOZWX6lNmWQNNLKE=;
        b=YrwbpXmotny6FI9nIbFIyeg+ylSzXsCvExjIzikQPY+n54yXehgurNHW7qrxGTQ9RT
         zesiXNUmTMuhevDfwch77rne6wrlv23AiG84gNLfdfKymRAvkODhKqK6/pnazuqE0WIc
         0ZBCViPwePVFn3aVY6NR9uKORsTkKiCCONjxkkAn8GJkIWpi9D3hCGFTMqTkDowkHUyM
         A0VeSsnP/oiP/KDS9Xm72ld5HmU8jLfnYFvor6vE3ZO8SfX/GF0pubM87YEL2nY1asf3
         +/OjQAVs8MHejN0ga1c1SC4/+PkFQatOcO56Tj4NrOm+tHGqWrGbviyQvxB2uacBMpai
         c1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PnkNvUFtvzbbYcE5CwfaCD/l1qPrOZWX6lNmWQNNLKE=;
        b=rDjn2Z2U8sPcMfU0fuo49PSrGEpWYznocbnBbJu5oOElybBMI6Q24lb8xG7cMmhL1T
         sryzAVOuuN7Dnp1TpN9NjPrIbKeAtEhBpOMV3aE8ActBQTWfWPPweRDBcOu2143RNESx
         29kWvnvhqCLfiqgfpXmAFE4yUciqOLtkAxG4bdp3nTSjNPMsAKZ3tIiZfsZTBCC5t100
         aNKFBGpSu/iFegANtoCtWERZh101sCw9RV+h0UyvuAbRaiUMSwgwDsHAN9OAf6D9r/F4
         DMHOg0p/YIq3MpfZzckY6OLKxoAF2UrKgUxMYUdkvOx2E2uCSJ0rbU6lZPbYevwvmVvL
         k/rQ==
X-Gm-Message-State: APjAAAU4agh8vCiARcs50NH+eoVA0HmWHqyGIAgsHRtq6BsZW0tMYLYG
        tg3Q8+Z5Wv7eaS0OUnczGsBhIw==
X-Google-Smtp-Source: APXvYqxtY/9hAi9APfUm0ya3wc7W/vrscRGRDzi+zNzns0bnB8bJqCmwIydV8hjy8GFWNUvuMXpFXw==
X-Received: by 2002:a17:902:bc4b:: with SMTP id t11mr14003821plz.190.1577429853727;
        Thu, 26 Dec 2019 22:57:33 -0800 (PST)
Received: from endless.endlessm-sf.com (ec2-34-209-191-27.us-west-2.compute.amazonaws.com. [34.209.191.27])
        by smtp.gmail.com with ESMTPSA id o2sm13449658pjo.26.2019.12.26.22.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 22:57:33 -0800 (PST)
From:   Chris Chiu <chiu@endlessm.com>
X-Google-Original-From: Chris Chiu <chris.chiu@pacidal.com>
To:     perex@perex.cz, tiwai@suse.com, kailang@realtek.com,
        hui.wang@canonical.com, tomas.espeleta@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Chris Chiu <chiu@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] ALSA: hda/realtek - Enable the subwoofer of ASUS UX431FLC
Date:   Fri, 27 Dec 2019 14:57:24 +0800
Message-Id: <20191227065724.2581-1-chris.chiu@pacidal.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Chiu <chiu@endlessm.com>

ASUS reported that there's an additional speaker which serves as
the subwoofer and uses DAC 0x02. It does not work with the commit
73a723348a43 ("ALSA: hda/realtek - Enable internal speaker of ASUS
UX431FLC") which enables the amplifier and front speakers. This
commit enables the subwoofer to improve the acoustic experience.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fada1ff61353..0193a8722be2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5576,6 +5576,16 @@ static void alc295_fixup_disable_dac3(struct hda_codec *codec,
 	}
 }
 
+/* Fixed DAC (0x02) on NID 0x17 to enable the mono speaker */
+static void alc294_fixup_fixed_dac_subwoofer(struct hda_codec *codec,
+					const struct hda_fixup *fix, int action)
+{
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		hda_nid_t conn[1] = { 0x02 };
+		snd_hda_override_conn_list(codec, 0x17, 1, conn);
+	}
+}
+
 /* Hook to update amp GPIO4 for automute */
 static void alc280_hp_gpio4_automute_hook(struct hda_codec *codec,
 					  struct hda_jack_callback *jack)
@@ -5950,7 +5960,8 @@ enum {
 	ALC269VC_FIXUP_ACER_HEADSET_MIC,
 	ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC,
 	ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE,
-	ALC294_FIXUP_ASUS_INTSPK_GPIO,
+	ALC294_FIXUP_ASUS_DUAL_SPEAKERS,
+	ALC294_FIXUP_FIXED_DAC_SUBWOOFER,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -7097,10 +7108,9 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ }
 		}
 	},
-	[ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC] = {
+	[ALC294_FIXUP_ASUS_HEADSET_MIC] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
-			{ 0x14, 0x411111f0 }, /* disable confusing internal speaker */
 			{ 0x19, 0x04a11150 }, /* use as headset mic, without its own jack detect */
 			{ }
 		},
@@ -7117,12 +7127,18 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
 	},
-	[ALC294_FIXUP_ASUS_INTSPK_GPIO] = {
+	[ALC294_FIXUP_FIXED_DAC_SUBWOOFER] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc294_fixup_fixed_dac_subwoofer,
+		.chained = true,
+		.chain_id = ALC294_FIXUP_ASUS_HEADSET_MIC
+	},
+	[ALC294_FIXUP_ASUS_DUAL_SPEAKERS] = {
 		.type = HDA_FIXUP_FUNC,
 		/* The GPIO must be pulled to initialize the AMP */
 		.v.func = alc_fixup_gpio4,
 		.chained = true,
-		.chain_id = ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC
+		.chain_id = ALC294_FIXUP_FIXED_DAC_SUBWOOFER
 	},
 };
 
@@ -7291,7 +7307,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
-	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_INTSPK_GPIO),
+	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_DUAL_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
 	SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD", ALC256_FIXUP_ASUS_MIC),
-- 
2.20.1

