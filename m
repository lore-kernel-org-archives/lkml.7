Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84737C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5996F22387
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGOorPHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387631AbfGWCxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 22:53:01 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33642 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfGWCxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 22:53:00 -0400
Received: by mail-lf1-f67.google.com with SMTP id x3so28268433lfc.0;
        Mon, 22 Jul 2019 19:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UGzqbbB1U0ppZ2A02MGdrN83+wMNNh/kz49yjkRagg4=;
        b=oGOorPHkG3fQQXMk4jmm3uqhV8r8dArAEn5qvIPCMkpwf/5MW5gfmXTishC51IYLD0
         gXyyk/zX1ndUDIEFEjxz2gWX7ui0buUAVeEbs++OEPsrFqCY19QmGCDA9vmGYPiUJlmV
         j1QupIgqpdTXLMXNni5PsAvXkRUgzWUcbbVaPRpCQ1N/Td2qr6LQhH17rvAb2CSdAXYr
         thCYI+tSL7SHjPzXIwZUUhQV16LOBkOIOdrwFinYx/hg42koRNMJA97e2gYN4AbbMfgw
         URqr1Kci6UhZMS5726Pl9z4WIf1PmOOsJlKarubM/xYofn3PqUbmWMn3AJpj8zjPRHl5
         dBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UGzqbbB1U0ppZ2A02MGdrN83+wMNNh/kz49yjkRagg4=;
        b=PO1BfaElMttj4/7xtChA/hie2wBQF2Sl444VreFEKIA+w+tBdHAAwVEiMkgixE25bi
         9modekcid43u5GbfToaqyO45eks5AWOTlCX4So6b9U052td95T8BJAMIb7qdxpeDUCtC
         654r/3yq3sYSPx4bYqjx5csw15XRnYoW10QNh+ZBfyi9p9BFSl4cEVGnSFQ7lqFt0McV
         aawqVWVZ1Xh0FnKcOpHlpjv0Uc3m0XfzKMxwR00/CI6+oa8LpJ7nYJRwwp4S20HdU86o
         Fc0P7G7e/GfZjOG2jLzLP+anpJzwD1S4zjYAXjfMVSLidZ8DJPhsP3TYzL0BCPz7Aito
         wFww==
X-Gm-Message-State: APjAAAUrH9YUuojlrRl/Iq482eul65DtSj2PW0EjD4Qts1Bks2BSUuAv
        UYmlVa/Oo/MyeYq/Zn27Q9s=
X-Google-Smtp-Source: APXvYqzkQl297ESK1gCyraELtwkgRNbj+CQx/Air8IrnkAcz+ps43Ei6UF1+13i4+edz7NFSQUcldw==
X-Received: by 2002:a19:8c57:: with SMTP id i23mr32883196lfj.192.1563850378088;
        Mon, 22 Jul 2019 19:52:58 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id v4sm7757477lji.103.2019.07.22.19.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 19:52:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] clk: tegra: divider: Add missing check for enable-bit on rate's recalculation
Date:   Tue, 23 Jul 2019 05:52:44 +0300
Message-Id: <20190723025245.27754-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unset "enable" bit means that divider is in bypass mode, hence it doesn't
have any effect in that case. Please note that there are no known bugs
caused by the missing check.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2: Changed the commit's description from 'Fix' to 'Add' in response to the
    Stephen's Boyd question about the need to backport the patch into stable
    kernels. The backporting is not really needed.

 drivers/clk/tegra/clk-divider.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
index e76731fb7d69..f33c19045386 100644
--- a/drivers/clk/tegra/clk-divider.c
+++ b/drivers/clk/tegra/clk-divider.c
@@ -40,8 +40,13 @@ static unsigned long clk_frac_div_recalc_rate(struct clk_hw *hw,
 	int div, mul;
 	u64 rate = parent_rate;
 
-	reg = readl_relaxed(divider->reg) >> divider->shift;
-	div = reg & div_mask(divider);
+	reg = readl_relaxed(divider->reg);
+
+	if ((divider->flags & TEGRA_DIVIDER_UART) &&
+	    !(reg & PERIPH_CLK_UART_DIV_ENB))
+		return rate;
+
+	div = (reg >> divider->shift) & div_mask(divider);
 
 	mul = get_mul(divider);
 	div += mul;
-- 
2.22.0

