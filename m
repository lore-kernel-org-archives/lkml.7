Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D7DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A277213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558354857;
	bh=YUv1TejkmAnYoNxC2SDdFSW/JTyRxjr3Dxt/50S2yCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G0m9nvG6K7U6iBg2TK6AuQrqxQ6Gl1cLmF3LnLxu1jLuBY0iaxqhuT6SxUuQqbwGT
	 cdeDm/mC3H2cb9pKZqhHKRVhHemqEhZL8x/jQDL6VrTfrl+8gvhXcHkyFNKZS2aBUy
	 mQRBb+7xb2po9MJAxMa/RE8sfQPIbqqMGrP8Jmrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388063AbfETMU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:20:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388026AbfETMUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:20:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB9C4213F2;
        Mon, 20 May 2019 12:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558354852;
        bh=YUv1TejkmAnYoNxC2SDdFSW/JTyRxjr3Dxt/50S2yCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TrSCGordaA+C3U/ZqMdStdLSGWyVBaT3XiPLA0wpyeGlYDXrFURkDC8ARsJsKA6NP
         1Qq8FJbDpqPj6nQCzuBOhnCRntGgmVaTzxBqWKRbCNoU73xstAyucbAlZI2oQzPMaC
         0XVZkIPW5FBb0i3DbQHOefOhT+KTUuJC5IDOe1J8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20Wadowski?= <wadosm@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 60/63] ALSA: hda/realtek - Fix for Lenovo B50-70 inverted internal microphone bug
Date:   Mon, 20 May 2019 14:14:39 +0200
Message-Id: <20190520115237.481009610@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115231.137981521@linuxfoundation.org>
References: <20190520115231.137981521@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michał Wadowski <wadosm@gmail.com>

commit 56df90b631fc027fe28b70d41352d820797239bb upstream.

Add patch for realtek codec in Lenovo B50-70 that fixes inverted
internal microphone channel.
Device IdeaPad Y410P has the same PCI SSID as Lenovo B50-70,
but first one is about fix the noise and it didn't seem help in a
later kernel version.
So I replaced IdeaPad Y410P device description with B50-70 and apply
inverted microphone fix.

Bugzilla: https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1524215
Signed-off-by: Michał Wadowski <wadosm@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6550,7 +6550,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x17aa, 0x313c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
-	SND_PCI_QUIRK(0x17aa, 0x3978, "IdeaPad Y410P", ALC269_FIXUP_NO_SHUTUP),
+	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x5013, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x17aa, 0x501a, "Thinkpad", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x501e, "Thinkpad L440", ALC292_FIXUP_TPT440_DOCK),


