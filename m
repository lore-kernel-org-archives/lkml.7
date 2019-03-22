Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23DCC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827D221925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253651;
	bh=DOPzwMYxU8EIVFdE8Gl2qZibhWS1Nrx0t8aJIxodI8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w2y+OwVrkNtQugFTofve4heRdO8Kx2nF6sjzSjlBk+YMfu9dg/hJkJVkBarqXJTb1
	 u3VsksF5ezkGYvYpIPPysEsg4pSPAiqZ2dQ2cpSgTvAK8FZQkag7iQaDX5bcg1MyEH
	 vYrmhqMcgju/KA3F4DQRjYYq5U6JbNZHXg3lelcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfCVLUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:20:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728435AbfCVLUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:20:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C9EC2192D;
        Fri, 22 Mar 2019 11:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253644;
        bh=DOPzwMYxU8EIVFdE8Gl2qZibhWS1Nrx0t8aJIxodI8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LlcgaVzSmJG0xgFF4Q4EikyD5C6JMAWSdpIGbNHjCrDkbD9TUr1aqfY67WWa4M80H
         bZKuBcb1P9fotA5+DiblE1XWOzjHX8o1rElgBCO6TebWHtHkIoum6M/HEd/W6qwM/d
         OEUJ9gwlkwrYJEIfW8R/0IubMb1PDIWq+U5xSmuM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rander Wang <rander.wang@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 028/134] ASoC: Intel: Haswell/Broadwell: fix setting for .dynamic field
Date:   Fri, 22 Mar 2019 12:14:01 +0100
Message-Id: <20190322111211.822040130@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 906a9abc5de73c383af518f5a806f4be2993a0c7 ]

For some reason this field was set to zero when all other drivers use
.dynamic = 1 for front-ends. This change was tested on Dell XPS13 and
has no impact with the existing legacy driver. The SOF driver also works
with this change which enables it to override the fixed topology.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/broadwell.c | 2 +-
 sound/soc/intel/haswell.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/broadwell.c b/sound/soc/intel/broadwell.c
index 0e550f14028f1..4aba2286a5aba 100644
--- a/sound/soc/intel/broadwell.c
+++ b/sound/soc/intel/broadwell.c
@@ -168,7 +168,7 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
 		.stream_name = "Loopback",
 		.cpu_dai_name = "Loopback Pin",
 		.platform_name = "haswell-pcm-audio",
-		.dynamic = 0,
+		.dynamic = 1,
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
diff --git a/sound/soc/intel/haswell.c b/sound/soc/intel/haswell.c
index 3981982674ac9..0efd574d37706 100644
--- a/sound/soc/intel/haswell.c
+++ b/sound/soc/intel/haswell.c
@@ -146,7 +146,7 @@ static struct snd_soc_dai_link haswell_rt5640_dais[] = {
 		.stream_name = "Loopback",
 		.cpu_dai_name = "Loopback Pin",
 		.platform_name = "haswell-pcm-audio",
-		.dynamic = 0,
+		.dynamic = 1,
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
-- 
2.19.1



