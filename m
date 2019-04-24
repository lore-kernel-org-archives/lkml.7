Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E30C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BF320835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126750;
	bh=5WzlTRktrRaShqcaO4SfF+sSiVO/bHHiUUPKeTTP1Qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yF2zn+2I149jmKNPTJ28JAx3vuCShE3r9o5W3zX5JzhvHcZbWeHCgbSePShvY33xo
	 vdbtbMdXxtGARvxQEtX3M1QbQEOTZvruQEf9T+TwGuocK12nLX7iJXUybe1XGwpRxb
	 /SsDKTOcAqkLN8oGkVOHhQLQYHfvreCkAvh1soXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389235AbfDXRZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389384AbfDXRZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:25:47 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B63C520835;
        Wed, 24 Apr 2019 17:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126746;
        bh=5WzlTRktrRaShqcaO4SfF+sSiVO/bHHiUUPKeTTP1Qs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C/7cxgmJ0VAeYbZMfMXJOUpl8wVlKW+0WIrwSv76Een+MtlF/i8yNhc4EUgDz7I8s
         ANrp7zGpVpKniH22F96l6IGvt5Krb9X93qzdIuQFtYZtfocCxkeDCQvePT9YjSjlyV
         jAK5/GPE2zrIAk2UNyzA7bDIAg5PRmW1/pb9twa4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 07/44] team: set slave to promisc if team is already in promisc mode
Date:   Wed, 24 Apr 2019 19:09:45 +0200
Message-Id: <20190424170845.902376125@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.924291114@linuxfoundation.org>
References: <20190424170839.924291114@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 43c2adb9df7ddd6560fd3546d925b42cef92daa0 ]

After adding a team interface to bridge, the team interface will enter
promisc mode. Then if we add a new slave to team0, the slave will keep
promisc off. Fix it by setting slave to promisc on if team master is
already in promisc mode, also do the same for allmulti.

v2: add promisc and allmulti checking when delete ports

Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/team/team.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1251,6 +1251,23 @@ static int team_port_add(struct team *te
 		goto err_option_port_add;
 	}
 
+	/* set promiscuity level to new slave */
+	if (dev->flags & IFF_PROMISC) {
+		err = dev_set_promiscuity(port_dev, 1);
+		if (err)
+			goto err_set_slave_promisc;
+	}
+
+	/* set allmulti level to new slave */
+	if (dev->flags & IFF_ALLMULTI) {
+		err = dev_set_allmulti(port_dev, 1);
+		if (err) {
+			if (dev->flags & IFF_PROMISC)
+				dev_set_promiscuity(port_dev, -1);
+			goto err_set_slave_promisc;
+		}
+	}
+
 	netif_addr_lock_bh(dev);
 	dev_uc_sync_multiple(port_dev, dev);
 	dev_mc_sync_multiple(port_dev, dev);
@@ -1267,6 +1284,9 @@ static int team_port_add(struct team *te
 
 	return 0;
 
+err_set_slave_promisc:
+	__team_option_inst_del_port(team, port);
+
 err_option_port_add:
 	team_upper_dev_unlink(team, port);
 
@@ -1312,6 +1332,12 @@ static int team_port_del(struct team *te
 
 	team_port_disable(team, port);
 	list_del_rcu(&port->list);
+
+	if (dev->flags & IFF_PROMISC)
+		dev_set_promiscuity(port_dev, -1);
+	if (dev->flags & IFF_ALLMULTI)
+		dev_set_allmulti(port_dev, -1);
+
 	team_upper_dev_unlink(team, port);
 	netdev_rx_handler_unregister(port_dev);
 	team_port_disable_netpoll(port);


