Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D854C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E897020675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482500;
	bh=C6IeJ1Jr9eVTqu3mUr/vW3aqgYeK24qHmCmJDg0Y4Co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=he+g6mBOLA+MesKtIqRed/OCIdNjX5AvtyULMoY0k7of7avHLud1ATwBarPPPtwqO
	 JV9Kf0FGW9O5LeL1yKwvQN6AiVNJQxG10Bjpa3J9ITqVAWAR+MPI4Mu7B1EY7Ev5Js
	 vFMIqPr3Bdtqtk1ZmX6k2nmZ7Cz77o86INKTHCSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbfLDSBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:01:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:42338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729618AbfLDSBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:01:36 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C029320675;
        Wed,  4 Dec 2019 18:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482496;
        bh=C6IeJ1Jr9eVTqu3mUr/vW3aqgYeK24qHmCmJDg0Y4Co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yI6aCkG8/xJBUXZXkyOId/4ROgy80L1iXfPZLfPVaKeHVkMcVPZr3shMEz6bRfxhk
         TbCEwJgYrt/oCYKfUPqMGr8V4jQiTmprwSRES2OKQeEVkT8F0CGueexVHq7XAnkNbC
         NxJSLeIJl+tJrWOMah+lO5SUhHbb1tWzG3UTruN8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 002/209] ASoC: msm8916-wcd-analog: Fix RX1 selection in RDAC2 MUX
Date:   Wed,  4 Dec 2019 18:53:34 +0100
Message-Id: <20191204175321.763617305@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

[ Upstream commit 9110d1b0e229cebb1ffce0c04db2b22beffd513d ]

According to the PM8916 Hardware Register Description,
CDC_D_CDC_CONN_HPHR_DAC_CTL has only a single bit (RX_SEL)
to switch between RX1 (0) and RX2 (1). It is not possible to
disable it entirely to achieve the "ZERO" state.

However, at the moment the "RDAC2 MUX" mixer defines three possible
values ("ZERO", "RX2" and "RX1"). Setting the mixer to "ZERO"
actually configures it to RX1. Setting the mixer to "RX1" has
(seemingly) no effect.

Remove "ZERO" and replace it with "RX1" to fix this.

Fixes: 585e881e5b9e ("ASoC: codecs: Add msm8916-wcd analog codec")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20191020153007.206070-1-stephan@gerhold.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 0b9b014b4bb6c..969283737787f 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -303,7 +303,7 @@ struct pm8916_wcd_analog_priv {
 };
 
 static const char *const adc2_mux_text[] = { "ZERO", "INP2", "INP3" };
-static const char *const rdac2_mux_text[] = { "ZERO", "RX2", "RX1" };
+static const char *const rdac2_mux_text[] = { "RX1", "RX2" };
 static const char *const hph_text[] = { "ZERO", "Switch", };
 
 static const struct soc_enum hph_enum = SOC_ENUM_SINGLE_VIRT(
@@ -318,7 +318,7 @@ static const struct soc_enum adc2_enum = SOC_ENUM_SINGLE_VIRT(
 
 /* RDAC2 MUX */
 static const struct soc_enum rdac2_mux_enum = SOC_ENUM_SINGLE(
-			CDC_D_CDC_CONN_HPHR_DAC_CTL, 0, 3, rdac2_mux_text);
+			CDC_D_CDC_CONN_HPHR_DAC_CTL, 0, 2, rdac2_mux_text);
 
 static const struct snd_kcontrol_new spkr_switch[] = {
 	SOC_DAPM_SINGLE("Switch", CDC_A_SPKR_DAC_CTL, 7, 1, 0)
-- 
2.20.1



