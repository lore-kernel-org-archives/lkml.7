Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B87BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D049921744
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640338;
	bh=xS+lBwFLJzDnqF2B0UvTsY6AXhYlAT+VP+Vhr/nouYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0B7ON90/QgnNA75M0JfZjz2ngrbdl/RexGrL5kNrEd3xqPDpns1nB1VhZ064jQ0uY
	 NXxaMJSIEPc+UF5QxoY6iPSAYmQRY5rGBregkpxy3M8nhb4MZ3pA4T1aYPobiUpI3g
	 9Om12jk7+5JwEAdtHC6DNcFSvaj9tdVClW0EmvBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfL2RZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:25:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728006AbfL2RZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:25:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5253720409;
        Sun, 29 Dec 2019 17:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640334;
        bh=xS+lBwFLJzDnqF2B0UvTsY6AXhYlAT+VP+Vhr/nouYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VvNfArV/2t4WXQvfg5CBMjq7w1RoxsjDNTVGmH9+oZzA58BvFEJTXuFezHz7l6UyH
         cB/iaZPsDn6SsVWMtXAFGXBCeVUZ3L3ROfSkwpohVA+L5KW7HsOo7N+Sq7RFSOlo0c
         bnvdxmwb2sqR5H7r/9uVSVxNCI5L/ElAqPY7+jYA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 114/161] ASoC: Intel: kbl_rt5663_rt5514_max98927: Add dmic format constraint
Date:   Sun, 29 Dec 2019 18:19:22 +0100
Message-Id: <20191229162431.989230651@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162355.500086350@linuxfoundation.org>
References: <20191229162355.500086350@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu-Hsuan Hsu <yuhsuan@chromium.org>

[ Upstream commit e2db787bdcb4f2722ecf410168f0583764634e45 ]

On KBL platform, the microphone is attached to external codec(rt5514)
instead of PCH. However, TDM slot between PCH and codec is 16 bits only.
In order to avoid setting wrong format, we should add a constraint to
force to use 16 bits format forever.

Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20190923162940.199580-1-yuhsuan@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 41cb1fefbd42..405196283688 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -422,6 +422,9 @@ static int kabylake_dmic_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
 			dmic_constraints);
 
+	runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
+	snd_pcm_hw_constraint_msbits(runtime, 0, 16, 16);
+
 	return snd_pcm_hw_constraint_list(substream->runtime, 0,
 			SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
 }
-- 
2.20.1



