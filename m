Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A0DC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43FB220850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHBcvhim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfDKVuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:50:07 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46684 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfDKVuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:50:03 -0400
Received: by mail-lf1-f68.google.com with SMTP id r25so5837336lfn.13;
        Thu, 11 Apr 2019 14:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EJvVCUfvI6iyVQeoKBvB2Y47bXsmGbMgyBKCT2yiRNc=;
        b=RHBcvhimU29csIHfKFn6lYG/9fbbh2UZ5H0WVhL2hjkxsT88Wx7R+r2/H+r8BGg4zB
         I9daVi0nUh53BatD6ID3rocnH5letnM7Qi1zAT1jDbGUxLkip2/Tj08aDsh2RGqkR29B
         YZl49HTJMsX3Z6qbZTpvwE4DBsFeB/yk0Hgr9bIVPdl/l1z5USM6soGetTyTls9dogfN
         69Cy8xmm1c76JJSnVi7x+EdyUIrUHQIo1D9gjhiSvfGEw7izPnNqIDH01CoEncxlgYuC
         GQuaQmAQ43lfrlWP8xa8/7J9Opj3Apt25JoqxEfVPRKltMbiAC8MNoNkIJsQjJy0ljoy
         YxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EJvVCUfvI6iyVQeoKBvB2Y47bXsmGbMgyBKCT2yiRNc=;
        b=ODynIUPkBH+GoGV6HUV9M83DLlyL6vlef2XirUXn2AwNf1IYuOAcl4r6Gdm3l4Lcl/
         pmL8gDp+pBtUAOHXC9IrV/+ALxwRuRNAtQgiPI/JIGEtryAEPh5NUiY+ZlhUceYbA04K
         dHXuyBcIMvikOPlLERx4ArzKtxs7A4pNg62Ry5FxpQdO/FFEB1QG4I6r/mh4af3Oq1gQ
         9c9fTClD0chhGpzqHIuWGY5LSUbrP4A5tBD7P2LNHon5cKoQkMVa+O8O1mM9dR/CxjNz
         h1lt3MmjF8rnlST8INf9uj5g8OkvClwz9YOgq1+J/6qLPHKjsKeFmjtUG5XrUbx4VtTI
         WLFQ==
X-Gm-Message-State: APjAAAXOC7Qed1TDwQxsNPsGE264wzevrFpsjO9mhTmpkqzjWNEf9jC+
        KLsq0aeHXK5hgKQjITq/e5k=
X-Google-Smtp-Source: APXvYqwcIkIuskqLRvMzRykSyGjoNcttJMp8wh2/rRNU/ZrUj7kPMAUwWp+EgmO6N0Pd6WPu//oKvg==
X-Received: by 2002:a19:6b14:: with SMTP id d20mr20531327lfa.152.1555019400600;
        Thu, 11 Apr 2019 14:50:00 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id t29sm7819985ljd.82.2019.04.11.14.49.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 14:49:59 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] clk: tegra: Fix PLLM programming on Tegra124+ when PMC overrides divider
Date:   Fri, 12 Apr 2019 00:48:34 +0300
Message-Id: <20190411214835.19947-2-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411214835.19947-1-digetx@gmail.com>
References: <20190411214835.19947-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are wrongly set parenthesis in the code that are resulting in a
wrong configuration being programmed for PLLM. The original fix was made
by Danny Huang in the downstream kernel. The patch was tested on Nyan Big
Tegra124 chromebook, PLLM rate changing works correctly now and system
doesn't lock up after changing the PLLM rate due to EMC scaling.

Cc: <stable@vger.kernel.org>
Tested-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-pll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index b50b7460014b..3e67cbcd80da 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -663,8 +663,8 @@ static void _update_pll_mnp(struct tegra_clk_pll *pll,
 		pll_override_writel(val, params->pmc_divp_reg, pll);
 
 		val = pll_override_readl(params->pmc_divnm_reg, pll);
-		val &= ~(divm_mask(pll) << div_nmp->override_divm_shift) |
-			~(divn_mask(pll) << div_nmp->override_divn_shift);
+		val &= ~((divm_mask(pll) << div_nmp->override_divm_shift) |
+			(divn_mask(pll) << div_nmp->override_divn_shift));
 		val |= (cfg->m << div_nmp->override_divm_shift) |
 			(cfg->n << div_nmp->override_divn_shift);
 		pll_override_writel(val, params->pmc_divnm_reg, pll);
-- 
2.21.0

