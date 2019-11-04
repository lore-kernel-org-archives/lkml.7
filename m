Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6A0CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93812205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904945;
	bh=Yfuc9zmR5UHiuZid6NBVEbbUTxnhxljsHJBvKXfvKNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kY2oTBuQoSeKe5gMhz7juu7ERgGikDjps6QmH0Ubm4Hd7UxhKkLjjYUNNdVh7idJ3
	 HvTqViiBH3BwKFzsciapsg2HUTxf3vIv7THF29ewtmMovGp3eV7bvZRjmVLE2EnwcC
	 CUZ5U651+Hjk5Q1MCtovyKeMBmXuSx0XoqS8T6bQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389289AbfKDWCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:02:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:60102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389190AbfKDWBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:01:53 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E45492084D;
        Mon,  4 Nov 2019 22:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904912;
        bh=Yfuc9zmR5UHiuZid6NBVEbbUTxnhxljsHJBvKXfvKNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VhjL1X4tA8tw5OCZod9PFxlpTUHNuyawFXleTaeAmQSRx5gasW7RIofIX+71AzlQu
         rUJ1gksu1pTfzMVqCXIQmgKniwCsht3AO0dzw0hMMmHi0zvAfwGOxjtCdaBb8EXyeB
         wJIr3147BIvKXqC+eQ5N8dialzfBvvrobXpOTMNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 113/149] ALSA: hda/realtek - Add support for ALC623
Date:   Mon,  4 Nov 2019 22:45:06 +0100
Message-Id: <20191104212144.286401061@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212126.090054740@linuxfoundation.org>
References: <20191104212126.090054740@linuxfoundation.org>
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
@@ -421,6 +421,9 @@ static void alc_fill_eapd_coef(struct hd
 	case 0x10ec0672:
 		alc_update_coef_idx(codec, 0xd, 0, 1<<14); /* EAPD Ctrl */
 		break;
+	case 0x10ec0623:
+		alc_update_coef_idx(codec, 0x19, 1<<13, 0);
+		break;
 	case 0x10ec0668:
 		alc_update_coef_idx(codec, 0x7, 3<<13, 0);
 		break;
@@ -2908,6 +2911,7 @@ enum {
 	ALC269_TYPE_ALC225,
 	ALC269_TYPE_ALC294,
 	ALC269_TYPE_ALC300,
+	ALC269_TYPE_ALC623,
 	ALC269_TYPE_ALC700,
 };
 
@@ -2943,6 +2947,7 @@ static int alc269_parse_auto_config(stru
 	case ALC269_TYPE_ALC225:
 	case ALC269_TYPE_ALC294:
 	case ALC269_TYPE_ALC300:
+	case ALC269_TYPE_ALC623:
 	case ALC269_TYPE_ALC700:
 		ssids = alc269_ssids;
 		break;
@@ -7783,6 +7788,9 @@ static int patch_alc269(struct hda_codec
 		spec->codec_variant = ALC269_TYPE_ALC300;
 		spec->gen.mixer_nid = 0; /* no loopback on ALC300 */
 		break;
+	case 0x10ec0623:
+		spec->codec_variant = ALC269_TYPE_ALC623;
+		break;
 	case 0x10ec0700:
 	case 0x10ec0701:
 	case 0x10ec0703:
@@ -8901,6 +8909,7 @@ static const struct hda_device_id snd_hd
 	HDA_CODEC_ENTRY(0x10ec0298, "ALC298", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0299, "ALC299", patch_alc269),
 	HDA_CODEC_ENTRY(0x10ec0300, "ALC300", patch_alc269),
+	HDA_CODEC_ENTRY(0x10ec0623, "ALC623", patch_alc269),
 	HDA_CODEC_REV_ENTRY(0x10ec0861, 0x100340, "ALC660", patch_alc861),
 	HDA_CODEC_ENTRY(0x10ec0660, "ALC660-VD", patch_alc861vd),
 	HDA_CODEC_ENTRY(0x10ec0861, "ALC861", patch_alc861),


