Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2CFC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC6721744
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556624593;
	bh=H+xRyV5UgN2vbYmWEZBIrgSB5x1Nx5ys8cCfRZS4CNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ma3qlzivsJ9yliqw4wNJdhTApsQQKkW0HZa5lN5S5c+U7gBT+WCE/duAo7r0UY9az
	 gGVyDQbMFZ5O60Z3x1gZRWkGAdGGeasnlPppr1vd9hoqzL+pOUrOJp18dmmpC9mkcR
	 kwhzfDR4s3Fevh4NObzkWHDU/GGPg+1J0QaxhbEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbfD3LnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:43:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728753AbfD3LnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:43:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDD9921734;
        Tue, 30 Apr 2019 11:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624585;
        bh=H+xRyV5UgN2vbYmWEZBIrgSB5x1Nx5ys8cCfRZS4CNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXOfmBTf1fimGjhVTa0Fszq/OW/NhR7YjmsiL7A11IfWm6ayG206pC/mNxYhvehPF
         2c07WK+KS9fU9wEW8nEAxgIZTzeeSAI+QlrZaaXrS6OlXCJEhOsrdGZPbmPCkZq4zE
         OKyl+2ysK0RiPnNnExslk7WCzlHmGfqIWoDuh5JQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Pirko <jiri@mellanox.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 50/53] team: fix possible recursive locking when add slaves
Date:   Tue, 30 Apr 2019 13:38:57 +0200
Message-Id: <20190430113559.330621869@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113549.400132183@linuxfoundation.org>
References: <20190430113549.400132183@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 925b0c841e066b488cc3a60272472b2c56300704 ]

If we add a bond device which is already the master of the team interface,
we will hold the team->lock in team_add_slave() first and then request the
lock in team_set_mac_address() again. The functions are called like:

- team_add_slave()
 - team_port_add()
   - team_port_enter()
     - team_modeop_port_enter()
       - __set_port_dev_addr()
         - dev_set_mac_address()
           - bond_set_mac_address()
             - dev_set_mac_address()
  	       - team_set_mac_address

Although team_upper_dev_link() would check the upper devices but it is
called too late. Fix it by adding a checking before processing the slave.

v2: Do not split the string in netdev_err()

Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/team/team.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1157,6 +1157,12 @@ static int team_port_add(struct team *te
 		return -EINVAL;
 	}
 
+	if (netdev_has_upper_dev(dev, port_dev)) {
+		netdev_err(dev, "Device %s is already an upper device of the team interface\n",
+			   portname);
+		return -EBUSY;
+	}
+
 	if (port_dev->features & NETIF_F_VLAN_CHALLENGED &&
 	    vlan_uses_dev(dev)) {
 		netdev_err(dev, "Device %s is VLAN challenged and team device has VLAN set up\n",


