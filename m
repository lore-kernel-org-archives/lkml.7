Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C14C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51A12184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5nH4ayV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391234AbfEXRYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:24:30 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45168 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390896AbfEXRY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:24:27 -0400
Received: by mail-lf1-f67.google.com with SMTP id n22so7689266lfe.12;
        Fri, 24 May 2019 10:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8xha0YYbSOA50yqsx0gYdKbmUeN0IEjWGQfpBZbNMQ=;
        b=k5nH4ayVKqYqds083qH9aKQsGhYcuNWwrS1DmKLIi5VOA/5K1r53HHlxVZ02IMoCzE
         aEowreg+KYH9cD3r9lhrl5NRWPqAEVU3uEAwddcCQM826ooSbiF/FOQZUSqhQVSM5wCe
         y+ts8Dk44aFhfnkpeAQvpxowIHZVf0XM0xbCWcwkw5ZG9npj/ZQ0s/3Er0C5uv9fJULX
         OCh2w+CQE9N4DgMfh6csNL69P3ybUAXPzJ6AIoIcXK9DQxJpC0GYdIoSKyQT64itfif+
         r/AKrUoUnlVTg/geO9sTcICw7XZCsk8gWW2QdV+i3zr6q0KRBMVrVnc7FXQPtUTaO8Qq
         XFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8xha0YYbSOA50yqsx0gYdKbmUeN0IEjWGQfpBZbNMQ=;
        b=pRQiVOs5heN/RY8HolnV497snHWJYWI1zNDj+jUUCDLWwwq22Fc4P2Ivq1/aLGK4vI
         ncoW8JIte5R8jDfTA8tAoq+ieyylJgNzZzx5aQf1/yBT3mnutaTxi7QNayysOmjti+ir
         hrjkJ4nQuie8LB/XvJ71tb6g4+/3ZeWUCrZ4VxdyxwcXXjcNkaXtWctxt+UvEsloeZE6
         v+ZhZCqwkcnHbvCK2XBM2/PXWSkCPfqoUsiTQgyX4KGVE9ezOtxCwJD6whY5neGALDRz
         OetMuAxGNjw34jspTKGwFtFWDKH44va85YTnZyJ0HnBLyFebWQ9LRdf3ewoWsEhm2yMS
         1TtQ==
X-Gm-Message-State: APjAAAXluuVhWv9m5LryCF8Zs1yOnG7n/GDqeubL1x4eMV4qeBrxR5St
        NedGt2keDmpm1QZVlnK+41A=
X-Google-Smtp-Source: APXvYqwtMX+Y2e8akfqSnwWIPT2vE7+sMokOVtqoTr9vg4i1/TbSNvI0O2buDVTrQ5QzVkBbSAJrkA==
X-Received: by 2002:ac2:43b7:: with SMTP id t23mr2424312lfl.26.1558718664997;
        Fri, 24 May 2019 10:24:24 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id d13sm196957lfm.27.2019.05.24.10.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 10:24:23 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/8] memory: tegra20-emc: Replace clk_get_sys with devm_clk_get
Date:   Fri, 24 May 2019 20:23:50 +0300
Message-Id: <20190524172353.29087-6-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524172353.29087-1-digetx@gmail.com>
References: <20190524172353.29087-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no problem for drivers to request pll_m and pll_p clocks for
the device, hence there is no need to use clk_get_sys() and it could be
replaced with devm_clk_get() for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 43aef3614b65..527aa4b90e95 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -527,33 +527,29 @@ static int tegra_emc_probe(struct platform_device *pdev)
 		goto unset_cb;
 	}
 
-	emc->pll_m = clk_get_sys(NULL, "pll_m");
+	emc->pll_m = devm_clk_get(&pdev->dev, "pll_m");
 	if (IS_ERR(emc->pll_m)) {
 		err = PTR_ERR(emc->pll_m);
 		dev_err(&pdev->dev, "failed to get pll_m clock: %d\n", err);
 		goto unset_cb;
 	}
 
-	emc->backup_clk = clk_get_sys(NULL, "pll_p");
+	emc->backup_clk = devm_clk_get(&pdev->dev, "pll_p");
 	if (IS_ERR(emc->backup_clk)) {
 		err = PTR_ERR(emc->backup_clk);
 		dev_err(&pdev->dev, "failed to get pll_p clock: %d\n", err);
-		goto put_pll_m;
+		goto unset_cb;
 	}
 
 	err = clk_notifier_register(emc->clk, &emc->clk_nb);
 	if (err) {
 		dev_err(&pdev->dev, "failed to register clk notifier: %d\n",
 			err);
-		goto put_backup;
+		goto unset_cb;
 	}
 
 	return 0;
 
-put_backup:
-	clk_put(emc->backup_clk);
-put_pll_m:
-	clk_put(emc->pll_m);
 unset_cb:
 	tegra20_clk_set_emc_round_callback(NULL, NULL);
 
-- 
2.21.0

