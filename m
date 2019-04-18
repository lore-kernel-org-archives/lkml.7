Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E90AC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1166A206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610990;
	bh=K4OBAaUL1645McQUoybnngqod54ZyJTQKxaJOic90VY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JpOksg1jrds4WAilK+zDUxbaEJQ2giXHA9Tl9vxWIL8DZhwPpdWw+bnRr2ZkGUl3e
	 x1EQqcwIa+KGS2Kms5WolZ2y+fpJPVjHIR6al+etGGDQZ9/sZNU2XjssVW+KGbGBMS
	 VQ8ny3Z7Gl+O9i78GW7h4J8dOUWeukqSMypIkN6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403948AbfDRSJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:09:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391886AbfDRSJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:09:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96C4B21871;
        Thu, 18 Apr 2019 18:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610985;
        bh=K4OBAaUL1645McQUoybnngqod54ZyJTQKxaJOic90VY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gS/1JOEeZxaAjCsaBXSNXphQQUdzuse21xvOWyhS/D8A9U207bmnUUGI04wNyLhYP
         JXMdlSkHHthglbxNcOIJR5+zdkTGRMgAadF2AdX1RW+4ADypMqvOl4YElMnsQztYKU
         EBRP6TWdGISNH/2fyj0ys0mQM26l2tpF78gT1EHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 15/93] i40iw: Avoid panic when handling the inetdev event
Date:   Thu, 18 Apr 2019 19:56:53 +0200
Message-Id: <20190418160438.371064859@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ec4fe4bcc584b55e24e8d1768f5510a62c0fd619 ]

There is a panic reported that on a system with x722 ethernet, when doing
the operations like:

	# ip link add br0 type bridge
	# ip link set eno1 master br0
	# systemctl restart systemd-networkd

The system will panic "BUG: unable to handle kernel null pointer
dereference at 0000000000000034", with call chain:

	i40iw_inetaddr_event
	notifier_call_chain
	blocking_notifier_call_chain
	notifier_call_chain
	__inet_del_ifa
	inet_rtm_deladdr
	rtnetlink_rcv_msg
	netlink_rcv_skb
	rtnetlink_rcv
	netlink_unicast
	netlink_sendmsg
	sock_sendmsg
	__sys_sendto

It is caused by "local_ipaddr = ntohl(in->ifa_list->ifa_address)", while
the in->ifa_list is NULL.

So add a check for the "in->ifa_list == NULL" case, and skip the ARP
operation accordingly.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/i40iw/i40iw_utils.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_utils.c b/drivers/infiniband/hw/i40iw/i40iw_utils.c
index 59e978141ad4..e99177533930 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_utils.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_utils.c
@@ -173,7 +173,12 @@ int i40iw_inetaddr_event(struct notifier_block *notifier,
 
 		rcu_read_lock();
 		in = __in_dev_get_rcu(upper_dev);
-		local_ipaddr = ntohl(in->ifa_list->ifa_address);
+
+		if (!in->ifa_list)
+			local_ipaddr = 0;
+		else
+			local_ipaddr = ntohl(in->ifa_list->ifa_address);
+
 		rcu_read_unlock();
 	} else {
 		local_ipaddr = ntohl(ifa->ifa_address);
@@ -185,6 +190,11 @@ int i40iw_inetaddr_event(struct notifier_block *notifier,
 	case NETDEV_UP:
 		/* Fall through */
 	case NETDEV_CHANGEADDR:
+
+		/* Just skip if no need to handle ARP cache */
+		if (!local_ipaddr)
+			break;
+
 		i40iw_manage_arp_cache(iwdev,
 				       netdev->dev_addr,
 				       &local_ipaddr,
-- 
2.19.1



