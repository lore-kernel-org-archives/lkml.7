Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7306FC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3EF2080F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384840;
	bh=VZnmPg5IckIkj42+lltGSiTdBTdV0VvKLXMECgyNU+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Td9VISqe2sPdsxmU9YpF7hNqxaLdYvHgr4S9By9zPFiB3WrdtDshm5VV9Z4eE9MbH
	 EIcqlQnz13Hmxk6t5PWXMoYR48sKJKYXZJMvDQcrTEcg/eWvYHPito2VofjBYkH18N
	 HiVsYZKlWk9tzC6GcBeZ8FPUDig1mmluwQ8nZTrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfJFR2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:28:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbfJFR2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:28:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99990217D6;
        Sun,  6 Oct 2019 17:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382914;
        bh=VZnmPg5IckIkj42+lltGSiTdBTdV0VvKLXMECgyNU+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PP1+i57VwXe55SzaBmyFFBN6uC1eqlN7b6Ye4JBVOOIpuQteP5eIcjh7e+rOkLEeI
         CMuGr2xL7xA7+PcQVWowiO4xnPO2jug/4DrDyyH/G6fJeLiHxPtHgz6SlW8KsESEcK
         Qp8dYVWmFWfzW6Ucy2O40t+pJbnczhdlbbfksnoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 018/106] clk: actions: Dont reference clk_init_data after registration
Date:   Sun,  6 Oct 2019 19:20:24 +0200
Message-Id: <20191006171132.803572044@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171124.641144086@linuxfoundation.org>
References: <20191006171124.641144086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@kernel.org>

[ Upstream commit cf9ec1fc6d7cceb73e7f1efd079d2eae173fdf57 ]

A future patch is going to change semantics of clk_register() so that
clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
referencing this member here so that we don't run into NULL pointer
exceptions.

Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Link: https://lkml.kernel.org/r/20190731193517.237136-2-sboyd@kernel.org
[sboyd@kernel.org: Move name to after checking for error or NULL hw]
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/actions/owl-common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/actions/owl-common.c b/drivers/clk/actions/owl-common.c
index 61c1071b5180a..e9be34b17f3f5 100644
--- a/drivers/clk/actions/owl-common.c
+++ b/drivers/clk/actions/owl-common.c
@@ -67,16 +67,17 @@ int owl_clk_probe(struct device *dev, struct clk_hw_onecell_data *hw_clks)
 	struct clk_hw *hw;
 
 	for (i = 0; i < hw_clks->num; i++) {
+		const char *name;
 
 		hw = hw_clks->hws[i];
-
 		if (IS_ERR_OR_NULL(hw))
 			continue;
 
+		name = hw->init->name;
 		ret = devm_clk_hw_register(dev, hw);
 		if (ret) {
 			dev_err(dev, "Couldn't register clock %d - %s\n",
-				i, hw->init->name);
+				i, name);
 			return ret;
 		}
 	}
-- 
2.20.1



