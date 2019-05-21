Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8B6C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D9920863
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 06:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rWBEaPbO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfEUGPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 02:15:54 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36128 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfEUGPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 02:15:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id d21so7913170plr.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 23:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4R0Z1avkl5DcwArAEdYF5RKsOqx23+ElfNwQfhlhU8U=;
        b=rWBEaPbOv0Ze4QP+zKqhgDJLjfQzgBZRlveZ5KKv6jzAPxoKfCAc9mSKLdMx/9jL3v
         nFmY67X/QCW8SlSFYYtgtr2TOtMrAz6nEGWK5x5dVRjLFh50dq7JDUw3s7bj6SzJ/E8I
         Himrhy2bu8WjqyccmLGj1r/JBcUBmkSVcN5j03XkSzrLQHubwWAiU/iwEml7Aezz4Rfq
         iZrUP6ztMtgo70T0vL607ynlVJImepQp5080ijDfWbjzF7kV/qvfOP6gDITJnzPftl63
         g1SpLgLn40kDNPNGJq5iNOEPcyabqIhbNJdrg+RJCt1/gxr4Zr+zuxsJQoz/T8vnXL2R
         LJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4R0Z1avkl5DcwArAEdYF5RKsOqx23+ElfNwQfhlhU8U=;
        b=CNEO7b2fCW9MR3rg6YpTiFaOp6wcLvRBLgOhE45YyU7bg5AyOTFru3Xus9eWrFhjLY
         q3cAgHUjk+fAb5kAWiSXG6pPy8WWT07aHO1xtvhzXDJSyQDgBBiucTMNXHJjD6njnY8i
         eRLypXoRudKd410Zp+VadFD0cpVyg+Wtbmf8O0Fxy0TGWD9BFVi8OShFKI6atBlqrt2e
         T3QziWrIHBdJkTcU76aslEchbGOFMrxaPxax0CV7uIypm6bpLBBBiTXQYEYkIZCrfehZ
         /qg5Q+P6S06doCxKb0/icy05mu//YQ9ZsTi8oSJ1F6vsk5EU2vO1wU/wCkQDw3Ze6Wow
         wChA==
X-Gm-Message-State: APjAAAU+Jk/fWQrD3H+qrMw3AOgfKtamKmilq1DXREwelWXbfdd8D34g
        hP/hMYYPr0lD0f1AEvKd46vezw==
X-Google-Smtp-Source: APXvYqwBHHtyco4N8WF7epFmyuDSFE9c1OUeIL1j1jNgX30UzSph1JCCf5VP/WOjybTewBj76jSwkA==
X-Received: by 2002:a17:902:1cb:: with SMTP id b69mr54576811plb.158.1558419352754;
        Mon, 20 May 2019 23:15:52 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id k9sm23064259pfa.180.2019.05.20.23.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 23:15:52 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 2/2] clk: sprd: Add check for return value of sprd_clk_regmap_init()
Date:   Tue, 21 May 2019 14:09:52 +0800
Message-Id: <20190521060952.2949-3-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190521060952.2949-1-zhang.chunyan@linaro.org>
References: <20190521060952.2949-1-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sprd_clk_regmap_init() doesn't always return success, adding check
for its return value should make the code more strong.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/clk/sprd/sc9860-clk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sprd/sc9860-clk.c b/drivers/clk/sprd/sc9860-clk.c
index 9980ab55271b..1ed45b4f2fe8 100644
--- a/drivers/clk/sprd/sc9860-clk.c
+++ b/drivers/clk/sprd/sc9860-clk.c
@@ -2031,7 +2031,9 @@ static int sc9860_clk_probe(struct platform_device *pdev)
 	}
 
 	desc = match->data;
-	sprd_clk_regmap_init(pdev, desc);
+	ret = sprd_clk_regmap_init(pdev, desc);
+	if (ret)
+		return ret;
 
 	return sprd_clk_probe(&pdev->dev, desc->hw_clks);
 }
-- 
2.17.1

