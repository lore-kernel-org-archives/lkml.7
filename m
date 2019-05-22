Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB78C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3208020862
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558553874;
	bh=9wYURvB6rQQAvedFZUg0/FddW7av8XxRmg8oVjOrHgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aP/SRA72t2A78o9rM2uw6rs1LCC8niUWcs7E5idaWtNFm6pvIIkZkWQgZXzy+ByCI
	 H8/fFe1e8ndiuooWIY9rBXnMDqC8sruQSOCSqf8HXtIMa44EgIFz7VTgjX8tkj72AT
	 IlsxHGGq5HSd9cmYnXACJz1EixL3WAs0xoJiCUco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbfEVThx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:37:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730376AbfEVTaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:30:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B4C320675;
        Wed, 22 May 2019 19:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553407;
        bh=9wYURvB6rQQAvedFZUg0/FddW7av8XxRmg8oVjOrHgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VRNVWE4aimxwTmG/MNm0BQEIL2kscYBpgNJUIeopQtUH6B0jFpBh1RLpWqwWvyuw7
         ofRiFT6KSMWro0IZxDiIRNHAJ0pFqshEFW4+p4uao+gWkpH7793wMWAKBLwkiKZIm3
         jHC262d4bEZXMr/x8dUPh2AD80rGRLcKZteucAPQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 056/167] pinctrl: samsung: fix leaked of_node references
Date:   Wed, 22 May 2019 15:26:51 -0400
Message-Id: <20190522192842.25858-56-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192842.25858-1-sashal@kernel.org>
References: <20190522192842.25858-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

[ Upstream commit 44b9f86cd41db6c522effa5aec251d664a52fbc0 ]

The call to of_find_compatible_node returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./drivers/pinctrl/samsung/pinctrl-exynos-arm.c:76:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 66, but without a corresponding object release within this function.
./drivers/pinctrl/samsung/pinctrl-exynos-arm.c:82:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 66, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos-arm.c b/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
index afeb4876ffb2c..07eb4f071fa87 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos-arm.c
@@ -76,6 +76,7 @@ s5pv210_retention_init(struct samsung_pinctrl_drv_data *drvdata,
 	}
 
 	clk_base = of_iomap(np, 0);
+	of_node_put(np);
 	if (!clk_base) {
 		pr_err("%s: failed to map clock registers\n", __func__);
 		return ERR_PTR(-EINVAL);
-- 
2.20.1

