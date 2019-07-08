Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25394C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DA0216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599019;
	bh=uCRlZIC/VW7rzqhFjBiiYtqSwHiFQPXOrTmJnrfKFWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AftToxSZArrBggStUfux5sRVQKidjWfswkuFTIfhppOmWGh9IQpAFrYg5GUN/FXWG
	 m31Hu+xjKw5KgESIIH2DL7o6dARt1+GlbBIAVwA03keyVpBx1xvFLdwyo7Ce4hIHKS
	 kuIRg9X+bmFpwq2e67Y76GwwKp3LSEw69M3Ofsbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732703AbfGHPQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:16:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732690AbfGHPQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:16:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4009216C4;
        Mon,  8 Jul 2019 15:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599014;
        bh=uCRlZIC/VW7rzqhFjBiiYtqSwHiFQPXOrTmJnrfKFWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pIj0cZGEdcND9tzqWaOnwaBxvn6luVT6KB5Cqc9OmAPrpZHJIkW/LsBZtoencGjeP
         I5eqvESTJ2gLsx6WuY4BIlNJseqaqsoTvkGMTI8kI4Z0fAS1NamTXjn9XeoksoPHm+
         4/gtvMfiOynOjsziHuPIyreUyRe/yrgTRn/4BTc8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Flax <flatmax@flatmax.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 49/73] ASoC : cs4265 : readable register too low
Date:   Mon,  8 Jul 2019 17:12:59 +0200
Message-Id: <20190708150523.966806295@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150513.136580595@linuxfoundation.org>
References: <20190708150513.136580595@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f3df05c805983427319eddc2411a2105ee1757cf ]

The cs4265_readable_register function stopped short of the maximum
register.

An example bug is taken from :
https://github.com/Audio-Injector/Ultra/issues/25

Where alsactl store fails with :
Cannot read control '2,0,0,C Data Buffer,0': Input/output error

This patch fixes the bug by setting the cs4265 to have readable
registers up to the maximum hardware register CS4265_MAX_REGISTER.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs4265.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
index 93b02be3a90e..6edec2387861 100644
--- a/sound/soc/codecs/cs4265.c
+++ b/sound/soc/codecs/cs4265.c
@@ -60,7 +60,7 @@ static const struct reg_default cs4265_reg_defaults[] = {
 static bool cs4265_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case CS4265_CHIP_ID ... CS4265_SPDIF_CTL2:
+	case CS4265_CHIP_ID ... CS4265_MAX_REGISTER:
 		return true;
 	default:
 		return false;
-- 
2.20.1



