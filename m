Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4F7C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2DC215EA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329175;
	bh=+Fr+hVutFm4OIbyoN6o7lQDaZ+bUFLXAiO1bInlsSlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KoN2JfpER/Y4VR/o0NeUYOKZ7F70q0CmrGa/Pl1qCzAKLu0eMVcBlWgUXwwZ7kGbk
	 GVv+R02bFYzGRvU2OUaR00HFrmVtJWmXRM+CkNy0PpJ4TxF+A8ZQ7ZD3UTpk/pPoFQ
	 T68J8uuUubcv8r3BMCssYHyq/loyy5TV6EgGtR6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfD0Bjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:39:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727641AbfD0Bjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:39:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43FAF20873;
        Sat, 27 Apr 2019 01:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329170;
        bh=+Fr+hVutFm4OIbyoN6o7lQDaZ+bUFLXAiO1bInlsSlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mh3wC8sgeCJ5nmGb8ULUGhgFjAk6qHVvVGRogRTNPYBXw1yxlSxT0WDZO4A81zhof
         eDfgagnqpkZ0sL77K92lzW9rjUYogkUhW6ZKaqa/nQja41zeC8muRrKasFWFnvhLj5
         7M1Yx60rHnhmIDouqhpDPTacPZY/7+MWMvrZXAko=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kailang Yang <kailang@realtek.com>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 34/79] ALSA: hda/realtek - Move to ACT_INIT state
Date:   Fri, 26 Apr 2019 21:37:53 -0400
Message-Id: <20190427013838.6596-34-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

[ Upstream commit 8983eb602af511fc5822f5ff4a82074c68816fd9 ]

It will be lose Mic JD state when Chrome OS boot and headset was plugged.
Just Implement of reset combo jack JD verb for ACT_PRE_PROBE state.
Intel test result was also failed.
It test passed until changed the initial state to ACT_INIT.
Mic JD will show every time.
This patch also changed the model name as 'alc-chrome-book' for
application of Chrome OS.

Fixes: 10f5b1b85ed1 ("ALSA: hda/realtek - Fixed Headset Mic JD not stable")
Signed-off-by: Kailang Yang <kailang@realtek.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 41 +++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 84fae0df59e9..c90394db38ed 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5490,7 +5490,7 @@ static void alc_headset_btn_callback(struct hda_codec *codec,
 	jack->jack->button_state = report;
 }
 
-static void alc295_fixup_chromebook(struct hda_codec *codec,
+static void alc_fixup_headset_jack(struct hda_codec *codec,
 				    const struct hda_fixup *fix, int action)
 {
 
@@ -5500,16 +5500,6 @@ static void alc295_fixup_chromebook(struct hda_codec *codec,
 						    alc_headset_btn_callback);
 		snd_hda_jack_add_kctl(codec, 0x55, "Headset Jack", false,
 				      SND_JACK_HEADSET, alc_headset_btn_keymap);
-		switch (codec->core.vendor_id) {
-		case 0x10ec0295:
-			alc_update_coef_idx(codec, 0x4a, 0x8000, 1 << 15); /* Reset HP JD */
-			alc_update_coef_idx(codec, 0x4a, 0x8000, 0 << 15);
-			break;
-		case 0x10ec0236:
-			alc_update_coef_idx(codec, 0x1b, 0x8000, 1 << 15); /* Reset HP JD */
-			alc_update_coef_idx(codec, 0x1b, 0x8000, 0 << 15);
-			break;
-		}
 		break;
 	case HDA_FIXUP_ACT_INIT:
 		switch (codec->core.vendor_id) {
@@ -5530,6 +5520,25 @@ static void alc295_fixup_chromebook(struct hda_codec *codec,
 	}
 }
 
+static void alc295_fixup_chromebook(struct hda_codec *codec,
+				    const struct hda_fixup *fix, int action)
+{
+	switch (action) {
+	case HDA_FIXUP_ACT_INIT:
+		switch (codec->core.vendor_id) {
+		case 0x10ec0295:
+			alc_update_coef_idx(codec, 0x4a, 0x8000, 1 << 15); /* Reset HP JD */
+			alc_update_coef_idx(codec, 0x4a, 0x8000, 0 << 15);
+			break;
+		case 0x10ec0236:
+			alc_update_coef_idx(codec, 0x1b, 0x8000, 1 << 15); /* Reset HP JD */
+			alc_update_coef_idx(codec, 0x1b, 0x8000, 0 << 15);
+			break;
+		}
+		break;
+	}
+}
+
 static void alc_fixup_disable_mic_vref(struct hda_codec *codec,
 				  const struct hda_fixup *fix, int action)
 {
@@ -5684,6 +5693,7 @@ enum {
 	ALC285_FIXUP_LENOVO_PC_BEEP_IN_NOISE,
 	ALC255_FIXUP_ACER_HEADSET_MIC,
 	ALC295_FIXUP_CHROME_BOOK,
+	ALC225_FIXUP_HEADSET_JACK,
 	ALC225_FIXUP_DELL_WYSE_AIO_MIC_NO_PRESENCE,
 	ALC225_FIXUP_WYSE_AUTO_MUTE,
 	ALC225_FIXUP_WYSE_DISABLE_MIC_VREF,
@@ -6645,6 +6655,12 @@ static const struct hda_fixup alc269_fixups[] = {
 	[ALC295_FIXUP_CHROME_BOOK] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc295_fixup_chromebook,
+		.chained = true,
+		.chain_id = ALC225_FIXUP_HEADSET_JACK
+	},
+	[ALC225_FIXUP_HEADSET_JACK] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_headset_jack,
 	},
 	[ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
@@ -7143,7 +7159,8 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC255_FIXUP_DUMMY_LINEOUT_VERB, .name = "alc255-dummy-lineout"},
 	{.id = ALC255_FIXUP_DELL_HEADSET_MIC, .name = "alc255-dell-headset"},
 	{.id = ALC295_FIXUP_HP_X360, .name = "alc295-hp-x360"},
-	{.id = ALC295_FIXUP_CHROME_BOOK, .name = "alc-sense-combo"},
+	{.id = ALC225_FIXUP_HEADSET_JACK, .name = "alc-headset-jack"},
+	{.id = ALC295_FIXUP_CHROME_BOOK, .name = "alc-chrome-book"},
 	{.id = ALC299_FIXUP_PREDATOR_SPK, .name = "predator-spk"},
 	{}
 };
-- 
2.19.1

