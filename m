Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE47DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40A02196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497583;
	bh=qMniKZ600avFidGQRAxOvWNIc/Fv4rGe7VfVytJg73A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wqqcdxwa8cqp1CJyp62UtrPyDaZUhEK2D0fT/LGYoul+eTGvNrVf9ZTHfXve7iTLP
	 +0P53wXad/Vom5ctClseuByJsWj9Uol9KZmmJTPrtMfK+WRpVH/akzDWGMoDIhXT7W
	 KPXXyTys29TGW2Dlz+vnVP9nKb79h7mmlfgug1RI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfKKSjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:39:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:58766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728254AbfKKSjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:39:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C1B02196E;
        Mon, 11 Nov 2019 18:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497579;
        bh=qMniKZ600avFidGQRAxOvWNIc/Fv4rGe7VfVytJg73A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MRQnRZSlUtJGHesKKqFljNDheoXWyHT8lWM8DgPEymN3QeTwtSRp4f/DsZibuO4Qo
         M7+y7CEux/ZQGGflV66AdkVb7qY0JxKXEPTlgujBo3s+lSyFNz5k+fE3HVhArwiXQF
         QoHU2+aUBxBCBdRTlW6OpcvqoqgKp6sVBgZ0mhc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 103/105] can: flexcan: disable completely the ECC mechanism
Date:   Mon, 11 Nov 2019 19:29:13 +0100
Message-Id: <20191111181449.558889091@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181421.390326245@linuxfoundation.org>
References: <20191111181421.390326245@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joakim Zhang <qiangqing.zhang@nxp.com>

[ Upstream commit 5e269324db5adb2f5f6ec9a93a9c7b0672932b47 ]

The ECC (memory error detection and correction) mechanism can be
activated or not, controlled by the ECCDIS bit in CAN_MECR. When
disabled, updates on indications and reporting registers are stopped.
So if want to disable ECC completely, had better assert ECCDIS bit, not
just mask the related interrupts.

Fixes: cdce844865be ("can: flexcan: add vf610 support for FlexCAN")
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/flexcan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 7280f3a8aa041..84dd79041285a 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1018,6 +1018,7 @@ static int flexcan_chip_start(struct net_device *dev)
 		reg_mecr = flexcan_read(&regs->mecr);
 		reg_mecr &= ~FLEXCAN_MECR_ECRWRDIS;
 		flexcan_write(reg_mecr, &regs->mecr);
+		reg_mecr |= FLEXCAN_MECR_ECCDIS;
 		reg_mecr &= ~(FLEXCAN_MECR_NCEFAFRZ | FLEXCAN_MECR_HANCEI_MSK |
 			      FLEXCAN_MECR_FANCEI_MSK);
 		flexcan_write(reg_mecr, &regs->mecr);
-- 
2.20.1



