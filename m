Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE50C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA31206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="W3EecKqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbfHTLCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 07:02:42 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:63654 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbfHTLCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:02:40 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 46CSX05fwvzM6;
        Tue, 20 Aug 2019 13:01:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1566298864; bh=vhh0R3ZwxyK95TRRuvI0sK1jU1a82qw8GoKLehqjapY=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=W3EecKqRDYEHwdqRCHVlv/4lWa3NvXCfiX89Qpg/qsSiFkpci9P2/11HMtgib/YiD
         1cAXGO6KWAS9EZFplwc6qLQfB6b4WD8CBOCEl06YeM9e0C2dZW8XvpEIngq8CFIw85
         n6Uucs3O7Zvb8cd3mWpsACiMs7p1hbqyTUlbSEN+AHYdUr7D1HJJ9N9/BE3rcKQzel
         oxXX4PhmBYQ09GPnDMJHhX0OLV61NpVHJCI/ELzGafCPTNT6Y8jzb+U3Jq2zjMhIc+
         5Qxtep0I0zRr74JAXlpbXeNMqFx8i/1I8PrWiOuuD7h+6+cyguvOGaYmGI/72oI49B
         EAt5M8BeBFLhw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.2 at mail
Date:   Tue, 20 Aug 2019 13:02:37 +0200
Message-Id: <125cd3c9f298da9b08a4d6002d4c00d70a898950.1566298834.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <f95ae1085f9f3c137a122c4d95728711613c15f7.1566298834.git.mirq-linux@rere.qmqm.pl>
References: <f95ae1085f9f3c137a122c4d95728711613c15f7.1566298834.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 2/2] ASoC: wm8904: implement input mode select as a mux
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Kate Stewart <kstewart@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make '* Capture Mode' a mux. This makes DAPM know that in single-ended
mode only inverting mux paths need to be enabled.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
v2: fixed 'right' to be 'Right'
---
 sound/soc/codecs/wm8904.c | 52 +++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 525e4ef654a1..bcb3c9d5abf0 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -545,18 +545,6 @@ static const DECLARE_TLV_DB_SCALE(out_tlv, -5700, 100, 0);
 static const DECLARE_TLV_DB_SCALE(sidetone_tlv, -3600, 300, 0);
 static const DECLARE_TLV_DB_SCALE(eq_tlv, -1200, 100, 0);
 
-static const char *input_mode_text[] = {
-	"Single-Ended", "Differential Line", "Differential Mic"
-};
-
-static SOC_ENUM_SINGLE_DECL(lin_mode,
-			    WM8904_ANALOGUE_LEFT_INPUT_1, 0,
-			    input_mode_text);
-
-static SOC_ENUM_SINGLE_DECL(rin_mode,
-			    WM8904_ANALOGUE_RIGHT_INPUT_1, 0,
-			    input_mode_text);
-
 static const char *hpf_mode_text[] = {
 	"Hi-fi", "Voice 1", "Voice 2", "Voice 3"
 };
@@ -591,9 +579,6 @@ static const struct snd_kcontrol_new wm8904_adc_snd_controls[] = {
 SOC_DOUBLE_R_TLV("Digital Capture Volume", WM8904_ADC_DIGITAL_VOLUME_LEFT,
 		 WM8904_ADC_DIGITAL_VOLUME_RIGHT, 1, 119, 0, digital_tlv),
 
-SOC_ENUM("Left Capture Mode", lin_mode),
-SOC_ENUM("Right Capture Mode", rin_mode),
-
 /* No TLV since it depends on mode */
 SOC_DOUBLE_R("Capture Volume", WM8904_ANALOGUE_LEFT_INPUT_0,
 	     WM8904_ANALOGUE_RIGHT_INPUT_0, 0, 31, 0),
@@ -852,6 +837,10 @@ static int out_pga_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static const char *input_mode_text[] = {
+	"Single-Ended", "Differential Line", "Differential Mic"
+};
+
 static const char *lin_text[] = {
 	"IN1L", "IN2L", "IN3L"
 };
@@ -868,6 +857,13 @@ static SOC_ENUM_SINGLE_DECL(lin_inv_enum, WM8904_ANALOGUE_LEFT_INPUT_1, 4,
 static const struct snd_kcontrol_new lin_inv_mux =
 	SOC_DAPM_ENUM("Left Capture Inverting Mux", lin_inv_enum);
 
+static SOC_ENUM_SINGLE_DECL(lin_mode_enum,
+			    WM8904_ANALOGUE_LEFT_INPUT_1, 0,
+			    input_mode_text);
+
+static const struct snd_kcontrol_new lin_mode =
+	SOC_DAPM_ENUM("Left Capture Mode", lin_mode_enum);
+
 static const char *rin_text[] = {
 	"IN1R", "IN2R", "IN3R"
 };
@@ -884,6 +880,13 @@ static SOC_ENUM_SINGLE_DECL(rin_inv_enum, WM8904_ANALOGUE_RIGHT_INPUT_1, 4,
 static const struct snd_kcontrol_new rin_inv_mux =
 	SOC_DAPM_ENUM("Right Capture Inverting Mux", rin_inv_enum);
 
+static SOC_ENUM_SINGLE_DECL(rin_mode_enum,
+			    WM8904_ANALOGUE_RIGHT_INPUT_1, 0,
+			    input_mode_text);
+
+static const struct snd_kcontrol_new rin_mode =
+	SOC_DAPM_ENUM("Right Capture Mode", rin_mode_enum);
+
 static const char *aif_text[] = {
 	"Left", "Right"
 };
@@ -932,9 +935,11 @@ SND_SOC_DAPM_SUPPLY("MICBIAS", WM8904_MIC_BIAS_CONTROL_0, 0, 0, NULL, 0),
 SND_SOC_DAPM_MUX("Left Capture Mux", SND_SOC_NOPM, 0, 0, &lin_mux),
 SND_SOC_DAPM_MUX("Left Capture Inverting Mux", SND_SOC_NOPM, 0, 0,
 		 &lin_inv_mux),
+SND_SOC_DAPM_MUX("Left Capture Mode", SND_SOC_NOPM, 0, 0, &lin_mode),
 SND_SOC_DAPM_MUX("Right Capture Mux", SND_SOC_NOPM, 0, 0, &rin_mux),
 SND_SOC_DAPM_MUX("Right Capture Inverting Mux", SND_SOC_NOPM, 0, 0,
 		 &rin_inv_mux),
+SND_SOC_DAPM_MUX("Right Capture Mode", SND_SOC_NOPM, 0, 0, &rin_mode),
 
 SND_SOC_DAPM_PGA("Left Capture PGA", WM8904_POWER_MANAGEMENT_0, 1, 0,
 		 NULL, 0),
@@ -1057,6 +1062,12 @@ static const struct snd_soc_dapm_route adc_intercon[] = {
 	{ "Left Capture Inverting Mux", "IN2L", "IN2L" },
 	{ "Left Capture Inverting Mux", "IN3L", "IN3L" },
 
+	{ "Left Capture Mode", "Single-Ended", "Left Capture Inverting Mux" },
+	{ "Left Capture Mode", "Differential Line", "Left Capture Mux" },
+	{ "Left Capture Mode", "Differential Line", "Left Capture Inverting Mux" },
+	{ "Left Capture Mode", "Differential Mic", "Left Capture Mux" },
+	{ "Left Capture Mode", "Differential Mic", "Left Capture Inverting Mux" },
+
 	{ "Right Capture Mux", "IN1R", "IN1R" },
 	{ "Right Capture Mux", "IN2R", "IN2R" },
 	{ "Right Capture Mux", "IN3R", "IN3R" },
@@ -1065,11 +1076,14 @@ static const struct snd_soc_dapm_route adc_intercon[] = {
 	{ "Right Capture Inverting Mux", "IN2R", "IN2R" },
 	{ "Right Capture Inverting Mux", "IN3R", "IN3R" },
 
-	{ "Left Capture PGA", NULL, "Left Capture Mux" },
-	{ "Left Capture PGA", NULL, "Left Capture Inverting Mux" },
+	{ "Right Capture Mode", "Single-Ended", "Right Capture Inverting Mux" },
+	{ "Right Capture Mode", "Differential Line", "Right Capture Mux" },
+	{ "Right Capture Mode", "Differential Line", "Right Capture Inverting Mux" },
+	{ "Right Capture Mode", "Differential Mic", "Right Capture Mux" },
+	{ "Right Capture Mode", "Differential Mic", "Right Capture Inverting Mux" },
 
-	{ "Right Capture PGA", NULL, "Right Capture Mux" },
-	{ "Right Capture PGA", NULL, "Right Capture Inverting Mux" },
+	{ "Left Capture PGA", NULL, "Left Capture Mode" },
+	{ "Right Capture PGA", NULL, "Right Capture Mode" },
 
 	{ "AIFOUTL Mux", "Left", "ADCL" },
 	{ "AIFOUTL Mux", "Right", "ADCR" },
-- 
2.20.1

