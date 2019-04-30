Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E4AC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2607621734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556625084;
	bh=+4WjDb9FV/4rePKrjQmde3TBFmURSqVCoxF/pRpRI/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1O0FsD1slcbZoVY5oIThIlgEiYrFpr79KeDkwK9K3RRc9cU2VCEwdrepS8Dl+kccB
	 a23sASzxXAbtfQ/ChD8vYSrDWEVX1ZbKD77HJ9u1L283XiKVU4c6PHynB27R6CVyg0
	 VErAW+/tjXuoiflMITiuLYwxPFIJIrmd4LRN37eM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbfD3LvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:51:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731367AbfD3LvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:51:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A635521670;
        Tue, 30 Apr 2019 11:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556625077;
        bh=+4WjDb9FV/4rePKrjQmde3TBFmURSqVCoxF/pRpRI/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G25+jRjrK9DNZwKScNzFCtmcZbPoJJiqv6GVLXpkR7viw8Mt4dg8MLfAG6rY1OYe8
         SpHPQmFGrXr/VtWdGpKIbyga8L5EWGqPvap9Umt35iSVh4cRn/Kdu+p6xu36N0tUzW
         uJL6bXlQJ/W4Uo+w83jHxgN9z2QVPUoG8mzdtodc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Pirko <jiri@mellanox.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 81/89] team: fix possible recursive locking when add slaves
Date:   Tue, 30 Apr 2019 13:39:12 +0200
Message-Id: <20190430113613.582316488@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113609.741196396@linuxfoundation.org>
References: <20190430113609.741196396@linuxfoundation.org>
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
 drivers/net/team/team.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1157,6 +1157,13 @@ static int team_port_add(struct team *te
 		return -EINVAL;
 	}
 
+	if (netdev_has_upper_dev(dev, port_dev)) {
+		NL_SET_ERR_MSG(extack, "Device is already an upper device of the team interface");
+		netdev_err(dev, "Device %s is already an upper device of the team interface\n",
+			   portname);
+		return -EBUSY;
+	}
+
 	if (port_dev->features & NETIF_F_VLAN_CHALLENGED &&
 	    vlan_uses_dev(dev)) {
 		NL_SET_ERR_MSG(extack, "Device is VLAN challenged and team device has VLAN set up");


