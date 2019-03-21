Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6490C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51CF218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="0e9Q3XwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfCUJSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:18:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46121 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfCUJSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:18:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id a22so3770079pgg.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 02:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8KK8JggM7xn5JWcpuPWrvCWmTaSRv+CFWNL+Dk1/1HM=;
        b=0e9Q3XwDsrAWLmJmCtbWFI7BaF2QmLZ4lax5IHh+3kpaC3OAShEsErPUPnjkzWo/lw
         I1gz3ucnX6FJExSkOZA0ma2K9jhyw/UfISM/vZ/JdsiNIOkhf0hyOnGyfJ6HxoUorD+Z
         f31obG9bpLbqTPuKuT6KwEaCOmMavMikTVtsn8mD2HYxH0mDPR9o36JCV5gnRvAJ1ngo
         9Akc2eLlffWg9I6Tq2pY5N3tw3B9ird/RyzLfTDMPRNL2m1PAym9pRPp3XfSkCzL/a08
         Z4wxXsacZySZ6wAqLEggdIzH0KDYdF0Ta/S5/dGAddfetLkODbZP+a3bxA9+f8uIFc0i
         ucKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8KK8JggM7xn5JWcpuPWrvCWmTaSRv+CFWNL+Dk1/1HM=;
        b=sNxdboMGqESQ/m9asKuW1Upfw1P4icdVwsVo6x0FLW7kQIij7FdWpmExeLAZQnqj3V
         4ZPL5lIjKG6o54KGtloDsMwYdaMIERsajJQgf88BdQgCZCDpuCNBqUwMJHoJ6XplYWiN
         fP/xP5Te+YIGKh6hEtwxzi0K1eu89nD5LvuS13nTgy/P94pQEe5HtZsKoJSHp1G3yH+O
         GUhZB3xFAr8uTecKEWKROgCJyxCt42xrK9VVIVEek0/s7nL136XRUYVXswjq0+49KWOh
         p1FSAFGVgFVC98iAsdnJO0uJ4L9EFdV1Z/yBqydgIWmVdYYcgXBvR2glQz5b2UU2d+p6
         uv+w==
X-Gm-Message-State: APjAAAVV8O/lR3qsTi/7dnr60g9qgAS+mNZqVz5Y2PqunBOXwg6KSM4B
        1VZP+IwOxOrWjkep1jMHjy/9YpE5MN4=
X-Google-Smtp-Source: APXvYqwRKc1jshgFRP10SE+TbtnGKrTDDlLKbtnvamaggGXSe5lu5ctSS1qm2EhMf8vqDc6KONjjPw==
X-Received: by 2002:a17:902:8643:: with SMTP id y3mr2451371plt.195.1553159886043;
        Thu, 21 Mar 2019 02:18:06 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id v2sm6261850pfg.118.2019.03.21.02.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 02:18:05 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH] ALSA: hda/realtek - Add support for Acer Aspire E5-523G/ES1-432 headset mic
Date:   Thu, 21 Mar 2019 17:17:31 +0800
Message-Id: <20190321091730.18638-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Chiu <chiu@endlessm.com>

The Acer laptop Aspire E5-523G and ES1-432 with ALC255 can't detect
the headset microphone until ALC255_FIXUP_ACER_MIC_NO_PRESENCE quirk
applied.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 191830d4fa40..89a96442eb07 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6712,6 +6712,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_ASPIRE_V5_PINS),
 	SND_PCI_QUIRK(0x1025, 0x102b, "Acer Aspire C24-860", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x106d, "Acer Cloudbook 14", ALC283_FIXUP_CHROME_BOOK),
+	SND_PCI_QUIRK(0x1025, 0x1099, "Acer Aspire E5-523G", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1025, 0x110e, "Acer Aspire ES1-432", ALC255_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x128f, "Acer Veriton Z6860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
-- 
2.20.1

