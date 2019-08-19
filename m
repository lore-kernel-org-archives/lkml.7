Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA7FC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0437B22CEB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/sammI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfHSUkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 16:40:55 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36751 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbfHSUkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 16:40:55 -0400
Received: by mail-lf1-f65.google.com with SMTP id j17so2379995lfp.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 13:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iwYJ4kbsjiWxcAgwDAclP5P256WJDBfh8B5iTsScM3w=;
        b=t/sammI9AoE2YlOs6wvwHNoXr0FW3ngr/DjAjNRLqhHhaL1xVyOY4spyQGQTeJlUq6
         2FbQeVCj9gGkPLo3A77S47fCF6s9J7RLANw++Q02bUhObzJDY2cWu7bhoKHgpXmrbNKN
         WO5iVvf81K+j2+g9fkb/siG4MAH0cXdePvwfkvtqcfvJL0aU+iJJ5KTlVl0JHjattdMz
         1Godo63Xr9myJOPbw1E1PVwkJZYdB8BNjGsrjkr1rB2W1LglMXVekmiFFoWFDC812Bax
         RhwJkGHP2JI/+pRL26wwgBXSvDw92eNVxadnZCygqsSPjRHbm+aewppcDILiq6dXtyqj
         Mn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iwYJ4kbsjiWxcAgwDAclP5P256WJDBfh8B5iTsScM3w=;
        b=KXK3J47kTF0caRnhsHWPcS9tIitk/fQnMWz4T8YbkYEXmDfBjCSCuXuQB3mmAQjuEs
         4htHahftOP+1/gyUM/QtUwZEUCmhsijnaJDCmlneqvvENTqxlZLUyPbT2LdhaZYQJIlo
         y9Jvd3Jc95Sk1zfEEzjDgcHG1YrpVX6Y1cOZXvU6Y7REIsJrcIneXm0ZQnOLiqfVxrrB
         prMwvfgtBSVgfysB0Jsc2eOOW9hvSLpw1pDSPxHqcxISpxNMAV6jKIZAXoJZ/Qv6vUXm
         56MtqgAbjf9FEyD8K5qrb1U63kvW3E8N3yVwkyOoiKJnqVbVponHcAvfM5DgxsTgJzWE
         zcXA==
X-Gm-Message-State: APjAAAX6L16GMF2j0h3K1whu3eLNb8mCfWEilfo/JL7gleFlxEfFWHsQ
        0u3zYHRezbUoZjDmPiIz9ug=
X-Google-Smtp-Source: APXvYqz4KlDpWAW/haO8/tNKjpikWkQE/yjJAvaHVdIEp9OmFQKk3X8oIXBzKpV9Lk5jVqIvNlzBmg==
X-Received: by 2002:ac2:5c4f:: with SMTP id s15mr14364702lfp.74.1566247253259;
        Mon, 19 Aug 2019 13:40:53 -0700 (PDT)
Received: from aurora.dekrai2i.com (host-94-78-150-95.dynamic.mm.pl. [94.78.150.95])
        by smtp.googlemail.com with ESMTPSA id f12sm2498355lfm.14.2019.08.19.13.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 13:40:52 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Rekowski?= <p.rekowski@gmail.com>
To:     tiwai@suse.com
Cc:     p.rekowski@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Connor McAdams <conmanx360@gmail.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ALSA: hda/ca0132 - Add new SBZ quirk
Date:   Mon, 19 Aug 2019 22:40:07 +0200
Message-Id: <20190819204008.14426-1-p.rekowski@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new PCI subsys ID for the SBZ, as found and tested by
me and some reddit users.

Signed-off-by: Paweł Rekowski <p.rekowski@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index c3096796ee05..c41865e1222c 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1175,6 +1175,7 @@ static const struct snd_pci_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1028, 0x0708, "Alienware 15 R2 2016", QUIRK_ALIENWARE),
 	SND_PCI_QUIRK(0x1102, 0x0010, "Sound Blaster Z", QUIRK_SBZ),
 	SND_PCI_QUIRK(0x1102, 0x0023, "Sound Blaster Z", QUIRK_SBZ),
+	SND_PCI_QUIRK(0x1102, 0x0027, "Sound Blaster Z", QUIRK_SBZ),
 	SND_PCI_QUIRK(0x1102, 0x0033, "Sound Blaster ZxR", QUIRK_SBZ),
 	SND_PCI_QUIRK(0x1458, 0xA016, "Recon3Di", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1458, 0xA026, "Gigabyte G1.Sniper Z97", QUIRK_R3DI),
-- 
2.23.0

