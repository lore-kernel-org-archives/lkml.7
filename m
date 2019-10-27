Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF54CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9649A2070B
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210977;
	bh=QW6MRCRLYhtplUwDHGu9qu0e/8biqeJI/X84mmGWZKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ezgf3z0UzKnBpnX3H1KLTHJw7nX8nBMYrVi+/NDy2DaDWxAPgOoUYBe79QpV6nm9t
	 UU032xDkazvHfzI/XwWD6NwqQwThyQpI/fq/YmCIeBUiYnE303UMpOwlEdSFgec6TN
	 asycI+YkGdUEdLypiWDVRuuv2nmXGqE+NvRc9ObE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbfJ0VQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730783AbfJ0VQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:16:13 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C760F205C9;
        Sun, 27 Oct 2019 21:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210972;
        bh=QW6MRCRLYhtplUwDHGu9qu0e/8biqeJI/X84mmGWZKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E0/VkZdtkBAsa2ZReVr6Jf3Nnkuq3DMXmCi8shkgrsNVBrTg5m1BviWy0j0zltjpi
         ChAUEi0dDorEU3ld6loLwq/L+TqW/NeN75JIVRRVlurLLhTOc8dqjUJgRN3kau6+zr
         i18GnbJ0r2ixBp7aTLpyik0va7X9sIhgffoREY5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 37/93] ALSA: hda/realtek - Add support for ALC711
Date:   Sun, 27 Oct 2019 22:00:49 +0100
Message-Id: <20191027203258.122885374@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203251.029297948@linuxfoundation.org>
References: <20191027203251.029297948@linuxfoundation.org>
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
@@ -405,6 +405,7 @@ static void alc_fill_eapd_coef(struct hd
 	case 0x10ec0700:
 	case 0x10ec0701:
 	case 0x10ec0703:
+	case 0x10ec0711:
 		alc_update_coef_idx(codec, 0x10, 1<<15, 0);
 		break;
 	case 0x10ec0662:
@@ -7752,6 +7753,7 @@ static int patch_alc269(struct hda_codec
 	case 0x10ec0700:
 	case 0x10ec0701:
 	case 0x10ec0703:
+	case 0x10ec0711:
 		spec->codec_variant = ALC269_TYPE_ALC700;
 		spec->gen.mixer_nid = 0; /* ALC700 does not have any loopback mixer path */
 		alc_update_coef_idx(codec, 0x4a, 1 << 15, 0); /* Combo jack auto trigger control */
@@ -8883,6 +8885,7 @@ static const struct hda_device_id snd_hd
 	HDA_CODEC_ENTRY(0x10ec0700, "ALC700", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0701, "ALC701", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0703, "ALC703", patch_alc269),
+	HDA_CODEC_ENTRY(0x10ec0711, "ALC711", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0867, "ALC891", patch_alc662),
 	HDA_CODEC_ENTRY(0x10ec0880, "ALC880", patch_alc880),
 	HDA_CODEC_ENTRY(0x10ec0882, "ALC882", patch_alc882),


