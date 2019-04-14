Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44838C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBBF20896
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGcrslUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfDNTZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 15:25:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36323 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfDNTZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 15:25:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id z5so7508268pfn.3;
        Sun, 14 Apr 2019 12:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zovPM/xHGahVwDEXHkt+DO70vYHIf96ob+2SMB4kTc8=;
        b=QGcrslUUvNUTW8LS3iH7a5dZ12Fi1oi91a7SF1vPda//aF9mm6vHLLRwQ9mCZn97q4
         fA4Hy+lMi5/84B3Car0sg0sO576aKDGrjJDB9bfSeh/pjJP+qlH2kDaKLdnL0lMTD/IQ
         weck56IGqWLgVuZHlj5uKxL+UMHgDGRVN7lbJNc7IcjttaA58Bz1IM+mhXJeJQLAp1Re
         SDhI4lfsVqiBWWNskv4MO9zVSkiq2blJIBWlBCAh7uDf7OFZmTCZ5huO43h419AUOkEY
         F/x4m+Rg4Lk3WJq/x5q2TA1bZQArMgqRjhJjWJPtIdKpfY5x4CfBH1IEcjT4cTGVlyaf
         TkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zovPM/xHGahVwDEXHkt+DO70vYHIf96ob+2SMB4kTc8=;
        b=VFSaD31UjUoucw0dRjyoQ5xfRzI0x2pESMKmpo2tKpPQtx7Ars56jX0ePDfOWug5J8
         GDSZliljghslSLKVQ4eMVv7X4yqPuAHBmd03NAY7KVLrCm2+dhdPS14lSUks87VtA8JA
         HKx2CXacesUUOimKGjzz4VtnbOFbs879nh4oK1yhdKd4cLgJrGiJJYZGOMqdnMzfTRTW
         QmTiu3fmOEaGIiErpDO/0ZcxWjRruBnWmD83tdogjC5CJO1qfZk1u4uc1YBruDP+jW7h
         /26uWlKT3Gz9W3fqJ7Kr+UGMgUaivmuAGJNu1ZhUC9iKz13nmAI9D0l9sHxPpWkMUSDu
         IACA==
X-Gm-Message-State: APjAAAX3cu3AtTb/G13filLFD/pnBvIxJxcYEHMuUbcwnphDnd8awDHj
        TlnnFtXEvZL/ULyrV/8h5Hs=
X-Google-Smtp-Source: APXvYqxHWDJ2iXSeaCG0JquPDbi9+AuCuVSD3kh/hoGoPVInRDUSDMyHmmOFVIB4sKoH/Q+2kDlNXg==
X-Received: by 2002:a63:28c:: with SMTP id 134mr66929837pgc.278.1555269923576;
        Sun, 14 Apr 2019 12:25:23 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id j4sm17837398pgi.71.2019.04.14.12.25.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 12:25:23 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] clk: tegra: divider: Mark Memory Controller clock as read-only
Date:   Sun, 14 Apr 2019 22:23:21 +0300
Message-Id: <20190414192321.23294-6-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190414192321.23294-1-digetx@gmail.com>
References: <20190414192321.23294-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Memory Controller (MC) clock rate can't be simply changed and nothing
in kernel need to change the rate, hence let's make the clock read-only.
This id also needed for the EMC driver because timing configuration may
require the MC clock diver to be disabled, that is handled by the EMC
clock / EMC driver integration and CLK framework shall not touch the
MC divider configuration on the EMC clock rate change.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-divider.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
index 205fe8ff63f0..2a1822a22740 100644
--- a/drivers/clk/tegra/clk-divider.c
+++ b/drivers/clk/tegra/clk-divider.c
@@ -175,6 +175,7 @@ struct clk *tegra_clk_register_mc(const char *name, const char *parent_name,
 				  void __iomem *reg, spinlock_t *lock)
 {
 	return clk_register_divider_table(NULL, name, parent_name,
-					  CLK_IS_CRITICAL, reg, 16, 1, 0,
+					  CLK_IS_CRITICAL,
+					  reg, 16, 1, CLK_DIVIDER_READ_ONLY,
 					  mc_div_table, lock);
 }
-- 
2.21.0

