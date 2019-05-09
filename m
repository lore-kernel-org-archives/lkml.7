Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDCEC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DC3217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557427810;
	bh=ycF3rSLz8AyUda2IepVML6nmjUi/GFNOsyv4yiV1oCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bnHSgIh/mh1SJVCZhI4R+ohLmOzNc2raZcVXiTszooALKmJaE9R5Wu4E1RE76AxGS
	 +vyhdfOT8oK43Yj7m5d4ZX5lWSAZ3o0gwKiiisUR8qBxBlBKF1lBjljIXP5LYm/6PM
	 KojnH0ew47aWKgkjYcCGOqB7mvQ/FOe/esGjrC1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfEISuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbfEISuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:50:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46926217F5;
        Thu,  9 May 2019 18:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427805;
        bh=ycF3rSLz8AyUda2IepVML6nmjUi/GFNOsyv4yiV1oCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D/UMDdxgrLAYlYwe+Wu1PK64uLvBtKFfHME6xIF0X/sHxEYAnfejqdf5eGfWWYUUl
         HozkKxp6t1XbDX4mQGU8WsgyzxWw3fkeuwS5XTL7qlkEd2EKLKT1sjw8A8EXbdapLD
         e3h5xBbZ1H8AoI/LSaZe5wiWaE/TVsvjc4Q7PEEs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olivier Moysan <olivier.moysan@st.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 11/95] ASoC: stm32: sai: fix exposed capabilities in spdif mode
Date:   Thu,  9 May 2019 20:41:28 +0200
Message-Id: <20190509181310.137731548@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181309.180685671@linuxfoundation.org>
References: <20190509181309.180685671@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b8468192971807c43a80d6e2c41f83141cb7b211 ]

Change capabilities exposed in SAI S/PDIF mode, to match
actually supported formats.
In S/PDIF mode only 32 bits stereo is supported.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index aaacec5b442df..1653cea936cbd 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -682,6 +682,14 @@ static int stm32_sai_startup(struct snd_pcm_substream *substream,
 
 	sai->substream = substream;
 
+	if (STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
+		snd_pcm_hw_constraint_mask64(substream->runtime,
+					     SNDRV_PCM_HW_PARAM_FORMAT,
+					     SNDRV_PCM_FMTBIT_S32_LE);
+		snd_pcm_hw_constraint_single(substream->runtime,
+					     SNDRV_PCM_HW_PARAM_CHANNELS, 2);
+	}
+
 	ret = clk_prepare_enable(sai->sai_ck);
 	if (ret < 0) {
 		dev_err(cpu_dai->dev, "Failed to enable clock: %d\n", ret);
-- 
2.20.1



