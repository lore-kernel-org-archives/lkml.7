Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF3DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0121E21872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="g+pg/yXW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfCOJxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:53:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38863 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfCOJxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:53:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id n125so5974957pfn.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 02:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R34Hc5VrGY8X4eTOWGoukKjOWMd10HDmULGs/URQgL8=;
        b=g+pg/yXW7qV5PSTm7QTFnDApsNiqFWNMAP75cmNjzVnveo/6kzujpuK0ah5SEcQFyT
         HyRyksm84LQIG3nOQNw0stSZB6kXgd9+bcYpTttB8xcK2AdFWETZRbGqvwKy1ZkFFzw5
         Jxd1k+CJ1UYx7HIrC9NcQR+zqnYTJeZit+xhZkHSrEHV15m32VY6pnMMy7jM5bd+NPbS
         cQ2/uuSPAn3wz0A5X5PTZPA+osB3UZ1q1r/0zdGz+TtEqbrnlcWNTlz+Zg/TtaPerocE
         TMvbgj26MGtgLVBGqK9XCBdhtbyyYBQdhAUiYZs4MdC8OXOUmOPUgbO+y1D1pji4+DP6
         Z47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R34Hc5VrGY8X4eTOWGoukKjOWMd10HDmULGs/URQgL8=;
        b=kcVVhLl4XMK6Tu7QRtlC+GUjqEbX692rYjQGmuePYzgysUZpLUMGuvqamyWJPNkV4S
         YrsWsxNuuypFwES+Qgwlg0oWCHXYS8V/Z4Cooxqk/ie3Af9iEJGVW4HPm6yL9NT/KaZ+
         SN5tEoZkcz3jaVQcV22a4hKoLe5rA2Z07vc4XxXmNVDGZSdcIsfA7XJWpNchYJCMrhgt
         JmhUJGB4OY7MFpz8Xi3N3oC2qatevsa6TPVQ570pqSk9dY6pCzQKnPiY/lMO+5VZ0IqQ
         LxEaR+apD24JFtABmhR+pQ9uZ/Ga5JJ12SNsFlZUWS2xo7oVau6TmoQ9bb2y+2b2X7Ck
         mB9w==
X-Gm-Message-State: APjAAAXsJQNxpmYYbrdPiX/tTrl/telV8hijrzrN8iByH5JUTY2d3dc+
        ozFjlEodHOScNDrJqytmdf00ug==
X-Google-Smtp-Source: APXvYqwQ4PdExfkqBUDETtnV/7xg7siqZb27NlcmkwAMbb4F+M8bkTmUgT+fpu66g2xw5OnmIBwypA==
X-Received: by 2002:a17:902:694b:: with SMTP id k11mr3298306plt.288.1552643620759;
        Fri, 15 Mar 2019 02:53:40 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id l28sm4439705pfi.186.2019.03.15.02.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 02:53:40 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>, Kailang Yang <kailang@realtek.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH v2] ALSA: hda/realtek: Enable headset MIC of Acer AIO with ALC286
Date:   Fri, 15 Mar 2019 17:51:09 +0800
Message-Id: <20190315095108.9195-1-jian-hong@endlessm.com>
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
v2: According to Realtek's suggestion, change the COEF 0x4f from 0xd429 to
    0x5029.  Thanks to Realtek!

 sound/pci/hda/patch_realtek.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 384719d5c44e..191830d4fa40 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5687,6 +5687,7 @@ enum {
 	ALC225_FIXUP_DELL_WYSE_AIO_MIC_NO_PRESENCE,
 	ALC225_FIXUP_WYSE_AUTO_MUTE,
 	ALC225_FIXUP_WYSE_DISABLE_MIC_VREF,
+	ALC286_FIXUP_ACER_AIO_HEADSET_MIC,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6685,6 +6686,16 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
 	},
+	[ALC286_FIXUP_ACER_AIO_HEADSET_MIC] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x4f },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x5029 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6701,9 +6712,9 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
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

