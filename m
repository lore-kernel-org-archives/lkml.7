Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69109C282CE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403272084D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 19:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iETdxrZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfDNTZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 15:25:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35203 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfDNTZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 15:25:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so7530436pgf.2;
        Sun, 14 Apr 2019 12:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SUHPgW7dZuGazhrcakTZtDm+HbJ3DjUZGyh8GwQB52k=;
        b=iETdxrZ7u5N2s4ZuvtOprMTg4a+x4Tf8MhO5EwMcIBnIkXNMfT6x9B9IoIy7cKBun7
         EcgmvAO/H14AVRrXDBmku9ktHxgNPBEkLfIpT6xsyI+0mzbH20DEr1iDs/mV4M9j7w25
         IbxEnIIm78szoevz7Quj/1AWDvoJhrTWT/1e4VUI2zf7Tm9YBfS5o9gL9P/aUdKP08Xr
         I2/kDUHY2XDDAAX/tyyq4pb2It1T5cIlrDia0W7ZFmq823qcRgn+69Fp4xJJpjwbx0ol
         VTvCQWlyG9LAvdi5eo9nN0XMpwbq6hyj9D936GGlxQDoJz5XpCUSsjHWldH3E21z2kHb
         Z+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SUHPgW7dZuGazhrcakTZtDm+HbJ3DjUZGyh8GwQB52k=;
        b=s0nia+9AVkj+o4BdkHiiT6GChPhefin6nnDv0UornCKtJikugjJbM/ZRMj8D5FnpnA
         Jk1XzcgI565Zvf8986j4GihryySCV33sgLgPNleYbWxi03xt63G56QkFLTmUiXch1dMd
         K0AzVXmrfRQtaez21Etm9NJxPvuOhzwt/gIGVFRVpWufdgxq+2XYyXgrERDnA2PdtJHa
         stux9xGREH9KXp5/E6BSOPxcyl11ty8V89IqSEq/HE0d4yKGmP9aEpRIs6GBzGLCQV8c
         kLVEhi9lYClxvt9vCvYONURjE9iKRf5qJtkCAa/HkKaowr9FnzBNL3R3C/q94kG2bJlH
         SF/w==
X-Gm-Message-State: APjAAAV71lZgcIpo2w2KYPt19sAZ1mWlMwMht3G/z3C6X7ZLVRXYwQZ/
        2XYgFHzPDE+w8D/wtE3oE/Y=
X-Google-Smtp-Source: APXvYqwFjGzdFX/A6BYhJTYXPb8NTFxRPq4snQb8Nzkc7grVTIeXConAGeatkyj8e00QBaUIfjh8Rg==
X-Received: by 2002:a62:415d:: with SMTP id o90mr70834058pfa.236.1555269909077;
        Sun, 14 Apr 2019 12:25:09 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id j4sm17837398pgi.71.2019.04.14.12.25.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 12:25:08 -0700 (PDT)
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
Subject: [PATCH v2 3/5] clk: tegra: emc: Fix EMC max-rate clamping
Date:   Sun, 14 Apr 2019 22:23:19 +0300
Message-Id: <20190414192321.23294-4-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190414192321.23294-1-digetx@gmail.com>
References: <20190414192321.23294-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a clk user requests rate that is higher than the maximum possible,
the rate shall be clamped to the maximum and not to the current value.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-emc.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/tegra/clk-emc.c b/drivers/clk/tegra/clk-emc.c
index 28068584ff6e..9a0179235939 100644
--- a/drivers/clk/tegra/clk-emc.c
+++ b/drivers/clk/tegra/clk-emc.c
@@ -121,7 +121,7 @@ static int emc_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 	struct tegra_clk_emc *tegra;
 	u8 ram_code = tegra_read_ram_code();
 	struct emc_timing *timing = NULL;
-	int i, k;
+	int i, k, t;
 
 	tegra = container_of(hw, struct tegra_clk_emc, hw);
 
@@ -130,12 +130,17 @@ static int emc_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 			break;
 	}
 
-	for (i = k; i < tegra->num_timings; i++) {
-		if (tegra->timings[i].ram_code != ram_code)
+	for (t = k; t < tegra->num_timings; t++) {
+		if (tegra->timings[t].ram_code != ram_code)
 			break;
+	}
 
+	for (i = k; i < t; i++) {
 		timing = tegra->timings + i;
 
+		if (timing->rate < req->rate && i != t - 1)
+			continue;
+
 		if (timing->rate > req->max_rate) {
 			i = max(i, k + 1);
 			req->rate = tegra->timings[i - 1].rate;
@@ -145,10 +150,8 @@ static int emc_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 		if (timing->rate < req->min_rate)
 			continue;
 
-		if (timing->rate >= req->rate) {
-			req->rate = timing->rate;
-			return 0;
-		}
+		req->rate = timing->rate;
+		return 0;
 	}
 
 	if (timing) {
-- 
2.21.0

