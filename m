Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF18C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C639B20748
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kW+Yur0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfKOWed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:34:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33839 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfKOWeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:34:15 -0500
Received: by mail-pl1-f194.google.com with SMTP id h13so5643375plr.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 14:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i5dPEh9y2ib6oOQnoQa1Apmmo+YJMTHG/tlqLO0haxk=;
        b=kW+Yur0Hl2oWdZbkaM/sYlnrLMZqd7UJF+2HEJzbhpeG0T9E+DGIbgyiCtM6Rn8cwG
         3TfxjWu0cq0O0Mq8seZ6SifvTMca6kTZcA5Q5IHZ+Vr7wi40pgdbQubrrP3lA716dYDT
         QQ/hQ5oOCbIRfgmybqfrg2P8aBTK/8ir+9wnrhdvqU1LZfpySWWHgCvwVa7p6SqVvpQM
         gD8BjoQhLQquamPA0i/EkkyiRTOOctidxeHXr7MaccD44rSjUXB4WVaBQMqEeDQCoqGs
         A9kZyWu0cxRQ65f0H1+XxOfxGa349XPFVe1fz4McNJfopYkmqTQPeOF1J9eREE1Pb3EO
         jrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i5dPEh9y2ib6oOQnoQa1Apmmo+YJMTHG/tlqLO0haxk=;
        b=FNG/rCud7GMPheacCjKlX6tKss9ewqFhnFy2g0tTDX0jPoqCimf0k6zqubfOP2jy3C
         Q2bAJ2769Ue9fyjYKw8ZyacbbDNyoeWQnGryJo4I1SKnMgk4+HYWW7fypaooof57KufY
         S3lFk5jenrS3TyArV2E45I9ciLAOdvWC3spl6kCy8AGVPd4p+gTTajmuWrRn79A5Z19y
         QjzvmJ2n4Vvc6R/fGu8oN3/vFfpLbglsE6oMcjdIHbIUhiDbxLx2vB2HcqVk+zewrKmH
         x0a4wmaE/kINWjfAuNTV27a40REY21KRrbsd2VPQN1GhVXqj5uEPFTQ5nlL+/YD29yvO
         nLkQ==
X-Gm-Message-State: APjAAAUoOeblGBNAe2ry7SewU94jTanPG7ulwcaUOZO/92zYg+HNPQj1
        Q2ns3XZFF56ywFbWJpKGkDiaEQ==
X-Google-Smtp-Source: APXvYqwHAc5twB501dJRqUfTBvKugpgHSSdUWAlfaFJMgzAPYdC8/2k7gHvhI3UOPNKl6RREJeuPVw==
X-Received: by 2002:a17:90a:252d:: with SMTP id j42mr23137114pje.131.1573857253840;
        Fri, 15 Nov 2019 14:34:13 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m15sm11699724pfh.19.2019.11.15.14.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 14:34:13 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19+][PATCH 18/20] ASoC: stm32: sai: add missing put_device()
Date:   Fri, 15 Nov 2019 15:33:54 -0700
Message-Id: <20191115223356.27675-18-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115223356.27675-1-mathieu.poirier@linaro.org>
References: <20191115223356.27675-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <yellowriver2010@hotmail.com>

commit 1c3816a194870e7a6622345dab7fb56c7d708613 upstream

The of_find_device_by_node() takes a reference to the underlying device
structure, we should release that reference.

Fixes: 7dd0d835582f ("ASoC: stm32: sai: simplify sync modes management")
Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
Acked-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable <stable@vger.kernel.org> # 4.19+
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 sound/soc/stm/stm32_sai.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index f22654253c43..540c4a00405c 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -112,16 +112,21 @@ static int stm32_sai_set_sync(struct stm32_sai_data *sai_client,
 	if (!sai_provider) {
 		dev_err(&sai_client->pdev->dev,
 			"SAI sync provider data not found\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_put_dev;
 	}
 
 	/* Configure sync client */
 	ret = stm32_sai_sync_conf_client(sai_client, synci);
 	if (ret < 0)
-		return ret;
+		goto out_put_dev;
 
 	/* Configure sync provider */
-	return stm32_sai_sync_conf_provider(sai_provider, synco);
+	ret = stm32_sai_sync_conf_provider(sai_provider, synco);
+
+out_put_dev:
+	put_device(&pdev->dev);
+	return ret;
 }
 
 static int stm32_sai_probe(struct platform_device *pdev)
-- 
2.17.1

