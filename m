Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05246C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCBDB207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EFd+uioU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfI0DvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 23:51:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43346 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfI0DvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 23:51:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id f21so503668plj.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 20:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=V9DS/QOwqeJEc++1RGa0/GFPq1bWylLG/sK8PIeSOjM=;
        b=EFd+uioUEzXYPg/htXgdnnNhmWIF6tsNx2mGdy29mHoJwPkK6SpCy4sMbYc1lcsoha
         yuA0KRB9ZGpDS79Stj6fUwL39iEAXtDcxHCztSXrK0dKUTZgY72fIy0B3HUUu43XkY+I
         J1a7FG+2DHFRSzWZ/y8nwusy1Pz1vY4rKUa8uuX73GENBBPGPv1zrhnLgnVfkzi4bcL5
         z5OdMy2QOlPRVIWMDM+Gf8ZKDpXAKVj6I+HVXLp6yibpCu3dgVr07X/RgJ34l0+oG5fM
         kL6gTCTINPcsWvayxAbydV97Olw22mGY4ClTx4JSrqPRAUMlxMP8aCTb4wX8jW38TMit
         Uj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V9DS/QOwqeJEc++1RGa0/GFPq1bWylLG/sK8PIeSOjM=;
        b=eot95aQBlzS7laNJwbTp7nQDQwrs46y2ZWRYkSV5r/pNrIDJt7YCo5dlwUTOwfKDQU
         2aMR2O2SId+HU5NJXK28qJmW2t1pyMr5ekwP7OhFqzv7Nq3YVQJ0O57Gho7Q7sIgicp/
         iMq74UT1+NwIPotV71VziTmh7dqH8UFM1yybHTpZY+iSL+UdEHzwdxezFWhSu3t0u6Ro
         HXGZx40OeULMXKpEC9QwFGzxvorRtFeeG58jlVpkBqjcxHMymTbZ0aYuZQvQ1pbOm/o8
         0mwuojS3mOA5wGfcGg8/qBfH4PESwst0v0bsXduKFxPkvAa4DH/48+MESL8NoC5gQNxx
         eH3w==
X-Gm-Message-State: APjAAAWkdhxDAL8CVTlzsIyeRmjBgViaiobxUt0aE32MI0ccZLPbL+tJ
        NfurJPkImu4K6R1klMCj5ydbHw==
X-Google-Smtp-Source: APXvYqzNTK6RbAVCanSAplvzHuRnqO4cljDQPwRdB1e36UzREEZiifwl0eCjvwxvg7s6wj91v/1Hew==
X-Received: by 2002:a17:902:b902:: with SMTP id bf2mr2370343plb.56.1569556275985;
        Thu, 26 Sep 2019 20:51:15 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id n66sm753640pfn.90.2019.09.26.20.51.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Sep 2019 20:51:15 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] clk: sprd: Use IS_ERR() to validate the return value of syscon_regmap_lookup_by_phandle()
Date:   Fri, 27 Sep 2019 11:50:53 +0800
Message-Id: <b7fbe8776703b9d637ab82ad4724353b359f1d04.1569555841.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syscon_regmap_lookup_by_phandle() will never return NULL, thus use
IS_ERR() to validate the return value instead of IS_ERR_OR_NULL().

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/clk/sprd/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
index 9d56eac..7ad5ba2 100644
--- a/drivers/clk/sprd/common.c
+++ b/drivers/clk/sprd/common.c
@@ -46,7 +46,7 @@ int sprd_clk_regmap_init(struct platform_device *pdev,
 
 	if (of_find_property(node, "sprd,syscon", NULL)) {
 		regmap = syscon_regmap_lookup_by_phandle(node, "sprd,syscon");
-		if (IS_ERR_OR_NULL(regmap)) {
+		if (IS_ERR(regmap)) {
 			pr_err("%s: failed to get syscon regmap\n", __func__);
 			return PTR_ERR(regmap);
 		}
-- 
1.7.9.5

