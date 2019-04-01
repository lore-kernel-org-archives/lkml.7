Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC45C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 03:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56522086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 03:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="lTZP0Fqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731794AbfDAD0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 23:26:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37528 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731383AbfDAD0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 23:26:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so3820697pfr.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 20:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=npgKgNSdlqU8Z2V5vLurv1Xl/iA4tNfvDxH6hPU2Mv4=;
        b=lTZP0FqalV4SK1qnidbw9uQVQU8KDz3MDrBNZW+YSnT30QHVgDV5N9URMmIGeLpRV5
         Z5IrLVKhDSEvzQ6JsuIjjnfCvjMlrUd+eXu9xjvVl22LXuhMiNMLx0YayBE9T8Rzeqci
         RW3Suqt7Z/sD2iMWAZ4y64kjmNp5BCsQAEWWrX2G713mZsz1Fr8zuFDjEX+bWnSz/VFl
         xZQjJmNdxFFfLKLElj5F+4RGdwdLIoBfrqNo/rhLuFN8cEkWT4Gt3MrTstR7FxIIUzrO
         XlTRZAziJIt4iVVluq//62/LG5FpUwpER7PEzY7P8ZDawgn9oZFJvPnMiQeo8tyoY1Jv
         fOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=npgKgNSdlqU8Z2V5vLurv1Xl/iA4tNfvDxH6hPU2Mv4=;
        b=huZBLXRgR2kSUl4IBFpt6fp3xco/LSz5ofEpdjYAihyf2cmwYEV6pbJoTzDNXrj5Dp
         EgC6btxYVm/Fz8dBmN8TgrEv9GnzC8pD1eCPM3zIZ4nuy4FE81jKtYdyuepXPDwvwHsa
         hnYVAXXIu/iiOUVewtcsgw+xSq30cP56zSrfV2q0sQT33MnkfduAOifnrGb8v1Hm5wiD
         bRsq2HKATNEwoCTJJDFHU5vGwcsgawfyNfO8OFo9cnse8i6G99GHVT2IK/QWqXdbFnHq
         c5shuyrebg2jLy3ps2PrDdZzPxINplsIVq1nqQpi0TQYpW+M0R9/xfMbZTfN+JACbRAw
         /0kg==
X-Gm-Message-State: APjAAAXfmmFJjYUyMwko4OXI4AwFgwVp2/V6TPt6oq58KNADKlZHWgMB
        7/xGO/ppeJG0F+sYFMoPBN6FwA==
X-Google-Smtp-Source: APXvYqxPuTtVXXqI5A+y4KPpVcKC4LKwf629McjG3avFIxJlT2DAlETxz5wU2l0jdMYLB8X8hSI48A==
X-Received: by 2002:a63:29c8:: with SMTP id p191mr50763617pgp.197.1554089184009;
        Sun, 31 Mar 2019 20:26:24 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id l19sm10745312pff.1.2019.03.31.20.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 20:26:23 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH] ALSA: hda/realtek: Enable headset MIC of Acer TravelMate B114-21 with ALC233
Date:   Mon,  1 Apr 2019 11:25:05 +0800
Message-Id: <20190401032503.2821-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Acer TravelMate B114-21 laptop cannot detect and record sound from
headset MIC.  This patch adds the ALC233_FIXUP_ACER_HEADSET_MIC HDA verb
quirk chained with ALC233_FIXUP_ASUS_MIC_NO_PRESENCE pin quirk to fix
this issue.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a3fb3d4c5730..bdb2227be4eb 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5690,6 +5690,7 @@ enum {
 	ALC286_FIXUP_ACER_AIO_HEADSET_MIC,
 	ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
 	ALC299_FIXUP_PREDATOR_SPK,
+	ALC233_FIXUP_ACER_HEADSET_MIC,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6713,6 +6714,15 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ 0x21, 0x90170150 }, /* use as headset mic, without its own jack detect */
 			{ }
 		}
+	[ALC233_FIXUP_ACER_HEADSET_MIC] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x45 },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x5089 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC233_FIXUP_ASUS_MIC_NO_PRESENCE
 	},
 };
 
@@ -6737,6 +6747,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1308, "Acer Aspire Z24-890", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x132a, "Acer TravelMate B114-21", ALC233_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC255_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", ALC275_FIXUP_DELL_XPS),
-- 
2.20.1

