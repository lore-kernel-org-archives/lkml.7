Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03ACAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45C520657
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253940;
	bh=5IYmoyrM6EjWltPR3ddgbMfzajV/ZHvXTNXHdxdqJvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L1fis+FxTbXFSyyUfZZZLMGjwzoDOTrcigqZHMhM1bFcVjkZF3KUgJrvvi3jOm2Nl
	 AxZt3xYIhYDLaDMBSB+3fEhSwexAvPGrVTrqFh5jiBGhcJZa4wVvoLgDGpzbGK3/zP
	 8N1ayWgrR3Yedg3+XN8RZPVBlNKi2EA8BlpYP4S8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfCVLZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:25:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728957AbfCVLZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:25:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4AC120657;
        Fri, 22 Mar 2019 11:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253937;
        bh=5IYmoyrM6EjWltPR3ddgbMfzajV/ZHvXTNXHdxdqJvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R6VLXGVVxuRD5/QREcF4beQp1kgGZdeNkJt72bNYNdXn7qe26qupZGqsoO4kr3rsd
         9JWx75DyrNcTFVAgAauHH33cAnw0YJraga8NcHZ4ObGE4fdgmYPL8jgePba9FKGygc
         06QvvTD7nErTNUCEgoSp9NYFjMxrDNhdlDgvL9m8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kyle Roeschley <kyle.roeschley@ni.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 100/134] i2c: cadence: Fix the hold bit setting
Date:   Fri, 22 Mar 2019 12:15:13 +0100
Message-Id: <20190322111217.392704080@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index c604f4c3ac0d..c50a015018fe 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -320,8 +320,10 @@ static void cdns_i2c_mrecv(struct cdns_i2c *id)
 	 * Check for the message size against FIFO depth and set the
 	 * 'hold bus' bit if it is greater than FIFO depth.
 	 */
-	if (id->recv_count > CDNS_I2C_FIFO_DEPTH)
+	if ((id->recv_count > CDNS_I2C_FIFO_DEPTH)  || id->bus_hold_flag)
 		ctrl_reg |= CDNS_I2C_CR_HOLD;
+	else
+		ctrl_reg = ctrl_reg & ~CDNS_I2C_CR_HOLD;
 
 	cdns_i2c_writereg(ctrl_reg, CDNS_I2C_CR_OFFSET);
 
@@ -375,8 +377,11 @@ static void cdns_i2c_msend(struct cdns_i2c *id)
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



