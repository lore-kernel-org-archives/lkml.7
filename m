Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68DCC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 03:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAA32071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 03:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="xhvr6vb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfL3DJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 22:09:26 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40040 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfL3DJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 22:09:25 -0500
Received: by mail-pg1-f195.google.com with SMTP id k25so17344723pgt.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 19:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=upEp8hl/kvhyOaP5IttMFvt3fWm36jVnMskRhcv5Zsk=;
        b=xhvr6vb2vZ0nn9EkANyBeJ5qsjBOHgXsLHVLUI8feB/l9fEpSQ8CzFPbJ2j+XgOIIR
         iTiPa3GdPHp13L2XH3BipCwvkZBJVaS7hNXn5OEoHTB7iAwgNr92Vf0REjYzyrDsivTX
         5Mf6DbwoQBgpgqIJfd+nHGqOxkehd0/5Tg94GwBXiXXmAD71fA2eWOu1uweHQnW/DJSO
         dwoEHY72JAtx70KLly+5E+1XP23IYi32uoEsdivHV7VSWvCkoATuCOYqbsWO2LsvbA9M
         btV+3V170bxvckTDFUlFXLaXC3NiXtaimZG1+ZzgtXouulwKL599jDeExJIg7gA34Z9s
         l6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=upEp8hl/kvhyOaP5IttMFvt3fWm36jVnMskRhcv5Zsk=;
        b=HIomxr28FHo3WC7jExHOevnBXnriuQcBaMWVnn2qwDgNOqPieEJaT7+ZoXFD/c1NLk
         SBNkWL3w8RZAqaoXoGpvRfPTLtHtUjyR/rpfx0UX2pikJT50P0GupInZrEcYvIhr1Vc5
         CXjHBJ7sqsmOCCBIkPeMv6HgwWyFHfAx73vb4V++/1rLScQJ1fuDAgzAoBUhz1Nl9/uO
         yKey71kVPs8ZqT7OfsehyDtTVI5GjLVTLoawROAw8B8KiA0weva0Y30tiIrhxdG7kIJv
         6UIgn9p0q7voCWHf/X5W137tnvBenHGxQlFFox0fL17OtHbTglzWJtDFsZUdacOJMV39
         I5cg==
X-Gm-Message-State: APjAAAUNvOHbYBzW1k1+OQY6b7g8p7ZNdpaksDVik5Switr9WXlVUGyd
        AuKv3CSOHzsK8O+7bVEEiD+mYQ==
X-Google-Smtp-Source: APXvYqyVElD4pB1vEk1hC+Kw8wCBz6j5MXcKPX1pbthfR5Z1vmDdVDy68/M3hAyrbQ6slwFEa26nLw==
X-Received: by 2002:a63:6d0e:: with SMTP id i14mr71335137pgc.12.1577675364836;
        Sun, 29 Dec 2019 19:09:24 -0800 (PST)
Received: from localhost.localdomain (59-127-47-126.HINET-IP.hinet.net. [59.127.47.126])
        by smtp.gmail.com with ESMTPSA id a23sm50434516pfg.82.2019.12.29.19.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Dec 2019 19:09:24 -0800 (PST)
From:   Chris Chiu <chiu@endlessm.com>
To:     perex@perex.cz, tiwai@suse.com, kailang@realtek.com,
        hui.wang@canonical.com, tomas.espeleta@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH v3] ALSA: hda/realtek - Enable the bass speaker of ASUS UX431FLC
Date:   Mon, 30 Dec 2019 11:11:18 +0800
Message-Id: <20191230031118.95076-1-chiu@endlessm.com>
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
UX431FLC") which only enables the amplifier and the front speaker.
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
  v3:
   - Rename the fixup to align with the naming of ALC289_FIXUP_DUAL_SPK


 sound/pci/hda/patch_realtek.c | 38 +++++++++++++++++------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2ee703c2da78..1cd4906a67e1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5905,11 +5905,12 @@ enum {
 	ALC256_FIXUP_ASUS_HEADSET_MIC,
 	ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
 	ALC299_FIXUP_PREDATOR_SPK,
-	ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC,
 	ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE,
-	ALC294_FIXUP_ASUS_INTSPK_GPIO,
 	ALC289_FIXUP_DELL_SPK2,
 	ALC289_FIXUP_DUAL_SPK,
+	ALC294_FIXUP_SPK2_TO_DAC1,
+	ALC294_FIXUP_ASUS_DUAL_SPK,
+
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6984,16 +6985,6 @@ static const struct hda_fixup alc269_fixups[] = {
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
@@ -7004,13 +6995,6 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
 	},
-	[ALC294_FIXUP_ASUS_INTSPK_GPIO] = {
-		.type = HDA_FIXUP_FUNC,
-		/* The GPIO must be pulled to initialize the AMP */
-		.v.func = alc_fixup_gpio4,
-		.chained = true,
-		.chain_id = ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC
-	},
 	[ALC289_FIXUP_DELL_SPK2] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -7026,6 +7010,20 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC289_FIXUP_DELL_SPK2
 	},
+	[ALC294_FIXUP_SPK2_TO_DAC1] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc285_fixup_speaker2_to_dac1,
+		.chained = true,
+		.chain_id = ALC294_FIXUP_ASUS_HEADSET_MIC
+	},
+	[ALC294_FIXUP_ASUS_DUAL_SPK] = {
+		.type = HDA_FIXUP_FUNC,
+		/* The GPIO must be pulled to initialize the AMP */
+		.v.func = alc_fixup_gpio4,
+		.chained = true,
+		.chain_id = ALC294_FIXUP_SPK2_TO_DAC1
+	},
+
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7187,7 +7185,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
-	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_INTSPK_GPIO),
+	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_DUAL_SPK),
 	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
 	SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD", ALC256_FIXUP_ASUS_MIC),
-- 
2.23.0

