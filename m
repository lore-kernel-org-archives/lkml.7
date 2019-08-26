Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2838C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F3B2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566821800;
	bh=iwOFBOI7Gq5ajYrPylzZLoZNnSQjqr85990hVj91PIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qVtNyEUBhhW7rbZhXwIvNl8pEgHuYNwIF2Y2x9yBkvWQniBSWAbRATNv+kIy8hTFW
	 nO3gt8KRsmHjntH5XQqLPLddxLxNlYxuxiWV0idgbcL9sC0Jn55df8HeidxUBAyZ96
	 b8PTrNmxXD0IBIH6DjlLH2sNHxoVIEpG4vdNAqBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbfHZMQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:16:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731709AbfHZMQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:16:38 -0400
Received: from localhost.localdomain (unknown [122.178.200.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9EED217F5;
        Mon, 26 Aug 2019 12:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566821797;
        bh=iwOFBOI7Gq5ajYrPylzZLoZNnSQjqr85990hVj91PIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0p8Lp2aLQ4s0kJ2E1MbwWM0Obc5HqtoInRtyiIcxCCH07yLNekuwJqQXnGtmd7K4I
         3s6ClIZK6Bf8ehUqGv4+q6Q31QtfZdNn9Rfx8rEvxEEG0KkPtQ/Pze64XSpqi735rA
         GhJ1yEAWi+Zol2W8IdVPRLRA9nupPqlaHUaEbibQ=
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] clk: qcom: clk-rpmh: Convert to parent data scheme
Date:   Mon, 26 Aug 2019 17:44:51 +0530
Message-Id: <20190826121453.21732-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190826121453.21732-1-vkoul@kernel.org>
References: <20190826121453.21732-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the rpmh clock driver to use the new parent data scheme by
specifying the parent data for board clock.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/clk/qcom/clk-rpmh.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index c3fd632af119..97aa092f5f40 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -95,7 +95,10 @@ static DEFINE_MUTEX(rpmh_clk_lock);
 		.hw.init = &(struct clk_init_data){			\
 			.ops = &clk_rpmh_ops,				\
 			.name = #_name,					\
-			.parent_names = (const char *[]){ "xo_board" },	\
+			.parent_data =  &(const struct clk_parent_data){ \
+					.fw_name = "xo_board",		\
+					.name = "xo",			\
+			},						\
 			.num_parents = 1,				\
 		},							\
 	};								\
@@ -110,7 +113,10 @@ static DEFINE_MUTEX(rpmh_clk_lock);
 		.hw.init = &(struct clk_init_data){			\
 			.ops = &clk_rpmh_ops,				\
 			.name = #_name_active,				\
-			.parent_names = (const char *[]){ "xo_board" },	\
+			.parent_data =  &(const struct clk_parent_data){ \
+					.fw_name = "xo_board",		\
+					.name = "xo",			\
+			},						\
 			.num_parents = 1,				\
 		},							\
 	}
-- 
2.20.1

