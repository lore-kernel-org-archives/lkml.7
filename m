Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9305C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF46420856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 10:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732050AbfETKrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 06:47:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:55356 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730588AbfETKri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 06:47:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD1E1AFD3;
        Mon, 20 May 2019 10:47:36 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        sboyd@kernel.org, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 2/5] clk: bcm2835: set pllb_arm divisor as readonly
Date:   Mon, 20 May 2019 12:47:04 +0200
Message-Id: <20190520104708.11980-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520104708.11980-1-nsaenzjulienne@suse.de>
References: <20190520104708.11980-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This divisor is controlled by the firmware, we don't want the clock
subsystem to update it inadvertently.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/clk/bcm/clk-bcm2835.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index c2772dfb155a..5aea110672f3 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -465,6 +465,7 @@ struct bcm2835_pll_divider_data {
 	u32 hold_mask;
 	u32 fixed_divider;
 	u32 flags;
+	u32 div_flags;
 };
 
 struct bcm2835_clock_data {
@@ -1349,7 +1350,7 @@ bcm2835_register_pll_divider(struct bcm2835_cprman *cprman,
 	divider->div.reg = cprman->regs + data->a2w_reg;
 	divider->div.shift = A2W_PLL_DIV_SHIFT;
 	divider->div.width = A2W_PLL_DIV_BITS;
-	divider->div.flags = CLK_DIVIDER_MAX_AT_ZERO;
+	divider->div.flags = data->div_flags | CLK_DIVIDER_MAX_AT_ZERO;
 	divider->div.lock = &cprman->regs_lock;
 	divider->div.hw.init = &init;
 	divider->div.table = NULL;
@@ -1676,7 +1677,8 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.load_mask = CM_PLLB_LOADARM,
 		.hold_mask = CM_PLLB_HOLDARM,
 		.fixed_divider = 1,
-		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE),
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+		.div_flags = CLK_DIVIDER_READ_ONLY),
 
 	/*
 	 * PLLC is the core PLL, used to drive the core VPU clock.
-- 
2.21.0

