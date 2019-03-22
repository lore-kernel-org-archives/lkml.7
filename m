Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D225C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3E62192D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256013;
	bh=9OzScS+1kFomAvKpYJYrhhJGsxpiDwty0Yf17AYa/B0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GcfCL9SoTn/W2hZqk22stYjcbg9Q8USqhh+1Ul3JKqh1Ntj84DE7K68ErN0S64tYc
	 l3e7XAaE7ojbz6USJm78Q6nAtN4TUN47SUjUlXnhLxI7aTRFfQ00JzTvg9OfOkdQjA
	 Nrccu5J/XZHB/YBQKyMDw7hLVh2eu7uG3lcDbxwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388060AbfCVMAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732561AbfCVMAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:00:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7C33204FD;
        Fri, 22 Mar 2019 12:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256009;
        bh=9OzScS+1kFomAvKpYJYrhhJGsxpiDwty0Yf17AYa/B0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XrppdkgBsI0ZMMeVNxNC5yicnHzZXDhN0airFnbn5bZ3YKOspXTusUuB8L/SlSXYB
         9VGPrKi/86EdYRSmjTGe74F3qHnuZ998uFeHT+XEl20u2VeXW1Suxr+wGr2jVkBrzN
         UKnOPVchnKSf6oCL1uLZ1tvr8t2Ui3nrLzRi/jkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kyle Roeschley <kyle.roeschley@ni.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 063/280] i2c: cadence: Fix the hold bit setting
Date:   Fri, 22 Mar 2019 12:13:36 +0100
Message-Id: <20190322111309.817759000@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index b13605718291..d917cefc5a19 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -382,8 +382,10 @@ static void cdns_i2c_mrecv(struct cdns_i2c *id)
 	 * Check for the message size against FIFO depth and set the
 	 * 'hold bus' bit if it is greater than FIFO depth.
 	 */
-	if (id->recv_count > CDNS_I2C_FIFO_DEPTH)
+	if ((id->recv_count > CDNS_I2C_FIFO_DEPTH)  || id->bus_hold_flag)
 		ctrl_reg |= CDNS_I2C_CR_HOLD;
+	else
+		ctrl_reg = ctrl_reg & ~CDNS_I2C_CR_HOLD;
 
 	cdns_i2c_writereg(ctrl_reg, CDNS_I2C_CR_OFFSET);
 
@@ -440,8 +442,11 @@ static void cdns_i2c_msend(struct cdns_i2c *id)
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



