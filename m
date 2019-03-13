Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D67C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4162C2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="2Di2N5GA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfCMJd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:33:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33666 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfCMJd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:33:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id i19so991053pfd.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 02:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yvz7KyEi8AZK4nIaVu7uWxj0DgdXUPU76VjA2dNvNC0=;
        b=2Di2N5GAvlb1ajm9+eY9QblKS6gu9WLOHKHHtNqQziniW7LPjW5pTIK3GU7movMImr
         xZ8EpxnC8S4lOoKBQKEBsf1sPbg58JBIPV0L04PIXFcftXlwIr51Kipz6iRXmdN2y8OL
         GDvrOtQx3IQDN0RKO9QLBcil1jIeb8th20XEjHfj2/mAD48WMX/nk3Kd/cL+9gEbTQ/i
         bAzycfrrUy4Stcd0lhCBdkYkdi/KpA6Np+Ca05JD/38mD2EomphPWYWEiyQG/LCrQ2r8
         oQVw7aKVnK0wbosp8AueF60rWQFKZtMCcNlDZzQBKUk8UAJzjDS5HRr3n86H1EU9CqHy
         n7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yvz7KyEi8AZK4nIaVu7uWxj0DgdXUPU76VjA2dNvNC0=;
        b=O6iMdL3oo98a5pzIY/s/00dOBQq8kFpDCNDHpgQIGsKgQEZuW2mThQCkbTmlCWU9jH
         svRevaiCzXVnxr3ds5unesabPbwuxZm/6wEzxjbiPyYPyXi8yU1+awMWHM7cAROYf46Y
         n9+zchfxss/qh6t+WE1EvO3qlIcsx6yncXakFgAKHaDZpiT55cj8HZmKRBQ5XcAnapOX
         zflueLVkn7r01dwfIfwWoIoDXj39J7d2z9tv/6rmkloqAPef+rUw1LltwNOYDcobcfuK
         raXm4EruSp10IROPaNKLN+pSxgJy3zE7d27174jX9IUvTPhbxY5VsmDRYvOn3xXNKtFl
         9d2A==
X-Gm-Message-State: APjAAAWcw2MZoF35H66RLuIBG8xbGjCkdD/6u1did2SZLIBZ8C95LkN4
        ejonUof9G5vTAa/iLTUgTLUNIw==
X-Google-Smtp-Source: APXvYqwgBlV+xZAdAAtLOGo0SkwGZQY74pshQaZcqGKMfwinxfPaC4YnPMZ8YlsexyDR/C9oHPtQfQ==
X-Received: by 2002:aa7:8749:: with SMTP id g9mr7551615pfo.36.1552469637300;
        Wed, 13 Mar 2019 02:33:57 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id g67sm25095238pfg.13.2019.03.13.02.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 02:33:56 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] ALSA: hda/realtek: Enable headset MIC of Acer TravelMate X514-51T with ALC255
Date:   Wed, 13 Mar 2019 17:33:24 +0800
Message-Id: <20190313093324.4034-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Acer TravelMate X514-51T with ALC255 cannot detect the headset MIC
until ALC255_FIXUP_ACER_HEADSET_MIC quirk applied.  Although, the
internal DMIC uses another module - snd_soc_skl as the driver.  We still
need the NID 0x1a in the quirk to enable the headset MIC.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Kailang Yang <kailang@realtek.com>
---
 sound/pci/hda/patch_realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c8413d44973c..8debd661e6f2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5673,6 +5673,7 @@ enum {
 	ALC225_FIXUP_HEADSET_JACK,
 	ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
 	ALC285_FIXUP_LENOVO_PC_BEEP_IN_NOISE,
+	ALC255_FIXUP_ACER_HEADSET_MIC,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6639,6 +6640,16 @@ static const struct hda_fixup alc269_fixups[] = {
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
@@ -6658,6 +6669,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC255_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", ALC275_FIXUP_DELL_XPS),
 	SND_PCI_QUIRK(0x1028, 0x05bd, "Dell Latitude E6440", ALC292_FIXUP_DELL_E7X),
-- 
2.20.1

