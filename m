Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE18C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6281216F4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 16:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l+WJiw5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfK1Qu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:50:29 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45370 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfK1QuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 11:50:20 -0500
Received: by mail-pl1-f194.google.com with SMTP id w7so11782479plz.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 08:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pq5KE5gIMiwWIeSMy3T4ZpUVkQI2nKjqwjW9YajORlM=;
        b=l+WJiw5FLVFlg2GB6XJBFoKiX8wRGvOC39Lkh0eo9GF2U1R5dvDk5qSGf0mZyR0vCc
         Y7e4vpSWAV0QLx5g1zc+WO0pWa1anz+Bd+U/2YxuciS5ALd7iNeJkkUa8nQJacIba+Pm
         0kLdz+ycG9JYZZWa0KBQT0hJPYBJvCoV4sPn10uWObuUAwd5O/pKNS6lfP6kVi4XGlZt
         0g5fZWPqGFgLCDLo008WlXCCWNBhf0GsbRKmNpMq8thQiVZRSJ9x8fpfVK/TwTpgQJIE
         pJHBx8mNVXJMnQR7I8ruSp5OH3kkQDcwIBA372I/NWDLX3AGmAIEQywRGQThamt3rYX6
         dl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pq5KE5gIMiwWIeSMy3T4ZpUVkQI2nKjqwjW9YajORlM=;
        b=hNliIlofdunt3CZatreTliBtmuaQ/udgZ6QeGCzwha9O9LD1lwqGHaYrKjqefjlrWh
         V5spoOCTcpevhIdASi4uYabkh92D7IFPEIzPH6JumCzj14Z52Ffoj8wv9EsVkXUN6/kY
         cgEF0/Irn9DMFSVZhQSft83mZez3+UhBjB/sr2Z+A9uEABmeoi0NdMs36THySFbQlEof
         GAeP8wzbHDB6MJ4HBKoh/3XLz15y2i/H+aFqrxmfm5j0f9fmF8jC4EwbGNylGCvT+EsF
         hLaaaRJ41Qlw0Te8o4IVqpqVQTzuCER5PA3rWthAIUQOQP0cjcvdR4z61waA8hdBRY1f
         35AA==
X-Gm-Message-State: APjAAAUVNIasve0E5I9Z6FK42onQAvwJJPSxUinUl4FC9jixloibMTjk
        MgarSOIjoWc+GN5is+XClJf71FPM7Rg=
X-Google-Smtp-Source: APXvYqy7nY4M8oKkslqOt/PVLmbSbyuu/6WmpZQ19v6gUqyI/h7a+EpQzknbr5KGWOToNNslZQXfxQ==
X-Received: by 2002:a17:902:d696:: with SMTP id v22mr10301232ply.66.1574959819278;
        Thu, 28 Nov 2019 08:50:19 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a15sm2450343pfh.169.2019.11.28.08.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:50:18 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19][PATCH 16/17] ASoC: stm32: sai: add missing put_device()
Date:   Thu, 28 Nov 2019 09:50:01 -0700
Message-Id: <20191128165002.6234-17-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191128165002.6234-1-mathieu.poirier@linaro.org>
References: <20191128165002.6234-1-mathieu.poirier@linaro.org>
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
Cc: stable <stable@vger.kernel.org> # 4.19
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

