Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899B3C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616F524654
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077704;
	bh=5d51ygvNrdY94fbcMcCKNXOd5JNbqHT4k5/Lie++wmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LMCh7j6kgAgP+8xyy4HLuEmDudZYtjxRdUJYelDPkaEcjjRcbyRu5vEuPVJ7hTx/z
	 ukW3sOLOip2tlO9vQ17ZV5qNz8vnIn6eNis/9ByhaLs2YLSR76tdFwANiuqagtUPn7
	 pGNoGtVMkN7luoapBMjSDrKUan0KIdncQlso0DHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732340AbfLKPVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:21:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:52014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732482AbfLKPVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:21:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F0AE22527;
        Wed, 11 Dec 2019 15:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077697;
        bh=5d51ygvNrdY94fbcMcCKNXOd5JNbqHT4k5/Lie++wmQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qpjOJg7ZgR+w2dy6zeJqoZA120FRUOhcAcJwUeH7dMZxFnFG0LDUpBAuAKVvT+kke
         +RG//ngZJG696zA7a5oCCCg/get2FugoK6SR8HVaPmPvj0l2vz8xkZ/LorTnD/Cnlz
         9X53jLwvo7EWET6yOOfQnalrgaZHTaM/fjPg/eJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Young_X <YangX92@hotmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 136/243] ASoC: au8540: use 64-bit arithmetic instead of 32-bit
Date:   Wed, 11 Dec 2019 16:04:58 +0100
Message-Id: <20191211150348.334788913@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Young_X <YangX92@hotmail.com>

[ Upstream commit cd7fdc45bc69a62b4e22c6e875f1f1aea566256d ]

Add suffix ULL to constant 256 in order to give the compiler complete
information about the proper arithmetic to use.

Notice that such constant is used in a context that expects an
expression of type u64 (64 bits, unsigned) and the following
expression is currently being evaluated using 32-bit arithmetic:

    256 * fs * 2 * mclk_src_scaling[i].param

Signed-off-by: Young_X <YangX92@hotmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/nau8540.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8540.c b/sound/soc/codecs/nau8540.c
index e3c8cd17daf2d..4dd1a609756be 100644
--- a/sound/soc/codecs/nau8540.c
+++ b/sound/soc/codecs/nau8540.c
@@ -585,7 +585,7 @@ static int nau8540_calc_fll_param(unsigned int fll_in,
 	fvco_max = 0;
 	fvco_sel = ARRAY_SIZE(mclk_src_scaling);
 	for (i = 0; i < ARRAY_SIZE(mclk_src_scaling); i++) {
-		fvco = 256 * fs * 2 * mclk_src_scaling[i].param;
+		fvco = 256ULL * fs * 2 * mclk_src_scaling[i].param;
 		if (fvco > NAU_FVCO_MIN && fvco < NAU_FVCO_MAX &&
 			fvco_max < fvco) {
 			fvco_max = fvco;
-- 
2.20.1



