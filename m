Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFEFC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67059206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+TpJT4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbfGORgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 13:36:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34677 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731574AbfGORgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 13:36:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id p17so17148725ljg.1;
        Mon, 15 Jul 2019 10:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0PMRfKqUM64Kq/wVxUa7k/YufQQA+RCsvqjLh/9HcSo=;
        b=X+TpJT4xZ/9Lxy1t/ff6N8LrdftCRIBFzNFuWt+av2w0RbuYQ4+ObTjT1/eetGMysj
         njfdS8d+1knVnwhxbN8xzEqjf5fOIIpx275AkJwzQxyTUqosZGTTs+EFW6Ex/+IwNzWd
         BBrnpp16OIBDX0HogxvaPN9KQEjTBlorGjWibxUtHOeH4supvKizCB6nW5L19k0pDwNm
         GT52JlZm8txV/IfKwrBDNKXAKAjfA6MwYe87AbLRiPk8uYPKfQ/Cqw8sZE1qvzxNNaOa
         Vw7O+OYJLFT6Fe0/93Jt6LP5CApZpEblbt+NNjkkW8BFFoC385/8iSeLTED1mXR3mSw9
         E6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0PMRfKqUM64Kq/wVxUa7k/YufQQA+RCsvqjLh/9HcSo=;
        b=YW8EI5N/mspTLdTL/SwKs8SNdF5t8O4QsuMfwk2IKjd+wlah/lEx6Wc61DdubfGExX
         nnu9ynKAsDIYmq2cd86U1upvvTJH84T/CHmIDe/Ycr4+W309DZEvxVFQebo/1WYayViO
         Emf+3NAbZDqlPBzhxFmnpQnNzlQm2kOC1iSHue6BGmE23kzDjgS2uyXd59olAos0SNYD
         JvrgSnxFy3djrWaakDpB8YShTCN98WAC+D4mFodm+Hrw8RWseL/edbkcOlMgjO1EdbVp
         3CNAlp21zsRdkKF1abjkVq/I1gNDs3abp7pCOuULPrxlQy/tZlyeUoe7+2tz9+jTSkSo
         ytyg==
X-Gm-Message-State: APjAAAWmzkPKsMSlwxYguPbi8EvrsbqqdZmpKwjQ0JuKwq34Yolr5yng
        g3qcIojR4F1x5pe/hkbgmMw=
X-Google-Smtp-Source: APXvYqwgEh3J9df/Bb9vC2X+CvuZEFtq0Vtyjxzjj+oqStW68PHQPy9U0T2SB5MTRdt5wSdV/m06qw==
X-Received: by 2002:a2e:6348:: with SMTP id x69mr14892434ljb.186.1563212172294;
        Mon, 15 Jul 2019 10:36:12 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id o8sm1869131lfi.15.2019.07.15.10.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 10:36:11 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] clk: tegra: divider: Support enable-bit for Super clocks
Date:   Mon, 15 Jul 2019 20:35:27 +0300
Message-Id: <20190715173527.5719-2-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190715173527.5719-1-digetx@gmail.com>
References: <20190715173527.5719-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All "super" clock dividers have enable bit.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-divider.c | 12 ++++++++++++
 drivers/clk/tegra/clk-super.c   |  1 +
 drivers/clk/tegra/clk.h         |  4 ++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
index f33c19045386..a980b9bddecd 100644
--- a/drivers/clk/tegra/clk-divider.c
+++ b/drivers/clk/tegra/clk-divider.c
@@ -17,6 +17,7 @@
 #define get_max_div(d) div_mask(d)
 
 #define PERIPH_CLK_UART_DIV_ENB BIT(24)
+#define SUPER_CLK_DIV_ENB BIT(31)
 
 static int get_div(struct tegra_clk_frac_div *divider, unsigned long rate,
 		   unsigned long parent_rate)
@@ -46,6 +47,10 @@ static unsigned long clk_frac_div_recalc_rate(struct clk_hw *hw,
 	    !(reg & PERIPH_CLK_UART_DIV_ENB))
 		return rate;
 
+	if ((divider->flags & TEGRA_DIVIDER_SUPER) &&
+	    !(reg & SUPER_CLK_DIV_ENB))
+		return rate;
+
 	div = (reg >> divider->shift) & div_mask(divider);
 
 	mul = get_mul(divider);
@@ -96,6 +101,13 @@ static int clk_frac_div_set_rate(struct clk_hw *hw, unsigned long rate,
 	val &= ~(div_mask(divider) << divider->shift);
 	val |= div << divider->shift;
 
+	if (divider->flags & TEGRA_DIVIDER_SUPER) {
+		if (div)
+			val |= SUPER_CLK_DIV_ENB;
+		else
+			val &= ~SUPER_CLK_DIV_ENB;
+	}
+
 	if (divider->flags & TEGRA_DIVIDER_UART) {
 		if (div)
 			val |= PERIPH_CLK_UART_DIV_ENB;
diff --git a/drivers/clk/tegra/clk-super.c b/drivers/clk/tegra/clk-super.c
index 39ef31b46df5..4d8e36b04f03 100644
--- a/drivers/clk/tegra/clk-super.c
+++ b/drivers/clk/tegra/clk-super.c
@@ -220,6 +220,7 @@ struct clk *tegra_clk_register_super_clk(const char *name,
 	super->frac_div.width = 8;
 	super->frac_div.frac_width = 1;
 	super->frac_div.lock = lock;
+	super->frac_div.flags = TEGRA_DIVIDER_SUPER;
 	super->div_ops = &tegra_clk_frac_div_ops;
 
 	/* Data in .init is copied by clk_register(), so stack variable OK */
diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
index 905bf1096558..a4fbf55930aa 100644
--- a/drivers/clk/tegra/clk.h
+++ b/drivers/clk/tegra/clk.h
@@ -53,6 +53,9 @@ struct clk *tegra_clk_register_sync_source(const char *name,
  * TEGRA_DIVIDER_UART - UART module divider has additional enable bit which is
  *      set when divider value is not 0. This flags indicates that the divider
  *      is for UART module.
+ * TEGRA_DIVIDER_SUPER - Super clock divider has additional enable bit which
+ *      is set when divider value is not 0. This flags indicates that the
+ *      divider is for super clock.
  */
 struct tegra_clk_frac_div {
 	struct clk_hw	hw;
@@ -70,6 +73,7 @@ struct tegra_clk_frac_div {
 #define TEGRA_DIVIDER_FIXED BIT(1)
 #define TEGRA_DIVIDER_INT BIT(2)
 #define TEGRA_DIVIDER_UART BIT(3)
+#define TEGRA_DIVIDER_SUPER BIT(4)
 
 extern const struct clk_ops tegra_clk_frac_div_ops;
 struct clk *tegra_clk_register_divider(const char *name,
-- 
2.22.0

