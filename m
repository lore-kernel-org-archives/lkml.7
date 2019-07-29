Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72398C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B4A21655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Wfz6C774"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388018AbfG2NRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:17:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50833 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfG2NRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:17:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so53846270wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 06:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ilNgiDVSmGak25pg9L0wagvtwRSAZxVDdm8Be33Ze3o=;
        b=Wfz6C774D3WcLjVSRjjQ9Lw6OAiML+fgZ8SRO9mkuLL3Gzg4MPG1wMAJOBhov2Q2BV
         PIgPQfA7tWuphF1Vx2YdRRrTQU+oZU6Ei2Mx+31nEU93c6KlukMw3bv6jtwjnA6WxOJd
         pxaG8IXHlrJjHAWA5Bv3mNNvJ36r8AgsfIgq2zKOOlZBj4yvhdEek/isUR/HhUxe1A6F
         9Tua4I1IPVpvm1aq/GUu4dyAOpFcpxGBnEEg6oNcLhFWYR5I0KnP6jGS6Nc1DEZ0FcO4
         SxDRZYkCUrrh2836Vcvs3RMfmZqivsJraN2vozaJk7mOJAlZpkendo8TlYJGAAa9tq0q
         chOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ilNgiDVSmGak25pg9L0wagvtwRSAZxVDdm8Be33Ze3o=;
        b=ogi4w4DYP/LJ1CL7H7as2QXsJCMiXRQONASq2Jby0S209YT3pO3cbfVxYNrjl0zLL6
         jZ9fqxQeK13RImRTaFRRXDE7J9OEAdIu2knEKRh0f9XFbrCgJXh+dOwJbUlnudYGxqKy
         L4fq6NkqD1fJhTBWkTSp3CY4E8ZzFh+azMjZgIPFkQKaeudBfXkwYBJryT1PgXCUrnt8
         xm3E4hNU9SpVTShhsgX4jNbtXY4Nb9yJiH35PPlW64uth7zndVfQ4Uv6MtTFj0K4gbSO
         QSw59dt5I+G6SuRnf2CAx7fZqQ2hrjh5G4Fz/FqNVMDiIzXqNpYuWnvZCKq4pG4W/TSm
         Sg4w==
X-Gm-Message-State: APjAAAUqZzb5MNT4cYM1BlwKWCBLSXLy+wPi3qFrbHby55KtlQWL45G+
        5x7XFO5Z+oHtAcjrxkNVAyqIHQ==
X-Google-Smtp-Source: APXvYqypMagpK7Rn4o7xdy8pV2mv01YyLBmCblc0Qt5Jzfp6qN3KU/2uEbRbZnALWwoGiWLw3SxERA==
X-Received: by 2002:a7b:c947:: with SMTP id i7mr102925593wml.77.1564406220768;
        Mon, 29 Jul 2019 06:17:00 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b5sm52520490wru.69.2019.07.29.06.17.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 06:17:00 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] clk: meson: regmap: export regmap_div ops functions
Date:   Mon, 29 Jul 2019 15:16:54 +0200
Message-Id: <20190729131656.7308-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729131656.7308-1-narmstrong@baylibre.com>
References: <20190729131656.7308-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The G12A CPU Clock Postmux divider needs a custom div_set_rate() call.

Export the clk_regmap_div_round_rate() and clk_regmap_div_recalc_rate()
to be able to override the default clk_regmap_div_set_rate() callback.
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
index c4a39604cffd..ebf776a32ce3 100644
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
2.22.0

