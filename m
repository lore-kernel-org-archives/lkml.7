Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC12C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F24321783
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142621;
	bh=2nG+f6/8R2SGBJCEGEqoz1aBXB5qp42nEOs/chALn5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o8tPUE2QIf3s1piiJP6Vf5U3EIf3mh31e3rjV/4LWyNkkmj6lldsy9cdL512XU9bD
	 K2zGlh4ZPXF9TrTzX3TDCDLYSCvmnkXghoSUcA1zU8k/eDxKJcawfeY4mNS/3rHkXr
	 f9xZOTrkdnehwuP+2a0Z/D8AiZkWHYwUJ+L2M6/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbfKSFuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:50:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:47330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731604AbfKSFuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:50:18 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B5E4218BA;
        Tue, 19 Nov 2019 05:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142617;
        bh=2nG+f6/8R2SGBJCEGEqoz1aBXB5qp42nEOs/chALn5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fFzd9k/sCqupCpgq1O9QXgw4IXhiMFtIFJlh8XXT4OWeWq4DSu5/5/UrHm0UbwvzX
         M7M0xHar942F/TofrMA6rZczy52rwGttUeIUsC5PZ76ID0mJRsvXglogH532lLdCfG
         Dw4c58RooKQJIX4NhSKv6XghtYRgG/XaLB158Oqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 143/239] RDMA/i40iw: Fix incorrect iterator type
Date:   Tue, 19 Nov 2019 06:19:03 +0100
Message-Id: <20191119051331.974668137@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Håkon Bugge <Haakon.Bugge@oracle.com>

[ Upstream commit 802fa45cd320de319e86c93bca72abec028ba059 ]

Commit f27b4746f378 ("i40iw: add connection management code") uses an
incorrect rcu iterator, whilst holding the rtnl_lock. Since the
critical region invokes i40iw_manage_qhash(), which is a sleeping
function, the rcu locking and traversal cannot be used.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/i40iw/i40iw_cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
index b7f1ce5333cb8..880c63579ba88 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -1667,7 +1667,7 @@ static enum i40iw_status_code i40iw_add_mqh_6(struct i40iw_device *iwdev,
 	unsigned long flags;
 
 	rtnl_lock();
-	for_each_netdev_rcu(&init_net, ip_dev) {
+	for_each_netdev(&init_net, ip_dev) {
 		if ((((rdma_vlan_dev_vlan_id(ip_dev) < I40IW_NO_VLAN) &&
 		      (rdma_vlan_dev_real_dev(ip_dev) == iwdev->netdev)) ||
 		     (ip_dev == iwdev->netdev)) && (ip_dev->flags & IFF_UP)) {
-- 
2.20.1



