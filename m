Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27933C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBB320880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139675;
	bh=xX7yZGE6kVqskkMYK1bq3H5hJ4+DAlJXlMFDEUwmrHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zKBwWt3gvaGxefDDpaT2BIKZm7FwV85Ckf3MwSJWj5GMDzn0cYBuPPAYoDAIX5oXk
	 EtRLjq2Gw8fJAQjVgEplxunHkHTA+7LmtB7wpFBWyiG5eig5Scp2sFqVVK82ytE+hd
	 7+QBvjqaAZTZTmK6wVh280ji+oBbWkRcbsQ9T6DQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbfDAR1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:27:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732533AbfDAR1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:27:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 557CD20830;
        Mon,  1 Apr 2019 17:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139665;
        bh=xX7yZGE6kVqskkMYK1bq3H5hJ4+DAlJXlMFDEUwmrHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TVlkp7GIBK4JsnSjunrExxFxrJbImcpXM+rkGxzYSFdYbC/T1051VvfW9FDJPZQhG
         Zi3IP1znhoo8PJ9UwFGFKrD41VcjEkBcRfhsCXMyWXvwl0lbYZQ8LFZBWyaZ5QLZuD
         at5+PKEtspceDVphAwXhH6Ipv/qzFPo5dAkkE3fo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bhadram Varka <vbhadram@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 05/56] stmmac: copy unicast mac address to MAC registers
Date:   Mon,  1 Apr 2019 19:02:21 +0200
Message-Id: <20190401170103.806283337@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a830405ee452ddc4101c3c9334e6fedd42c6b357 ]

Currently stmmac driver not copying the valid ethernet
MAC address to MAC registers. This patch takes care
of updating the MAC register with MAC address.

Signed-off-by: Bhadram Varka <vbhadram@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2931,6 +2931,20 @@ static int stmmac_ioctl(struct net_devic
 	return ret;
 }
 
+static int stmmac_set_mac_address(struct net_device *ndev, void *addr)
+{
+	struct stmmac_priv *priv = netdev_priv(ndev);
+	int ret = 0;
+
+	ret = eth_mac_addr(ndev, addr);
+	if (ret)
+		return ret;
+
+	priv->hw->mac->set_umac_addr(priv->hw, ndev->dev_addr, 0);
+
+	return ret;
+}
+
 #ifdef CONFIG_DEBUG_FS
 static struct dentry *stmmac_fs_dir;
 
@@ -3137,7 +3151,7 @@ static const struct net_device_ops stmma
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller = stmmac_poll_controller,
 #endif
-	.ndo_set_mac_address = eth_mac_addr,
+	.ndo_set_mac_address = stmmac_set_mac_address,
 };
 
 /**


