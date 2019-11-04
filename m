Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0858CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C2B2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905436;
	bh=+bOn5BpQyjay3VhCnIJDG7dAzmW2EedPioKRNMyG1gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y42QtIFoXq6XdCzDpAorbF+nOG11k8FDhvWRRKuVr4mJAanaqeDzOsWfKYWKBvCuU
	 OnMNlzU6rNFEpSlzDOvDXJUae7wG2ijau2ri5ZdTd0IplCTunEIl1Ku+3JibUjsCgB
	 ZalIipWf+FUQB0VszYaqN2POsPKqyqfzKMiIvDhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390563AbfKDWKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:10:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390535AbfKDWKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:10:31 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8BC620650;
        Mon,  4 Nov 2019 22:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905430;
        bh=+bOn5BpQyjay3VhCnIJDG7dAzmW2EedPioKRNMyG1gI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K7uVJcJDq9ZiiIfcOnLV5uD3XugaJSRKTsNfuFc0L1DWezgOjwOcRoPQwBgaBMfpN
         Slmbes+3A8gAkgDmzFzeT3GtSZyrJMp1uD1RK7+W6sXOGH0uDCN1ImRe097W/JRwZ0
         VUElVZxu2NJCZJg4GWGa2x3+gDf/6DW+sCpd1RcY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.3 100/163] ALSA: hda/realtek - Add support for ALC623
Date:   Mon,  4 Nov 2019 22:44:50 +0100
Message-Id: <20191104212147.314982865@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

commit f0778871a13889b86a65d4ad34bef8340af9d082 upstream.

Support new codec ALC623.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/ed97b6a8bd9445ecb48bc763d9aaba7a@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -409,6 +409,9 @@ static void alc_fill_eapd_coef(struct hd
 	case 0x10ec0672:
 		alc_update_coef_idx(codec, 0xd, 0, 1<<14); /* EAPD Ctrl */
 		break;
+	case 0x10ec0623:
+		alc_update_coef_idx(codec, 0x19, 1<<13, 0);
+		break;
 	case 0x10ec0668:
 		alc_update_coef_idx(codec, 0x7, 3<<13, 0);
 		break;
@@ -2919,6 +2922,7 @@ enum {
 	ALC269_TYPE_ALC225,
 	ALC269_TYPE_ALC294,
 	ALC269_TYPE_ALC300,
+	ALC269_TYPE_ALC623,
 	ALC269_TYPE_ALC700,
 };
 
@@ -2954,6 +2958,7 @@ static int alc269_parse_auto_config(stru
 	case ALC269_TYPE_ALC225:
 	case ALC269_TYPE_ALC294:
 	case ALC269_TYPE_ALC300:
+	case ALC269_TYPE_ALC623:
 	case ALC269_TYPE_ALC700:
 		ssids = alc269_ssids;
 		break;
@@ -7976,6 +7981,9 @@ static int patch_alc269(struct hda_codec
 		spec->codec_variant = ALC269_TYPE_ALC300;
 		spec->gen.mixer_nid = 0; /* no loopback on ALC300 */
 		break;
+	case 0x10ec0623:
+		spec->codec_variant = ALC269_TYPE_ALC623;
+		break;
 	case 0x10ec0700:
 	case 0x10ec0701:
 	case 0x10ec0703:
@@ -9103,6 +9111,7 @@ static const struct hda_device_id snd_hd
 	HDA_CODEC_ENTRY(0x10ec0298, "ALC298", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0299, "ALC299", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0300, "ALC300", patch_alc269),
+	HDA_CODEC_ENTRY(0x10ec0623, "ALC623", patch_alc269),
 	HDA_CODEC_REV_ENTRY(0x10ec0861, 0x100340, "ALC660", patch_alc861),
 	HDA_CODEC_ENTRY(0x10ec0660, "ALC660-VD", patch_alc861vd),
 	HDA_CODEC_ENTRY(0x10ec0861, "ALC861", patch_alc861),


