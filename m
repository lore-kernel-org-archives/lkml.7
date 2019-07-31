Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FCAC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC10C208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564601740;
	bh=jEkMQfw4L7S/t3liDgglHmF76THS5l4KeuIrArMt5eY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KYZNOzDXXPlJUELiHFLlWJnjqRvXvtbkMtlgVkyVYm/CpnS770/4l2cOdhdcd/80t
	 pKuc8LjiDi4um+3HlOmxEVLP2A4BypY4xYeuTXa4TlKyvMFSbpxnx++90mjErTH7Qy
	 LYqB9rcUHWeanRu4u95b6f/h5uvFKpWlwn9+xpRY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbfGaTfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:35:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730992AbfGaTfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:35:21 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1174921726;
        Wed, 31 Jul 2019 19:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564601721;
        bh=jEkMQfw4L7S/t3liDgglHmF76THS5l4KeuIrArMt5eY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BSo+N0FnXu6Xxfk93LlLHUGRvic0oUioOCy87mltGDyWWKdZ7v4rTOKBVLpXMcJwc
         zY4w8JBQ2dcy6nHAWqVHBuJNbKk0QwbDrysLy2vB7mFyia/uoBEQpw8b6/ldkXWXX0
         7J13vcOwST79JJPU9qX3ZNtYJJLitlzPLuKA3f5w=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 8/9] phy: ti: am654-serdes: Don't reference clk_init_data after registration
Date:   Wed, 31 Jul 2019 12:35:16 -0700
Message-Id: <20190731193517.237136-9-sboyd@kernel.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190731193517.237136-1-sboyd@kernel.org>
References: <20190731193517.237136-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A future patch is going to change semantics of clk_register() so that
clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
referencing this member here so that we don't run into NULL pointer
exceptions.

Cc: Roger Quadros <rogerq@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

Please ack so I can take this through clk tree

 drivers/phy/ti/phy-am654-serdes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
index f8edd0840fa2..398a8c9b675a 100644
--- a/drivers/phy/ti/phy-am654-serdes.c
+++ b/drivers/phy/ti/phy-am654-serdes.c
@@ -335,6 +335,7 @@ static int serdes_am654_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct serdes_am654_clk_mux *mux = to_serdes_am654_clk_mux(hw);
 	struct regmap *regmap = mux->regmap;
+	const char *name = clk_hw_get_name(hw);
 	unsigned int reg = mux->reg;
 	int clk_id = mux->clk_id;
 	int parents[SERDES_NUM_CLOCKS];
@@ -374,8 +375,7 @@ static int serdes_am654_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 		 * This can never happen, unless we missed
 		 * a valid combination in serdes_am654_mux_table.
 		 */
-		WARN(1, "Failed to find the parent of %s clock\n",
-		     hw->init->name);
+		WARN(1, "Failed to find the parent of %s clock\n", name);
 		return -EINVAL;
 	}
 
-- 
Sent by a computer through tubes

