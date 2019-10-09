Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971CFECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B8621835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 11:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYUqb/h3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbfJILUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 07:20:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38215 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJILUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 07:20:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id w12so2411418wro.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 04:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NiFi50FuqI1VBpxzFdOXo/50+9I/uAkHDK87JHPscnU=;
        b=IYUqb/h35TlOVvANFhPXRwdzAJit1HS7e8FL86O0yeE6P8hgNfhos27Ng6uveFyPyw
         2mf36pEI87UXaGXeLkOr1yOQe+onbuyQ/DoIL+nFkyGAj+kHFjN+IB4PCfv9KVrqE6aM
         /kyYvCbklhWGYbmsUeHdoeqo9DmeJslfqOY4o+nqx5s9dYQe4dthhWF4WR/b8KLIPZPo
         BKUZiaSLr/lOFjOStbueSEKq81bBBjh+TAU3v/QFaHcIkEYyrv3ID0DRMg3suNM2xeMf
         R36IjldPLxPfA+siJfNs9KxyUMDN/U3ihcuYGO4THYVe2AC94XI26aN2mgrVhRcYhz6z
         AZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NiFi50FuqI1VBpxzFdOXo/50+9I/uAkHDK87JHPscnU=;
        b=cLfVtnAu8R/R2KfQXqcd1L0r6CsH8d5rpRwLuFeFXCdCizP+7JGsmNZPbQ05Id8P61
         UT8nXdI6dAbRtPnkyFX+KlkuAzzYyuvyi+wVssA4UkpJR8DCB0GVf9RFKNlq3B8LZ37S
         MiJO3bxdH192l8KH5so5erwp3YvTVBn3YdmnUSmizA12yNb9HiLrHX36u1ZKhZ3CKApY
         3+Vzl7gDHcJE1QUyKefoyAuygd3jo/8CRRlhqiLZRd+xTg6C7nxKo/I6wk08POnjrzdd
         uCLRpZK962jX/kELjBZV8QjEckjRclytIy3519gGbdInH1ddTj/mG0v1vHPn4rlkykyy
         n5eQ==
X-Gm-Message-State: APjAAAX3lvBwPMgODp1upKvdcbBmD/Pk/hs4CfuVheLNeCyfDrlyN+zL
        Ffpqj0wQmv99xwEpBeNWfknqtQ==
X-Google-Smtp-Source: APXvYqxfoIMEQHrCYevrzZsV5a92ggMZZsyuGPNKm0meavL9E991mpyYRdC345pA/uJsZsgpQ5WMbQ==
X-Received: by 2002:adf:fa88:: with SMTP id h8mr2392734wrr.89.1570620008255;
        Wed, 09 Oct 2019 04:20:08 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q15sm3197470wrg.65.2019.10.09.04.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 04:20:07 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH] ASoC: msm8916-wcd-digital: add missing MIX2 path for RX1/2
Date:   Wed,  9 Oct 2019 12:19:44 +0100
Message-Id: <20191009111944.28069-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing MIX2 path on RX1/2 which take IIR1 and
IIR2 as inputs.

Without this patch sound card fails to intialize with below warning:

 ASoC: no sink widget found for RX1 MIX2 INP1
 ASoC: Failed to add route IIR1 -> IIR1 -> RX1 MIX2 INP1
 ASoC: no sink widget found for RX2 MIX2 INP1
 ASoC: Failed to add route IIR1 -> IIR1 -> RX2 MIX2 INP1
 ASoC: no sink widget found for RX1 MIX2 INP1
 ASoC: Failed to add route IIR2 -> IIR2 -> RX1 MIX2 INP1
 ASoC: no sink widget found for RX2 MIX2 INP1
 ASoC: Failed to add route IIR2 -> IIR2 -> RX2 MIX2 INP1

Reported-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Stephan Gerhold <stephan@gerhold.net>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index 9fa5d44fdc79..58b2468fb2a7 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -243,6 +243,10 @@ static const char *const rx_mix1_text[] = {
 	"ZERO", "IIR1", "IIR2", "RX1", "RX2", "RX3"
 };
 
+static const char * const rx_mix2_text[] = {
+	"ZERO", "IIR1", "IIR2"
+};
+
 static const char *const dec_mux_text[] = {
 	"ZERO", "ADC1", "ADC2", "ADC3", "DMIC1", "DMIC2"
 };
@@ -270,6 +274,16 @@ static const struct soc_enum rx3_mix1_inp_enum[] = {
 	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX3_B2_CTL, 0, 6, rx_mix1_text),
 };
 
+/* RX1 MIX2 */
+static const struct soc_enum rx_mix2_inp1_chain_enum =
+	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX1_B3_CTL,
+		0, 3, rx_mix2_text);
+
+/* RX2 MIX2 */
+static const struct soc_enum rx2_mix2_inp1_chain_enum =
+	SOC_ENUM_SINGLE(LPASS_CDC_CONN_RX2_B3_CTL,
+		0, 3, rx_mix2_text);
+
 /* DEC */
 static const struct soc_enum dec1_mux_enum = SOC_ENUM_SINGLE(
 				LPASS_CDC_CONN_TX_B1_CTL, 0, 6, dec_mux_text);
@@ -309,6 +323,10 @@ static const struct snd_kcontrol_new rx3_mix1_inp2_mux = SOC_DAPM_ENUM(
 				"RX3 MIX1 INP2 Mux", rx3_mix1_inp_enum[1]);
 static const struct snd_kcontrol_new rx3_mix1_inp3_mux = SOC_DAPM_ENUM(
 				"RX3 MIX1 INP3 Mux", rx3_mix1_inp_enum[2]);
+static const struct snd_kcontrol_new rx1_mix2_inp1_mux = SOC_DAPM_ENUM(
+				"RX1 MIX2 INP1 Mux", rx_mix2_inp1_chain_enum);
+static const struct snd_kcontrol_new rx2_mix2_inp1_mux = SOC_DAPM_ENUM(
+				"RX2 MIX2 INP1 Mux", rx2_mix2_inp1_chain_enum);
 
 /* Digital Gain control -38.4 dB to +38.4 dB in 0.3 dB steps */
 static const DECLARE_TLV_DB_SCALE(digital_gain, -3840, 30, 0);
@@ -740,6 +758,10 @@ static const struct snd_soc_dapm_widget msm8916_wcd_digital_dapm_widgets[] = {
 			 &rx3_mix1_inp2_mux),
 	SND_SOC_DAPM_MUX("RX3 MIX1 INP3", SND_SOC_NOPM, 0, 0,
 			 &rx3_mix1_inp3_mux),
+	SND_SOC_DAPM_MUX("RX1 MIX2 INP1", SND_SOC_NOPM, 0, 0,
+			 &rx1_mix2_inp1_mux),
+	SND_SOC_DAPM_MUX("RX2 MIX2 INP1", SND_SOC_NOPM, 0, 0,
+			 &rx2_mix2_inp1_mux),
 
 	SND_SOC_DAPM_MUX("CIC1 MUX", SND_SOC_NOPM, 0, 0, &cic1_mux),
 	SND_SOC_DAPM_MUX("CIC2 MUX", SND_SOC_NOPM, 0, 0, &cic2_mux),
-- 
2.21.0

