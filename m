Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF03CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E0A21843
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887755;
	bh=QGsz8Ks1Tojt059lcycjgRGYNsiZ059yMmZcprWBtGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lfefd0jXae08QayU4Po7fs0f8s9K92iQmCigN734V3opYsCq0Sv/FlI7yDjflcxm6
	 mUiaVpLa4EnlIali8XCLiTLvfL9Kyt9pf5nGnHfIqmKfpASL6hPJVz8VcOS0EmnWqr
	 EBFgMN1ffLkaHkbUD3HArb97sc3Vbf4utSvfaHMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfK0UtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:49:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729770AbfK0UtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:49:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7B3A21787;
        Wed, 27 Nov 2019 20:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887751;
        bh=QGsz8Ks1Tojt059lcycjgRGYNsiZ059yMmZcprWBtGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wA5YYSjdsY+rGh8ls0dtLJlZJ7rejo8OuJSFWaRnSm2l2HwGo7fJgUJdAWYdnO9IM
         +CLvBcP5jAmBTsHxaGtofxt0xASPKNYEGRtspC+lSz9jfGRkLXkBtJJBnOelYa+OjG
         pUY2ExGP5RT0OEi/rXBoo+tez9FBQOjrqStpfStU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 079/211] qlcnic: fix a return in qlcnic_dcb_get_capability()
Date:   Wed, 27 Nov 2019 21:30:12 +0100
Message-Id: <20191127203101.270614373@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
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



