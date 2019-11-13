Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B28C17441
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F90222478
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610188;
	bh=OxXzQAr70fXBBzcLAr9eVFr6RFQbVwNx2hw2gPHvS3M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=k/wGFzmXd6IHMlfSalZfzM+RgrEePGrorJaUz+WuISwJgvKENplqUJ12mI3QI1v4X
	 wvmy5RmmYaXJ57dPBUnsq7ErNl8Gq67jBQcYyn1YMeEoFSVvs67sMjkwIe/XGxbRgu
	 1i73hOqE4yItV4ox5jmmqbeRXNqmkyUCztLEaZ80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfKMB40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:56:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:48662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbfKMB4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:56:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB4C1222D3;
        Wed, 13 Nov 2019 01:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610184;
        bh=OxXzQAr70fXBBzcLAr9eVFr6RFQbVwNx2hw2gPHvS3M=;
        h=From:To:Cc:Subject:Date:From;
        b=1Zmqm50ZsWdv73AWv/nw1ZowuQu78QEpzAt6UBnIuZoYhrjeDC0WUSzUfumfnDiPq
         zMu5r8wnhsx2yp6JLqCP4XOzimP2UpSegtcELHL/fyRz2tnxJz7lvC7rEkBlC2j8tX
         DgCVUDhDUJJ7Y6Z1qAFBmIK49BGSAbk5YKGjTYvk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        dev@openvswitch.org
Subject: [PATCH AUTOSEL 4.14 001/115] net: ovs: fix return type of ndo_start_xmit function
Date:   Tue, 12 Nov 2019 20:54:28 -0500
Message-Id: <20191113015622.11592-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit eddf11e18dff0e8671e06ce54e64cfc843303ab9 ]

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/vport-internal_dev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index b9377afeaba45..1025bed255b9b 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -44,7 +44,8 @@ static struct internal_dev *internal_dev_priv(struct net_device *netdev)
 }
 
 /* Called with rcu_read_lock_bh. */
-static int internal_dev_xmit(struct sk_buff *skb, struct net_device *netdev)
+static netdev_tx_t
+internal_dev_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
 	int len, err;
 
@@ -63,7 +64,7 @@ static int internal_dev_xmit(struct sk_buff *skb, struct net_device *netdev)
 	} else {
 		netdev->stats.tx_errors++;
 	}
-	return 0;
+	return NETDEV_TX_OK;
 }
 
 static int internal_dev_open(struct net_device *netdev)
-- 
2.20.1

