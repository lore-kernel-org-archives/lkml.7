Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B09C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DC22184D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557427733;
	bh=uZaDk2MwG1pjJ1LTJ9lj/yeRBUt9aHHPE2OQWP7w6zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EHNWLeefHFeYVW3CGJfRUQCD9JyNlTXBiFDpVOj0aFv86K6WJFG4E0MImt98uFRqE
	 PCQoIDU8HxCalGLERODdf4ZThYF4b15/etPTTx+SIwT2pB2Cy4LKy3xsBlTOGeRody
	 5d7ETub7IMRNBPYn90MtiVZyMeWKJLz2wfUvQ3HU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfEISsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:48:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728070AbfEISsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:48:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 786112183E;
        Thu,  9 May 2019 18:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427727;
        bh=uZaDk2MwG1pjJ1LTJ9lj/yeRBUt9aHHPE2OQWP7w6zY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ffh8Ie/7yySYxUd2b/3TPmkYtPZD/Rm4gYRKu8hZWTVJ4smgLDwWY+q8J79AVpbLr
         3/D1wi4pnNGf1pu86krnHtbbTPvaqtC0pZx5GHlqmmbALT2JmmVr5C6K6syLLqxBrI
         RzSLNpgYI8pU2DswTR0JuO5HWT2iTCPQkJyqPXRs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Hsu <KCHSU0@nuvoton.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 14/66] ASoC: nau8810: fix the issue of widget with prefixed name
Date:   Thu,  9 May 2019 20:41:49 +0200
Message-Id: <20190509181303.418977513@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181301.719249738@linuxfoundation.org>
References: <20190509181301.719249738@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 54d1cf78b0f4ba348a7c7fb8b7d0708d71b6cc8a ]

The driver changes the stream name of DAC and ADC to avoid the issue of
widget with prefixed name. When the machine adds prefixed name for codec,
the stream name of DAI may not find the widgets.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/nau8810.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/nau8810.c b/sound/soc/codecs/nau8810.c
index bfd74b86c9d2f..645aa07941237 100644
--- a/sound/soc/codecs/nau8810.c
+++ b/sound/soc/codecs/nau8810.c
@@ -411,9 +411,9 @@ static const struct snd_soc_dapm_widget nau8810_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("Mono Mixer", NAU8810_REG_POWER3,
 		NAU8810_MOUTMX_EN_SFT, 0, &nau8810_mono_mixer_controls[0],
 		ARRAY_SIZE(nau8810_mono_mixer_controls)),
-	SND_SOC_DAPM_DAC("DAC", "HiFi Playback", NAU8810_REG_POWER3,
+	SND_SOC_DAPM_DAC("DAC", "Playback", NAU8810_REG_POWER3,
 		NAU8810_DAC_EN_SFT, 0),
-	SND_SOC_DAPM_ADC("ADC", "HiFi Capture", NAU8810_REG_POWER2,
+	SND_SOC_DAPM_ADC("ADC", "Capture", NAU8810_REG_POWER2,
 		NAU8810_ADC_EN_SFT, 0),
 	SND_SOC_DAPM_PGA("SpkN Out", NAU8810_REG_POWER3,
 		NAU8810_NSPK_EN_SFT, 0, NULL, 0),
-- 
2.20.1



