Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F241CC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD901218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355481;
	bh=0fFtSvHW+spB6RaS6HOKdeMcaTfsQJUxbI4wf5vMSo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YcmbcAV7wXnfLpPrfMMqV9x6jP/umMNgpUVJppQu+L15KrkzFxJ5bR058MTxZu4Dn
	 CsP0harTYBAfYAbPfSbbZGJGkil5F0D4al4tLi7oq60Im1iThkEitsbn2QoqI2CczF
	 qDHLkHw4aRxpMmJzo7OFWDPGXIpMLlh/uYPEh5/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbfDOTLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:11:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731178AbfDOTLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:11:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38CF3218A1;
        Mon, 15 Apr 2019 19:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355472;
        bh=0fFtSvHW+spB6RaS6HOKdeMcaTfsQJUxbI4wf5vMSo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JXRkSB3pLLPR/mznlhVnE+aWfZ8coRzVF2oNKaLtp09mWX545/GsC3nWF7kn8Xfvm
         RoYzP+216wI1xtCqpaQkWDdWcSRhA9ChwtJrGVSvKSOQuL96Xl6/ikA0fq2NSK97E9
         shl8YsdGkow3Rvj1eH+iWp5E3l69x2OCucFjRTb4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, liam.mcbirnie@boeing.com,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 034/117] net: bridge: always clear mcast matching struct on reports and leaves
Date:   Mon, 15 Apr 2019 21:00:04 +0200
Message-Id: <20190415183746.730481950@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1515a63fc413f160d20574ab0894e7f1020c7be2 ]

We need to be careful and always zero the whole br_ip struct when it is
used for matching since the rhashtable change. This patch fixes all the
places which didn't properly clear it which in turn might've caused
mismatches.

Thanks for the great bug report with reproducing steps and bisection.

Steps to reproduce (from the bug report):
ip link add br0 type bridge mcast_querier 1
ip link set br0 up

ip link add v2 type veth peer name v3
ip link set v2 master br0
ip link set v2 up
ip link set v3 up
ip addr add 3.0.0.2/24 dev v3

ip netns add test
ip link add v1 type veth peer name v1 netns test
ip link set v1 master br0
ip link set v1 up
ip -n test link set v1 up
ip -n test addr add 3.0.0.1/24 dev v1

# Multicast receiver
ip netns exec test socat
UDP4-RECVFROM:5588,ip-add-membership=224.224.224.224:3.0.0.1,fork -

# Multicast sender
echo hello | nc -u -s 3.0.0.2 224.224.224.224 5588

Reported-by: liam.mcbirnie@boeing.com
Fixes: 19e3a9c90c53 ("net: bridge: convert multicast to generic rhashtable")
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_multicast.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index ac92b2eb32b1..e4777614a8a0 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -599,6 +599,7 @@ static int br_ip4_multicast_add_group(struct net_bridge *br,
 	if (ipv4_is_local_multicast(group))
 		return 0;
 
+	memset(&br_group, 0, sizeof(br_group));
 	br_group.u.ip4 = group;
 	br_group.proto = htons(ETH_P_IP);
 	br_group.vid = vid;
@@ -1489,6 +1490,7 @@ static void br_ip4_multicast_leave_group(struct net_bridge *br,
 
 	own_query = port ? &port->ip4_own_query : &br->ip4_own_query;
 
+	memset(&br_group, 0, sizeof(br_group));
 	br_group.u.ip4 = group;
 	br_group.proto = htons(ETH_P_IP);
 	br_group.vid = vid;
@@ -1512,6 +1514,7 @@ static void br_ip6_multicast_leave_group(struct net_bridge *br,
 
 	own_query = port ? &port->ip6_own_query : &br->ip6_own_query;
 
+	memset(&br_group, 0, sizeof(br_group));
 	br_group.u.ip6 = *group;
 	br_group.proto = htons(ETH_P_IPV6);
 	br_group.vid = vid;
-- 
2.19.1



