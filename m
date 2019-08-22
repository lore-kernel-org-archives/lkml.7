Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436AFC3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1451223405
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566493393;
	bh=G20B2Sj+t5RLI31yQu/iPrpehHHuQshNQDtv8ZsXKG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TqXtL4TP5i6WYs4bo0NwukjV9gS3xiHTR8MjE/61gLUbZoBQz125UQOmbrL0UKe8j
	 WAG0VIv/514o3F4wmm1BxEqRD9LEW+zsCcmUrdNz/TmdwSUK3RGnyrBRqEEsJbr+mZ
	 8MVvd/jWv+Sq8jKHh8F7hmAB1Ijn9z5LDlUnYxXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388630AbfHVRDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbfHVRDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:03:11 -0400
Received: from localhost.localdomain (unknown [171.61.89.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FD9E20870;
        Thu, 22 Aug 2019 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566493390;
        bh=G20B2Sj+t5RLI31yQu/iPrpehHHuQshNQDtv8ZsXKG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TjJs0ipqr4j0e1Sd+2YOe+ViVKB/HVmU+vQ7RwkFxPogKe+Pu7AwHB/2JkNNQ8MnY
         TSF7R+advtsCOTZTXNeYeFHHO9kyIAuDzMsmnftVeCNQS+WPdTLW5R6aGmD4fU6VKN
         DIx4+790TbUrJ0rPRYDotdr8ClUgtXyiEYF9pua0=
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] clk: qcom: clk-rpmh: Convert to parent data scheme
Date:   Thu, 22 Aug 2019 22:31:38 +0530
Message-Id: <20190822170140.7615-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822170140.7615-1-vkoul@kernel.org>
References: <20190822170140.7615-1-vkoul@kernel.org>
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
index c3fd632af119..0bced7326a20 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -95,7 +95,10 @@ static DEFINE_MUTEX(rpmh_clk_lock);
 		.hw.init = &(struct clk_init_data){			\
 			.ops = &clk_rpmh_ops,				\
 			.name = #_name,					\
-			.parent_names = (const char *[]){ "xo_board" },	\
+			.parent_data =  &(const struct clk_parent_data){ \
+					.fw_name = "xo_board",		\
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
+					.fw_name = "xo_board",		\
+					.name = "xo_board",		\
+			},						\
 			.num_parents = 1,				\
 		},							\
 	}
-- 
2.20.1

