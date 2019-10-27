Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079C6CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11FE208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210492;
	bh=HX1uJv3K6nliWLyVHLjYQ5UaxNy1uDdm3bnjZGi1i3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2N8W9BhI2qYubw2EUg4c39dI06qL590UvE0E4ZFECliVZR40uKnciv6rHARy4MsJP
	 nPlwYNRFSFRY2gf24mRHGASMvoLIPBjBNcNumUoiBqSsu74muCEyvCHvLJm9H0jQZI
	 Ry0rsRQYZeZfEl82mn/LrUuqzmH8OQkBEASyO6uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfJ0VIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729327AbfJ0VIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:08:06 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CD6E2064A;
        Sun, 27 Oct 2019 21:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210485;
        bh=HX1uJv3K6nliWLyVHLjYQ5UaxNy1uDdm3bnjZGi1i3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X4ODa/0jyTG6EgcpMi+84EeUumQrwSamSncpt8cO8INpvzQy10g8He6ln1kNvfdhc
         DNGAGabfe3vrcCP+/TFbttiJYy8ppaEykiUi1sURVqTQxmsT4+bkJkUlSyGXGRvROh
         OIqLYmpLKvSJjOLU9P11+VJ+JMBwqOgevr7AivWw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 031/119] ALSA: hda/realtek - Add support for ALC711
Date:   Sun, 27 Oct 2019 22:00:08 +0100
Message-Id: <20191027203309.899226470@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203259.948006506@linuxfoundation.org>
References: <20191027203259.948006506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

commit 83629532ce45ef9df1f297b419b9ea112045685d upstream.

Support new codec ALC711.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -359,6 +359,7 @@ static void alc_fill_eapd_coef(struct hd
 	case 0x10ec0700:
 	case 0x10ec0701:
 	case 0x10ec0703:
+	case 0x10ec0711:
 		alc_update_coef_idx(codec, 0x10, 1<<15, 0);
 		break;
 	case 0x10ec0662:
@@ -7272,6 +7273,7 @@ static int patch_alc269(struct hda_codec
 	case 0x10ec0700:
 	case 0x10ec0701:
 	case 0x10ec0703:
+	case 0x10ec0711:
 		spec->codec_variant = ALC269_TYPE_ALC700;
 		spec->gen.mixer_nid = 0; /* ALC700 does not have any loopback mixer path */
 		alc_update_coef_idx(codec, 0x4a, 1 << 15, 0); /* Combo jack auto trigger control */
@@ -8365,6 +8367,7 @@ static const struct hda_device_id snd_hd
 	HDA_CODEC_ENTRY(0x10ec0700, "ALC700", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0701, "ALC701", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0703, "ALC703", patch_alc269),
+	HDA_CODEC_ENTRY(0x10ec0711, "ALC711", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0867, "ALC891", patch_alc662),
 	HDA_CODEC_ENTRY(0x10ec0880, "ALC880", patch_alc880),
 	HDA_CODEC_ENTRY(0x10ec0882, "ALC882", patch_alc882),


