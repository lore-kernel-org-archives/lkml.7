Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CF4C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF2C120665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999172;
	bh=JLHNKPN0UpWv5Ars4n9ZfXOXJBOrMrfJGsdj7n1P1S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eVPsHnIFBkF+gCY7mSRPDMfmrltIhkYgW9pKydFhFAbiWDRbUZhUSOPNEXoopdUHy
	 QZgMIGgAMOvWYcOruYhT8T65evDfIXogoY33CQlxAbHruSBQ+yKm1CgVAY71KMse2f
	 6uQBIJHkNmJXAQ/eL+bq13VQgGXUrisxrgGgA2c0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391909AbfGXUMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:12:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404739AbfGXT5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:57:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 319BD205C9;
        Wed, 24 Jul 2019 19:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998225;
        bh=JLHNKPN0UpWv5Ars4n9ZfXOXJBOrMrfJGsdj7n1P1S4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fBHhc1mkUxQA3xGVK+zdkUIN5ZT2UVPvd82DDFGVO7a+TcCOnnFf6MAnxxYgOTc1M
         5p5NqX01lqnmZobZW7LR6ZMS0XXYKBJmrRgdvb4lB0IjfIMDD0Nc1Zs1PkFPI0+bwU
         YOKsggpOHP3EpiO3aRq7ztIg7XutkjtM7MEJbPIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.1 289/371] ALSA: hda/realtek - Fixed Headphone Mic cant record on Dell platform
Date:   Wed, 24 Jul 2019 21:20:41 +0200
Message-Id: <20190724191746.081404491@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

commit fbc571290d9f7bfe089c50f4ac4028dd98ebfe98 upstream.

It assigned to wrong model. So, The headphone Mic can't work.

Fixes: 3f640970a414 ("ALSA: hda - Fix headset mic detection problem for several Dell laptops")
Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7614,9 +7614,12 @@ static const struct snd_hda_pin_quirk al
 		{0x12, 0x90a60130},
 		{0x17, 0x90170110},
 		{0x21, 0x03211020}),
-	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
+	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
 		{0x14, 0x90170110},
 		{0x21, 0x04211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
+		{0x14, 0x90170110},
+		{0x21, 0x04211030}),
 	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC295_STANDARD_PINS,
 		{0x17, 0x21014020},


