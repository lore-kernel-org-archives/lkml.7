Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5EFC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 17:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B53821872
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 17:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566840779;
	bh=/bpf7xC2H//gRGlYPbogjUfpowEtufJcXobWye4Cnlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u73lcnl4CmgWHfDKP+d9W2U2+/+Aky5DbGYyJPBQbtSDYX5LWAi7br6H3DozdRA7J
	 ONuo3iBAQUrZZrBNm6uGTMT+Ko/21qnPZ5mE+q7ULFpj+YcyZgrH6XuT20U1kv8PCh
	 45LyyLjRpzKGVT1smEfcciVLQGxAIJi9HtI1jemE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733085AbfHZRc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 13:32:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733008AbfHZRcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 13:32:54 -0400
Received: from localhost.localdomain (unknown [122.178.200.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5AE021872;
        Mon, 26 Aug 2019 17:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566840773;
        bh=/bpf7xC2H//gRGlYPbogjUfpowEtufJcXobWye4Cnlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ku/zyUq//J5sP5b/Jc4aUd/6Qs8Ci3Ac9uMLwlQI2K4DUTxDW1HXebjnTDhl1RB1S
         eUX9JmFeIGQjvCqit+C980G5SLh9DnmmZ8NjkBtNT86E7B9MMdTxTSZGTDA/HYJcWt
         cI+GHVXUB/KIWGVbVy72ZT4uZAtNFgagPaiU4Q0E=
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] clk: qcom: clk-rpmh: Convert to parent data scheme
Date:   Mon, 26 Aug 2019 23:01:18 +0530
Message-Id: <20190826173120.2971-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190826173120.2971-1-vkoul@kernel.org>
References: <20190826173120.2971-1-vkoul@kernel.org>
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
index c3fd632af119..35d55aee6a01 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -95,7 +95,10 @@ static DEFINE_MUTEX(rpmh_clk_lock);
 		.hw.init = &(struct clk_init_data){			\
 			.ops = &clk_rpmh_ops,				\
 			.name = #_name,					\
-			.parent_names = (const char *[]){ "xo_board" },	\
+			.parent_data =  &(const struct clk_parent_data){ \
+					.fw_name = "xo",		\
+					.name = "xo_board",		\
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
+					.name = "xo_board",		\
+			},						\
 			.num_parents = 1,				\
 		},							\
 	}
-- 
2.20.1

