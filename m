Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E14C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 02:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3452208E4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 02:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="KJakSu1u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i9oMpixH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfIACbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 22:31:35 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:36807 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727485AbfIACbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 22:31:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id A22E1431;
        Sat, 31 Aug 2019 22:31:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 31 Aug 2019 22:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        date:from:to:cc:subject:message-id:mime-version:content-type; s=
        fm3; bh=Fo0oQ0WtdqAoWBVLoEOMh4lWt0MWd2jdToSDMXaYfdk=; b=KJakSu1u
        kM25osrvNsaYs2HHwEZHhiPOP8Ap1Zgf2kJiku8Msfwhn25B5lXbsFEpEay9YNVY
        BggNQkNgLT18WcGh9gMfLl0BAGzM8RpvsVzCU1LVgOPa6DHdWNcBomSyHJeMY8Iv
        melAztRdHTtYQSJPAotjyWQ7uZ2fQ743p2ZcuyLxbTyzgcUDO4bm/yh8e3kHGosf
        uj9lDle4sTryCLtvZyWpWDRTIqAjkyEHRDSnDo2tCAAk4KYx3n1G9LVGGvUM6E0A
        Wgd1LArn0PH7YD0BXr/ATkniidsMslwQe1Ef2ZH2zHEyTIt9UB6RLnBWAVUjZB2A
        jg4XnKYmyUhNgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=Fo0oQ0WtdqAoWBVLoEOMh4lWt0MWd
        2jdToSDMXaYfdk=; b=i9oMpixHxJ4CBkPb+L9AAzVFiOgRaRNRK7Qso2v8NLtMY
        0YAWKfTz4IqZDAiU8jEnrUDnGrZJrMXmYzyafifxs8JhoNYvwpQ9DjarL1OayY8S
        RATrKy/9fj0TnZ1P7r5m0zZEDjDvKscs9gAvecj+PU6rfImrzUoymESBc2hUYy6I
        kcPRcIDfQKhlQ3xO4QOpSiH58JGMOL0okgiTD8rbIaji2Q32k7Eo/BOGX/Qaeozo
        PLsAGH8sIbkUdTtf0ac5waYXlukkQS9InIbG4BhjkkZ8vrNZVHoBHJisvtbfqK+D
        xwFLaCyitIMzyt+UpG0V3dxeniEYQUoHOzNWvz4+Q==
X-ME-Sender: <xms:hC1rXSVC86DWolV6nqXJw4QodyZ7j76ttQSbUY_mQs_ua1SYK9NK_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeijedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtuggfsehttdertd
    dtredvnecuhfhrohhmpefurghmuceurgiilhgvhicuoehsrghmsggriihlvgihsehfrghs
    thhmrghilhdrtghomheqnecukfhppeekiedriedrleehrddvfeegnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehsrghmsggriihlvgihsehfrghsthhmrghilhdrtghomhenucevlhhu
    shhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:hC1rXexdZVnGs5vJuoDhEtwDLVxmLuxK2yluLlOPxAmOZy3qIHtVNA>
    <xmx:hC1rXYNO9Ye4xAtfUCodWGBG-QBecQ6GISeDVyiJcdDvMXiUHToEJg>
    <xmx:hC1rXX6dhixV5SahNB5lDYUvJVFGmdY5KBRQK7SypN6IMkjemnUQiA>
    <xmx:hS1rXUKbP2ar-N_-DFr6fdPMVZKJ2B4eYykqav5rjd1-SoPM65A8_w>
Received: from SamLinux (cpc88606-newt36-2-0-cust1001.19-3.cable.virginm.net [86.6.95.234])
        by mail.messagingengine.com (Postfix) with ESMTPA id E368AD6005E;
        Sat, 31 Aug 2019 22:31:31 -0400 (EDT)
Date:   Sun, 1 Sep 2019 03:31:30 +0100
From:   Sam Bazley <sambazley@fastmail.com>
To:     tiwai@suse.com
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, sambazley@fastmail.com
Subject: [PATCH] ALSA: hda/realtek - Add quirk for HP Pavilion 15
Message-ID: <20190901023130.GA15295@SamLinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HP Pavilion 15 (AMD Ryzen-based model) with 103c:84e7 needs the same
quirk like HP Envy/Spectre x360 for enabling the mute LED over Mic3 pin.

Signed-off-by: Sam Bazley <sambazley@fastmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e333b3e30e31..31ba8d68c16d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6973,6 +6973,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x802e, "HP Z240 SFF", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x802f, "HP Z240", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x820d, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
+	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8256, "HP", ALC221_FIXUP_HP_FRONT_MIC),
 	SND_PCI_QUIRK(0x103c, 0x827e, "HP x360", ALC295_FIXUP_HP_X360),
 	SND_PCI_QUIRK(0x103c, 0x82bf, "HP G3 mini", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
-- 
2.23.0

