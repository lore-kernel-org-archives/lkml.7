Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C482CC5B57F
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 21:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8EC2089C
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 21:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1mBBGjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfF3VFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 17:05:16 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34418 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfF3VEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 17:04:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id y198so7349195lfa.1;
        Sun, 30 Jun 2019 14:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UWa9gcb+W/CIAOv0/O/hapxydWbD232AuhpZZZL43dE=;
        b=R1mBBGjPpO0e9Twwx/yLI1BLIts6HffsD7ASrtqz1JixYL6LCnpb6sQK6pbhh1dLs4
         OZG94EZs/VSwOpNQtUiOINg7+LelgXHENSzyLfjsenHJ44FI+ZPhxnbm9aQR+k5grrB+
         yRahKYpPCVhAefBc9s/QyqiZu9on7NJ8UizQp4jYzIPB4j2giyIUrLkaK6/IPDfFBCAu
         FgHku59mVZBQtxVEyOGrDwamej3AksSveD8Yw4LneTMNwBq/IX4UV5M9h5uSHPjex8If
         SX95KVgLUsXgocTf72jFy9NJPrJzRb5LabU9y7PK855EwIYfotU0ReZe0F2WsqHlsky3
         NMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UWa9gcb+W/CIAOv0/O/hapxydWbD232AuhpZZZL43dE=;
        b=LdmHmLUCtxeDjFSNkNwQwe/cFpAZdaRuJAp/cnhcC0iofBgy7LrZGajrazpWcAoSnF
         fuqJA5IePYf8s2N0vr7jq8yacQibnp3tf3LgPAFqKy++bMEKmEep8g/bEkaLDudvrNfX
         bxsX13vyXvlpiYLi9frFEcPyVrRlIkqYOmhGpabFoAigJwxOAzSXNXBGyfAcATBjIjow
         a4NLQp3VIg8sZ9NU8dXbaBh70qf+V0fxYTXFQw4mbk/+b2TesJFQNzGp2ahvMc3dwRFu
         8MmR/HqIa+IHhgUMlU6fzULTFWzKJBERU73Fqmkt9YFXJ/FGfzOWQFmoCIN9SIPFp3hb
         BjGg==
X-Gm-Message-State: APjAAAXoLgnW6B7XuGYW3yLCiRq0duVnFMapsymunH9Oia982PunaOK6
        TuroYXty0Hk99zGgRaN/u2Q=
X-Google-Smtp-Source: APXvYqxJoXqkyWpUSSljPUi1j17FgA/hwZs8PNXxo+dpg+Djzn+6kO7rg/wN/eGK7Q1JuuJo7wgugQ==
X-Received: by 2002:a19:c14f:: with SMTP id r76mr10426342lff.70.1561928690409;
        Sun, 30 Jun 2019 14:04:50 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id u9sm2221408lfb.38.2019.06.30.14.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jun 2019 14:04:49 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 13/15] clk: tegra20: emc: Add tegra20_clk_emc_on_pllp()
Date:   Mon,  1 Jul 2019 00:00:17 +0300
Message-Id: <20190630210019.26914-14-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190630210019.26914-1-digetx@gmail.com>
References: <20190630210019.26914-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function will be used by Tegra30 CPUIDLE driver to determine whether
CPU could be power-gated.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra20-emc.c | 14 ++++++++++++++
 include/linux/clk/tegra.h           |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra20-emc.c b/drivers/clk/tegra/clk-tegra20-emc.c
index 03bf0009a33c..ace7150d5cc1 100644
--- a/drivers/clk/tegra/clk-tegra20-emc.c
+++ b/drivers/clk/tegra/clk-tegra20-emc.c
@@ -291,3 +291,17 @@ int tegra20_clk_prepare_emc_mc_same_freq(struct clk *emc_clk, bool same)
 
 	return 0;
 }
+
+bool tegra20_clk_emc_on_pllp(void)
+{
+	struct clk *clk = __clk_lookup("emc");
+	struct clk_hw *hw;
+
+	if (clk) {
+		hw = __clk_get_hw(clk);
+
+		return emc_get_parent(hw) == EMC_SRC_PLL_P;
+	}
+
+	return true;
+}
diff --git a/include/linux/clk/tegra.h b/include/linux/clk/tegra.h
index 6a7cbc3cfadc..c862447ffada 100644
--- a/include/linux/clk/tegra.h
+++ b/include/linux/clk/tegra.h
@@ -129,5 +129,6 @@ typedef long (tegra20_clk_emc_round_cb)(unsigned long rate,
 void tegra20_clk_set_emc_round_callback(tegra20_clk_emc_round_cb *round_cb,
 					void *cb_arg);
 int tegra20_clk_prepare_emc_mc_same_freq(struct clk *emc_clk, bool same);
+bool tegra20_clk_emc_on_pllp(void);
 
 #endif /* __LINUX_CLK_TEGRA_H_ */
-- 
2.22.0

