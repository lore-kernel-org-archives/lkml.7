Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C856C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6936E206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892958;
	bh=dHl6+KoD8OPrNumf8l17wWgVRJhE0CepafrgyhtPWGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tNOt2XzekDnXZ0Z2ettAAJBSZEbA06PMzKNToSf/spU8K/ml8PNKzDVFO5ME0EKEB
	 CcVwOZki6pi5n1SGILp8E7SkDi6LfpWP0LzgJG8mw8hx9pPxZCFBHZVL16G3+SwGtV
	 wYgry0C4Q1frtA0AHbOE7t5Sq592Kyve/VwDV3o4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbfH0ICh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:02:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731940AbfH0ICV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:02:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02EB3206BF;
        Tue, 27 Aug 2019 08:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892940;
        bh=dHl6+KoD8OPrNumf8l17wWgVRJhE0CepafrgyhtPWGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kRRkp6BYJjex/ujV/cGfmPEbkEw4kDOIjhu4dbq4dq2zWK6OURWH1jJ6O+/45Bznf
         BOCPGYVi4mtawjwdg7hMecbc1izcqYTy3NCjKpJ369EkEkSv7KurFtxRYbclMeH0KZ
         2aVP813qP8z+63Y1w/WKdz+evEcg2q2OKOU2PB1I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vijendar Mukunda <vijendar.mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 068/162] ASoC: amd: acp3x: use dma_ops of parent device for acp3x dma driver
Date:   Tue, 27 Aug 2019 09:49:56 +0200
Message-Id: <20190827072740.514603453@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 88639051017fb61a414b636dd0fc490da2b62b64 ]

AMD platform device acp3x_rv_i2s created by parent PCI device
driver. Pass struct device of the parent to
snd_pcm_lib_preallocate_pages() so dma_alloc_coherent() can use
correct dma_ops. Otherwise, it will use default dma_ops which
is nommu_dma_ops on x86_64 even when IOMMU is enabled and
set to non passthrough mode.

Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
Link: https://lore.kernel.org/r/1564753899-17124-1-git-send-email-Vijendar.Mukunda@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 9775bda2a4ca3..d8aa6ab3f68bc 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -367,9 +367,11 @@ static snd_pcm_uframes_t acp3x_dma_pointer(struct snd_pcm_substream *substream)
 
 static int acp3x_dma_new(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd,
+								    DRV_NAME);
+	struct device *parent = component->dev->parent;
 	snd_pcm_lib_preallocate_pages_for_all(rtd->pcm, SNDRV_DMA_TYPE_DEV,
-					      rtd->pcm->card->dev,
-					      MIN_BUFFER, MAX_BUFFER);
+					      parent, MIN_BUFFER, MAX_BUFFER);
 	return 0;
 }
 
-- 
2.20.1



