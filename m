Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9335CC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65677208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sctYjSKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbfEMMb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:31:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46127 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbfEMMbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:31:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so14420803wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 05:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tymhb+Xz3NQPhmyQuz/DcF6uda1a1VVKCg7sutpOQ84=;
        b=sctYjSKOyxhrlLrIsdGH7QhWzJuNOG2YGIRBw27DW2bKxLJdmDcajEJX6fwS67fVt6
         jwCDAZTNfhRFTvC5J5Cs0B4p2VG3l9rjmOfhAnElDketpei7UccrxppmBgICQFtl5n8n
         JAU8r5iGMU/jlYgjpcI8dJ6VATC5KelEY7x1sQeuatayIwFcmY1YWIwYhaosPwyeTqIw
         mmLWtIPpN1x62TDSGa8Rfc67VzUah5VaAF5OTtN/Vi5oydNI1Pq3p7kyb3afsR3nu3ta
         tBpqFdKLwHPxvHbBjhJ1ZyKtMbl4j4hiexe2LZOgqJk/+QslS+88L602jcEyi6daZ3G2
         8M0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tymhb+Xz3NQPhmyQuz/DcF6uda1a1VVKCg7sutpOQ84=;
        b=lk/2an95EgGjPH4n2tWT0U5Q8dkVumlkBN1zj5FHZXXkdKcu14s1eJWMprv9B7tJkX
         Rw74QvAn5M00u6SqKKYp30SB83viZsioCy6r9V2JV2qh22eqow2LlXWrn01HSzB1x6/9
         0PM0YnrqlT3RLVDasGIxJ9jpI5+d1rfVaeXpcp+Kdd9eV6i2EiwFfjMxUZ8MUA4xQHgi
         Ybh95zf5lTs+nOp2K5NHgGvyT8nz+gcVsVfvLRiv+OWYJleSYkYr34+7lLBViMHyk45t
         1V6d5HORUkNzTNNi8O69PGOROtRioYQkjPqQ8gRHEc8J7N3i2NVa0XBCmC7wFoILNKFC
         wy7g==
X-Gm-Message-State: APjAAAWnWO99+8flHmn3rdJ5MylhP8g6sUg+ZUGjOoXV7ai5k31CKzNR
        QrGKdpAujvPL8rc5GrJ6wZAVbg==
X-Google-Smtp-Source: APXvYqyZR/kqmNSgmJHOV6dDeiXFW6KQ/fySx/khvLwUzuVjVflasaCTGNddLrsBnteNp/ChOlA5kQ==
X-Received: by 2002:a5d:6710:: with SMTP id o16mr14850407wru.173.1557750684166;
        Mon, 13 May 2019 05:31:24 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id t13sm16175584wra.81.2019.05.13.05.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 05:31:23 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] clk: meson: mpll: properly handle spread spectrum
Date:   Mon, 13 May 2019 14:31:09 +0200
Message-Id: <20190513123115.18145-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513123115.18145-1-jbrunet@baylibre.com>
References: <20190513123115.18145-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bit 'SSEN' available on some MPLL DSS outputs is not related to the
fractional part of the divider but to the function called
'Spread Spectrum'.

This function might be used to solve EM issues by adding a jitter on
clock signal. This widens the signal spectrum and weakens the peaks in it.

While spread spectrum might be useful for some application, it is
problematic for others, such as audio.

This patch introduce a new flag to the MPLL driver to enable (or not) the
spread spectrum function.

Fixes: 1f737ffa13ef ("clk: meson: mpll: fix mpll0 fractional part ignored")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/clk-mpll.c | 9 ++++++---
 drivers/clk/meson/clk-mpll.h | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/meson/clk-mpll.c b/drivers/clk/meson/clk-mpll.c
index f76850d99e59..d3f42e086431 100644
--- a/drivers/clk/meson/clk-mpll.c
+++ b/drivers/clk/meson/clk-mpll.c
@@ -119,9 +119,12 @@ static int mpll_set_rate(struct clk_hw *hw,
 	meson_parm_write(clk->map, &mpll->sdm, sdm);
 	meson_parm_write(clk->map, &mpll->sdm_en, 1);
 
-	/* Set additional fractional part enable if required */
-	if (MESON_PARM_APPLICABLE(&mpll->ssen))
-		meson_parm_write(clk->map, &mpll->ssen, 1);
+	/* Set spread spectrum if possible */
+	if (MESON_PARM_APPLICABLE(&mpll->ssen)) {
+		unsigned int ss =
+			mpll->flags & CLK_MESON_MPLL_SPREAD_SPECTRUM ? 1 : 0;
+		meson_parm_write(clk->map, &mpll->ssen, ss);
+	}
 
 	/* Set the integer divider part */
 	meson_parm_write(clk->map, &mpll->n2, n2);
diff --git a/drivers/clk/meson/clk-mpll.h b/drivers/clk/meson/clk-mpll.h
index cf79340006dd..0f948430fed4 100644
--- a/drivers/clk/meson/clk-mpll.h
+++ b/drivers/clk/meson/clk-mpll.h
@@ -23,6 +23,7 @@ struct meson_clk_mpll_data {
 };
 
 #define CLK_MESON_MPLL_ROUND_CLOSEST	BIT(0)
+#define CLK_MESON_MPLL_SPREAD_SPECTRUM	BIT(1)
 
 extern const struct clk_ops meson_clk_mpll_ro_ops;
 extern const struct clk_ops meson_clk_mpll_ops;
-- 
2.20.1

