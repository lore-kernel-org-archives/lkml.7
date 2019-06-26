Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B9FC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 04:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EA12086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 04:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561522509;
	bh=nLhLl0KRASWFnS70bdCvQOMOFLG+QXRubn6Xsywf0Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cb0J2RhFRqkxlAn8Ae6Be9m2hjRKSvxRSr9q1ihVm/TBHnWc5peko1UVJWNvtIWsj
	 uD2+2g+qlA3ITDAMwPI3h6ypob4LPJraBJLIEIgCUbq7LncVkO3mmbCPoNxxgk2NcO
	 /eJw+gBxp0DD5tJ07Z0L4aE2hCPf51sjvTNMtb1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfFZEPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 00:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbfFZEPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 00:15:04 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76D322146E;
        Wed, 26 Jun 2019 04:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561522503;
        bh=nLhLl0KRASWFnS70bdCvQOMOFLG+QXRubn6Xsywf0Zg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2odwG4C0c+WfqgHqocwKhJvQuog8CyN+0KKVO72O7lAEC1sLKz0fDyNoxUNS3v53N
         VITNRI4TZWa55Y5uWsxzUp+648pHQXhgKAxk94KA0CgjftaFhfWbV5e4oPeRPGBqqw
         7uYDkgYA91GnkCjBmwu89AgrsvhdiMk27m+gMHIU=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 2/2] clk: Unexport __clk_of_table
Date:   Tue, 25 Jun 2019 21:15:02 -0700
Message-Id: <20190626041502.237211-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190626041502.237211-1-sboyd@kernel.org>
References: <20190626041502.237211-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This symbol doesn't need to be exported to clk providers anymore.
Originally, it was hidden inside clk.c, but then OMAP needed to get
access to it in commit 819b4861c18d ("CLK: ti: add init support for
clock IP blocks"), but eventually that code also changed in commit
c08ee14cc663 ("clk: ti: change clock init to use generic of_clk_init")
and we were left with this exported. Move this back into clk.c so that
it isn't exposed anymore.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c            | 1 +
 include/linux/clk-provider.h | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index aa51756fd4d6..b34e84bb8167 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4038,6 +4038,7 @@ struct of_clk_provider {
 	void *data;
 };
 
+extern struct of_device_id __clk_of_table;
 static const struct of_device_id __clk_of_table_sentinel
 	__used __section(__clk_of_table_end);
 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 3bced2ec9f26..9ba000e3a50d 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -865,8 +865,6 @@ static inline long divider_ro_round_rate(struct clk_hw *hw, unsigned long rate,
  */
 unsigned long clk_hw_round_rate(struct clk_hw *hw, unsigned long rate);
 
-struct of_device_id;
-
 struct clk_onecell_data {
 	struct clk **clks;
 	unsigned int clk_num;
@@ -877,8 +875,6 @@ struct clk_hw_onecell_data {
 	struct clk_hw *hws[];
 };
 
-extern struct of_device_id __clk_of_table;
-
 #define CLK_OF_DECLARE(name, compat, fn) OF_DECLARE_1(clk, name, compat, fn)
 
 /*
-- 
Sent by a computer through tubes

