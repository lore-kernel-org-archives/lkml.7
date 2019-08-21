Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458FFC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D57320870
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 15:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="sLeJloAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfHUPC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:02:56 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18132 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfHUPCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 11:02:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5d5d1e0000>; Wed, 21 Aug 2019 08:02:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 21 Aug 2019 08:02:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 21 Aug 2019 08:02:54 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 15:02:54 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 21 Aug 2019 15:02:54 +0000
Received: from moonraker.nvidia.com (Not Verified[10.2.160.227]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d5d5d1e0000>; Wed, 21 Aug 2019 08:02:54 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 1/2] clocksource/drivers/timer-of: Do not warn on deferred probe
Date:   Wed, 21 Aug 2019 16:02:40 +0100
Message-ID: <20190821150241.31093-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566399774; bh=c+D10e7qyD/v8odq9Z4b64li+E5jzsQQuZpseZjoJdY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=sLeJloAdyAClgj5ykcwCZWoLQLqSPbEcPcqNvDq1OwNQjyVss1S0cm7SROcWSEjTo
         Tsi+pPghQVzvD4+nZRBdYVNgcRtTwCiNCEPuyHwQeIH9kg+6/3ruz4bw3GXLQLOkMY
         /UGmhTXlT6zAR5jBm7cyAo+6UlMSuLLeocMK6zpuXEl2aaCSp2BkIA9t5t2Ydj5iWb
         8L3SNk4aBsJJumrHkazf/pWgCyP5iZ+mbHoWGjcGfN53jkMfpvoUVAmBNT2bARtwwv
         YDfiqJ9xQBIDA37xMfwB5JGqXrZ4oe+8psNtHR1WWWggIv9JEfWmKr62rffo/4jJxg
         y3If8llHulqDQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deferred probe is an expected return value for clk_get() on many
platforms. The driver deals with it properly, so there's no need
to output a warning that may potentially confuse users.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/clocksource/timer-of.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index 80542289fae7..d8c2bd4391d0 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -113,8 +113,10 @@ static __init int timer_of_clk_init(struct device_node *np,
 	of_clk->clk = of_clk->name ? of_clk_get_by_name(np, of_clk->name) :
 		of_clk_get(np, of_clk->index);
 	if (IS_ERR(of_clk->clk)) {
-		pr_err("Failed to get clock for %pOF\n", np);
-		return PTR_ERR(of_clk->clk);
+		ret = PTR_ERR(of_clk->clk);
+		if (ret != -EPROBE_DEFER)
+			pr_err("Failed to get clock for %pOF\n", np);
+		goto out;
 	}
 
 	ret = clk_prepare_enable(of_clk->clk);
-- 
2.17.1

