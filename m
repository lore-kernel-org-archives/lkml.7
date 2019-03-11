Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6202EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304F62087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334425;
	bh=dreO4LGqw9LVj1R+omuHVNeF32gEB1t2HDUfEwG86F4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ss/0YvA1Dj8eVtDfbc7ig0aTSpEgyjIX2k2IuqrWOpxCImegcodST8gC4O1xHiM1Z
	 M4kfZP1OoJh452qTmd93p83d+uNP3grm7yTxobQ/mr+hNrQsuele/dCOGf4Ss96aCc
	 Tk97cm0bY8/JYXeUOO09qaDWiGjLTFBynZN3dFIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfCKT76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:59:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729683AbfCKT7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:59:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A08A5214D8;
        Mon, 11 Mar 2019 19:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334388;
        bh=dreO4LGqw9LVj1R+omuHVNeF32gEB1t2HDUfEwG86F4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v44Y0AoVcSCZxE7harKcDxqatG7mWnEmLh9JyeEH7fzgrIHG7Rhso5T8jPYyyZ2ly
         Dql3cGITJCRCub1ldMExkZ4Er984DRTAMfm1fIJuAZyzUHG7NlV3zzyEiI9D/nahmS
         7uAjjBupFPgsck61gaRNNkqprZ4CgvfcBhfNvgT4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 7/8] i2c: cadence: Fix the hold bit setting
Date:   Mon, 11 Mar 2019 15:59:37 -0400
Message-Id: <20190311195938.139603-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195938.139603-1-sashal@kernel.org>
References: <20190311195938.139603-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

[ Upstream commit d358def706880defa4c9e87381c5bf086a97d5f9 ]

In case the hold bit is not needed we are carrying the old values.
Fix the same by resetting the bit when not needed.

Fixes the sporadic i2c bus lockups on National Instruments
Zynq-based devices.

Fixes: df8eb5691c48 ("i2c: Add driver for Cadence I2C controller")
Reported-by: Kyle Roeschley <kyle.roeschley@ni.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Tested-by: Kyle Roeschley <kyle.roeschley@ni.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-cadence.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 84deed6571bd..6d32e6da3110 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -378,8 +378,10 @@ static void cdns_i2c_mrecv(struct cdns_i2c *id)
 	 * Check for the message size against FIFO depth and set the
 	 * 'hold bus' bit if it is greater than FIFO depth.
 	 */
-	if (id->recv_count > CDNS_I2C_FIFO_DEPTH)
+	if ((id->recv_count > CDNS_I2C_FIFO_DEPTH)  || id->bus_hold_flag)
 		ctrl_reg |= CDNS_I2C_CR_HOLD;
+	else
+		ctrl_reg = ctrl_reg & ~CDNS_I2C_CR_HOLD;
 
 	cdns_i2c_writereg(ctrl_reg, CDNS_I2C_CR_OFFSET);
 
@@ -436,8 +438,11 @@ static void cdns_i2c_msend(struct cdns_i2c *id)
 	 * Check for the message size against FIFO depth and set the
 	 * 'hold bus' bit if it is greater than FIFO depth.
 	 */
-	if (id->send_count > CDNS_I2C_FIFO_DEPTH)
+	if ((id->send_count > CDNS_I2C_FIFO_DEPTH) || id->bus_hold_flag)
 		ctrl_reg |= CDNS_I2C_CR_HOLD;
+	else
+		ctrl_reg = ctrl_reg & ~CDNS_I2C_CR_HOLD;
+
 	cdns_i2c_writereg(ctrl_reg, CDNS_I2C_CR_OFFSET);
 
 	/* Clear the interrupts in interrupt status register. */
-- 
2.19.1

