Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58186C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2257D2173B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383736;
	bh=NpxL+WCCtdslumQX2yqO+h1199gm+NJi3hIXzXiutNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WHgY6SbQGtSvRCSf3mokVaPoVqnvpQLueFXuDZR3+R7EeXIj+PucGTepKROAQz8ba
	 gRO8wRIELXsfzS4Who6zfup3MjbDVjkdssngge+Zpm9g3DWmOxL1icOLQlfprH60DE
	 oOERAs8GkyFa1xa96R4SkwYlrY/BdJaed1JBLjEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbfJFRmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:42:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730351AbfJFRmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:42:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A28F20700;
        Sun,  6 Oct 2019 17:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383732;
        bh=NpxL+WCCtdslumQX2yqO+h1199gm+NJi3hIXzXiutNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8exilOfkITt/tTO4SX+3VaSXlM9ma/LRoGnor/wB5Ca/qSAqTZuE8YCH0MtWBtiP
         LbHr0NEujkWmRxtuE2hK3VFueri7StFZMO+GFKvph+J5qT3y8B2Sq07Ydgz6CncgJV
         xYTynWlGeXXZlsMq6+n+0SP2ZIxFFSF+ooC4I3Ig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 074/166] clk: Make clk_bulk_get_all() return a valid "id"
Date:   Sun,  6 Oct 2019 19:20:40 +0200
Message-Id: <20191006171219.660307134@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171212.850660298@linuxfoundation.org>
References: <20191006171212.850660298@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

[ Upstream commit 7f81c2426587b34bf73e643c1a6d080dfa14cf8a ]

The adreno driver expects the "id" field of the returned clk_bulk_data
to be filled in with strings from the clock-names property.

But due to the use of kmalloc_array() in of_clk_bulk_get_all() it
receives a list of bogus pointers instead.

Zero-initialize the "id" field and attempt to populate with strings from
the clock-names property to resolve both these issues.

Fixes: 616e45df7c4a ("clk: add new APIs to operate on all available clocks")
Fixes: 8e3e791d20d2 ("drm/msm: Use generic bulk clock function")
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lkml.kernel.org/r/20190913024029.2640-1-bjorn.andersson@linaro.org
Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-bulk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
index 524bf9a530985..e9e16425c739c 100644
--- a/drivers/clk/clk-bulk.c
+++ b/drivers/clk/clk-bulk.c
@@ -18,10 +18,13 @@ static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
 	int ret;
 	int i;
 
-	for (i = 0; i < num_clks; i++)
+	for (i = 0; i < num_clks; i++) {
+		clks[i].id = NULL;
 		clks[i].clk = NULL;
+	}
 
 	for (i = 0; i < num_clks; i++) {
+		of_property_read_string_index(np, "clock-names", i, &clks[i].id);
 		clks[i].clk = of_clk_get(np, i);
 		if (IS_ERR(clks[i].clk)) {
 			ret = PTR_ERR(clks[i].clk);
-- 
2.20.1



