Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7F6C76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151D22077C
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419434;
	bh=lQTLJllY6K13/FS1uhhiKx1rKXqx7YniJx9bi8kAt+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KltuEWIRL8xpAeluk8e6CvvVLRzF8ivbOHZjvGD4GN4gHvbkbnuEI836HZePkSOhS
	 T7MNySKvOoMr1JOtxoJnjaxMbFZwNLGr0h/Aa0QBhNe8/gm68lpBtZdgZLCuQPrtaO
	 HBVr12ticDO9eIs7Go7FWUDY8BNGP6eFgLrhNdNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403864AbfGRDKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:10:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391164AbfGRDKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:10:22 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D9032053B;
        Thu, 18 Jul 2019 03:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419421;
        bh=lQTLJllY6K13/FS1uhhiKx1rKXqx7YniJx9bi8kAt+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g1bg/XnmYoupJIM1a2M6pgdpnvIFF/kld7WMdO3sqlic5lFc5PC2VPoMnDdfwYlB0
         6Acb4mofmSdZ4qiGuJdU04S8br1fsbLcb7D6XlK7t/aFDLki1MdVswwJvz8sbsjMgI
         dc95S4jJwbZiTnBwNQ06gHSmPZScvlD9s/AWAP88=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 42/80] ALSA: hda/realtek - Headphone Mic cant record after S3
Date:   Thu, 18 Jul 2019 12:01:33 +0900
Message-Id: <20190718030101.902422292@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030058.615992480@linuxfoundation.org>
References: <20190718030058.615992480@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

commit d07a9a4f66e944fcc900812cbc2f6817bde6a43d upstream.

Dell headset mode platform with ALC236.
It doesn't recording after system resume from S3.
S3 mode was deep. s2idle was not has this issue.
S3 deep will cut of codec power. So, the register will back to default
after resume back.
This patch will solve this issue.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3114,6 +3114,7 @@ static void alc256_init(struct hda_codec
 	alc_update_coefex_idx(codec, 0x57, 0x04, 0x0007, 0x4); /* Hight power */
 	alc_update_coefex_idx(codec, 0x53, 0x02, 0x8000, 1 << 15); /* Clear bit */
 	alc_update_coefex_idx(codec, 0x53, 0x02, 0x8000, 0 << 15);
+	alc_update_coef_idx(codec, 0x36, 1 << 13, 1 << 5); /* Switch pcbeep path to Line in path*/
 }
 
 static void alc256_shutup(struct hda_codec *codec)
@@ -7218,7 +7219,6 @@ static int patch_alc269(struct hda_codec
 		spec->shutup = alc256_shutup;
 		spec->init_hook = alc256_init;
 		spec->gen.mixer_nid = 0; /* ALC256 does not have any loopback mixer path */
-		alc_update_coef_idx(codec, 0x36, 1 << 13, 1 << 5); /* Switch pcbeep path to Line in path*/
 		break;
 	case 0x10ec0257:
 		spec->codec_variant = ALC269_TYPE_ALC257;


