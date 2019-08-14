Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929AEC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF2B2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565750396;
	bh=1xgrUvmGxX/jYsyf1aBvQ4XPUPe/5oORHXydsIYsGis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ciEsSKB2LYw6drax4oCSPUikQ2Ju4kjMmqhd9DGIlVRMzgxZScI/Aal/yBxntRwXl
	 ssIXbVBp17bWgy93U9e13rL6P3yvlBTpu+MLJb8JCS07ltkTQPM53I47Qx1EfOIBKA
	 08kYTSreMyg2Fg2Hz730ACoMUfUBgddU9J6FgOhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfHNCjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:39:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbfHNCLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:11:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCBA920842;
        Wed, 14 Aug 2019 02:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748674;
        bh=1xgrUvmGxX/jYsyf1aBvQ4XPUPe/5oORHXydsIYsGis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IMy0nijk3XxU7lEambcq1TpNPGFm+5NC3SfgcM+MFSnFkXDsZEXyiKnsXL/tc5JkS
         4fA/8rH6fZb1C+dznCGTDQDeWVD3FHezXInUtkF7hwXEavA1ZYWXHRwd8wNOAbxDMB
         5eysdHtWgpZgmMcmldbaLt9yrtTOwfYDTrcOb3BU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 014/123] ASoC: samsung: odroid: fix a double-free issue for cpu_dai
Date:   Tue, 13 Aug 2019 22:08:58 -0400
Message-Id: <20190814021047.14828-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021047.14828-1-sashal@kernel.org>
References: <20190814021047.14828-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

[ Upstream commit 2abee12c0ab1924a69993d2c063a39a952e7d836 ]

The cpu_dai variable is still being used after the of_node_put() call,
which may result in double-free:

        of_node_put(cpu_dai);            ---> released here

        ret = devm_snd_soc_register_card(dev, card);
        if (ret < 0) {
...
                goto err_put_clk_i2s;    --> jump to err_put_clk_i2s
...

err_put_clk_i2s:
        clk_put(priv->clk_i2s_bus);
err_put_sclk:
        clk_put(priv->sclk_i2s);
err_put_cpu_dai:
        of_node_put(cpu_dai);            --> double-free here

Fixes: d832d2b246c5 ("ASoC: samsung: odroid: Fix of_node refcount unbalance")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sangbeom Kim <sbkim73@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/r/1562989575-33785-3-git-send-email-wen.yang99@zte.com.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/samsung/odroid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index 95c35e3ff3303..d606e48fe551a 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -299,7 +299,6 @@ static int odroid_audio_probe(struct platform_device *pdev)
 		ret = PTR_ERR(priv->clk_i2s_bus);
 		goto err_put_sclk;
 	}
-	of_node_put(cpu_dai);
 
 	ret = devm_snd_soc_register_card(dev, card);
 	if (ret < 0) {
@@ -307,6 +306,7 @@ static int odroid_audio_probe(struct platform_device *pdev)
 		goto err_put_clk_i2s;
 	}
 
+	of_node_put(cpu_dai);
 	of_node_put(codec);
 	return 0;
 
-- 
2.20.1

