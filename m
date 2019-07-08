Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FCFC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A805320651
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600248;
	bh=wn8tfUQ0QII5ET8ilWg6zjwjOTp8UIfnFEDeH8m0txk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SqTgMlqbfi4l7JLC9C0ZIAfs+wJuROCiNcCnQnNIZKiai+JniCFd2H4vKFgUYRUAa
	 yZM6WC4xB08Kb+6EUHLbvwlLM3BD5/Yl0xUz7xetF8AMYxZRUfdS/Z3aHw6ug4WW70
	 MQDZiR59jVJ8ZMB/Sghzpgd8otCD8JpIJxxQqPjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390656AbfGHPh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:37:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390043AbfGHPcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:32:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B0A721738;
        Mon,  8 Jul 2019 15:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599923;
        bh=wn8tfUQ0QII5ET8ilWg6zjwjOTp8UIfnFEDeH8m0txk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vs7A3lk4wi8FTzyDHBtFZcXkxPGpj40Z2vXccsvlao/McPrTOYY7tiUV/RZhvR2rN
         a894HZThQpDqCw/G268RPWtQzUBJbYd7jIQ2auvqR7qgHq9PJaaCmaH9cj1I7BJ9OA
         X3i6dYum3KbdGQcj3zsVmofMgu1Fhtkl4gJchTVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 33/96] ASoC: Intel: cht_bsw_nau8824: fix kernel oops with platform_name override
Date:   Mon,  8 Jul 2019 17:13:05 +0200
Message-Id: <20190708150528.356305528@linuxfoundation.org>
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

[ Upstream commit 096701e8131425044d2054a0c210d6ea24ee7386 ]

The platform override code uses devm_ functions to allocate memory for
the new name but the card device is not initialized. Fix by moving the
init earlier.

Fixes: 4506db8043341 ("ASoC: Intel: cht_bsw_nau8824: platform name fixup support")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_nau8824.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/cht_bsw_nau8824.c b/sound/soc/intel/boards/cht_bsw_nau8824.c
index 02c2fa239331..20fae391c75a 100644
--- a/sound/soc/intel/boards/cht_bsw_nau8824.c
+++ b/sound/soc/intel/boards/cht_bsw_nau8824.c
@@ -257,6 +257,7 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	snd_soc_card_set_drvdata(&snd_soc_card_cht, drv);
 
 	/* override plaform name, if required */
+	snd_soc_card_cht.dev = &pdev->dev;
 	mach = (&pdev->dev)->platform_data;
 	platform_name = mach->mach_params.platform;
 
@@ -266,7 +267,6 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		return ret_val;
 
 	/* register the soc card */
-	snd_soc_card_cht.dev = &pdev->dev;
 	ret_val = devm_snd_soc_register_card(&pdev->dev, &snd_soc_card_cht);
 	if (ret_val) {
 		dev_err(&pdev->dev,
-- 
2.20.1



