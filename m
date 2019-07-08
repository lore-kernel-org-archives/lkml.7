Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4ABC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A049216E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391381AbfGHPr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:47:59 -0400
Received: from foss.arm.com ([217.140.110.172]:52426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391358AbfGHPrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:47:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 428EDCFC;
        Mon,  8 Jul 2019 08:47:55 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3FB5A3F59C;
        Mon,  8 Jul 2019 08:47:54 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Subject: [PATCH 11/11] firmware: arm_scmi: Use asynchronous CLOCK_RATE_SET when possible
Date:   Mon,  8 Jul 2019 16:47:30 +0100
Message-Id: <20190708154730.16643-12-sudeep.holla@arm.com>
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

Keeping the current count of pending asynchronous clock set rate
requests, we can decide if we can you asynchronous request for the
incoming/new request.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index dd215bd11a58..70044b7c812e 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -56,7 +56,7 @@ struct scmi_msg_resp_clock_describe_rates {
 struct scmi_clock_set_rate {
 	__le32 flags;
 #define CLOCK_SET_ASYNC		BIT(0)
-#define CLOCK_SET_DELAYED	BIT(1)
+#define CLOCK_SET_IGNORE_RESP	BIT(1)
 #define CLOCK_SET_ROUND_UP	BIT(2)
 #define CLOCK_SET_ROUND_AUTO	BIT(3)
 	__le32 id;
@@ -67,6 +67,7 @@ struct scmi_clock_set_rate {
 struct clock_info {
 	int num_clocks;
 	int max_async_req;
+	atomic_t cur_async_req;
 	struct scmi_clock_info *clk;
 };
 
@@ -221,21 +222,35 @@ static int scmi_clock_rate_set(const struct scmi_handle *handle, u32 clk_id,
 			       u64 rate)
 {
 	int ret;
+	u32 flags = 0;
 	struct scmi_xfer *t;
 	struct scmi_clock_set_rate *cfg;
+	struct clock_info *ci = handle->clk_priv;
 
 	ret = scmi_xfer_get_init(handle, CLOCK_RATE_SET, SCMI_PROTOCOL_CLOCK,
 				 sizeof(*cfg), 0, &t);
 	if (ret)
 		return ret;
 
+	if (ci->max_async_req) {
+		if (atomic_inc_return(&ci->cur_async_req) < ci->max_async_req)
+			flags |= CLOCK_SET_ASYNC;
+		else
+			atomic_dec(&ci->cur_async_req);
+	}
+
 	cfg = t->tx.buf;
-	cfg->flags = cpu_to_le32(0);
+	cfg->flags = cpu_to_le32(flags);
 	cfg->id = cpu_to_le32(clk_id);
 	cfg->value_low = cpu_to_le32(rate & 0xffffffff);
 	cfg->value_high = cpu_to_le32(rate >> 32);
 
-	ret = scmi_do_xfer(handle, t);
+	if (flags & CLOCK_SET_ASYNC) {
+		ret = scmi_do_xfer_with_response(handle, t);
+		atomic_dec(&ci->cur_async_req);
+	} else {
+		ret = scmi_do_xfer(handle, t);
+	}
 
 	scmi_xfer_put(handle, t);
 	return ret;
-- 
2.17.1

