Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B71C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FB6204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599930;
	bh=MvPKptrsH1yGccI/d1FhXIx/+pPTsmfzi2Gzw1r0H4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=APTenW4nllvyvjJpOw/pNGC7BrZp/TlRj5z4peBjbo0mPPGZkEcAYxNlcCOpB1ffJ
	 BZNzgCpctrrM8HNUDPPfMjsls+MxBPxFODfH1l2jm/shVvjlWMv9PJeRYwCE5ldYUm
	 gOo0z4Rga7XMuwyt1O9elJ0dk1M8c/Eqo7/G1API=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390071AbfGHPcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:32:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390026AbfGHPcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:32:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2897921743;
        Mon,  8 Jul 2019 15:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599925;
        bh=MvPKptrsH1yGccI/d1FhXIx/+pPTsmfzi2Gzw1r0H4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gYeDVt6ySjt6dtWpR7NmKnvFFngJfJlDaDj0tE6SaBO4f1Zd3fA7ytTBPSrNTS4op
         429OmmkuIHQxfRAXYvngNn0SZfN1FSV4flZkBpkcJWgcExvoJwqddooKGM2iXwqryp
         lBFTadjKU+IxpmxcLz7M5YJF20XmaVHw9gEIKTCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 34/96] ASoC: Intel: cht_bsw_rt5672: fix kernel oops with platform_name override
Date:   Mon,  8 Jul 2019 17:13:06 +0200
Message-Id: <20190708150528.406899292@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150526.234572443@linuxfoundation.org>
References: <20190708150526.234572443@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 9bbc799318a34061703f2a980e2b6df7fc6760f0 ]

The platform override code uses devm_ functions to allocate memory for
the new name but the card device is not initialized. Fix by moving the
init earlier.

Fixes: f403906da05cd ("ASoC: Intel: cht_bsw_rt5672: platform name fixup support")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_rt5672.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index 3d5a2b3a06f0..87ce3857376d 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -425,6 +425,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	}
 
 	/* override plaform name, if required */
+	snd_soc_card_cht.dev = &pdev->dev;
 	platform_name = mach->mach_params.platform;
 
 	ret_val = snd_soc_fixup_dai_links_platform_name(&snd_soc_card_cht,
@@ -442,7 +443,6 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	snd_soc_card_set_drvdata(&snd_soc_card_cht, drv);
 
 	/* register the soc card */
-	snd_soc_card_cht.dev = &pdev->dev;
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_cht);
 	if (ret_val) {
 		dev_err(&pdev->dev,
-- 
2.20.1



