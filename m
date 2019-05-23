Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C142CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885A92175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya3dE6SY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbfEWJam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:30:42 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:32942 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbfEWJam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:30:42 -0400
Received: by mail-vs1-f68.google.com with SMTP id y6so3182306vsb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 02:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PO80VBuLn5GypHKjx6dTB2iF8DAusDk59M6dfGDzXDk=;
        b=Ya3dE6SYMaV5uMVVgWaLUOSutPdll/CCuFOCaSpTLj/x3cwbY7CKDsTfFY0I7hLCa/
         +pdPi8rwvDbBtqsMKBh/8Oq/fP0KBmci5VFxdd5+9qQyMzlDsVY3Oii28y7QWHqoniLK
         Fus4hQGi9aiCmPccs0r1xLrV4pHyI/4/ETLVQiy7M08h/gXdmPD14B1XNF5VGd6+a23j
         Zw+TszY3jHZjDHaX/K2vYho0/U6OnAvLXM7ukCln36dZ0y3RHEJqjaYk5HaG8rTbLm0o
         MxseDIvUWhNz0eWoeN3YLdJHU+GqoR3gPFioq/ks9jFLaZAU0Zm5Sqj7gI8k/K2o3wwk
         GqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PO80VBuLn5GypHKjx6dTB2iF8DAusDk59M6dfGDzXDk=;
        b=Qr7sE5CpkT4othbVwGrrm3/VcTIty+1CuFIjCPdEJgsiUsMTx+sZjfnTTnEy7vIO/M
         lpZ6trNGMHnfHPu7GlaCjU01JlrU3rUBjG8x3GEH5SlPoktg8tjTmEDJeZBye4p0wOZi
         oA5l6g5WZ7hdv9iL8oThwvHcATCHS9Dg3G3FSq6LEpDua4AH560UtaxB/tJpSBGssewn
         kT3zLb3QaaudDBVJathSrGeJkQ1+N/VG3TUVdCvOt7c8Kr7HfUi+SBjyLHnmKn4FOKwC
         yK9OtC6EltbsgTsNxAeNVQWdTOe48eVNlOAKsO/1tYH5PqSbknz9ftE23ChkRUQOuC3s
         8hnw==
X-Gm-Message-State: APjAAAV3v0CgDMz22QTL5hn+4jzPRJhA1YJDwWfUaW8GD7rD8Ea2uZb7
        om1QI0Mxyi0Yh/GYxDr7CA==
X-Google-Smtp-Source: APXvYqz0jG6UhEDV42viWsxnbkgBC/9NhE3R2GAylfMg4GSs6zcoDKERuDOvknwcZ9hpcTB5F4eMKg==
X-Received: by 2002:a05:6102:388:: with SMTP id m8mr20117271vsq.53.1558603841126;
        Thu, 23 May 2019 02:30:41 -0700 (PDT)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id d81sm7809112vkf.39.2019.05.23.02.30.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 02:30:40 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     ayman.bagabas@gmail.com
Subject: [PATCH] ALSA: Enable micmute LED for Huawei laptops
Date:   Thu, 23 May 2019 05:30:11 -0400
Message-Id: <20190523093014.21019-1-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this LED is found on all Huawei laptops, we can hook it to
huawei-wmi platform driver to control it.

Also, some renames have been made to use product name instead of common
name to avoid confusions.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f83f21d64dd4..ab6a856ec614 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5747,7 +5747,7 @@ enum {
 	ALC298_FIXUP_TPT470_DOCK,
 	ALC255_FIXUP_DUMMY_LINEOUT_VERB,
 	ALC255_FIXUP_DELL_HEADSET_MIC,
-	ALC256_FIXUP_HUAWEI_MBXP_PINS,
+	ALC256_FIXUP_HUAWEI_MACH_WX9_PINS,
 	ALC295_FIXUP_HP_X360,
 	ALC221_FIXUP_HP_HEADSET_MIC,
 	ALC285_FIXUP_LENOVO_HEADPHONE_NOISE,
@@ -6038,7 +6038,7 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
-	[ALC256_FIXUP_HUAWEI_MBXP_PINS] = {
+	[ALC256_FIXUP_HUAWEI_MACH_WX9_PINS] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
 			{0x12, 0x90a60130},
@@ -7063,9 +7063,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
-	SND_PCI_QUIRK(0x19e5, 0x3200, "Huawei MBX", ALC255_FIXUP_MIC_MUTE_LED),
-	SND_PCI_QUIRK(0x19e5, 0x3201, "Huawei MBX", ALC255_FIXUP_MIC_MUTE_LED),
-	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MBXP", ALC256_FIXUP_HUAWEI_MBXP_PINS),
+	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MACH-WX9", ALC256_FIXUP_HUAWEI_MACH_WX9_PINS),
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
 
 #if 0
@@ -7124,6 +7122,7 @@ static const struct snd_pci_quirk alc269_fixup_vendor_tbl[] = {
 	SND_PCI_QUIRK_VENDOR(0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK_VENDOR(0x104d, "Sony VAIO", ALC269_FIXUP_SONY_VAIO),
 	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad", ALC269_FIXUP_THINKPAD_ACPI),
+	SND_PCI_QUIRK_VENDOR(0x19e5, "Huawei Matebook", ALC255_FIXUP_MIC_MUTE_LED),
 	{}
 };
 
-- 
2.20.1

