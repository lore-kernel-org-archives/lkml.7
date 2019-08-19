Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A38C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A4921872
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566200517;
	bh=Qz8PhyWf0+VgB0haEtXhkGUqS2uIp+Tg4BMmWfb6Lc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aemM3wru55tMXuLFZXTuT783MN7+vZ4FlQ77Xggnb8yksZFpFZ5mR4hbVs5jrcMGZ
	 mBr3vheQ6CFBUyATsAyByvTYgA6zld+erQUrzUb6kKgXsAZkMVY6Eqv8DN1+K0UUSx
	 NRcH9NUoVDZkj67P92JD8ef7CwaFlP5sXO9qfEFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfHSHl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 03:41:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfHSHlz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:41:55 -0400
Received: from localhost.localdomain (unknown [122.182.221.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A65520989;
        Mon, 19 Aug 2019 07:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566200514;
        bh=Qz8PhyWf0+VgB0haEtXhkGUqS2uIp+Tg4BMmWfb6Lc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=om0PAXLo9bcOZ51YHgZYNxMkClVhQWeXEUXBj/3cVgJOgZonFGdFqbo3ch5uByCXj
         mdLwzOjNCuJvP43JyOygL1cIveofL2/DNI160KLTCwPoH3SOWi7LQ/UdV+k3MqjyG+
         nFB/U9mqEV7XCJIrDqDjd+Irgc87TGvKTRKUcgS0=
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] clk: qcom: clk-rpmh: Convert to parent data scheme
Date:   Mon, 19 Aug 2019 13:09:45 +0530
Message-Id: <20190819073947.17258-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190819073947.17258-1-vkoul@kernel.org>
References: <20190819073947.17258-1-vkoul@kernel.org>
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
index c3fd632af119..16d689e5bb3c 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -95,7 +95,10 @@ static DEFINE_MUTEX(rpmh_clk_lock);
 		.hw.init = &(struct clk_init_data){			\
 			.ops = &clk_rpmh_ops,				\
 			.name = #_name,					\
-			.parent_names = (const char *[]){ "xo_board" },	\
+			.parent_data =  &(const struct clk_parent_data){ \
+					.fw_name = "xo",		\
+					.name = "xo",		\
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
+					.fw_name = "xo",		\
+					.name = "xo",		\
+			},						\
 			.num_parents = 1,				\
 		},							\
 	}
-- 
2.20.1

