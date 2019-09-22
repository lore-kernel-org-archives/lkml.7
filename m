Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC59C4740C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102B72196E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569178186;
	bh=csEuR0I3jvQUqVfdCrUe0yTO9jh+m3SBF9finvCv31s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pFDCyyGzTAxt8namRls79b6Ak37QUJ6F5+h7upbxjt5S9XTfNd8pyX+F6s1NEmFxD
	 pALvlYdutnRDv13N6ap2Uz9NC5LZtMNjvFaWFFdE6yuerPBkXoGCyP8GGjySly5PHu
	 oGMEg2JVgZu472grQTMmB/iwo0NA+qE34qWwnXH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392562AbfIVStp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392432AbfIVSte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:49:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7037921BE5;
        Sun, 22 Sep 2019 18:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178174;
        bh=csEuR0I3jvQUqVfdCrUe0yTO9jh+m3SBF9finvCv31s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=maVj7LOZ9/iD9ITNaPF38qs5//WwDYX+3hUa2xvqykHNbRFtYcsqfk653uuTjVDG0
         0Dm2JVu1dfpn2f6kNahtMW+utxHBVHYJ1Y2iYj0PlXOtCJbUMYS4UCMGWfU2VWHZjH
         NUWk9qPEsCzhkrc/g6vn3JjcYHW63X4xxxMt5uDE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        "Andrew F . Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 006/185] ASoC: tlv320aic31xx: suppress error message for EPROBE_DEFER
Date:   Sun, 22 Sep 2019 14:46:24 -0400
Message-Id: <20190922184924.32534-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184924.32534-1-sashal@kernel.org>
References: <20190922184924.32534-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

[ Upstream commit b7e814deae33eb30f8f8c6528e8e69b107978d88 ]

Both the supplies and reset GPIO might need a probe deferral for the
resource to be available. Don't print a error message in that case, as
it is a normal operating condition.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Andrew F. Davis <afd@ti.com>
Link: https://lore.kernel.org/r/20190719143637.2018-1-l.stach@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 9b37e98da0db1..26a4f6cd32883 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1553,7 +1553,8 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 	aic31xx->gpio_reset = devm_gpiod_get_optional(aic31xx->dev, "reset",
 						      GPIOD_OUT_LOW);
 	if (IS_ERR(aic31xx->gpio_reset)) {
-		dev_err(aic31xx->dev, "not able to acquire gpio\n");
+		if (PTR_ERR(aic31xx->gpio_reset) != -EPROBE_DEFER)
+			dev_err(aic31xx->dev, "not able to acquire gpio\n");
 		return PTR_ERR(aic31xx->gpio_reset);
 	}
 
@@ -1564,7 +1565,9 @@ static int aic31xx_i2c_probe(struct i2c_client *i2c,
 				      ARRAY_SIZE(aic31xx->supplies),
 				      aic31xx->supplies);
 	if (ret) {
-		dev_err(aic31xx->dev, "Failed to request supplies: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(aic31xx->dev,
+				"Failed to request supplies: %d\n", ret);
 		return ret;
 	}
 
-- 
2.20.1

