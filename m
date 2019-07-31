Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3948EC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 05:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D6A208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 05:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfGaFkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 01:40:19 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:48516 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfGaFkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 01:40:15 -0400
Received: from localhost.localdomain (10.28.8.29) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.1591.10; Wed, 31 Jul 2019
 13:40:48 +0800
From:   chunguo feng <chunguo.feng@amlogic.com>
To:     <lgirdwood@gmail.com>
CC:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <RyanS.Lee@maximintegrated.com>, <bleung@chromium.org>,
        <pierre-louis.bossart@linux.intel.com>, <grundler@chromium.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <chunguo.feng@amlogic.com>
Subject: [PATCH] ASoC: max98383: add  88200 and 96000 sampling rate support
Date:   Wed, 31 Jul 2019 13:40:03 +0800
Message-ID: <20190731054003.16076-1-chunguo.feng@amlogic.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.28.8.29]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: fengchunguo <chunguo.feng@amlogic.com>

88200 and 96000 sampling rate was not enabled on driver, so can't be played.

The error information:
max98373 3-0031：rate 96000 not supported
max98373 3-0031：ASoC: can't set max98373-aif1 hw params: -22

Signed-off-by: fengchunguo <chunguo.feng@amlogic.com>
---
 sound/soc/codecs/max98373.c | 6 ++++++
 sound/soc/codecs/max98373.h | 2 ++
 2 files changed, 8 insertions(+)
 mode change 100644 => 100755 sound/soc/codecs/max98373.c
 mode change 100644 => 100755 sound/soc/codecs/max98373.h

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
old mode 100644
new mode 100755
index 528695cd6a1c..8c601a3ebc27
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -267,6 +267,12 @@ static int max98373_dai_hw_params(struct snd_pcm_substream *substream,
 	case 48000:
 		sampling_rate = MAX98373_PCM_SR_SET1_SR_48000;
 		break;
+	case 88200:
+		sampling_rate = MAX98373_PCM_SR_SET1_SR_88200;
+		break;
+	case 96000:
+		sampling_rate = MAX98373_PCM_SR_SET1_SR_96000;
+		break;
 	default:
 		dev_err(component->dev, "rate %d not supported\n",
 			params_rate(params));
diff --git a/sound/soc/codecs/max98373.h b/sound/soc/codecs/max98373.h
old mode 100644
new mode 100755
index f6a37aa02f26..a59e51355a84
--- a/sound/soc/codecs/max98373.h
+++ b/sound/soc/codecs/max98373.h
@@ -130,6 +130,8 @@
 #define MAX98373_PCM_SR_SET1_SR_32000 (0x6 << 0)
 #define MAX98373_PCM_SR_SET1_SR_44100 (0x7 << 0)
 #define MAX98373_PCM_SR_SET1_SR_48000 (0x8 << 0)
+#define MAX98373_PCM_SR_SET1_SR_88200 (0x9 << 0)
+#define MAX98373_PCM_SR_SET1_SR_96000 (0xA << 0)
 
 /* MAX98373_R2028_PCM_SR_SETUP_2 */
 #define MAX98373_PCM_SR_SET2_SR_MASK (0xF << 4)
-- 
2.22.0

