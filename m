Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974E1C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6821720879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zpNEfai/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbfEMMbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:31:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38276 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbfEMMb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:31:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id v11so15066841wru.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 05:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mW2Fqi37nfrJWuA7Y78Xlr35mQpQP8Au1z+vEQpFR/c=;
        b=zpNEfai/ShFL9b9BqnxeB/Z0ueU/STT54nBh4jzNCSq8avg67UIuysT+FBIdpsciGJ
         fH+PJQ9dp/RC7UD4U5T30ILymLeLPSwMCGXbRrY5FXFhGMJXH/+xZrPQkS/NROWCtXPG
         Y7ljuoZE9vGoccHwsjUOCzX8dVYDO7DZe8QJuNXNCAPU66G93Qz+KX2xdn/T7cRrxtNc
         8oB5kEqR8RaHUs3dERDJiu2eG5YGccaZMM0q08ciUhiKKYmMbNuj7N6p3ewMaIvPWP4C
         DeWdKERkqxW3JlXFcHB6roMjM7t/OioSCWUmH/ADLTHh0+Plh+vhbwRRRN3wuazodw3q
         8xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mW2Fqi37nfrJWuA7Y78Xlr35mQpQP8Au1z+vEQpFR/c=;
        b=tCtKtBmQezN22XTsklRYovNRW3QpbSm+B0lLV3E6FYW08eC11tSNHzOPeICX6RLphx
         0vDvibkJtUxsM4YZPqmGaGO9muuhkU3f8RuBOsdcJmLNtCRL3OGr72z6G/hc/rBE7u9P
         tXZL1exssNFSuDzgSRD07kOuUD0WjDteQ5Sro2AIYkAhZDGfPr3zDvp5a8Y9AI6RpApW
         laGaX3jISy5srmld5OR2ZzhHZXevZ7fSL43ZguRM5spWzhz90dljAkqi1sRoz4Wnp0ve
         go52geVNwfLHH1AWWxCN30gHNr+Z/cAPd/7NRDQMeKBFqDg5KtmdbXxXh1Ybw717KXOu
         ovvA==
X-Gm-Message-State: APjAAAWQs5JJfAtYYRe5uQTiuHMBWStjkVZIdRL4I05p2EBwG+xyHNKL
        IMeFkqzBfjyreNQETmNY0Cjoi13KZvU=
X-Google-Smtp-Source: APXvYqzMT85oqFabMAnmREk8mC5CwV17opJfsoHj/As/U4QV+LoR1dwrkdAtQjJSAYM8uOuBfPWaiw==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr18014405wrj.66.1557750685310;
        Mon, 13 May 2019 05:31:25 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id t13sm16175584wra.81.2019.05.13.05.31.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 05:31:24 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] clk: meson: gxbb: no spread spectrum on mpll0
Date:   Mon, 13 May 2019 14:31:10 +0200
Message-Id: <20190513123115.18145-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513123115.18145-1-jbrunet@baylibre.com>
References: <20190513123115.18145-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation says there is an SSEN bit on mpll0 but, after testing
it, no spread spectrum function appears to be enabled by this bit on any
of the MPLLs.

Let's remove it until we know more

Fixes: 1f737ffa13ef ("clk: meson: mpll: fix mpll0 fractional part ignored")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/gxbb.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 29ffb4fde714..dab16d9b1af8 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -679,11 +679,6 @@ static struct clk_regmap gxbb_mpll0_div = {
 			.shift   = 16,
 			.width   = 9,
 		},
-		.ssen = {
-			.reg_off = HHI_MPLL_CNTL,
-			.shift   = 25,
-			.width	 = 1,
-		},
 		.lock = &meson_clk_lock,
 	},
 	.hw.init = &(struct clk_init_data){
-- 
2.20.1

