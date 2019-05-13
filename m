Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D78C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC0320862
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8nFyRFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfEMUad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 16:30:33 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38950 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfEMUac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 16:30:32 -0400
Received: by mail-vs1-f68.google.com with SMTP id m1so1732283vsr.6;
        Mon, 13 May 2019 13:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jVLUCuvIkgHf1PJRweruJ3z4sfjR/n08csEPSkBQeiA=;
        b=E8nFyRFa7hSDOzGPngvfVrHBMQ2geS+vTTr2QU0F1v2MFpx9RQK0A9P/q2QU2k2f+v
         oP6iUKNKQsWRnqoMef92zWQ57knOTjw0RFBtPsDsRPSFsCj+OIEYcWNLMzOK40OlUc9C
         WnkB7BNPFdpixtqtchVJpgXXrHxF9AJ2ySOQBKUxWygQWzAvqRznM7RJJ6yv2int/1sd
         YOhed0gcnpVvkFVG/r6Ah9ji5TvcqKNEFqouVTxHt+E1PoAWj5cZNGTJiRTC0fNgpBiw
         8ZAj9GdJ5szvHwDXb25JHB8tnilFN3zdUYZJe700sC+SwGwJhgXU6scFluoRoPNQtAZf
         z88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jVLUCuvIkgHf1PJRweruJ3z4sfjR/n08csEPSkBQeiA=;
        b=MEn8X3q5pC+aWtxt8kMIPzPjRSTSbGT/TRvubbxYwsDMO2vSi4uKIJKpldrE8HNYaD
         zjs+LcCGBDL2kWlMFYinYRS9TcCHazz1DM2XeM4qem5AMukqpnaFYQujPNS8XYiNOFAG
         U1VbBGkLo0bXDAikB3/noq+JhtuG5RK/wFGBXHYLD6FKYVjP2wdWYSiV84DxMRIQuMrJ
         4YAI993VGddef9oupqm2FJ9TtS+LIzGqaHKJWFMM2yHhxmHtK5Qyny9tC+u0oD6PkhA5
         T6iv74t+NZzJrZCUe3zut3PhoNKjX9EVjAvQGVeLl+VbnW+3kYcp9RBhz/sK+3bmpsoc
         dcJg==
X-Gm-Message-State: APjAAAV9WEOgvfTKKsDx0REmNT28niff2nPEh6Dva9Ru/393Qm2mD63U
        WPxVdns0EXKERkVagpbs6Q==
X-Google-Smtp-Source: APXvYqwMryfqgImbiP13+/arDvUYMQDSct2MI76bgMrirL+kFL49BVKMSV1BVgRcsHsqBsKujSk0wA==
X-Received: by 2002:a67:d71d:: with SMTP id p29mr16059536vsj.223.1557779430915;
        Mon, 13 May 2019 13:30:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:902:c200:6512:37bd:d695:3a39:ceb9])
        by smtp.gmail.com with ESMTPSA id 143sm1285120vkj.44.2019.05.13.13.30.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 13:30:30 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        Hui Wang <hui.wang@canonical.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     ayman.bagabas@gmail.com
Subject: [PATCH v1 2/2] sound: Enable micmute led for Huawei laptops
Date:   Mon, 13 May 2019 16:30:06 -0400
Message-Id: <20190513203009.28686-3-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513203009.28686-1-ayman.bagabas@gmail.com>
References: <20190513203009.28686-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this LED is found on huawei laptops, we can hook it to
huawei-wmi platform driver which uses the common WMI interface present
in these laptops to control the LED.

I've also made some renames and used product name instead of common name
to avoid confusion.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 42cd3945e0de..3661470766ba 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5684,7 +5684,7 @@ enum {
 	ALC298_FIXUP_TPT470_DOCK,
 	ALC255_FIXUP_DUMMY_LINEOUT_VERB,
 	ALC255_FIXUP_DELL_HEADSET_MIC,
-	ALC256_FIXUP_HUAWEI_MBXP_PINS,
+	ALC256_FIXUP_HUAWEI_MACH_WX9_PINS,
 	ALC295_FIXUP_HP_X360,
 	ALC221_FIXUP_HP_HEADSET_MIC,
 	ALC285_FIXUP_LENOVO_HEADPHONE_NOISE,
@@ -5975,7 +5975,7 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
-	[ALC256_FIXUP_HUAWEI_MBXP_PINS] = {
+	[ALC256_FIXUP_HUAWEI_MACH_WX9_PINS] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
 			{0x12, 0x90a60130},
@@ -6996,9 +6996,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
-	SND_PCI_QUIRK(0x19e5, 0x3200, "Huawei MBX", ALC255_FIXUP_MIC_MUTE_LED),
-	SND_PCI_QUIRK(0x19e5, 0x3201, "Huawei MBX", ALC255_FIXUP_MIC_MUTE_LED),
-	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MBXP", ALC256_FIXUP_HUAWEI_MBXP_PINS),
+	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MACH-WX9", ALC256_FIXUP_HUAWEI_MACH_WX9_PINS),
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
 
 #if 0
@@ -7057,6 +7055,7 @@ static const struct snd_pci_quirk alc269_fixup_vendor_tbl[] = {
 	SND_PCI_QUIRK_VENDOR(0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK_VENDOR(0x104d, "Sony VAIO", ALC269_FIXUP_SONY_VAIO),
 	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad", ALC269_FIXUP_THINKPAD_ACPI),
+	SND_PCI_QUIRK_VENDOR(0x19e5, "Huawei Matebook", ALC255_FIXUP_MIC_MUTE_LED),
 	{}
 };
 
-- 
2.20.1

