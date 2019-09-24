Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9FBC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 394F421971
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569343773;
	bh=imc0Q0pspsvYgj/52o+N72nnGePu1STZj1a8QPV/zXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zXbGRonm5fE0EjyClzl1g/vz+5rwJaohWlj2K6HA/eXzoTRO5w1Zl8+dhwfbjm+QY
	 uIoI3hxejlxHC7mvy0/IiEXlPLEf0DZExSmQ5pBaoZY37EAUiYIbXQ00eY5CqewjJz
	 Nvk2IUe2+vqDp5YKF2g0fCFy1IzoKMh2jXY+htTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410573AbfIXQtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:49:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410550AbfIXQt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:49:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A6DC21971;
        Tue, 24 Sep 2019 16:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343768;
        bh=imc0Q0pspsvYgj/52o+N72nnGePu1STZj1a8QPV/zXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KinAgMK22nU5WJ97LqGsjDjtAXZEhsqoBKrTd62ZReqNNHFfZsijDIMbMO26aGfcA
         bP/IeeCFXI0I52ddEZ4FjJQsag0yy9nriu9aEyaaiaUWU3NTAdZPNhPOcI7gdNC5RP
         iQoeOjat6uD0cLkQ3ZRMmRv4vwz96zqPI3vR4j/g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 21/50] clk: sprd: Don't reference clk_init_data after registration
Date:   Tue, 24 Sep 2019 12:48:18 -0400
Message-Id: <20190924164847.27780-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164847.27780-1-sashal@kernel.org>
References: <20190924164847.27780-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@kernel.org>

[ Upstream commit f6c90df8e7e33c3dc33d4d7471bc42c232b0510e ]

A future patch is going to change semantics of clk_register() so that
clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
referencing this member here so that we don't run into NULL pointer
exceptions.

Cc: Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Link: https://lkml.kernel.org/r/20190731193517.237136-8-sboyd@kernel.org
Acked-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/sprd/common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
index e038b04472061..8bdab1c3013b8 100644
--- a/drivers/clk/sprd/common.c
+++ b/drivers/clk/sprd/common.c
@@ -71,16 +71,17 @@ int sprd_clk_probe(struct device *dev, struct clk_hw_onecell_data *clkhw)
 	struct clk_hw *hw;
 
 	for (i = 0; i < clkhw->num; i++) {
+		const char *name;
 
 		hw = clkhw->hws[i];
-
 		if (!hw)
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

