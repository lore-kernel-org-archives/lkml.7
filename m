Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EE8C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8CB2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EOIDTbSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfFZJHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:07:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46705 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfFZJGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:06:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so1740170wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 02:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QF6xtFv2zQ8ZUqjO9Cs7FIQcWQGqk9AuakROnInyaSE=;
        b=EOIDTbSRmHPt/lFJvqYWsxI4pCg4Dy45ntsrrp31zEPhOT03iRH3/jj/+1rogovQ67
         NfjLB2W6EYnIYpDdLL9uCHUB0IyHXlPgD8/DxDTjtFcCd9Jo0zNs9K74n3aMIuRMrsTM
         qOr3PdCuf1nS8zWejXEnvxM3cwTfNnMjQ5m8P2QwHnXzYrgsfac8mYdLqk47BYfChLEu
         SYydOMncB/OrY/E76Su6Y0BpV2DOT4JJcO4hz/DoDnLdIGx8cvfPjBib2bQx27yOU/sE
         tCVV60jH13P9vnamKEDQzkLqltVVWmMY1hBbqNr6y0bKUcQPvL5JIVOneYSQTVJ5f3HS
         PyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QF6xtFv2zQ8ZUqjO9Cs7FIQcWQGqk9AuakROnInyaSE=;
        b=hA20JHftZIkRZ0FQgZ8b6pL5hQ/JPTNCpuV+c1iRyoFnLMwnDoxxswOFAdNbJ4Ribt
         GXr45fiiodFrIv/ApqIg5GZIV5oRL8IwdPU0E/5uorzkmKkurrvV98RPBLYCkBnyvKHS
         85/BA3ED6f3H4phE2l8ewQVzRgF8nC/+Q+itJlBUNENGlC3hxTSftQ07Y/e4hGja7ZNQ
         dAKEQKm0afxjuJaaOIZ7LgRkRc6+0PnyRuWZMmBBl9L/Jdxyf96Qt1t+u0v/I+5UfigZ
         KlRA33Kzc6fn5Awxgakd4q8Mtm60+mKGCwdzRdShLY0tr9ZU+2LNagInrr/led7YTJqK
         XOpQ==
X-Gm-Message-State: APjAAAXeIBRR/Kw+p3oGbT+97hDJ7wLYwYYE98wOIHF3xoEnVU0YjaJU
        j1W73evRMXoigIzBadvbH0o52A==
X-Google-Smtp-Source: APXvYqyOJTQLTQr5UOlvihb2uvDm1M8Bu0G5R2D6gXBw7OAcDmhWQNRUOM5NXcNu+psXLHm/tUm3aQ==
X-Received: by 2002:adf:afd5:: with SMTP id y21mr2687630wrd.12.1561540000020;
        Wed, 26 Jun 2019 02:06:40 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o6sm1925797wmc.46.2019.06.26.02.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jun 2019 02:06:39 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC/RFT v2 03/14] clk: meson: regmap: export regmap_div ops functions
Date:   Wed, 26 Jun 2019 11:06:21 +0200
Message-Id: <20190626090632.7540-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626090632.7540-1-narmstrong@baylibre.com>
References: <20190626090632.7540-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The G12A CPU Clock Postmux divider needs a custom div_set_rate() call.

Export the clk_regmap_div_round_rate() and clk_regmap_div_recalc_rate()
to be able to override the default clk_regmap_div_set_rate() callback.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/clk-regmap.c | 10 ++++++----
 drivers/clk/meson/clk-regmap.h |  5 +++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/meson/clk-regmap.c b/drivers/clk/meson/clk-regmap.c
index dcd1757cc5df..26c8c74a8cf0 100644
--- a/drivers/clk/meson/clk-regmap.c
+++ b/drivers/clk/meson/clk-regmap.c
@@ -56,8 +56,8 @@ const struct clk_ops clk_regmap_gate_ro_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_regmap_gate_ro_ops);
 
-static unsigned long clk_regmap_div_recalc_rate(struct clk_hw *hw,
-						unsigned long prate)
+unsigned long clk_regmap_div_recalc_rate(struct clk_hw *hw,
+					 unsigned long prate)
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
@@ -74,9 +74,10 @@ static unsigned long clk_regmap_div_recalc_rate(struct clk_hw *hw,
 	return divider_recalc_rate(hw, prate, val, div->table, div->flags,
 				   div->width);
 }
+EXPORT_SYMBOL_GPL(clk_regmap_div_recalc_rate);
 
-static long clk_regmap_div_round_rate(struct clk_hw *hw, unsigned long rate,
-				      unsigned long *prate)
+long clk_regmap_div_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
 	struct clk_regmap_div_data *div = clk_get_regmap_div_data(clk);
@@ -100,6 +101,7 @@ static long clk_regmap_div_round_rate(struct clk_hw *hw, unsigned long rate,
 	return divider_round_rate(hw, rate, prate, div->table, div->width,
 				  div->flags);
 }
+EXPORT_SYMBOL_GPL(clk_regmap_div_round_rate);
 
 static int clk_regmap_div_set_rate(struct clk_hw *hw, unsigned long rate,
 				   unsigned long parent_rate)
diff --git a/drivers/clk/meson/clk-regmap.h b/drivers/clk/meson/clk-regmap.h
index 1dd0abe3ba91..d22b83fb9bad 100644
--- a/drivers/clk/meson/clk-regmap.h
+++ b/drivers/clk/meson/clk-regmap.h
@@ -78,6 +78,11 @@ clk_get_regmap_div_data(struct clk_regmap *clk)
 	return (struct clk_regmap_div_data *)clk->data;
 }
 
+unsigned long clk_regmap_div_recalc_rate(struct clk_hw *hw,
+					 unsigned long prate);
+long clk_regmap_div_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate);
+
 extern const struct clk_ops clk_regmap_divider_ops;
 extern const struct clk_ops clk_regmap_divider_ro_ops;
 
-- 
2.21.0

