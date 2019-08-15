Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD70C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF46E2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 16:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565884836;
	bh=A4wQl6vcC8iZEo+vLLbng0Wix6dTYFgjLABnwe1gTpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F9Wbd4OmVaTQAUvd8qnDJBqMriT4e1C2XiIkpe7UmM8f+DxmccoPPNijas1BFAfcg
	 O7tNdgVbjH0keluW+hwes2CdzENhBdKvDdo08LNlgdFio9hzLcmgk4t3u9K+UNI9Uo
	 qeD+HRD75mzzlvL+AxLNbTKHBVOOKRGR0IBdEc7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbfHOQAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 12:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729539AbfHOQAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 12:00:23 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EFBA2171F;
        Thu, 15 Aug 2019 16:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565884823;
        bh=A4wQl6vcC8iZEo+vLLbng0Wix6dTYFgjLABnwe1gTpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YC9e654T/YbzSJ2/aIR2ryASLUL2B5Uu0n1AxyMJhG/B3tjT6DSd0JQYAvHdw3ose
         1SvsZKH1vaij+mxpOTcfr9+N5HrM8bcw4G+DoqXmYvqAsxXneDziMTe9+IaRrJMzit
         xMAeOPSyULkiHT+QQrS2pk8v9ap8ygmcYPC6V80o=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH 4/4] clk: qcom: Remove error prints from DFS registration
Date:   Thu, 15 Aug 2019 09:00:20 -0700
Message-Id: <20190815160020.183334-5-sboyd@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190815160020.183334-1-sboyd@kernel.org>
References: <20190815160020.183334-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These aren't useful and they reference the init structure name. Let's
just drop them.

Cc: Taniya Das <tdas@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/clk-rcg2.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 8c02bffe50df..161a6498ed5a 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -1105,8 +1105,6 @@ static int clk_rcg2_enable_dfs(const struct clk_rcg_dfs_data *data,
 
 	rcg->freq_tbl = NULL;
 
-	pr_debug("DFS registered for clk %s\n", init->name);
-
 	return 0;
 }
 
@@ -1117,12 +1115,8 @@ int qcom_cc_register_rcg_dfs(struct regmap *regmap,
 
 	for (i = 0; i < len; i++) {
 		ret = clk_rcg2_enable_dfs(&rcgs[i], regmap);
-		if (ret) {
-			const char *name = rcgs[i].init->name;
-
-			pr_err("DFS register failed for clk %s\n", name);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;
-- 
Sent by a computer through tubes

