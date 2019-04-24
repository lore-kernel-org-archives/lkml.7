Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78014C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474B2218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127914;
	bh=17UlZXxf8UUS6yaEhvezelVge69t+0V+9R1NjKVqIKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SFi6SwDYYZfbqGL3Q/cECw3lVKHuJeVQrZorSOmkZD2F4+JLvzrXxC/eqHZKuH9rJ
	 WhznbccO8D43IfVUhfLzX7vr2gqYPAZOt/r9o6yELQeRxsYNFD3elaUgaX0fMf0pTC
	 MwONPY2TP9zyMiqcHkmPhjFhQUm1GkGg+OD1F7iE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391544AbfDXRdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:33:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390909AbfDXRdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:33:37 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36A662077C;
        Wed, 24 Apr 2019 17:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127216;
        bh=17UlZXxf8UUS6yaEhvezelVge69t+0V+9R1NjKVqIKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y/590sturmXuWgz3IHf6bbBEtvLiQvP5VbwWuUA7T1fEg5aRT9D7expb6gzTWPs13
         Mtpl4AXBXY86JfellOPu4uZ9DHs88Sc5Y05Tjk6iQVDdW0eGlds37whjBjKjk9d9ey
         f1oRqRpipzBar/O+saVVnRp8XJzMKagRyTkcg/Z8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 010/115] team: set slave to promisc if team is already in promisc mode
Date:   Wed, 24 Apr 2019 19:09:06 +0200
Message-Id: <20190424170925.576011522@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
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
@@ -1247,6 +1247,23 @@ static int team_port_add(struct team *te
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
@@ -1263,6 +1280,9 @@ static int team_port_add(struct team *te
 
 	return 0;
 
+err_set_slave_promisc:
+	__team_option_inst_del_port(team, port);
+
 err_option_port_add:
 	team_upper_dev_unlink(team, port);
 
@@ -1308,6 +1328,12 @@ static int team_port_del(struct team *te
 
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


