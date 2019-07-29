Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5825FC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 02:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB402075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 02:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfG2Cvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 22:51:42 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:15989 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725681AbfG2Cvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 22:51:42 -0400
X-IronPort-AV: E=Sophos;i="5.64,320,1559491200"; 
   d="scan'208";a="72407009"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Jul 2019 10:51:40 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id DFA3A4B4041E;
        Mon, 29 Jul 2019 10:51:40 +0800 (CST)
Received: from localhost.localdomain (10.167.226.33) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 29 Jul 2019 10:51:44 +0800
From:   Su Yanjun <suyj.fnst@cn.fujitsu.com>
To:     <davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>,
        <yoshfuji@linux-ipv6.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <suyj.fnst@cn.fujitsu.com>
Subject: [PATCH net] net: ipv6: Fix a bug in ndisc_send_ns when netdev only has a global address
Date:   Mon, 29 Jul 2019 10:49:51 +0800
Message-ID: <1564368591-42301-1-git-send-email-suyj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.33]
X-yoursite-MailScanner-ID: DFA3A4B4041E.AF2A4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we send mpls packets and the interface only has a
manual global ipv6 address, then the two hosts cant communicate.
I find that in ndisc_send_ns it only tries to get a ll address.
In my case, the executive path is as below.
ip6_output
 ->ip6_finish_output
  ->lwtunnel_xmit
   ->mpls_xmit
    ->neigh_resolve_output
     ->neigh_probe
      ->ndisc_solicit
       ->ndisc_send_ns

In RFC4861, 7.2.2 says
"If the source address of the packet prompting the solicitation is the
same as one of the addresses assigned to the outgoing interface, that
address SHOULD be placed in the IP Source Address of the outgoing
solicitation.  Otherwise, any one of the addresses assigned to the
interface should be used."

In this patch we try get a global address if we get ll address failed.

Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
---
 include/net/addrconf.h |  4 ++++
 net/ipv6/addrconf.c    | 34 ++++++++++++++++++++++++++++++++++
 net/ipv6/ndisc.c       |  8 ++++++--
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index becdad5..006db8e 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -107,6 +107,10 @@ int __ipv6_get_lladdr(struct inet6_dev *idev, struct in6_addr *addr,
 		      u32 banned_flags);
 int ipv6_get_lladdr(struct net_device *dev, struct in6_addr *addr,
 		    u32 banned_flags);
+int __ipv6_get_addr(struct inet6_dev *idev, struct in6_addr *addr,
+		      u32 banned_flags);
+int ipv6_get_addr(struct net_device *dev, struct in6_addr *addr,
+		    u32 banned_flags);
 bool inet_rcv_saddr_equal(const struct sock *sk, const struct sock *sk2,
 			  bool match_wildcard);
 bool inet_rcv_saddr_any(const struct sock *sk);
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 521e320..4c0a43f 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1870,6 +1870,40 @@ int ipv6_get_lladdr(struct net_device *dev, struct in6_addr *addr,
 	return err;
 }
 
+int __ipv6_get_addr(struct inet6_dev *idev, struct in6_addr *addr,
+		    u32 banned_flags)
+{
+	struct inet6_ifaddr *ifp;
+	int err = -EADDRNOTAVAIL;
+
+	list_for_each_entry_reverse(ifp, &idev->addr_list, if_list) {
+		if (ifp->scope == 0 &&
+		    !(ifp->flags & banned_flags)) {
+			*addr = ifp->addr;
+			err = 0;
+			break;
+		}
+	}
+	return err;
+}
+
+int ipv6_get_addr(struct net_device *dev, struct in6_addr *addr,
+		  u32 banned_flags)
+{
+	struct inet6_dev *idev;
+	int err = -EADDRNOTAVAIL;
+
+	rcu_read_lock();
+	idev = __in6_dev_get(dev);
+	if (idev) {
+		read_lock_bh(&idev->lock);
+		err = __ipv6_get_addr(idev, addr, banned_flags);
+		read_unlock_bh(&idev->lock);
+	}
+	rcu_read_unlock();
+	return err;
+}
+
 static int ipv6_count_addresses(const struct inet6_dev *idev)
 {
 	const struct inet6_ifaddr *ifp;
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 083cc1c..18ac2fb 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -606,8 +606,12 @@ void ndisc_send_ns(struct net_device *dev, const struct in6_addr *solicit,
 
 	if (!saddr) {
 		if (ipv6_get_lladdr(dev, &addr_buf,
-				   (IFA_F_TENTATIVE|IFA_F_OPTIMISTIC)))
-			return;
+				   (IFA_F_TENTATIVE | IFA_F_OPTIMISTIC))) {
+			/* try global address */
+			if (ipv6_get_addr(dev, &addr_buf,
+					  (IFA_F_TENTATIVE | IFA_F_OPTIMISTIC)))
+				return;
+		}
 		saddr = &addr_buf;
 	}
 
-- 
2.7.4



