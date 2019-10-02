Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB5EC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2301020679
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="T/aGw4jB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfJBJPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 05:15:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35791 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfJBJPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:15:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id v8so18765866wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 02:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nE4XL8qms/9Kpgy3n+0LiYMlRLilMKnu0uTWVFko214=;
        b=T/aGw4jBTIUHeH9SKGQLtK1hvCEFgU+EMbG+nv70eK/25cpAooafnR8JbK4j/uyYFy
         IuVO65n51+KadCsWy1hwU16qrq3ujxIUpZVP/E+jc6d4VzIBwCsSLrFX08ZRyepE+Q5M
         SVBgd9lMVOlZGao1ZypNTExynwUn7IzZGEeivtTBnw7Hm5lhkN8OyaroXPUNtDdeLaQH
         bfZcY/3vqaGDIj5ctUMEvX88YDnzl5FLgQXFS2q64VNckirJ3rDGJMHcKaqSBJar7Q7a
         dq/32C3NeflV3mh7SeOrS3O6m9x856HR3M448QwkMPFYqRnSt84hWZef1o5dqWvNB3XZ
         3YMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nE4XL8qms/9Kpgy3n+0LiYMlRLilMKnu0uTWVFko214=;
        b=isjjflJ7bJ4fH6Qc2+fH/puO1YaJLGesSButxzceShIBLAA69/Gc/85iCWOAraWsro
         4kFOmq1SI9ZTctqSCywKYbw4hmHPR/p0d/tmtCjsaJPaQV09KGjXU7rhTGS6ZcSWp2Gy
         zitPkjiysWvKgEt5jnwgCpiKgOSTRdf6yd7+xAATboAEqsHqy4JdijPgzr02KjBZsimI
         TX41gSvwyjsKdCb9+d/ObY2wHstowEPS1M9aBVHCDjGAT/TWgTypcC0go9z7VrsxgSHY
         +yTnfI1MDrpjUu869/LDiFJz/I3//ibvlyFJYr263VQ29KrN3byBh/k8YHifBxE9Dt+t
         nnSw==
X-Gm-Message-State: APjAAAXODAVlHC1rmRlB2vnHLrrZk9MrHmGqLhdnOYURiaVkYb4wVX/q
        asClEAJg6B0fyYzu4jXqFSPIPg==
X-Google-Smtp-Source: APXvYqymrSpIQdJa2W/1+In8Zgc9ChQQebe+UJurZWszpY6vhZXVv5ks8iziGJ7wEuF/wSAOsbv+ZA==
X-Received: by 2002:a5d:4083:: with SMTP id o3mr1938600wrp.216.1570007736610;
        Wed, 02 Oct 2019 02:15:36 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r13sm32913737wrn.0.2019.10.02.02.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 02:15:35 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] clk: meson: axg-audio: fix regmap last register
Date:   Wed,  2 Oct 2019 11:15:26 +0200
Message-Id: <20191002091529.17112-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191002091529.17112-1-jbrunet@baylibre.com>
References: <20191002091529.17112-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the addition of the g12a, the last register is
AUDIO_CLK_SPDIFOUT_B_CTRL.

Fixes: 075001385c66 ("clk: meson: axg-audio: add g12a support")
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg-audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 60ac71856e5e..4b34601342bb 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -997,7 +997,7 @@ static const struct regmap_config axg_audio_regmap_cfg = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
-	.max_register	= AUDIO_CLK_PDMIN_CTRL1,
+	.max_register	= AUDIO_CLK_SPDIFOUT_B_CTRL,
 };
 
 struct audioclk_data {
-- 
2.21.0

