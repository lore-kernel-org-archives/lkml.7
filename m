Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C342C76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D26205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njkX0o54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387809AbfGWCxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 22:53:04 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34980 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732216AbfGWCxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 22:53:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id p197so28158143lfa.2;
        Mon, 22 Jul 2019 19:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u+tzQfpQc+UqaIlYqeJCEspMrMPh4Bc2dl2aym2TiZM=;
        b=njkX0o549nZn4jIGIIW1FTXWtRBjbSNo0zaqoHIY+ZmFDwn5wz2tcKCDK9Y0aUFngP
         ZW0M2Xm5AuvKxW2ZsyADKs9eD18j8jBGtu473djEccVaY6MIeBVbhVY5AS3xYbSOvrWj
         DqS0t/Svk1JvpPDFvH70wWMF83qFwLTb/Z50A1USFMN4893NU6ieJ2W7cPxFhl9e4r8/
         heJXlFtYc81dr0zc7hOYt3bK/1MlCsgAAZ+jZ/pWJp1f/Cd7w0XSy4PdRq6vj4ydGQhJ
         LsNL8v/sYQDRXna1nRr5MR3nlSLEatI06+FW+C11BnAkwV2rN8WVy8UWy+YAsoIjxcv8
         dKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u+tzQfpQc+UqaIlYqeJCEspMrMPh4Bc2dl2aym2TiZM=;
        b=l5BSYQg5dKHdLaAaNmRdUNv32yMOrbItkQAHGRsyCrvCaJVzcRdIJpJGwYrxDJeLT8
         bQWWetJi9bAnipsGTtHYQIHsPdxCE0oEJbH6nSvarEmfYYrE/LIknqmb+C7izplU5GYE
         78LXQIS+0B6nttqHNo7DntBx5CFKfERQ4SYd7LeSlM35cMTkqm01UV15ljxTeRehTdMB
         Jgm3jg923ATRO3ZyGFICPovsnCwpGQzUMIB6rT0XINfOTcqkeji1UoEM+5Fwapt40VHZ
         tLFQFw+oKbgoUkD0wSxRQ78EmG7mAhioPMsXQqrWXQjgVQNmiHD63i4g8REI2SjBqHoI
         haYg==
X-Gm-Message-State: APjAAAXpzeK33x3WzG0LVCfKuUFGXcjq6jd3i0TXj/UsCbOQR7uvRHmr
        ZKyTfnm8KBIaQ1wgPfgHpls=
X-Google-Smtp-Source: APXvYqynTlrhq3xw4yK512LmiY2MjT5Hdl3t1pDeaX9QNSSfOzhf8RBs0aB1lzYfT2G8YWF3jWhP6w==
X-Received: by 2002:a19:c80b:: with SMTP id y11mr32959793lff.81.1563850379179;
        Mon, 22 Jul 2019 19:52:59 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id v4sm7757477lji.103.2019.07.22.19.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 19:52:58 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] clk: tegra: divider: Support enable-bit for Super clocks
Date:   Tue, 23 Jul 2019 05:52:45 +0300
Message-Id: <20190723025245.27754-2-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723025245.27754-1-digetx@gmail.com>
References: <20190723025245.27754-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All Super clocks have a divider that has the enable bit.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2: Improved commit's message.

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

