Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629D3C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F742071E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="Emq8bumT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfKYJfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:35:22 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42554 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfKYJfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:35:22 -0500
Received: by mail-pg1-f195.google.com with SMTP id q17so6893189pgt.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 01:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4/z6y/lM25UnwrOC7SJQVocxqxujjJ+VWEHPJueEijk=;
        b=Emq8bumTRWRp4IfwHVIBioxstETvN2zCnvFpvuYDFD+VNDlXil2IIyFxjnw+XCmh0w
         l3UyxtIg2AgMnP83Ef+GM4IoKNFnDvIz51MIlgr0mFNQ2UNPNZI8+aaUBD1feBCYkvHS
         rtoBy+mUu08tugYNlD5wLTmILXyRfNyN8YSY2Zp81Vh+8IkHH5FHVblPO7usVcii+wLO
         iU63I5N+JgPojMvFtPKHA5u51OT944+Yc7Qf+tuEhZv3ftUtegHhSn6Mx+vjuAX0QIeq
         cx2N9Ji0/Qu4brX994RRM4Pi+CmVRXVuhgmuQObGJFWMQabWmZQ0wc+8rQ0fivuj7v0O
         9MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4/z6y/lM25UnwrOC7SJQVocxqxujjJ+VWEHPJueEijk=;
        b=rY4FxrcZ46rFG5P82jNRcdfamguwi8lF8eVzoE0HLeAV++/tW3OGRCs/5vlS/XcR0h
         x5+BHvn4xogiclUsCMiI37ZdrY5ZDhsVS5AztBDV9EmOix8i0PbgaRBqlraq63/IPhHF
         cBxZz8fgw7oZiA5LCODAr+Wi4hfWHqWP7lKupmGWpM8uDVWduuMEfuvrRXvZ1QVIPZQI
         TcSWuXJ0ziCNTdL1gHFbBJBWztbxf3tAhoMO0G4blt6649rx6crj6Q2eODWUdjk+h3Eq
         VbhVkc/mqi7tYq4moSSOOuPnx34Q3vaI4vavhXiM6oXil+z4WxarNs0PoDA/FlahtRqq
         xL5g==
X-Gm-Message-State: APjAAAXI3ipADXGdGqXyrnD2Fmq84xArxpHVvXFzr4O0vdomUX6CiTYG
        mBEamBBvcwntp+rD1scedkoSAA==
X-Google-Smtp-Source: APXvYqx1wUh4ZkMgMOZDf3dRtAJT4xi4XMxa2xxICe7xCOcPRD6k8ebBROgF9NQQtyiBzRobB+vZ4Q==
X-Received: by 2002:aa7:982c:: with SMTP id q12mr33929274pfl.83.1574674519876;
        Mon, 25 Nov 2019 01:35:19 -0800 (PST)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id f10sm7459009pfd.28.2019.11.25.01.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 01:35:19 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] ALSA: hda/realtek - Enable internal speaker of ASUS UX431FLC
Date:   Mon, 25 Nov 2019 17:34:06 +0800
Message-Id: <20191125093405.5702-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laptops like ASUS UX431FLC and UX431FL can share the same audio quirks.
But UX431FLC needs one more step to enable the internal speaker: Pull
the GPIO from CODEC to initialize the AMP.

Fixes: 60083f9e94b2 ("ALSA: hda/realtek - Enable internal speaker & headset mic of ASUS UX431FL")
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 80f66ba85f87..eb6894a67302 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5892,6 +5892,7 @@ enum {
 	ALC299_FIXUP_PREDATOR_SPK,
 	ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC,
 	ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE,
+	ALC294_FIXUP_ASUS_INTSPK_GPIO,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6982,6 +6983,13 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
 	},
+	[ALC294_FIXUP_ASUS_INTSPK_GPIO] = {
+		.type = HDA_FIXUP_FUNC,
+		/* The GPIO must be pulled to initialize the AMP */
+		.v.func = alc_fixup_gpio4,
+		.chained = true,
+		.chain_id = ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7141,7 +7149,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
-	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_INTSPK_GPIO),
 	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
 	SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD", ALC256_FIXUP_ASUS_MIC),
-- 
2.20.1

