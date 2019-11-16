Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B76EC43215
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DC720B7C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921314;
	bh=QGsz8Ks1Tojt059lcycjgRGYNsiZ059yMmZcprWBtGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ht1oZymuz/p+C7KW5fUvHBGkljqOdD067+FobIX4xH2g+J6zuGxIr4pDXN+4MPmb1
	 +fPxolYj3cKtjVaP/mBVgFzlk5GLSy+dyYSlqNE27XT5Mm1UcO1u3CZ0yR8YGRS8qz
	 hvw87IrGsjpyqS2SKjEM8jNXfb/DoqhZ971WnqPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfKPPn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:43:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:47372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728702AbfKPPnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:43:23 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 253FE20833;
        Sat, 16 Nov 2019 15:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919003;
        bh=QGsz8Ks1Tojt059lcycjgRGYNsiZ059yMmZcprWBtGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZoCLRx8n4/uUk8vPx22f7HT00O15SdXJ/xrAN+84EoiLUMY0x5ihjCjLUhSV+0QdS
         HBG+0gANwbdSMB5tZ4AUsQaptb+OW/de2wKNDElvbSTqsxN1KcsBKcgzWTt9/OOsiI
         sV4zmvZTHqoQKSPvwAClUTEfmZFfXajaQJBbZHNc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 107/237] qlcnic: fix a return in qlcnic_dcb_get_capability()
Date:   Sat, 16 Nov 2019 10:39:02 -0500
Message-Id: <20191116154113.7417-107-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 4b76c69fe86d2..834208e55f7b8 100644
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

