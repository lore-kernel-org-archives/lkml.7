Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF875C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8912C2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lGf990GU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfFGI5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:57:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42608 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfFGI5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:57:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id x17so1304794wrl.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 01:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Nk/ajWW2fVH/9L9yBJ6zZfHfEglcI3MSG9DcJjyJ+A=;
        b=lGf990GUa32z0NWIrq3IT6/tA3Tr8dWI3lrZM3jaURZmclg6wXHKJYFjEWQHzF3XIg
         /m/7PkryJ8qIuEbig95LkE1ACJ7vLBmvws+COjHV+uc5rLqRm40f7TDDINmKXQquq7s7
         W5SkXYwzLakiKIMVw/RMB9xwCfM0uhLqzlxAULjh8N78xMuyizZS4nojgOYLt0c9LUjn
         qZrx1OdGESo+38kl0Enl+Gp4WMpsRkxPx/y60Vd8NvYLkHJs0Cfq0ZhqWjYwlw606Pos
         wS77pebk39PKtajivrkP1jwJ1U94AyJUtC+grClHgRgbn0tbUqbqnTvZlInDE8HmL6N7
         ETyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Nk/ajWW2fVH/9L9yBJ6zZfHfEglcI3MSG9DcJjyJ+A=;
        b=jf7GBbNzpBorf09ULwE+Cq9b2UWT2Yw/6Lm3sB5cQkOenwOYrmZfGq6LUuRkU+Z5hY
         h655xtQ4vRuf5E6vew0VpNopSWXEzNVTkWm3/ueyJHeI/XTl8tAdnSHXLzzA3hVzrQTb
         dGmczsGxLDX3bxmOKgqBuPUcA2xZ/i/iqGGUrPc7NbD+r7b4/3Vgd0lOYW3UXjK4f4ps
         yFbBA3u3gwh66fsLAFsMEYhf1tscW3rugtACvqVi9OYlDzBhO52qk/hgC6lpDUE1zsBt
         2hzIYwvVHtrPTMTsXDbF0s/j9xcKkZFzVOmlSBA0C+8tYLi+E0+N988ttbrNoVjzx7+9
         OeDw==
X-Gm-Message-State: APjAAAVl3U5zTLqycvLZDtny697iUtsFNzxKHMu00wGNIOxWAbApIFWY
        Jt3DiZd1/PYNcAt4f8y6/EZqKg==
X-Google-Smtp-Source: APXvYqz4IVNqNRbjq+XkvxaB+gbUjrylYR3ZBRzgq2RaTUqsgoCPlp1OgQmHsCNzGYDFiJsh9GGXLw==
X-Received: by 2002:adf:ee49:: with SMTP id w9mr9789849wro.112.1559897828100;
        Fri, 07 Jun 2019 01:57:08 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id d10sm2035308wrh.91.2019.06.07.01.57.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 01:57:07 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 1/6] ASoC: core: add support to snd_soc_dai_get_sdw_stream()
Date:   Fri,  7 Jun 2019 09:56:38 +0100
Message-Id: <20190607085643.932-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
References: <20190607085643.932-1-srinivas.kandagatla@linaro.org>
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
index f5d70041108f..9f90b936fd9a 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -177,6 +177,7 @@ struct snd_soc_dai_ops {
 
 	int (*set_sdw_stream)(struct snd_soc_dai *dai,
 			void *stream, int direction);
+	void *(*get_sdw_stream)(struct snd_soc_dai *dai, int direction);
 	/*
 	 * DAI digital mute - optional.
 	 * Called by soc-core to minimise any pops.
@@ -385,4 +386,13 @@ static inline int snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
 		return -ENOTSUPP;
 }
 
+static inline void *snd_soc_dai_get_sdw_stream(struct snd_soc_dai *dai, int direction)
+{
+	if (dai->driver->ops->get_sdw_stream)
+		return dai->driver->ops->get_sdw_stream(dai, direction);
+	else
+		return NULL;
+
+}
+
 #endif
-- 
2.21.0

