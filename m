Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E99FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D903A20830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="k7ozUAUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfCVDl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:41:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34801 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCVDl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:41:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id v64so566884pfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 20:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=clZMkpeTShj1B8W+xPbB9E++esPvww+cHpjnyKa9i20=;
        b=k7ozUAUd06neIXna2xpfnaD+KaNYavnaZr7GfKRXqg/OA6K2UPBHI3cMTo6czrBsiB
         wM/QPjBTvnFBr+oEy9NKSuYXdE/FvHRsRvOc5CAhTzlTm8dRWpbdCGVkcEoxqbUaicec
         CIGohya6n52lULRgLYBM+QyZ0lCgoSiHlvvVizmpC0I7OhOi3goqZd7Ui0rz63+pPpTX
         bkvGeKJgiBObe/GAizon/gpHCiTSKcudraAiU6+jJ6EVaSp+IpeurZQXZbJjnC2KN/JZ
         A5sA857Bz0kLO3xTfsh9AXSgH83GxtGjwPHOmX4lMge9Au2yqOpZGqSWSsiD6UgrbP2g
         3ZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=clZMkpeTShj1B8W+xPbB9E++esPvww+cHpjnyKa9i20=;
        b=MnGiGVmOQQ+XaRLhqdP8UqzX387381DC4jIq0VSuXa+UB76wUdGfa1LQ/yn45xkwnU
         7Y4qX2oJjEtMk+sGR7820D0JuUbCYPfZoQWSRZDvfPO/XHFbIwGtiF7M2Yq39oZ5vHMo
         JKpfEjKYdkg5COlpYucE98SYxXAR4OILkZ0zCM/G+W31NV/YPSPNDcaJ+JigqKg/W8nx
         wKdPw+ODiSPcJkzGvU/6caxaT84+8kvIau77Py8095gEq0CghZU2rCxMiAe8x7SyiJVq
         jZi2GLd3csBjGzt1QQ/8hJZeuF1em0FZk/ataA+5L84U3hoMR7fb0WbCiyhR7FKP+OyR
         Wq6Q==
X-Gm-Message-State: APjAAAUKQs1rqZy7cYexSXTx+B+cpU6JF6JYyav1SC3o5inhIncG1enV
        A1uBDqygERx3u05iOBcPXrcUVw==
X-Google-Smtp-Source: APXvYqzufuWzH02wuXsinHUee1llsSkXq93j0zrq0SR9CIN/m4hmHI4R/mVkRBGcg8Y/lyc7iD39tA==
X-Received: by 2002:a62:55c7:: with SMTP id j190mr6765066pfb.226.1553226084652;
        Thu, 21 Mar 2019 20:41:24 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id g2sm14028826pfm.144.2019.03.21.20.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 20:41:24 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH 1/3] ALSA: hda/realtek: Enable ASUS X441MB and X705FD headset MIC with ALC256
Date:   Fri, 22 Mar 2019 11:37:18 +0800
Message-Id: <20190322033719.10793-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS laptop X441MB and X705FD with ALC256 cannot detect the headset
MIC until ALC256_FIXUP_ASUS_MIC_NO_PRESENCE quirk applied.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 89a96442eb07..2523e495924e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5688,6 +5688,7 @@ enum {
 	ALC225_FIXUP_WYSE_AUTO_MUTE,
 	ALC225_FIXUP_WYSE_DISABLE_MIC_VREF,
 	ALC286_FIXUP_ACER_AIO_HEADSET_MIC,
+	ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6696,6 +6697,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE
 	},
+	[ALC256_FIXUP_ASUS_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x04a11120 }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7333,6 +7343,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x14, 0x90170110},
 		{0x1b, 0x90a70130},
 		{0x21, 0x03211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1043, "ASUS", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
+		{0x1a, 0x90a70130},
+		{0x1b, 0x90170110},
+		{0x21, 0x03211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0274, 0x1028, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB,
 		{0x12, 0xb7a60130},
 		{0x13, 0xb8a61140},
-- 
2.20.1

