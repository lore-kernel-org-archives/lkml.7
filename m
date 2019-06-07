Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ACBC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD366208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 16:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="QqYoPdcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfFGQPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 12:15:14 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:49934 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbfFGQPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 12:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559924108; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LD3D3GMmh6oZn/yovGkBRET4CaZLI7sJLLT+O64xYqs=;
        b=QqYoPdcOw+DqdYdw1guIArXBtY29hpCJomqVLBzFMBc5qG8RxqPo5SofTLkPpfMC8ry3CU
        9gkqZajkejAlkD3JKiiaUUauuclN9qzlAWBHSD4zxm1/3a0jenGSvIFuftRhEboajy0zii
        oMB8HFm3IFeCjOtdiREFLRyFtVE4z2M=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     od@zcrc.me, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/3] ASoC/codecs: jz4740: Make probe function __init_or_module
Date:   Fri,  7 Jun 2019 18:14:59 +0200
Message-Id: <20190607161500.17379-2-paul@crapouillou.net>
In-Reply-To: <20190607161500.17379-1-paul@crapouillou.net>
References: <20190607161500.17379-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the probe function to be dropped after the kernel finished
its initialization, in the case where the driver was not compiled as a
module.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/codecs/jz4740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 974e17fa1911..f7293004971d 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -314,7 +314,7 @@ static const struct regmap_config jz4740_codec_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int jz4740_codec_probe(struct platform_device *pdev)
+static int __init_or_module jz4740_codec_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct jz4740_codec *jz4740_codec;
-- 
2.21.0.593.g511ec345e18

