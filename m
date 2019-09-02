Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04D2C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 10:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A338217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 10:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="mh3+HhRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbfIBKCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 06:02:41 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37907 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730250AbfIBKCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 06:02:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id h195so2208644pfe.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 03:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RQ4bgGpDe1aO2dcXCN2kWEia8kVQV/JW3GaWgKM7FYE=;
        b=mh3+HhRmMDF81+H6REGveUB1w/FITeP87l5Kn0pE/4A7ip3Z5n/gzLlKFGvZ4X1urg
         uTrpaaPPotgwE1gr0/qkMLkkEL1LFvVDQ1g6zdBYh5mNyl/iYUjoMweg1L0+Iq06FP5f
         f4Qty34vvU0ICYsKoQ6NQB2X16O+G5MR8/eRKCBB9pORO2u6OXD2bBaa+CskviGyjQRX
         D39hS8k6KY0yQtWXsycwUKfCKd28ujoMsypj9cyIrODLgCNiyce+93/An3DIAZLTGnws
         cujQTluCGz50xtILEjftm19ngvM+CNMXSRx2BuJDGhzdrOePRM8YHdbV93g9Xd4znWws
         /1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RQ4bgGpDe1aO2dcXCN2kWEia8kVQV/JW3GaWgKM7FYE=;
        b=I8963KPNPlSpZFgwEbGm2hg3ly9JQUujZobb9tR2FbVOejFyhFBCeydsMDgmMC9pnv
         YHrlK8y+GA1Nu/RENKZr2IzXKOPSjqs7Skl5IhsQ/w7ikyl55z8aPx1F7d78YERu/SNv
         jKZCVnDgyq+IVXfFwePOCh6ckHbxUmTMx8OehnJ5B9MujqGEa1NDaIHCjFBcsePrRltQ
         OElhpV1UNuX+Ci3ZUUReNPWKIdyQfk2g/xFcYlf9gWc9Jk1/pbjElx5hg27jxNVMRAm5
         T8k5aVgCCA0bAz8M5m9cYlsGZgKIDKlpPI4KsgyBH1l9b7Xu8SaQk9j1SGm6z3OWTz5r
         0Y4Q==
X-Gm-Message-State: APjAAAUHOp+RFj8IWBcc+dlvwBe/Tw/vOGhDLQ0rfBgGx13mOtsYBOwz
        WbU6qLXls+lrv0U5qm85OQ9gYA==
X-Google-Smtp-Source: APXvYqxRf34N5BEFEv8etsDj/JI3+CfZ0JnpQI+TsEcRr5YSB05J7K3rQw7oqzyvUHr981kBtMIs4g==
X-Received: by 2002:a62:2603:: with SMTP id m3mr34483187pfm.163.1567418560532;
        Mon, 02 Sep 2019 03:02:40 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id z4sm12783932pgp.80.2019.09.02.03.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 03:02:40 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] ALSA: hda/realtek - Enable internal speaker & headset mic of ASUS UX431FL
Date:   Mon,  2 Sep 2019 18:00:56 +0800
Message-Id: <20190902100054.6941-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Original pin node values of ASUS UX431FL with ALC294:

0x12 0xb7a60140
0x13 0x40000000
0x14 0x90170110
0x15 0x411111f0
0x16 0x411111f0
0x17 0x90170111
0x18 0x411111f0
0x19 0x411111f0
0x1a 0x411111f0
0x1b 0x411111f0
0x1d 0x4066852d
0x1e 0x411111f0
0x1f 0x411111f0
0x21 0x04211020

1. Has duplicated internal speakers (0x14 & 0x17) which makes the output
   route become confused. So, the output volume cannot be changed by
   setting.
2. Misses the headset mic pin node.

This patch disables the confusing speaker (NID 0x14) and enables the
headset mic (NID 0x19).

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e333b3e30e31..0a1fa99a6723 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5797,6 +5797,7 @@ enum {
 	ALC286_FIXUP_ACER_AIO_HEADSET_MIC,
 	ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
 	ALC299_FIXUP_PREDATOR_SPK,
+	ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6837,6 +6838,16 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ }
 		}
 	},
+	[ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x14, 0x411111f0 }, /* disable confusing internal speaker */
+			{ 0x19, 0x04a11150 }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6995,6 +7006,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
+	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_INTSPK_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
 	SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1b13, "Asus U41SV", ALC269_FIXUP_INV_DMIC),
-- 
2.20.1

