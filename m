Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E25C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE752064A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555612487;
	bh=EeKTikSizQZ/J9EcfmHYN84AY0ue2uB7f4LvH1R05a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oNHB/3/XfXDloY3FywkAiARr3AeepjFWuEoVVPnanHT2w71mAjon+1rCJvt7fkrk5
	 ManAiurK0PPXTb+7wLmAlDgUy3DLcSH4joURvHBnOtKBa6xlCXgwt/sv/cNSWwTsSz
	 hCW94ehxffMF3hPZEblpmWLDIcogjwGLGarlB7R0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390445AbfDRSeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389883AbfDRR6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:58:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55206217FA;
        Thu, 18 Apr 2019 17:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610315;
        bh=EeKTikSizQZ/J9EcfmHYN84AY0ue2uB7f4LvH1R05a0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ULGvHgyAv/YcBGcQb1AElgADa54S+tVQQUxryZO/5p6RadgSVJzZd0hKPjH9J235j
         zrBIoqIMPMTzZcDeSgqj4eZ0rZtUxFCUeQSt7k474XTe1KCLRN9yQ1BTO1Y3vI5oLg
         9lRKIy+texyDPznXnGpes8e76ekgM1LrTLtY5TM0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 014/110] i40iw: Avoid panic when handling the inetdev event
Date:   Thu, 18 Apr 2019 19:56:03 +0200
Message-Id: <20190418160438.724778159@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
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
index a9ea966877f2..dda8e79d4b27 100644
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



