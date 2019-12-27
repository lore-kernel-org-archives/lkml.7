Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA0FC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 10:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7D420828
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 10:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="yU3sjTZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfL0KGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 05:06:44 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43957 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfL0KGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 05:06:43 -0500
Received: by mail-pl1-f194.google.com with SMTP id p27so11547477pli.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 02:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YSXwFBLAEFX5vgAYLDnvOhz1WELYWMvrd2rMYXD92go=;
        b=yU3sjTZ3UM5MPM6+hSjKb7aFvzWuMSFQHmB3i/PqwSdPIEExVYaGx4sXWtIAI0bSy0
         5phFZbMFG4siPfj8FJUkI4j7skD+pVsNblli9W/ka72nnbukEBT5qNARXG2m63AhOjn7
         lJp3r5pCuhzpiWrpWdiSbOzOa1Cj4vepEZ1FfqY7bKEh0jrdvCrHTn2ukmTsy3YBvF4k
         AUC/NIDVQPOmXTGUDqp+EjiNNV/xII6H88nxGUnlv4A2coEjoZWQBHbTX3PyoBuVfwwG
         MCur0h4t7aa4KYbUNPRDoM3LzX77BiyngergyM/KG3LeFgbnt41wwY/qBOT0FoQFzkae
         xmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YSXwFBLAEFX5vgAYLDnvOhz1WELYWMvrd2rMYXD92go=;
        b=Jz33uTDjCNMcJvzTSUVwqKJJljB2d+OgU8e5AS8wvsPR7ayZjJOJD6Ids+1PK2PQb0
         nfdbdBxzN/ltPSKf1s05iJIjug+fKLvEJrA+rnBxm/yrOVPovV2bgIKMv4uJ/eW3gfmf
         f77rqd878H+eFZZkD02Z3mZMQTTZyH0UPsAn120h/odqLMfpezRKp0xosnV34alCjYNK
         5NyosNT80z9thOV1yM93LSRUHU/YbAq1uYqFMclOkppN+DHVTpU5S7Ap+DP2ZbBqR9TC
         CM81J9+b7nOolvcHPwhWxQVXTouWvu9WOryQroJ4B8ab99TBrKowwVyO8nTUDDwsLy0K
         tgiw==
X-Gm-Message-State: APjAAAX2TIi+DOAleIDnPg2HmR73jo0imGRFnsiyf+GX9WXwTWAWdQBL
        Tb3+0Dr7hDAqhcf6/h0SKtzOIA==
X-Google-Smtp-Source: APXvYqxF0l9MAPbmvnAGtE3gYkb2wmPuO8TCsM6g4jddDynbiNMOtfe8BnU4yFoEdek7szDaXVFaYQ==
X-Received: by 2002:a17:902:b487:: with SMTP id y7mr27228535plr.29.1577441202862;
        Fri, 27 Dec 2019 02:06:42 -0800 (PST)
Received: from localhost.localdomain (59-127-47-126.HINET-IP.hinet.net. [59.127.47.126])
        by smtp.gmail.com with ESMTPSA id g24sm39236522pfk.92.2019.12.27.02.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Dec 2019 02:06:42 -0800 (PST)
From:   Chris Chiu <chiu@endlessm.com>
To:     perex@perex.cz, tiwai@suse.com, kailang@realtek.com,
        hui.wang@canonical.com, tomas.espeleta@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH v2] ALSA: hda/realtek - Enable the bass speaker of ASUS UX431FLC
Date:   Fri, 27 Dec 2019 18:08:25 +0800
Message-Id: <20191227100825.75790-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS reported that there's an bass speaker in addition to internal
speaker and it uses DAC 0x02. It was not enabled in the commit
436e25505f34 ("ALSA: hda/realtek - Enable internal speaker of ASUS
UX431FLC") which only enables the amplifier for the front speaker.
This commit enables the bass speaker on top of the aforementioned
work to improve the acoustic experience.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---

Notes:
  v2: 
   - Use existing alc285_fixup_speaker2_to_dac1 instead of new fixup function
   - Correct the commit hash number in the commit message 
   - Remove the redundant fixup ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC

 sound/pci/hda/patch_realtek.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 5bc1a6d24333..9c5c65396b3c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5905,9 +5905,9 @@ enum {
 	ALC256_FIXUP_ASUS_HEADSET_MIC,
 	ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
 	ALC299_FIXUP_PREDATOR_SPK,
-	ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC,
 	ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE,
-	ALC294_FIXUP_ASUS_INTSPK_GPIO,
+	ALC294_FIXUP_ASUS_DUAL_SPEAKERS,
+	ALC294_FIXUP_SPEAKER2_TO_DAC1,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6982,16 +6982,6 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ }
 		}
 	},
-	[ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC] = {
-		.type = HDA_FIXUP_PINS,
-		.v.pins = (const struct hda_pintbl[]) {
-			{ 0x14, 0x411111f0 }, /* disable confusing internal speaker */
-			{ 0x19, 0x04a11150 }, /* use as headset mic, without its own jack detect */
-			{ }
-		},
-		.chained = true,
-		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
-	},
 	[ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -7002,12 +6992,18 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
 	},
-	[ALC294_FIXUP_ASUS_INTSPK_GPIO] = {
+	[ALC294_FIXUP_SPEAKER2_TO_DAC1] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_speaker2_to_dac1,
+		.chained = true,
+		.chain_id = ALC294_FIXUP_ASUS_HEADSET_MIC
+	},
+	[ALC294_FIXUP_ASUS_DUAL_SPEAKERS] = {
 		.type = HDA_FIXUP_FUNC,
 		/* The GPIO must be pulled to initialize the AMP */
 		.v.func = alc_fixup_gpio4,
 		.chained = true,
-		.chain_id = ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC
+		.chain_id = ALC294_FIXUP_SPEAKER2_TO_DAC1
 	},
 };
 
@@ -7168,7 +7164,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
-	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_INTSPK_GPIO),
+	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_DUAL_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
 	SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD", ALC256_FIXUP_ASUS_MIC),
-- 
2.23.0

