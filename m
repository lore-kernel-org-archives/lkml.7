Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F04C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCBD2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lIYZhQL3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfGAJNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:13:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54901 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbfGAJNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:13:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id g135so15014068wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 02:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QF6xtFv2zQ8ZUqjO9Cs7FIQcWQGqk9AuakROnInyaSE=;
        b=lIYZhQL3jTzMkEXGBHTejQuEo2Wg6Z7RjfFgI4uYHafubWHGXRc6G+3127Ldq9Aj1b
         DGM+VLYAo7oKAb+SM81qnIo8he0wpupHrxH+YJ1bu32D/udLAkQHUGXDCMKNkiwztdmr
         UL1t/r1dxSb7cPCvGnE2yL3ZPEBPkcivM+DmX8myy2McJHzaa2T9Fm8m42TOt5j5q9/7
         YKxjVrQD3XhAkTr+IXcWmgW+XxJR5OvgmBKrZnFG2XMJXkFXuuoZCsK9NAYps93yG8t8
         nRDiYAz8hiTqPaDXGfSF6MXla2iU2+7NE4SbYalzr0mDioFbl9yyPpAcaN7IF16ReuVy
         bcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QF6xtFv2zQ8ZUqjO9Cs7FIQcWQGqk9AuakROnInyaSE=;
        b=M0QQscHq2XnbGrqeT5bCSvfRp2a2MQSTmG9ooXlw3R+CuOGM0w9+TeISjll64M3Coy
         KM4gNzgEqQnBvpm5XFHbw89HOgMkBH26EzQEn5KTM8Kgl32VwDGrgB2UrZF1FdCo+rvH
         wHI7AdOSFl/6Rc5WAYmdZOXqpLtghcMH3nBdbnG1JTLV2axq9ePcrlpJbsxDW0ybFzoV
         Z6xJlcUv8OZYahv2VxmQGvlgv1wdzeLaMXD6tl6JsCuLSJD5A6rExPiAvHKaHuIF1jh7
         xsajyuYN9qEb3JSFGKm6feussyqVf86KRNMUnBnx4Y+jPaTxQJGWtXUE47ROUvqIIuiH
         i/FQ==
X-Gm-Message-State: APjAAAVBe0IxcbdSAZwIc+kVU0vb9fqsP5Kg74bKa1/kc6qnDkM1+97/
        79X4fx4BVuJJW2KNvJG7oUYFTg==
X-Google-Smtp-Source: APXvYqz0R1Me131hk3YNR44WqrLF91l40/ePDko2bzhUb5OlZVcim0JviXo7HbsXJhGIuvbExPl9Cg==
X-Received: by 2002:a05:600c:240e:: with SMTP id 14mr15893491wmp.30.1561972393857;
        Mon, 01 Jul 2019 02:13:13 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id i16sm6305659wrm.37.2019.07.01.02.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jul 2019 02:13:13 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC/RFT v3 03/14] clk: meson: regmap: export regmap_div ops functions
Date:   Mon,  1 Jul 2019 11:12:47 +0200
Message-Id: <20190701091258.3870-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190701091258.3870-1-narmstrong@baylibre.com>
References: <20190701091258.3870-1-narmstrong@baylibre.com>
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

