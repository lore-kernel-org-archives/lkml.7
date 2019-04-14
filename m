Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACCBC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2250E2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ft3SNqec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfDNTY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 15:24:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34487 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfDNTYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 15:24:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so7508450plt.1;
        Sun, 14 Apr 2019 12:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C0g4W32KpOFEIBf/b/mgiwGkgi29MbSE0goELOf/fPg=;
        b=ft3SNqecy5Y6cAbBWB6EAH+sa+mvQNOY9WFXFX9DpH+uQjFQhGs6IRssMUT05WshSe
         eanmSTqdJJDszRlTStk3g2xHAMHoK+GGBg8H/yay0Vp0ZSLp3DJl5/4ldslilOT+ULiI
         2nXCM17ETHVDVIjyxrONTi8h2oW5jQcswkAyP6SCljYW7DnYiHOktCWfKK8tJ+8KG3SC
         hCfv3LCWBb01PpEDRR7ofrFfqxxvDR6mzo2RJIGQu4j9n5C8fJiN4JuecoJ2D1JSyFEV
         b4+8He0jLLk5A65V/wwKjd0j1hDqnZuHHhWyWkQtCc4fkWpAmOhckHC7I8L/4mszTlAz
         MN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C0g4W32KpOFEIBf/b/mgiwGkgi29MbSE0goELOf/fPg=;
        b=da6yCAH0qgTUcYdkgJMU9Gtp3ZxzNqkFKKqABa1ia6wEwBGByWDjAF5ItrJRa2X0ce
         2MhAR/tB7by4c8UlEr4prhgs6sC1rnKn0x7LMyowsenqzCU2spjr2ZllHj50i/qJuUz5
         dsZZmu3ibOCOkGldgeJqclKKQ8tYoEPfJEcwhK8yzWqAU9449fYqypbpN2oEqNObhYai
         VAwjfqlGy2xLJLGgOyqp3bYWjJkQznrFMoXUznVcTXUp9N/auO+KUX2+xw3qGkt7I+eq
         2U9X0ElsFm+kmWj3UK+ss+I5ftjBNn5x1qNg4ANa2wMDbgNPzfFlwBo/cbrKqT9S49iG
         T8UQ==
X-Gm-Message-State: APjAAAVgNdOJ9H+0+W9ksSYCKrN+8JY6Ub4K7tYdMjl2tUXg4TtIJdq4
        lb1khEcRGk5panFjmo90PHA=
X-Google-Smtp-Source: APXvYqw+f4eHoiPeQ4my8roVo/wfEBlquETnzWgiYOxBO6cXENcFQbHUmhH97552dCY12MzVXhI5tw==
X-Received: by 2002:a17:902:d68d:: with SMTP id v13mr71453792ply.55.1555269894613;
        Sun, 14 Apr 2019 12:24:54 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id j4sm17837398pgi.71.2019.04.14.12.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 12:24:53 -0700 (PDT)
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
Subject: [PATCH v2 1/5] clk: tegra: emc: Don't enable EMC clock manually
Date:   Sun, 14 Apr 2019 22:23:17 +0300
Message-Id: <20190414192321.23294-2-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190414192321.23294-1-digetx@gmail.com>
References: <20190414192321.23294-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EMC clock marked as critical, hence it is already enabled at the
registration time.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-emc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-emc.c b/drivers/clk/tegra/clk-emc.c
index 0621a3a82ea6..23416982e7c7 100644
--- a/drivers/clk/tegra/clk-emc.c
+++ b/drivers/clk/tegra/clk-emc.c
@@ -532,7 +532,5 @@ struct clk *tegra_clk_register_emc(void __iomem *base, struct device_node *np,
 	/* Allow debugging tools to see the EMC clock */
 	clk_register_clkdev(clk, "emc", "tegra-clk-debug");
 
-	clk_prepare_enable(clk);
-
 	return clk;
 };
-- 
2.21.0

