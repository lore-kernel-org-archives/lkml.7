Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22A5C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795FA20679
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IT4kodYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfJBJP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 05:15:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55478 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfJBJPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:15:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id a6so6303849wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 02:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vWHRyjfWyVAvZ0d9limuIhAOHFkppMKjucGsUpwzYtI=;
        b=IT4kodYwuiwRChWFe0eoHn2SWkYKNLbK2zm1QRfQ7XdR+ptwWJ0FPNkUeKU1yAR1Mp
         wlit5v3MTL8Mz7eKBgwgOjNDB4dn60dYlDjRuiToOKV7ZJ52ImLhHqkKwalwPd6Hy/fk
         KzZda3ngaCzZO6SvTUO7lQPbQKpXZypePnB/ou/iz5/E8UjyLfZMrlSXMsAaOhA9W4os
         0rAjQCKPJE0iRsd1avs9/XYkHrXWreYBnOBdeXpY5zQgVoZDjqXrpF7G8YlAoKz1ZW4K
         pvkFLoGOjUZSnrpzt5r69ODJXKLdKaV8yfufInFu9T5XjutwDppnZoMOlEL5yCtdFa7N
         akHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vWHRyjfWyVAvZ0d9limuIhAOHFkppMKjucGsUpwzYtI=;
        b=qSwo8CuQ7teDtYZSRI0zSq5EDwFiUUeCldFUyYgw6/NT/FVG7gIKyWbATr07zeSOY/
         2iXQU/laKo42FRr9332itCFfbaV2hLuOOynU1uFS5E9wcqpQkrLdpjdGt63eGo/o60nO
         OCVbYCN7/FUTdMrrIzib60MVttg2eeu88mciJnzI5YFjQYHBu96XHoPLZobeZzjOK4sb
         TeKGr6V6BSrC2RUtguaIW6mIL8PPexxVmccgV60VXx6jU+hO+EZITplI5Y9mao1W6sJq
         gvTRtc0xbSeb9nzM0BOS5bVb30G4E0f78r/JNcu6WMGKglY/7qXXYx9Z5ELigm8UMXMK
         D3Xw==
X-Gm-Message-State: APjAAAWSXA8kTdVryDUxqInVptqQFbJglm56z3djzSe0NhxtO97qv+49
        dFLs6PUAbh9uPO+g+nHyhNCE9BWjA4M=
X-Google-Smtp-Source: APXvYqwsEcbHS9VxVbT8PbT3+/VY3fUIWGTk13U19bPg+ixrsvda8GXPStlhgdEi5taAB/VQ4TKOKw==
X-Received: by 2002:a1c:c78f:: with SMTP id x137mr2149162wmf.42.1570007735561;
        Wed, 02 Oct 2019 02:15:35 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r13sm32913737wrn.0.2019.10.02.02.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 02:15:34 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] clk: meson: axg-audio: remove useless defines
Date:   Wed,  2 Oct 2019 11:15:25 +0200
Message-Id: <20191002091529.17112-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191002091529.17112-1-jbrunet@baylibre.com>
References: <20191002091529.17112-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defining the number of each input type is no longer necessary since
we are not using the clk-input hack anymore

Fixes: 282420eed23f ("clk: meson: axg-audio: migrate to the new parent description method")
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg-audio.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 18b23cdf679c..60ac71856e5e 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -20,10 +20,6 @@
 #include "clk-phase.h"
 #include "sclk-div.h"
 
-#define AUD_MST_IN_COUNT	8
-#define AUD_SLV_SCLK_COUNT	10
-#define AUD_SLV_LRCLK_COUNT	10
-
 #define AUD_GATE(_name, _reg, _bit, _phws, _iflags)			\
 struct clk_regmap aud_##_name = {					\
 	.data = &(struct clk_regmap_gate_data){				\
-- 
2.21.0

