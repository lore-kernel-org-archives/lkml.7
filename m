Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885EAC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9852082E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510976;
	bh=4bB8qtrnRPBP80hwpyceHPKXuR1qkIAQivDFdyKUZ9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FMfQWqhHDaQ5oT1EF9C2d+hlMz8CA25mZtLDkjoSNReSqq7CajaqJY2mFuY3jfKpX
	 GP7iUbKGb/CkOITG53kWN53ZtK/wZT5bQJnPBNI/+ggjavqMxhRSO/haDtkIkJ150C
	 Y5Uvl9K81Umz99uvf7L/nmHx8MopTUyWige1uXzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfGSEAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:00:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729053AbfGSEAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:00:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A2AB21873;
        Fri, 19 Jul 2019 04:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508830;
        bh=4bB8qtrnRPBP80hwpyceHPKXuR1qkIAQivDFdyKUZ9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yRti8pnJ3v8NaBtXQjjuVYkhF8JD/9pfQXnGY4m6UaIKQ0sjfYOgEiRnueix2a/ez
         oPQtHCTIL1p+USf6wolwsWkyF3q8cxM7sVrSMuxpupiSaroa88b2++cyE3Bqsa3p3z
         FWeGEe9Xpy2GSsjPW14tnE0ptUTSaJ2WP3nwjmQs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Valentine Fatiev <valentinef@mellanox.com>,
        Feras Daoud <ferasda@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 113/171] IB/ipoib: Add child to parent list only if device initialized
Date:   Thu, 18 Jul 2019 23:55:44 -0400
Message-Id: <20190719035643.14300-113-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentine Fatiev <valentinef@mellanox.com>

[ Upstream commit 91b01061fef9c57d2f5b712a6322ef51061f4efd ]

Despite failure in ipoib_dev_init() we continue with initialization flow
and creation of child device. It causes to the situation where this child
device is added too early to parent device list.

Change the logic, so in case of failure we properly return error from
ipoib_dev_init() and add child only in success path.

Fixes: eaeb39842508 ("IB/ipoib: Move init code to ndo_init")
Signed-off-by: Valentine Fatiev <valentinef@mellanox.com>
Reviewed-by: Feras Daoud <ferasda@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 34 +++++++++++++----------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index 9b5e11d3fb85..bb904ec511be 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1893,12 +1893,6 @@ static void ipoib_child_init(struct net_device *ndev)
 	struct ipoib_dev_priv *priv = ipoib_priv(ndev);
 	struct ipoib_dev_priv *ppriv = ipoib_priv(priv->parent);
 
-	dev_hold(priv->parent);
-
-	down_write(&ppriv->vlan_rwsem);
-	list_add_tail(&priv->list, &ppriv->child_intfs);
-	up_write(&ppriv->vlan_rwsem);
-
 	priv->max_ib_mtu = ppriv->max_ib_mtu;
 	set_bit(IPOIB_FLAG_SUBINTERFACE, &priv->flags);
 	memcpy(priv->dev->dev_addr, ppriv->dev->dev_addr, INFINIBAND_ALEN);
@@ -1941,6 +1935,17 @@ static int ipoib_ndo_init(struct net_device *ndev)
 	if (rc) {
 		pr_warn("%s: failed to initialize device: %s port %d (ret = %d)\n",
 			priv->ca->name, priv->dev->name, priv->port, rc);
+		return rc;
+	}
+
+	if (priv->parent) {
+		struct ipoib_dev_priv *ppriv = ipoib_priv(priv->parent);
+
+		dev_hold(priv->parent);
+
+		down_write(&ppriv->vlan_rwsem);
+		list_add_tail(&priv->list, &ppriv->child_intfs);
+		up_write(&ppriv->vlan_rwsem);
 	}
 
 	return 0;
@@ -1958,6 +1963,14 @@ static void ipoib_ndo_uninit(struct net_device *dev)
 	 */
 	WARN_ON(!list_empty(&priv->child_intfs));
 
+	if (priv->parent) {
+		struct ipoib_dev_priv *ppriv = ipoib_priv(priv->parent);
+
+		down_write(&ppriv->vlan_rwsem);
+		list_del(&priv->list);
+		up_write(&ppriv->vlan_rwsem);
+	}
+
 	ipoib_neigh_hash_uninit(dev);
 
 	ipoib_ib_dev_cleanup(dev);
@@ -1969,15 +1982,8 @@ static void ipoib_ndo_uninit(struct net_device *dev)
 		priv->wq = NULL;
 	}
 
-	if (priv->parent) {
-		struct ipoib_dev_priv *ppriv = ipoib_priv(priv->parent);
-
-		down_write(&ppriv->vlan_rwsem);
-		list_del(&priv->list);
-		up_write(&ppriv->vlan_rwsem);
-
+	if (priv->parent)
 		dev_put(priv->parent);
-	}
 }
 
 static int ipoib_set_vf_link_state(struct net_device *dev, int vf, int link_state)
-- 
2.20.1

