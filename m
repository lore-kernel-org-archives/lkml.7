Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A077DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4A020830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="IkwMEo7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfCVDmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:42:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45633 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCVDmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:42:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id v21so533722pfm.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 20:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BRoNWiacASKELC27SN7jRyI+1nU6xbCdCMXI5FoGH1E=;
        b=IkwMEo7j//e5OsAaFwJaqPQYZAf5HukkCfjrMgTUif5IxqgVm31XgPVzE4cq8N5JxU
         kuS2vb/RRl6AZ198zN/02jv25pB/KYg7RDTTzWGE8rdWCHP3m/fEWIB7FUHe20GDnq4G
         5xxpB7EsZJg7iPPY8uceoTIsXNIzS+uBXw7ZQ2oj68xCuJVO/aW/j9Q/JIDPaDVoSxiZ
         stihYiTIsMphrMcXBVX78HappG59M702ZHEcN9R21yB/j+MUttVvJaqFKsDIKEYQLW5T
         By2hiJZbZv/t6QJHZ6+WkKL0QRLZfV8nxLPbY0JO64QxYSq4FQ9fO5g1SDZmnrN9g3Zm
         /w7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BRoNWiacASKELC27SN7jRyI+1nU6xbCdCMXI5FoGH1E=;
        b=Bnm1cX8+UlhVUwHI0c7d/B15s1qyp1jXBZ82NCAM/7lHu3iHNZ4EpQTGoehJ/Fh+Lj
         7eK/7Zr1OAShCgnKK9GJO5xW84B4frkjoGNtceSE2asCiZqXeLzr+m/IG/zNQ6s990ig
         MExPBdYlnekzY+Wgy/jJORec7EaMfTkf/TIaiySaPFrQ5pV3H1nO2gKgtxyPMsgRcjbT
         0OEEaY19YRYnu4dD+5v0qW5xIF/a5qJxJ7G4oqIuCFmyo5AlJDn1YvLT24AU9WG2Q4QA
         Rm0dVZ16xelVSpt9edplEdxGwfe4nLLP2SdIhUw/5XjCZTzCNSyTdZsZPkWSDkKZl7zh
         VZnQ==
X-Gm-Message-State: APjAAAXNQ4RiTblwT6ePVXbZRUZSFLqxqyLlamcsHKEb33gL6VLN+Mjz
        cKCJR46aWefCmiwdLDffjVhS3w==
X-Google-Smtp-Source: APXvYqwEN6ZQdAzQz2YcoQgGEm4wfTRXh+5aduUtXaJX4Ty2PD6tYLMC3DWkEVC3xLZ2wWrDrlVPcQ==
X-Received: by 2002:a17:902:b707:: with SMTP id d7mr7176224pls.91.1553226127495;
        Thu, 21 Mar 2019 20:42:07 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id g2sm14028826pfm.144.2019.03.21.20.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 20:42:06 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH 2/3] ALSA: hda/realtek: Enable headset mic of ASUS P5440FF with ALC256
Date:   Fri, 22 Mar 2019 11:37:20 +0800
Message-Id: <20190322033719.10793-2-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190322033719.10793-1-jian-hong@endlessm.com>
References: <20190322033719.10793-1-jian-hong@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Chiu <chiu@endlessm.com>

The ASUS laptop P5440FF with ALC256 can't detect the headset microphone
until ALC256_FIXUP_ASUS_MIC_NO_PRESENCE quirk applied.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2523e495924e..b8efb20916ba 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7343,6 +7343,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x14, 0x90170110},
 		{0x1b, 0x90a70130},
 		{0x21, 0x03211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1043, "ASUS", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
+		{0x12, 0x90a60130},
+		{0x14, 0x90170110},
+		{0x21, 0x03211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1043, "ASUS", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
 		{0x1a, 0x90a70130},
 		{0x1b, 0x90170110},
-- 
2.20.1

