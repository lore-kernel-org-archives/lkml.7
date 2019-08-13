Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38348C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACCA2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NIbQsuQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfHMIgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:36:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39521 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbfHMIf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:35:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id i63so692241wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 01:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B9rsr1/dgfaWkUD61V9rwU3U5jz+C8FjG7cuo0AJp/Q=;
        b=NIbQsuQ2GpNnu739xoBeBF5FbMINwGQO+uIiIC0oSLND+QmbFVEfIMFPovy+35DF/K
         wg++6jFE3Z9x5YLYZzPdq3Td/haqQlmOjOe2kkrJEYAeG2DEXu1cUrNyCr8UXuRtNjJ2
         M8cpQ+NGVZzfmBjrrbQVSi09Fk1hcLN0wTa2gbd8aT6C4hJ/bV1Ty/wgvnZIzTzLNq1C
         GMCi/GaYWG04/R8YjyoIM97doonDiD9mxrNim+ql2pMM+zsPLw2Il2hxXPIg5EMx5Sva
         4N/VaFxQyREtZdPogXXXuqNfJn5TUJyO7KtYv/4svBoYj4qUzg1iZ2KBR5awYOXaAwFI
         NSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B9rsr1/dgfaWkUD61V9rwU3U5jz+C8FjG7cuo0AJp/Q=;
        b=XdV6lk+2Hvd8EjY6T2yvYGjdMtsSMDtU5LavmyzgccclHpkNh7/eHb7jr6ICMfOGl/
         XznzndzKcEm3mX28/rlHCwJolIyXzwSp0tlkNLitaWH2PCbD/ZdYj5Ol5zQvNharHm9I
         Kjllnf5Vw6Fp1wyVPZ9lU978j6tRDwTUUxgPBYyZ2yvuvEdtjERPQGxuYqo0cu5TvZQW
         xIIzsOAR5LVvLZUC7U3EkV+D/uzK6oDyN44IwzlUTDNtYx7MpejM/B5n5KENKNeosoXW
         0P9zQ6WQXzhEOSZXXVQhLj0mg2pBn561BrGhhCZw+TLNS0d1AxBwwuKivQ+aYEK11z7n
         Zu9w==
X-Gm-Message-State: APjAAAWMMrOp828Xg3vEnPJB5dcZdt2cq9IxzGlJgK1l/8o1OrH7wU3H
        zt9lQawVhQUWdCpgxHwFF5SSNA==
X-Google-Smtp-Source: APXvYqwP5gWmgCWzPHvhUEOHEmYJug9XD6Ru09g/P4GV8esa71ue0cYftUlFH20psboRMPK85MePTg==
X-Received: by 2002:a1c:7a12:: with SMTP id v18mr1765791wmc.56.1565685358047;
        Tue, 13 Aug 2019 01:35:58 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id o11sm8651822wrw.19.2019.08.13.01.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 01:35:57 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, broonie@kernel.org
Cc:     bgoswami@codeaurora.org, plai@codeaurora.org,
        pierre-louis.bossart@linux.intel.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/5] ASoC: core: add support to snd_soc_dai_get_sdw_stream()
Date:   Tue, 13 Aug 2019 09:35:48 +0100
Message-Id: <20190813083550.5877-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On platforms which have smart speaker amplifiers connected via
soundwire and modeled as aux devices in ASoC, in such usecases machine
driver should be able to get sdw master stream from dai so that it can
use the runtime stream to setup slave streams.

soundwire already as a set function, get function would provide more
flexibility to above configurations.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/sound/soc-dai.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index dc48fe081a20..1e01f4a302e0 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -202,6 +202,7 @@ struct snd_soc_dai_ops {
 
 	int (*set_sdw_stream)(struct snd_soc_dai *dai,
 			void *stream, int direction);
+	void *(*get_sdw_stream)(struct snd_soc_dai *dai, int direction);
 	/*
 	 * DAI digital mute - optional.
 	 * Called by soc-core to minimise any pops.
@@ -410,4 +411,13 @@ static inline int snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
 		return -ENOTSUPP;
 }
 
+static inline void *snd_soc_dai_get_sdw_stream(struct snd_soc_dai *dai,
+					       int direction)
+{
+	if (dai->driver->ops->get_sdw_stream)
+		return dai->driver->ops->get_sdw_stream(dai, direction);
+	else
+		return ERR_PTR(-ENOTSUPP);
+}
+
 #endif
-- 
2.21.0

