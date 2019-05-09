Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78AAC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8308B20656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428527;
	bh=0zZtPe/QZmm1wOMxxCB1OieNmsIUQ3UbVlb0wPX58Fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j2l5JAXOngR4pyMknJ+x3aIa1zyJyRSTXfhU2SBi94eIhfnw81WNL5A3pWdZrpCdG
	 C4VEMCot05GdQ+ZX3ewRU9vH3L3lxJ1y6YjYmGsyNlSC7HfAKH6AmsFKyTXwLm4JHd
	 EqxAHHdKrDctTW2psqJJdLxIY+4ZMu1i2i4Y+YcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfEITCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 15:02:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728417AbfEISu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:50:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EB312177E;
        Thu,  9 May 2019 18:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427826;
        bh=0zZtPe/QZmm1wOMxxCB1OieNmsIUQ3UbVlb0wPX58Fw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aO1v7cDneCplmkhOI93BcaexmUVhj/0tXCcHZe8Pw5QSXO+KwxLRpHSOWzzvIhWgh
         Btw/+X/gZLoh4CU8CZL5UgivKdP8x0dbjYSLsLltjhsd+ui0N50R4fpLzQEQTyWIbH
         4f+e9Ronjm/x89QJdKHRYFSyV67h4wqhqgMBboQQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, JaeChul Lee <jcsing.lee@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 19/95] ASoC: samsung: odroid: Fix clock configuration for 44100 sample rate
Date:   Thu,  9 May 2019 20:41:36 +0200
Message-Id: <20190509181310.684874052@linuxfoundation.org>
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

[ Upstream commit 2b13bee3884926cba22061efa75bd315e871de24 ]

After commit fbeec965b8d1c ("ASoC: samsung: odroid: Fix 32000 sample rate
handling") the audio root clock frequency is configured improperly for
44100 sample rate. Due to clock rate rounding it's 20070401 Hz instead
of 22579000 Hz. This results in a too low value of the PSR clock divider
in the CPU DAI driver and too fast actual sample rate for fs=44100. E.g.
1 kHz tone has actual 1780 Hz frequency (1 kHz * 20070401/22579000 * 2).

Fix this by increasing the correction passed to clk_set_rate() to take
into account inaccuracy of the EPLL frequency properly.

Fixes: fbeec965b8d1c ("ASoC: samsung: odroid: Fix 32000 sample rate handling")
Reported-by: JaeChul Lee <jcsing.lee@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/samsung/odroid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index e7b371b072304..45c6d73967852 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -64,11 +64,11 @@ static int odroid_card_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 
 	/*
-	 *  We add 1 to the rclk_freq value in order to avoid too low clock
+	 *  We add 2 to the rclk_freq value in order to avoid too low clock
 	 *  frequency values due to the EPLL output frequency not being exact
 	 *  multiple of the audio sampling rate.
 	 */
-	rclk_freq = params_rate(params) * rfs + 1;
+	rclk_freq = params_rate(params) * rfs + 2;
 
 	ret = clk_set_rate(priv->sclk_i2s, rclk_freq);
 	if (ret < 0)
-- 
2.20.1



