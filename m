Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8ADC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EE92064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127691;
	bh=2b6I9hwFcX/I2pUyuFEfwL4mTpN65QeBhTUlYYdLM9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X3o/BeWE+xZmKEu4HTOn/73L5CMldWxH2ENfHaTBd5xqoQwZ0rkCcM0MdCe65aBE/
	 PAW9sY3u6Yo4ZvadMLxRTAej/0zIZnXPO6/Cdiur4kCyrWGbI6TAJlzI+mFow2ZUaM
	 S08jaKf0FAvgtAiznETcsHUvZIFFv2W1TSFbJk8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404060AbfDXRl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:41:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403936AbfDXRgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:36:40 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81A752054F;
        Wed, 24 Apr 2019 17:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127400;
        bh=2b6I9hwFcX/I2pUyuFEfwL4mTpN65QeBhTUlYYdLM9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U9V2HSbk4Z0rCvtUaeTskDUwoA0wm5ytqEiAqXkDeGnOtii9Y+Yv66xzyZdZ3gfOJ
         v2rq9CD/OnGObNsdP2IpK4J4EGyz7C5P0PyBaUOo2k7lRnM2k1MV5usRYcfBDH7obH
         cumeu/67Qg0p647Rs+g/15XgMORvA+A8mm9SZtRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.0 070/115] ALSA: hda/realtek - add two more pin configuration sets to quirk table
Date:   Wed, 24 Apr 2019 19:10:06 +0200
Message-Id: <20190424170929.161179671@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Wang <hui.wang@canonical.com>

commit b26e36b7ef36a8a3a147b1609b2505f8a4ecf511 upstream.

We have two Dell laptops which have the codec 10ec0236 and 10ec0256
respectively, the headset mic on them can't work, need to apply the
quirk of ALC255_FIXUP_DELL1_MIC_NO_PRESENCE. So adding their pin
configurations in the pin quirk table.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7247,6 +7247,8 @@ static const struct snd_hda_pin_quirk al
 		{0x12, 0x90a60140},
 		{0x14, 0x90170150},
 		{0x21, 0x02211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0236, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x21, 0x02211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL2_MIC_NO_PRESENCE,
 		{0x14, 0x90170110},
 		{0x21, 0x02211020}),
@@ -7357,6 +7359,10 @@ static const struct snd_hda_pin_quirk al
 		{0x21, 0x0221101f}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC256_STANDARD_PINS),
+	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x14, 0x90170110},
+		{0x1b, 0x01011020},
+		{0x21, 0x0221101f}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1043, "ASUS", ALC256_FIXUP_ASUS_MIC,
 		{0x14, 0x90170110},
 		{0x1b, 0x90a70130},


