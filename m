Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8FAC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0643520645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558356111;
	bh=p3V5fAHgOq3Ue735wlneHW0DYFFHfzc6aDjM9S8BQss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PTaWooEHS0Xg27rTqXyFK0R4hDE+62Y426zy4uriBrUhCNmZyu94+Szn1JohiO6SB
	 wO6tCCdWK178qfRYJBK8po9HfDJ02EP7WOzlxO3wzVO/8+uVqxTZ42JZRjcxpINhaE
	 wNHXVse++jwZHmN0VcR363HtZeUuOz1MTZyfEit8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390233AbfETMbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:31:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390203AbfETMa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:30:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03A8420675;
        Mon, 20 May 2019 12:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355458;
        bh=p3V5fAHgOq3Ue735wlneHW0DYFFHfzc6aDjM9S8BQss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OH6TRxu8cY+sktVUbJR3sYMQiE1hFy43Vt1FFF39jbfNdNaEKR8owudxPWhcJQiLQ
         5lEqmeUanTeagLL8gSfjBdgVTgSNaqo6GxKyhkgQ2VO08lU/bDDvFP7S+KplyYMFZk
         +sm1CP5sBgeVPUq+HnFe9tskPKFpN8YuHFzwEpVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeremy Soller <jeremy@system76.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.0 106/123] ALSA: hda/realtek - Corrected fixup for System76 Gazelle (gaze14)
Date:   Mon, 20 May 2019 14:14:46 +0200
Message-Id: <20190520115252.097108120@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115245.439864225@linuxfoundation.org>
References: <20190520115245.439864225@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Soller <jeremy@system76.com>

commit 891afcf2462d2cc4ef7caf94215358ca61fa32cb upstream.

A mistake was made in the identification of the four variants of the
System76 Gazelle (gaze14). This patch corrects the PCI ID of the
17-inch, GTX 1660 Ti variant from 0x8560 to 0x8551. This patch also
adds the correct fixups for the 15-inch and 17-inch GTX 1650 variants
with PCI IDs 0x8560 and 0x8561.

Tests were done on all four variants ensuring full audio capability.

Fixes: 80a5052db751 ("ALSA: hdea/realtek - Headset fixup for System76 Gazelle (gaze14)")
Signed-off-by: Jeremy Soller <jeremy@system76.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6931,7 +6931,9 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1462, 0xb171, "Cubi N 8GL (MS-B171)", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1558, 0x1325, "System76 Darter Pro (darp5)", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x8550, "System76 Gazelle (gaze14)", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
-	SND_PCI_QUIRK(0x1558, 0x8560, "System76 Gazelle (gaze14)", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0x8551, "System76 Gazelle (gaze14)", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0x8560, "System76 Gazelle (gaze14)", ALC269_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1558, 0x8561, "System76 Gazelle (gaze14)", ALC269_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x1036, "Lenovo P520", ALC233_FIXUP_LENOVO_MULTI_CODECS),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Thinkpad SL410/510", ALC269_FIXUP_SKU_IGNORE),
 	SND_PCI_QUIRK(0x17aa, 0x215e, "Thinkpad L512", ALC269_FIXUP_SKU_IGNORE),


