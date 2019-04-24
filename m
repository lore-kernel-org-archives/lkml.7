Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65DFC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0ED2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127199;
	bh=6m4AsTVGZF/EqVY09xRACLimlT1Bl3ovTQawKNrere0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hoJ79bj1EmbGzM3O79Gg2hl9FH75xVsINulzjHWPKHyzNbU5da0K+kt1HOgzXjeag
	 Cvq6ulIwy6YwxU/0OyfYHRVrd4CeB3xsazRfsEib6yH8zuhbD74sIEMY6tClyM5p9M
	 qtRP4EhwKZ2NRqvGL7zSwM+ZeAtRs7O2ScEObGkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390881AbfDXRdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:33:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391447AbfDXRdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:33:13 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5EEC21903;
        Wed, 24 Apr 2019 17:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127193;
        bh=6m4AsTVGZF/EqVY09xRACLimlT1Bl3ovTQawKNrere0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hgxeqaib0EU8hx2g0dmxt9/MX+2WOWwVzvwWKM1MyEh9BMaI9rqL7Zy7rZQhoIWhs
         OkoJpw5jwT75m/Ep7tHGgRbSP5adFGINGslGiiXhYEHCc7GalJ1W65/x/pqiREbps0
         SBixR8gmZiSuzwucXUEVgxln2JJBISMOlB/J5Lig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 52/96] ALSA: hda/realtek - add two more pin configuration sets to quirk table
Date:   Wed, 24 Apr 2019 19:09:57 +0200
Message-Id: <20190424170923.317864495@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
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
@@ -7170,6 +7170,8 @@ static const struct snd_hda_pin_quirk al
 		{0x12, 0x90a60140},
 		{0x14, 0x90170150},
 		{0x21, 0x02211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0236, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x21, 0x02211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1028, "Dell", ALC255_FIXUP_DELL2_MIC_NO_PRESENCE,
 		{0x14, 0x90170110},
 		{0x21, 0x02211020}),
@@ -7280,6 +7282,10 @@ static const struct snd_hda_pin_quirk al
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


