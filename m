Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB014C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FE421582
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574886969;
	bh=ZZNklmPefQ3KLoghL8Ew6T8cRfOw/TBoReMABM988cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y4Tq1haKPEXxZToN/PNfrjHzSMHZtWdr6zH7Av3+HUCYeKVwGyrDMAKzw6i0s8nRq
	 oC9qKHE1e/FlL/AKC8Oi6KUatHMgjj4QsXm6B4FJ37Gk7iZ+EKSb942DFiG8hx2WPv
	 w7eBJSJt6WRQM2cN3gDyIAkupXst5whuK5LwxwhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfK0UgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:36:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:37488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727969AbfK0Ufx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:35:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A458E207DD;
        Wed, 27 Nov 2019 20:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574886953;
        bh=ZZNklmPefQ3KLoghL8Ew6T8cRfOw/TBoReMABM988cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n0ke7hqf14NCEqJc9OO5tDBls6DHiTlq7wK+5lQ3pirxtc5snbERVnXj2ab1ow5mP
         3zELh/7Pn+rU8aQOsycLfMdkGpfjIADAxJyEdMT/yGI2V9Nal33pHLdoDX4AryYWWF
         /Vfcj6cs2AevadbnkEppmm84xUinNOZ4vg5XKUBo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 055/132] qlcnic: fix a return in qlcnic_dcb_get_capability()
Date:   Wed, 27 Nov 2019 21:30:46 +0100
Message-Id: <20191127202955.641786739@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202857.270233486@linuxfoundation.org>
References: <20191127202857.270233486@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit c94f026fb742b2d3199422751dbc4f6fc0e753d8 ]

These functions are supposed to return one on failure and zero on
success.  Returning a zero here could cause uninitialized variable
bugs in several of the callers.  For example:

    drivers/scsi/cxgbi/cxgb4i/cxgb4i.c:1660 get_iscsi_dcb_priority()
    error: uninitialized symbol 'caps'.

Fixes: 48365e485275 ("qlcnic: dcb: Add support for CEE Netlink interface.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_dcb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_dcb.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_dcb.c
index a72bcddf160ac..178e7236eeb51 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_dcb.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_dcb.c
@@ -883,7 +883,7 @@ static u8 qlcnic_dcb_get_capability(struct net_device *netdev, int capid,
 	struct qlcnic_adapter *adapter = netdev_priv(netdev);
 
 	if (!test_bit(QLCNIC_DCB_STATE, &adapter->dcb->state))
-		return 0;
+		return 1;
 
 	switch (capid) {
 	case DCB_CAP_ATTR_PG:
-- 
2.20.1



