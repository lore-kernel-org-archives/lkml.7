Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E596C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C2220823
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cxNkdU1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfCXQnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:43:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45067 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfCXQnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 12:43:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so7415866wra.12;
        Sun, 24 Mar 2019 09:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BzekSxk7r2M+F/v0AiDgvjTXBQnuIPdQBLE4FKZ4rcY=;
        b=cxNkdU1SuhlTGonSFiTwVBnJmN2gDmtOQqdl+yo/LQuneGR8mB5NSv/+/uBY6jClNl
         aumplSyUpFv+DmJs9OfOXzlppiaWZSm50+NVNmCWmpEun65BRQmF/qgsFaw51Mv3QSwf
         cwiq4GtV0bopYMTHizTcPRarTviwVQzpjhH1O5RxhhzdPvVYvJyXFE/nXaokdqVb90uY
         8G74PBAlzvrH3AqcSRP7CBMz7hokWUQ6YmAHr46FOfPZQJiOpOKYv/9FT6+jGM/RtW9N
         YOIBubB13WVTwYIlKUtA02Az1bV9h+VZqaXV3H/eCmy14sNnPnAPjK+Bmrez7Z3AuPzj
         3YVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BzekSxk7r2M+F/v0AiDgvjTXBQnuIPdQBLE4FKZ4rcY=;
        b=IKYIRwrl5s7/gGe0eElmoD/oWZtCXXyBDMmbyKHLcSx78atRjvfAP8p0mo+Ya9X5ip
         TeAqwAMSKmmUo6m6Kep0uw0ur+JiScmn3p+a6vxNENFmIxL/H1HYOLZpTvLddQOubNmv
         L+xyiKr307Pa2QWpoKvc8JXTyVIP70tGMqpDmz9qnpZL6mjJ7t+sYq5Jer5B2ruxffa8
         lQiNj0bZA+6h3uN+SVuBe0ZyWTeXXHXleVYnm02P727EdqqLK8WCQBXrQ8i4hxvqOgxH
         F5zO9BrMS+xddDnOC3u87xj1xMyvgguVBjLRP0IdZ8KseGmWc3sb5r+j1EistJv/He6l
         6VXw==
X-Gm-Message-State: APjAAAUfQh6PUirrEHQxu7umEQ/UFTvWXDbWEjJ2mJG72Pcn9/15G0EP
        6t0LU9yM2dOJXMw3jSgef/g=
X-Google-Smtp-Source: APXvYqyua+Lde3zbJ9f7AkAVMKdXWUppEWos3RKcGbqQNVdvlk4+cw6k/TLebKe/z3005IgfRK7+zg==
X-Received: by 2002:a5d:6883:: with SMTP id h3mr12675106wru.215.1553445818635;
        Sun, 24 Mar 2019 09:43:38 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD7399900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d739:9900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id v16sm19042461wru.76.2019.03.24.09.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 09:43:37 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/1] clk: meson: pll: fix rounding and setting a rate that matches precisely
Date:   Sun, 24 Mar 2019 17:43:27 +0100
Message-Id: <20190324164327.22590-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190324164327.22590-1-martin.blumenstingl@googlemail.com>
References: <20190324164327.22590-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make meson_clk_pll_is_better() consider a rate that precisely matches
the requested rate to be better than any previous rate (which was
smaller than the current).

Prior to commit 8eed1db1adec6a ("clk: meson: pll: update driver for the
g12a") meson_clk_get_pll_settings() returned early (before calling
meson_clk_pll_is_better()) if the rate from the current iteration
matches the requested rate precisely. After this commit
meson_clk_pll_is_better() is called unconditionally. This requires
meson_clk_pll_is_better() to work with the case where "now == rate".

This fixes a hang during boot on Meson8b / Odroid-C1 for me.

Fixes: 8eed1db1adec6a ("clk: meson: pll: update driver for the g12a")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/clk-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 41e16dd7272a..7a14ac9b2fec 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -120,7 +120,7 @@ static bool meson_clk_pll_is_better(unsigned long rate,
 			return true;
 	} else {
 		/* Round down */
-		if (now < rate && best < now)
+		if (now <= rate && best < now)
 			return true;
 	}
 
-- 
2.21.0

