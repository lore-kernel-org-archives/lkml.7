Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61A9C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B710120861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806715;
	bh=7Iv5Ulhl84qu6JpysTXKjrWoWEeyUTjni8Mbp9/vFsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pk7maG3hWuv5kFLUJA5O/STev3UxQgnL2HlNVegq2Ik785yit7L1erSDhAI7VHjZW
	 MdNexy/p20FTaS/hiViqavPyJdRNfbuVRM9idUprqe1gy4KGn1nvFKffa4HT/36A9r
	 vFouILuCDqeR9jc3gZdWD4/imPsikynzqRBYkgM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfFQVZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730034AbfFQVZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:25:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39D2920673;
        Mon, 17 Jun 2019 21:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806709;
        bh=7Iv5Ulhl84qu6JpysTXKjrWoWEeyUTjni8Mbp9/vFsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l16vOfBTLwrYV4jWxVBVxm9fUkYbWvavT/o11TI7doRWWlMmDD58LuF6XmA1MNWa9
         S5zZdC68fAUjbcagJWUWIHSPHAAXJFHOJWq3TThkq0BZkQBG8bqe45Ay1OkN8LU0Gg
         jAoDHL9ZEAgm5RNNPqYVIkaZ58uC6NuOxtoBUEV8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 09/75] Revert "ALSA: hda/realtek - Improve the headset mic for Acer Aspire laptops"
Date:   Mon, 17 Jun 2019 23:09:20 +0200
Message-Id: <20190617210753.220340169@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210752.799453599@linuxfoundation.org>
References: <20190617210752.799453599@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Wang <hui.wang@canonical.com>

commit 17d304604a88cf20c8dfd2c95d3decb9c4f8bca4 upstream.

This reverts commit 9cb40eb184c4220d244a532bd940c6345ad9dbd9.

This patch introduces noise and headphone playback issue after
rebooting or suspending/resuming. Let us revert it.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=203831
Fixes: 9cb40eb184c4 ("ALSA: hda/realtek - Improve the headset mic for Acer Aspire laptops")
Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6084,15 +6084,13 @@ static const struct hda_fixup alc269_fix
 		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
 	},
 	[ALC255_FIXUP_ACER_MIC_NO_PRESENCE] = {
-		.type = HDA_FIXUP_VERBS,
-		.v.verbs = (const struct hda_verb[]) {
-			/* Enable the Mic */
-			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x45 },
-			{ 0x20, AC_VERB_SET_PROC_COEF, 0x5089 },
-			{}
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+			{ }
 		},
 		.chained = true,
-		.chain_id = ALC269_FIXUP_LIFEBOOK_EXTMIC
+		.chain_id = ALC255_FIXUP_HEADSET_MODE
 	},
 	[ALC255_FIXUP_ASUS_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
@@ -7124,10 +7122,6 @@ static const struct snd_hda_pin_quirk al
 		{0x19, 0x0181303F},
 		{0x21, 0x0221102f}),
 	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1025, "Acer", ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
-		{0x12, 0x90a60140},
-		{0x14, 0x90170120},
-		{0x21, 0x02211030}),
-	SND_HDA_PIN_QUIRK(0x10ec0255, 0x1025, "Acer", ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
 		{0x12, 0x90a601c0},
 		{0x14, 0x90171120},
 		{0x21, 0x02211030}),


