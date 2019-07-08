Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9959AC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E592216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599922;
	bh=WNVKe9XdnyGsS8CB+43/HUL12WZxv+JKCoH2Y64xShw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JqMuGUKRG6Lc8zZt1DKd6Y4osEK71A2BVeHek0ZJPNrD0/T3RoVEVIfYBvODkIkuq
	 LswlGwlX/tpKjuyQHBdQPPpI5YsaUWq78vFwpbFGlianOdWZDCpQnJJvrFmD9/NcMF
	 36jxTDeXVVfhlfsSSdam7+S/wq+SNpfTjmKFSZSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390033AbfGHPcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387573AbfGHPb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:31:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19D4B216C4;
        Mon,  8 Jul 2019 15:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599917;
        bh=WNVKe9XdnyGsS8CB+43/HUL12WZxv+JKCoH2Y64xShw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mB5k8D9lkkRuLCbsEwPHo0kIu+YeFO2zo0pGUAYrWpG3Ghyj5gm8d9frvzOoNxL1m
         NdzKJczR/GdpLRS0jzgevNwAMVhDe2VvXzfxYdMrER7x9MgL8tM+nRbNoYUFzL9RZc
         xieuPaqv2XqhrCvPqbIjxKuQGKerO0/kIIwZnO6A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 31/96] ASoC: Intel: cht_bsw_max98090: fix kernel oops with platform_name override
Date:   Mon,  8 Jul 2019 17:13:03 +0200
Message-Id: <20190708150528.235698557@linuxfoundation.org>
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

[ Upstream commit fb54555134b9b17835545e4d096b5550c27eed64 ]

The platform override code uses devm_ functions to allocate memory for
the new name but the card device is not initialized. Fix by moving the
init earlier.

Fixes: 7e7e24d7c7ff0 ("ASoC: Intel: cht_bsw_max98090_ti: platform name fixup support")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index c0e0844f75b9..572e336ae0f9 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -454,6 +454,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	}
 
 	/* override plaform name, if required */
+	snd_soc_card_cht.dev = &pdev->dev;
 	mach = (&pdev->dev)->platform_data;
 	platform_name = mach->mach_params.platform;
 
@@ -463,7 +464,6 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		return ret_val;
 
 	/* register the soc card */
-	snd_soc_card_cht.dev = &pdev->dev;
 	snd_soc_card_set_drvdata(&snd_soc_card_cht, drv);
 
 	if (drv->quirks & QUIRK_PMC_PLT_CLK_0)
-- 
2.20.1



