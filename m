Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A43C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE2C20659
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420650;
	bh=UrD8YiwKxXaJ/kMLAEuxrBkiQf0urUIp4Z3Wm6yFIqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BTvV3MQzCqwmYxfdDu/GNOeBxztQk9Ppg4yqnfOOHxoVrfcIa9lOBwZaOabrZr247
	 9ZwuZgsyEMKFPYiNmojLXS639YlI+LiSQuYcoamwysxDVyUWPvmS0bfjVkuU746jT5
	 G9hnVfBMGiDul757cztyOy8hywkJ65MlJklbfe+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbfKVLEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:04:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:58706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730859AbfKVLEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:04:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99D692084D;
        Fri, 22 Nov 2019 11:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420644;
        bh=UrD8YiwKxXaJ/kMLAEuxrBkiQf0urUIp4Z3Wm6yFIqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mC/pRhoRje24QTG1xbrP/Jr3aOg/rnuHAbrwQDbzMbZ9iJ2y9wGM9HPtfG8ztE3JU
         6HCjpSERA6D6/dJWXwQBy2D4cR8Co9vDJMcRm7SRsFtbwvlzX3zkbvWIRKbx3c9S3P
         rBhUWEOr7oQMShRTO0Ifmyg2L+teEn1yMdqkE/Co=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Connor McAdams <conmanx360@gmail.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 178/220] ALSA: hda/ca0132 - Fix input effect controls for desktop cards
Date:   Fri, 22 Nov 2019 11:29:03 +0100
Message-Id: <20191122100925.648885708@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index f2cabfdced05c..6a9b89e05daea 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4521,7 +4521,7 @@ static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val)
 			val = 0;
 
 		/* If Voice Focus on SBZ, set to two channel. */
-		if ((nid == VOICE_FOCUS) && (spec->quirk == QUIRK_SBZ)
+		if ((nid == VOICE_FOCUS) && (spec->use_pci_mmio)
 				&& (spec->cur_mic_type != REAR_LINE_IN)) {
 			if (spec->effects_switch[CRYSTAL_VOICE -
 						 EFFECT_START_NID]) {
@@ -4540,7 +4540,7 @@ static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val)
 		 * For SBZ noise reduction, there's an extra command
 		 * to module ID 0x47. No clue why.
 		 */
-		if ((nid == NOISE_REDUCTION) && (spec->quirk == QUIRK_SBZ)
+		if ((nid == NOISE_REDUCTION) && (spec->use_pci_mmio)
 				&& (spec->cur_mic_type != REAR_LINE_IN)) {
 			if (spec->effects_switch[CRYSTAL_VOICE -
 						 EFFECT_START_NID]) {
@@ -5856,8 +5856,8 @@ static int ca0132_build_controls(struct hda_codec *codec)
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



