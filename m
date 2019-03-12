Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4533C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951C321741
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410891;
	bh=M4nwY7OdKHA2J8gnBptO46wjmPcQeljnjGyIqJAladI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AOMw83roQSU/PZ/J5Vz3epF8SQeiLJkuGWOqHgSYDdbVVcYUJv0wypRHFAKathHIY
	 +xsomj5vDxmXxHf9SbTrpcVHvQ1H18f/Xzk6BhjVA/A+mkIpXFh+dtTEI135bUDUVW
	 ON5Ivn7wwVQBkd4HNCLl1sTkObJWRuFrSBKX5Rs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfCLROu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728194AbfCLROB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:01 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD5E22173C;
        Tue, 12 Mar 2019 17:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410840;
        bh=M4nwY7OdKHA2J8gnBptO46wjmPcQeljnjGyIqJAladI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WqfYKFRCYJPKvZqW0WdkilxKJkMzbbkM94DjdGSzL3siUYAQIjFwIjz7E6U+b26sP
         4DT2v2ZqzCVZfQ9/fs0l9zlHkoA330XV4brC44JP6ZMddV92AM1q8K02yoDf5gWj92
         MEdfuobGjo2YcAYGYWj1pKqagYpBC1AlS6P9sMUY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Tero Kristo <t-kristo@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 013/149] clk: ti: Fix error handling in ti_clk_parse_divider_data()
Date:   Tue, 12 Mar 2019 10:07:11 -0700
Message-Id: <20190312170350.679677128@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 303aef8b84272d73999a3207dd05bbe10ed89dc5 ]

The ti_clk_parse_divider_data() function is only called from
_get_div_table_from_setup().  That function doesn't look at the return
value but instead looks at the "*table" pointer.  In this case, if the
kcalloc() fails then *table is NULL (which means success).  It should
instead be an error pointer.

The ti_clk_parse_divider_data() function has two callers.  One checks
for errors and the other doesn't.  I have fixed it so now both handle
errors.

Fixes: 4f6be5655dc9 ("clk: ti: divider: add driver internal API for parsing divider data")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ti/divider.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index ccfb4d9a152a..079f0beda8b6 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -367,8 +367,10 @@ int ti_clk_parse_divider_data(int *div_table, int num_dividers, int max_div,
 	num_dividers = i;
 
 	tmp = kcalloc(valid_div + 1, sizeof(*tmp), GFP_KERNEL);
-	if (!tmp)
+	if (!tmp) {
+		*table = ERR_PTR(-ENOMEM);
 		return -ENOMEM;
+	}
 
 	valid_div = 0;
 	*width = 0;
@@ -403,6 +405,7 @@ struct clk_hw *ti_clk_build_component_div(struct ti_clk_divider *setup)
 {
 	struct clk_omap_divider *div;
 	struct clk_omap_reg *reg;
+	int ret;
 
 	if (!setup)
 		return NULL;
@@ -422,6 +425,12 @@ struct clk_hw *ti_clk_build_component_div(struct ti_clk_divider *setup)
 		div->flags |= CLK_DIVIDER_POWER_OF_TWO;
 
 	div->table = _get_div_table_from_setup(setup, &div->width);
+	if (IS_ERR(div->table)) {
+		ret = PTR_ERR(div->table);
+		kfree(div);
+		return ERR_PTR(ret);
+	}
+
 
 	div->shift = setup->bit_shift;
 	div->latch = -EINVAL;
-- 
2.19.1



