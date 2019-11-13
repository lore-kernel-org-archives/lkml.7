Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FB9C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EB822459
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610116;
	bh=AIYtbqFaSVhN3JGaOi6Hkys2vKMeqBOtBZxFJ6Fjv9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RLd13Nf2ADVJ2+6u6kMpV3BM2i+pfa3p8YsSdyIMDOTJxpfSRL2HtDo/Cj0wDUd8G
	 EdQzTQ+BHR7jb5ZRLWlfP9c2BX2Ckn4deCW6k/xkJejh6pnWKQ8xERKiextK75pVGo
	 lyxBmCy2jDJ7GjqFKlp5EHCvz0C959ieguIbug5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbfKMBzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:55:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbfKMBzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:55:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77FE8204EC;
        Wed, 13 Nov 2019 01:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610111;
        bh=AIYtbqFaSVhN3JGaOi6Hkys2vKMeqBOtBZxFJ6Fjv9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IgipqFagL5wvW/vqzKR/EG+FbAN5w/8ltrrzzMMyZTNALZgA5Vg/GsOqmdLz3uPDr
         AiBRknY1TM8F7+O4KK9vPuOMt//V7Z2qLmJgnvqKLpD/X3gExTgStoO7a0xqh6t6d8
         uxEAleuEm2YcptQZnQCb36UumSPQz1u2o5YC3vnw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Connor McAdams <conmanx360@gmail.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 167/209] ALSA: hda/ca0132 - Fix input effect controls for desktop cards
Date:   Tue, 12 Nov 2019 20:49:43 -0500
Message-Id: <20191113015025.9685-167-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Connor McAdams <conmanx360@gmail.com>

[ Upstream commit 7a2dc84fc480aec4f8f96e152327423014edf668 ]

This patch removes the echo cancellation control for desktop cards, and
makes use of the special 0x47 SCP command for noise reduction.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_ca0132.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 0436789e7cd88..36cf23a300d46 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4520,7 +4520,7 @@ static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val)
 			val = 0;
 
 		/* If Voice Focus on SBZ, set to two channel. */
-		if ((nid == VOICE_FOCUS) && (spec->quirk == QUIRK_SBZ)
+		if ((nid == VOICE_FOCUS) && (spec->use_pci_mmio)
 				&& (spec->cur_mic_type != REAR_LINE_IN)) {
 			if (spec->effects_switch[CRYSTAL_VOICE -
 						 EFFECT_START_NID]) {
@@ -4539,7 +4539,7 @@ static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val)
 		 * For SBZ noise reduction, there's an extra command
 		 * to module ID 0x47. No clue why.
 		 */
-		if ((nid == NOISE_REDUCTION) && (spec->quirk == QUIRK_SBZ)
+		if ((nid == NOISE_REDUCTION) && (spec->use_pci_mmio)
 				&& (spec->cur_mic_type != REAR_LINE_IN)) {
 			if (spec->effects_switch[CRYSTAL_VOICE -
 						 EFFECT_START_NID]) {
@@ -5855,8 +5855,8 @@ static int ca0132_build_controls(struct hda_codec *codec)
 	 */
 	num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT;
 	for (i = 0; i < num_fx; i++) {
-		/* SBZ and R3D break if Echo Cancellation is used. */
-		if (spec->quirk == QUIRK_SBZ || spec->quirk == QUIRK_R3D) {
+		/* Desktop cards break if Echo Cancellation is used. */
+		if (spec->use_pci_mmio) {
 			if (i == (ECHO_CANCELLATION - IN_EFFECT_START_NID +
 						OUT_EFFECTS_COUNT))
 				continue;
-- 
2.20.1

