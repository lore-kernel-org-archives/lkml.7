Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82863C072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3254F217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B3XhrGin"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfEVBPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 21:15:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33490 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbfEVBPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 21:15:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id z28so392462pfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 18:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NTS1odQw+3K/o26m56A8dudsgiFBip3uvfuWtKKFHvU=;
        b=B3XhrGinnvN8sKjWn4ooBhJDwiBZy++xwD3PIwifiEQmGkn9dXEIXn56iDzEoxfVvj
         buXxk5oR6q/tDHs5OOaUOkRWM1sLkSX4JU0PyfPJCY/0ZHnvNjW+5t6L/klL89CpmkOU
         RskDCpXRp8Nb0ntd+sjYiNmTwpWddBd2/vc+Qss6vnBNh0rx9yQ1VlRU+ynGuu5CgZL9
         riuxQgdodNGLJ7JIcSjyTdkhtNXRSVa4DnyqinGH1zfrS2v3sYsMbbBF1l5tT5dXe7R0
         umoIlSFNx9D9SlsIIXLF4fISmz0vBqrgIOvMii2WHcJXQ3fqvIMmHOW5xZARBO3AlqvT
         jDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NTS1odQw+3K/o26m56A8dudsgiFBip3uvfuWtKKFHvU=;
        b=Nku6EqHXsaLdK9WhO0NCLVG3KwpLzrcZ3pk/engucfBU+HJ+Q/Xu1NB5uhAyn78rPn
         82/ja1QwAisNEMYP0j6GrtqhikyrssgHpEneU4upLFYeZ35sp2XuVz1P6tjt3eq3fHtP
         pQhBpy2dPpgRsT8RuRampoh6mAtfvZ2AAcMwpjkkf88/JpH7LgiQU5DLOd+cm+Hw4Ttn
         S1y5opn0RH9kcE7z2/4mmFqtfjxeRM7KrThhtYqilqOcezzk417aonQXEI29DWLeAJCB
         S/glSJ/fsJiSIRPFQN91Pk2ajVwhfPw9PYWpYmwd7VPFsgPhPtwaOglP31H4/bpsFLLo
         MrqQ==
X-Gm-Message-State: APjAAAUiYm1ORY9J+e3SeL7wApQKXD+fnLauSTfLZtsltF32RNK+6cs4
        k9xhi8l2+OguQcPeTH0ZZ9CZjQ==
X-Google-Smtp-Source: APXvYqwCHdfP9ydZV/hnCl50oxwldTytQuZ5sT/dbQl5TBOLCFSD6z2kQzBhyOjfPNocbs5fbF6ZXw==
X-Received: by 2002:a62:6585:: with SMTP id z127mr52504792pfb.179.1558487750638;
        Tue, 21 May 2019 18:15:50 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e184sm31756061pfa.169.2019.05.21.18.15.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 18:15:49 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v2 3/3] clk: sprd: Add check for return value of sprd_clk_regmap_init()
Date:   Wed, 22 May 2019 09:15:03 +0800
Message-Id: <20190522011504.19342-4-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522011504.19342-1-zhang.chunyan@linaro.org>
References: <20190522011504.19342-1-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sprd_clk_regmap_init() doesn't always return success, adding check
for its return value should make the code more strong.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
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

