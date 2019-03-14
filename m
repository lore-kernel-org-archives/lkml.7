Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF54AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DBA217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="yfSc6C/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCNJA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:00:56 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45737 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCNJAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:00:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id v21so3367077pfm.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 02:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9/H5GPG5TzysHz/4vblclyc79/Qd6mhu+FfYyvkY5iA=;
        b=yfSc6C/SzmLRAc2jH6As6SnOu0VK9apzVesZwFk9KYzLNxbsw39kRX5uBX+pZL/t0h
         QBCfkIR6+07feza/owCrA7/qJlK816c7yO0XrkhdZOIRFfTQcdtWiM949XHC2ceC99Cy
         Q+PF0e8wy4OnW8JEmnxLaliB60KKpLDTZoTO46h3eYYqRyKA0X5BxHiFoZ1hw3NduSuB
         MnnrNl1cPg1Ne26yZoZ73h26w3Wt7OIeVor5Naqxjtoc5Da/4UAjTMl32L7kGXtyogDc
         SOumBchYiZiRlc+pdkuVuYHKV4irQ7xdohx5KanDtQ6yKoNfzigKB2dxvfeXDrm4OHcC
         4ItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9/H5GPG5TzysHz/4vblclyc79/Qd6mhu+FfYyvkY5iA=;
        b=RYa5x69y7OzndpnMcD1F9dbFKM9wA/+KCcj0rCw5YjGYgEfIbmD9qjfB83Kl9Ln4wf
         OSMY9qUjmIDKwszbmDBnD5B7UfznjUZ7rvDrWFXID/KSS5L2zGuiMjyaZQK4mXHuD2cI
         hmf6thO/3o8VqOYRNBCpgTvrgH0Aq7oJ99ACG6k/WhMfNYAwH6TKJF/LzxEKfMrDMDhx
         GEKD22bUmmXjlwi4rEVXC9Icp+RCxkGmsKitPanLgZ65wLha4o1Ocb48FW91iYyJPnCD
         jVFpL/ck8xWrs4WQt2I+PO1LLIPV843j9+0h/gPlTcG2eGMjho4pSLIfpm4ZbB6KHQ0V
         Trvw==
X-Gm-Message-State: APjAAAXBHU1iwz7QFxMRu1EiMB2q39JOgBLFZo2m1GP3klVo4OnsEg1q
        sXMDHMeVNrC0VX6y+nUB+To8oA==
X-Google-Smtp-Source: APXvYqw2NQ7jCmn0sO5RfcEfnjjLjAzmyo+z4gsDfudkkeGLWseGufea15XL3pLjnkFSjnhPdz/uwQ==
X-Received: by 2002:aa7:82d7:: with SMTP id f23mr48594927pfn.114.1552554054431;
        Thu, 14 Mar 2019 02:00:54 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id u24sm20708033pfm.140.2019.03.14.02.00.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 02:00:53 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] ALSA: hda/realtek: Enable headset MIC of Acer AIO with ALC286
Date:   Thu, 14 Mar 2019 16:59:34 +0800
Message-Id: <20190314085933.11404-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Acer AIO desktops like Veriton Z6860G, Z4860G and Z4660G cannot
record sound from headset MIC.  This patch adds the
ALC286_FIXUP_ACER_AIO_HEADSET_MIC quirk to fix this issue.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a63670013943..b3fbad5a680f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5695,6 +5695,7 @@ enum {
 	ALC285_FIXUP_LENOVO_PC_BEEP_IN_NOISE,
 	ALC255_FIXUP_ACER_HEADSET_MIC,
 	ALC295_FIXUP_CHROME_BOOK,
+	ALC286_FIXUP_ACER_AIO_HEADSET_MIC,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6677,6 +6678,16 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC225_FIXUP_HEADSET_JACK
 	},
+	[ALC286_FIXUP_ACER_AIO_HEADSET_MIC] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x4f },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0xd429 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6693,9 +6704,9 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_ASPIRE_V5_PINS),
 	SND_PCI_QUIRK(0x1025, 0x102b, "Acer Aspire C24-860", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x106d, "Acer Cloudbook 14", ALC283_FIXUP_CHROME_BOOK),
-	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC255_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", ALC275_FIXUP_DELL_XPS),
-- 
2.20.1

