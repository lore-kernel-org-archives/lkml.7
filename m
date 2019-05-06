Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE2FC04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB06C2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557155082;
	bh=SsqbmMywSBVKwpFvFFFQV1gHcQwfUpjDQfe4U40oK1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GV3KVzWVGgmxkDaf4RuAMdebDLCNkzhBPCGUJ+oGSZ7BKE+yfsv0ZyXNZvFNS3UC8
	 y/3Rx2VAznANZ6KWLFa5Nc7ntwuqybhPIY8tiPiheYD2bCZHTgND2w9avRLB6dIQy/
	 UmmYCroAfbncv/BavjblANK4UZF3XMe66Y4PeJxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfEFPEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:04:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbfEFOjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:39:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFD9C21479;
        Mon,  6 May 2019 14:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153553;
        bh=SsqbmMywSBVKwpFvFFFQV1gHcQwfUpjDQfe4U40oK1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gpb8Oxldlr/F7jD0qhMe5BIgzDUm3uUputVqanId6ehR7vkNG2qiqCU3mZVs8A+Ph
         dPNZT7ZwGrMZB4yy5YFhA4Edknkb2EAR9WAH/vyTwyR5tzIXrbnfDUkOWiIvAkXm42
         gR0R7GSGHaoEQV62KHTkLYU7f4+OGGURob1qOIOg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 10/99] ALSA: hda/realtek - Add new Dell platform for headset mode
Date:   Mon,  6 May 2019 16:31:43 +0200
Message-Id: <20190506143054.785244490@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.899356316@linuxfoundation.org>
References: <20190506143053.899356316@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

commit 0a29c57b76624723b6b00c027e0e992d130ace49 upstream.

Add two Dell platform for headset mode.

[ Note: this is a further correction / addition of the previous
  pin-based quirks for Dell machines; another entry for ALC236 with
  the d-mic pin 0x12 and an entry for ALC295 -- tiwai ]

Fixes: b26e36b7ef36 ("ALSA: hda/realtek - add two more pin configuration sets to quirk table")
Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7172,6 +7172,10 @@ static const struct snd_hda_pin_quirk al
 		{0x21, 0x02211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0236, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x21, 0x02211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0236, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0x40000000},
+		{0x14, 0x90170110},
+		{0x21, 0x02211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL2_MIC_NO_PRESENCE,
 		{0x14, 0x90170110},
 		{0x21, 0x02211020}),
@@ -7446,6 +7450,9 @@ static const struct snd_hda_pin_quirk al
 		{0x17, 0x90170110},
 		{0x21, 0x04211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x14, 0x90170110},
+		{0x21, 0x04211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC295_STANDARD_PINS,
 		{0x17, 0x21014020},
 		{0x18, 0x21a19030}),


