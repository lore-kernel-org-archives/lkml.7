Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C03C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D95217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553908036;
	bh=biFYfu9WpHqSG/bnvdiyGpFVUNHO9I/6b9h7+lwpex0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1QDkLD5xpjMbgGDbso16gLCF02/Z9c+zfimgbZgJu2w746PHRiu6pAeSywGMFU9Ep
	 vlrlsnx1W+Oq1No+elmzQlMZyUq3RjRinDdww+f/uMLBO+hzVHMaKlGKt/qrzXHMz5
	 WhahZ4p52Zy7WUYMBBESW711ZFAnMa+DtIPRybK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbfC3BHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:07:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730451AbfC3AxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:53:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B537218CD;
        Sat, 30 Mar 2019 00:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907203;
        bh=biFYfu9WpHqSG/bnvdiyGpFVUNHO9I/6b9h7+lwpex0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mV2bvo/sRd3yLKJpLrNGOJOcdfObd2sjniaKNFWVKzJpW1+Y3kEo50xd8AES6/3PU
         UUStHri3eN7vW4M0xKOvPm5KVoZ89PelBBt0UMcKzKttfrbz/wJxTam9478anf+nva
         ZVumnUbnMA5sTePw6NVsre2OCHd+Kel3zZLOXuc8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 14/52] i40iw: Avoid panic when handling the inetdev event
Date:   Fri, 29 Mar 2019 20:52:21 -0400
Message-Id: <20190330005301.26868-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005301.26868-1-sashal@kernel.org>
References: <20190330005301.26868-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feng Tang <feng.tang@intel.com>

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

