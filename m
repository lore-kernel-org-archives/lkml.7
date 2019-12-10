Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47139C04E30
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2E02071E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K42xURoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLJCGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:06:14 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35479 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfLJCGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:06:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id j6so18005081lja.2;
        Mon, 09 Dec 2019 18:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AmQ89GILhlx/U5P8wU6P6IdbZMbjFb3kbbiTdTM2PN8=;
        b=K42xURoUdWBqhYqBJsTlXFkBp+gv727RKojcVrVpC4YZ8E4bbMVrGlBdAoc1gaY4nl
         tJAybS6U2p76KORxvwPIY7BrslTlGtz1O/memkiy6v5u3loWBan8WH+YiTYV4SpjV4IC
         dxZ+82w4EY2WVvdlRPU+pekuBIUvxBnlaR6TZfu1u9//78vSXpvaqVOGQ+84ZiWvw1oj
         e4M+xiVCD4JHh/qKeVcsexKW2Mwc76yZ9h+F20++l2bcWd2D2xao0oT2gxgXJVhL5R8Q
         +eFRctm5FdUZRiEnr3K2bTQzX5dKQp04KrvGra/8ZEALyZBjUSoA98hCM0/aWLJvhaVD
         gK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AmQ89GILhlx/U5P8wU6P6IdbZMbjFb3kbbiTdTM2PN8=;
        b=So+FUes6uWJ6ofF+wH2pIfOhJS1nD3FXQjO1LYJPsUah247hWoSGpIL7DLWw+ctS/z
         cdokKo/xY0Fk118dLDBvLHnBU1dSB0eaoi1bRqTVb0gIC775FtKTAAkX+BSACi4KQ2p4
         4JwH1MQkmiQvU8mxq4agKKrGvYDAJQguGjbUyK3AOy6rf8LCClL/L1PqUNQDfqEk52tZ
         sH06JuL9PU1dT0sgd3ylIkdRfOkp/FaAkwsRxcYepwAUB7A0svuK2Vo9qYGrT1wGuhRx
         L5BK8SYwTNdXobC4sAGXIiWgdcQTostOzH1yhLSYnlAsDzZx+w+tmv4tZyt6+1jRgTDd
         kWLw==
X-Gm-Message-State: APjAAAWUamPNmqcx7Eht3X6vKQfPZZeT2Dmx2NdC2zvvg2JrGPBcmHjU
        00NBZ+508ACluJoAXII9pY4=
X-Google-Smtp-Source: APXvYqyAlnA1BMRhELESRDbCH7OGjo25oaNp4BWKPx/VCjt0jyNLpGnyzNhReAYH7B90uswNz0W1GA==
X-Received: by 2002:a2e:8e97:: with SMTP id z23mr17993160ljk.125.1575943571643;
        Mon, 09 Dec 2019 18:06:11 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id o20sm789018ljc.35.2019.12.09.18.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 18:06:11 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] clk: tegra: Fix double-free in tegra_clk_init()
Date:   Tue, 10 Dec 2019 05:05:12 +0300
Message-Id: <20191210020512.6088-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's unlikely to happen in practice ever, but makes static checkers happy.

Fixes: 535f296d47de ("clk: tegra: Add suspend and resume support on Tegra210")
Reported-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index e6bd6d1ea012..f6cdce441cf7 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -231,8 +231,10 @@ struct clk ** __init tegra_clk_init(void __iomem *regs, int num, int banks)
 	periph_banks = banks;
 
 	clks = kcalloc(num, sizeof(struct clk *), GFP_KERNEL);
-	if (!clks)
+	if (!clks) {
 		kfree(periph_clk_enb_refcnt);
+		return NULL;
+	}
 
 	clk_num = num;
 
-- 
2.24.0

