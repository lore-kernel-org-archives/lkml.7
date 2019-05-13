Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF71C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB9620879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="b8POFUNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfEMMcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:32:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34033 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729848AbfEMMba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:31:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id f8so5408203wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 05:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4iwsD3U3np8IEFD+xTq9Et1jrPwGjexYK1TesQwMIZ0=;
        b=b8POFUNthuvdlpyMAvkz/XPAZYSPESkYHVHrRsGD/I32mzJ09+S9i3Ktn/Iqf0CN5e
         eXNw9ANuWYo8/i8SL0pEagFcNTCv93/n0ORqEmb5I2K2xaCNEU/d2yjQks/B/8wSDyAW
         /r18vTn6m5K+nQoLd5zViswByZF48gxxHIgU5HBH6NH1amFjBFP1R9vqLwMaM/oIVYyg
         10xxLLdLF0O/ejD3lGhw/7YDhCE9sKJviaNDyJaxML+EgtQH5MJwIOkMAv1JljUI9q2b
         LzuvBa77ygJMnX/ZnUmOeXkHAU9bXme+N9/WDu9099QCMnn6M9DzKZnT4kR5OWheER7j
         WfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4iwsD3U3np8IEFD+xTq9Et1jrPwGjexYK1TesQwMIZ0=;
        b=pzZySNUVF+U0T8xaFXlaqcA2E33SCAXZqUvrbfjsmEhatOXfj0ed7+fUhQkBvmRLeE
         V9pi06iEm6qfhMyg4TGQ/C5pgytwH7EQvf9lJf1jy+7/lVULA9d2dBUA0nLddTnSw/oT
         HXTcF5gDB8E0Rg9CL+vUEO7VGaGHwvO0JEHQPFMbavNpJX5b+Ie6xlpjxiLws0dAtTTS
         8V1k17zaS/0wIh4WLteV5dZ60CEVuY/h82R/uGjEJE7ghpweW5JJkD4ZK7cXv444i0Id
         bgtu9+aUw0BK44fFgkKoKjJVnKfv3RngfxXqiZ19LIqgpx/iJ+p9PKxL3DpeNYM/V6rQ
         Av1Q==
X-Gm-Message-State: APjAAAVZQOVTW9ZltOonCLtM0VzP1j63r+FLTKQG/2lLJuT4PdUhqSKD
        SdTqtkEQqcjLxebhsx71om6hwA==
X-Google-Smtp-Source: APXvYqzbRgH8TxkyaTtXi+U2BxwbBAXcKGSfcjnlnf1UOwMIO+s/0Olaj1fC2ez7G+vkB7d/5d63Ng==
X-Received: by 2002:adf:dece:: with SMTP id i14mr18177889wrn.138.1557750687429;
        Mon, 13 May 2019 05:31:27 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id t13sm16175584wra.81.2019.05.13.05.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 05:31:26 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] clk: meson: mpll: add init callback and regs
Date:   Mon, 13 May 2019 14:31:12 +0200
Message-Id: <20190513123115.18145-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513123115.18145-1-jbrunet@baylibre.com>
References: <20190513123115.18145-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now (gx and axg), the mpll setting on boot (whatever the
bootloader) was good enough to generate a clean fractional division.

It is not the case on the g12a. While moving away from the vendor u-boot,
it was noticed the fractional part of the divider was no longer applied.
Like on the pll, some magic settings need to applied on the mpll
register.

This change adds the ability to do that on the mpll driver.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/clk-mpll.c | 35 ++++++++++++++++++++++++-----------
 drivers/clk/meson/clk-mpll.h |  2 ++
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
index d3f42e086431..2d39a8bc367c 100644
--- a/drivers/clk/meson/clk-mpll.c
+++ b/drivers/clk/meson/clk-mpll.c
@@ -115,8 +115,30 @@ static int mpll_set_rate(struct clk_hw *hw,
 	else
 		__acquire(mpll->lock);
 
-	/* Enable and set the fractional part */
+	/* Set the fractional part */
 	meson_parm_write(clk->map, &mpll->sdm, sdm);
+
+	/* Set the integer divider part */
+	meson_parm_write(clk->map, &mpll->n2, n2);
+
+	if (mpll->lock)
+		spin_unlock_irqrestore(mpll->lock, flags);
+	else
+		__release(mpll->lock);
+
+	return 0;
+}
+
+static void mpll_init(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_mpll_data *mpll = meson_clk_mpll_data(clk);
+
+	if (mpll->init_count)
+		regmap_multi_reg_write(clk->map, mpll->init_regs,
+				       mpll->init_count);
+
+	/* Enable the fractional part */
 	meson_parm_write(clk->map, &mpll->sdm_en, 1);
 
 	/* Set spread spectrum if possible */
@@ -126,19 +148,9 @@ static int mpll_set_rate(struct clk_hw *hw,
 		meson_parm_write(clk->map, &mpll->ssen, ss);
 	}
 
-	/* Set the integer divider part */
-	meson_parm_write(clk->map, &mpll->n2, n2);
-
 	/* Set the magic misc bit if required */
 	if (MESON_PARM_APPLICABLE(&mpll->misc))
 		meson_parm_write(clk->map, &mpll->misc, 1);
-
-	if (mpll->lock)
-		spin_unlock_irqrestore(mpll->lock, flags);
-	else
-		__release(mpll->lock);
-
-	return 0;
 }
 
 const struct clk_ops meson_clk_mpll_ro_ops = {
@@ -151,6 +163,7 @@ const struct clk_ops meson_clk_mpll_ops = {
 	.recalc_rate	= mpll_recalc_rate,
 	.round_rate	= mpll_round_rate,
 	.set_rate	= mpll_set_rate,
+	.init		= mpll_init,
 };
 EXPORT_SYMBOL_GPL(meson_clk_mpll_ops);
 
diff --git a/drivers/clk/meson/clk-mpll.h b/drivers/clk/meson/clk-mpll.h
index 0f948430fed4..a991d568c43a 100644
--- a/drivers/clk/meson/clk-mpll.h
+++ b/drivers/clk/meson/clk-mpll.h
@@ -18,6 +18,8 @@ struct meson_clk_mpll_data {
 	struct parm n2;
 	struct parm ssen;
 	struct parm misc;
+	const struct reg_sequence *init_regs;
+	unsigned int init_count;
 	spinlock_t *lock;
 	u8 flags;
 };
-- 
2.20.1

