Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A21BC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534F520693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391406AbfGHPsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:48:03 -0400
Received: from foss.arm.com ([217.140.110.172]:52420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391341AbfGHPry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:47:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C12B360;
        Mon,  8 Jul 2019 08:47:54 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C750F3F59C;
        Mon,  8 Jul 2019 08:47:52 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH 10/11] firmware: arm_scmi: Drop config flag in clk_ops->rate_set
Date:   Mon,  8 Jul 2019 16:47:29 +0100
Message-Id: <20190708154730.16643-11-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190708154730.16643-1-sudeep.holla@arm.com>
References: <20190708154730.16643-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CLOCK_PROTOCOL_ATTRIBUTES provides attributes to indicate the maximum
number of pending asynchronous clock rate changes supported by the
platform. If it's non-zero, then we should be able to use asynchronous
clock rate set for any clocks until the maximum limit is reached.

In order to add that support, let's drop the config flag passed to
clk_ops->rate_set and handle the asynchronous requests dynamically.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/clk/clk-scmi.c            | 2 +-
 drivers/firmware/arm_scmi/clock.c | 4 ++--
 include/linux/scmi_protocol.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index a2287c770d5c..886f7c5df51a 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -69,7 +69,7 @@ static int scmi_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct scmi_clk *clk = to_scmi_clk(hw);
 
-	return clk->handle->clk_ops->rate_set(clk->handle, clk->id, 0, rate);
+	return clk->handle->clk_ops->rate_set(clk->handle, clk->id, rate);
 }
 
 static int scmi_clk_enable(struct clk_hw *hw)
diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 0a194af92438..dd215bd11a58 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -218,7 +218,7 @@ scmi_clock_rate_get(const struct scmi_handle *handle, u32 clk_id, u64 *value)
 }
 
 static int scmi_clock_rate_set(const struct scmi_handle *handle, u32 clk_id,
-			       u32 config, u64 rate)
+			       u64 rate)
 {
 	int ret;
 	struct scmi_xfer *t;
@@ -230,7 +230,7 @@ static int scmi_clock_rate_set(const struct scmi_handle *handle, u32 clk_id,
 		return ret;
 
 	cfg = t->tx.buf;
-	cfg->flags = cpu_to_le32(config);
+	cfg->flags = cpu_to_le32(0);
 	cfg->id = cpu_to_le32(clk_id);
 	cfg->value_low = cpu_to_le32(rate & 0xffffffff);
 	cfg->value_high = cpu_to_le32(rate >> 32);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 1be16d7730e2..1694ee1b410e 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -71,7 +71,7 @@ struct scmi_clk_ops {
 	int (*rate_get)(const struct scmi_handle *handle, u32 clk_id,
 			u64 *rate);
 	int (*rate_set)(const struct scmi_handle *handle, u32 clk_id,
-			u32 config, u64 rate);
+			u64 rate);
 	int (*enable)(const struct scmi_handle *handle, u32 clk_id);
 	int (*disable)(const struct scmi_handle *handle, u32 clk_id);
 };
-- 
2.17.1

