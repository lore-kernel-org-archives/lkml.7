Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C7FC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675AC22459
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eVxW6Kgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbfJDVoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:44:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38359 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731223AbfJDVno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:43:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id h195so4685400pfe.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GlE7EV9ZCAIebEa+EIBxR8fUoerT1/7sfKy7D9MHjI4=;
        b=eVxW6KgtyZ8JQrKs0J/lCOximSvmXNsC1eBefIROkzFGAjbHwvP1CIkoAjV00sn/ZT
         c37j0oEoOCfnf42J6h13VbuR1Plru4KL2pAmil/2mEiCxIC+/eOl5vhe/yZ2QsOOQryF
         NfODdc9R4JjgUz3eIt3BqOdX3FRAu3XS9Vu2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GlE7EV9ZCAIebEa+EIBxR8fUoerT1/7sfKy7D9MHjI4=;
        b=CUZhm4LGRxF04HJPTppDVcSHK39rMoYXjhuM2LUQ3s1ZhxlDl4N6B96rKIFor+ySaV
         rtCLww+dqFBf3uMFKyFiXuehXwBUlW1BHbiL3Zlscr2EAACwnb0kcKGsp7E3Oqa3CgeA
         WcGLqA5/598JOlpKuvWHeucjMFyGm9C0Afr1MHCq/nJGiH2h4ET+tRj2B57lP9SG59mx
         d1h6n1yKJWmikrijXRaEya3pCwPQpTZy54WV983ojsNKXUg5K7Roh490am+0tZjyrJpS
         nXRgWBuYVpo/LJmP1rETA0/f+lCBykq3cCecSRszYizcBRCDFj/xlnzVaxPjhLG5cO/Y
         9/7A==
X-Gm-Message-State: APjAAAXlsM8Y6t5usmZz8vw2H2z4QI8sEyTq1zpThvDeRcFZIubZEwgf
        xzX/wSGmY487JfbD+zil3rnUChw59KE=
X-Google-Smtp-Source: APXvYqz/zeAfOFLn8InrUDsSwRMd8ffzxCvY/3n479aCfXR18qlzfF6acmga5aGS3E9hIODd6McEkw==
X-Received: by 2002:a63:df50:: with SMTP id h16mr17395692pgj.126.1570225423141;
        Fri, 04 Oct 2019 14:43:43 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a11sm10446799pfg.94.2019.10.04.14.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 14:43:42 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH 07/10] ASoC: jz4740: Use of_device_get_match_data()
Date:   Fri,  4 Oct 2019 14:43:31 -0700
Message-Id: <20191004214334.149976-8-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191004214334.149976-1-swboyd@chromium.org>
References: <20191004214334.149976-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This probe function is only called if the device is backed by a DT node,
so switch this call to of_device_get_match_data() to reduce code size
and simplify a bit. This also avoids needing to reference a potentially
undefined variable because of_device_get_match_data() doesn't need to
know anything beyond the struct device to find the match table.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: <alsa-devel@alsa-project.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please ack or pick for immediate merge so the last patch can be merged.

 sound/soc/jz4740/jz4740-i2s.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 13408de34055..d2dab4d24b87 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -503,9 +503,8 @@ static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 	if (!i2s)
 		return -ENOMEM;
 
-	match = of_match_device(jz4740_of_matches, &pdev->dev);
-	if (match)
-		i2s->version = (enum jz47xx_i2s_version)match->data;
+	i2s->version =
+		(enum jz47xx_i2s_version)of_device_get_match_data(&pdev->dev);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	i2s->base = devm_ioremap_resource(&pdev->dev, mem);
-- 
Sent by a computer through tubes

