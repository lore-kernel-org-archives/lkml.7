Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA37AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748DE218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="qR4SW4hk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbfCUIkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:40:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44893 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbfCUIkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:40:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id i2so3725610pgj.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 01:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CIv5ATPwQHBSUgPZ0gLWNz/Gua9bg8OsXzB4s1UH5IY=;
        b=qR4SW4hkOeSXBmffdrsg1Ms8Zx18u1NL5pyH5BlG95DQMjA68/VdyOjuTB79WM+sCI
         OR2XiUSESMbFJBv/vKArx7H2srMHUa+dIFjZOd3kmGDCh8Xuc6RimrwTJ73ivzxgxNV9
         GAREGnVhfLRgekys7jQHpJ+HL5/jNCUXFssUxXMvOLswuZPS27h1scJUj0xm1ypScpQp
         3UaL4zg3Z6NoBGtzuvzvb7r6/jy9iIoZTCPAGbgxr2Kif/WyuUJogVseZzXoexcs9RT7
         VAthPE3MjyGWWYBM0Bw3xRbwPctxCSzYjopI5NMXMILz6YNJ/MXqJVsuk+bKqZHmo6B4
         Ekqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CIv5ATPwQHBSUgPZ0gLWNz/Gua9bg8OsXzB4s1UH5IY=;
        b=CfbFsY/zcA39ljkMskiGUiub/zXqisg0YVC9g/Ms10e0gGTJdQR0AMhiwzProrP0PJ
         ff7H0HBoHwgOW3gEXem3PMv8KcCN86Yp/FhbSIcWmmGTAflIwc7Cj7UdoaZj5cageVlX
         JXqXhr8t3xudovfWva2JBs4HWbsOb4gVGTO7BvklEAm6IbFOLgFhwMR8m9yZjgQ5Ubau
         NDFFN7FOJsZz9EG9AbU2yt5AeCDLt30bv8PFNGjapwA/eAlMm1hCH9XmffFOZaOPbt8n
         5wPsqvIT9nodi6ITear8XHWLwJyj/kozkgdLqpF/qstjICxF4GqYci8WOFhu1QYiC0ny
         IX6Q==
X-Gm-Message-State: APjAAAVBkS9L0Hajsw8xdetpOR5UZtwBf8WHg6INXoycbotT+HAt7hYj
        wKAnBgH3+nX+Mun8jqH89tPy5xhqmps=
X-Google-Smtp-Source: APXvYqwffCVj9uZPWAMpFtPXSf9hnru1FoVuczl357XsJaGirgRg9oREcVwF2DEebmtt0N9Xlv7IeQ==
X-Received: by 2002:a63:4750:: with SMTP id w16mr2302598pgk.256.1553157603832;
        Thu, 21 Mar 2019 01:40:03 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id r24sm5058818pfn.19.2019.03.21.01.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 01:40:03 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH] ALSA: hda/realtek: Enable headset MIC of Acer Aspire Z24-890 with ALC286
Date:   Thu, 21 Mar 2019 16:39:04 +0800
Message-Id: <20190321083903.2962-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Acer Aspire Z24-890 cannot detect the headset MIC until
ALC286_FIXUP_ACER_AIO_HEADSET_MIC quirk applied.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 191830d4fa40..916bb5a3f324 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6715,6 +6715,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x1308, "Acer Aspire Z24-890", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC255_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", ALC275_FIXUP_DELL_XPS),
-- 
2.20.1

