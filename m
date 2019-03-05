Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2104C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C704B20684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfCEBTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 20:19:54 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:28403 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726066AbfCEBTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 20:19:53 -0500
X-IronPort-AV: E=Sophos;i="5.58,441,1544457600"; 
   d="scan'208";a="55912118"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Mar 2019 09:19:50 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 8CC954C7F2B1;
        Tue,  5 Mar 2019 09:19:34 +0800 (CST)
Received: from ubuntu.g08.fujitsu.local (10.167.226.33) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 5 Mar 2019 09:19:53 +0800
From:   Su Yanjun <suyj.fnst@cn.fujitsu.com>
To:     <davem@davemloft.net>, <steffen.klassert@secunet.com>,
        <fw@strlen.de>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <suyj.fnst@cn.fujitsu.com>
Subject: [PATCH v2] net: xfrm: Add '_rcu' tag for rcu protected pointer in netns_xfrm
Date:   Mon, 4 Mar 2019 20:19:14 -0500
Message-ID: <1551748754-16895-1-git-send-email-suyj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.33]
X-yoursite-MailScanner-ID: 8CC954C7F2B1.A0A48
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For rcu protected pointers, we'd better add '__rcu' for them.

Once added '__rcu' tag for rcu protected pointer, the sparse tool reports
warnings.

net/xfrm/xfrm_user.c:1198:39: sparse:    expected struct sock *sk
net/xfrm/xfrm_user.c:1198:39: sparse:    got struct sock [noderef] <asn:4> *nlsk
[...]

So introduce a new wrapper function of nlmsg_unicast  to handle type
conversions.

No functional change.

Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
---
Changes from v1:
- fix spelling mistakes and the sparse tool' warnings

 include/net/netns/xfrm.h |  2 +-
 net/xfrm/xfrm_user.c     | 30 +++++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index 59f45b1..d2a36fb 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -57,7 +57,7 @@ struct netns_xfrm {
 	struct list_head	inexact_bins;
 
 
-	struct sock		*nlsk;
+	struct sock		__rcu *nlsk;
 	struct sock		*nlsk_stash;
 
 	u32			sysctl_aevent_etime;
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d832783..e8f23e4 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1071,6 +1071,22 @@ static inline int xfrm_nlmsg_multicast(struct net *net, struct sk_buff *skb,
 	return nlmsg_multicast(nlsk, skb, pid, group, GFP_ATOMIC);
 }
 
+/* A similar wrapper like xfrm_nlmsg_multicast checking that nlsk is still
+ * available.
+ */
+static inline int xfrm_nlmsg_unicast(struct net *net, struct sk_buff *skb,
+				     u32 pid)
+{
+	struct sock *nlsk = rcu_dereference(net->xfrm.nlsk);
+
+	if (!nlsk) {
+		kfree_skb(skb);
+		return -EPIPE;
+	}
+
+	return nlmsg_unicast(nlsk, skb, pid);
+}
+
 static inline unsigned int xfrm_spdinfo_msgsize(void)
 {
 	return NLMSG_ALIGN(4)
@@ -1195,7 +1211,7 @@ static int xfrm_get_spdinfo(struct sk_buff *skb, struct nlmsghdr *nlh,
 	err = build_spdinfo(r_skb, net, sportid, seq, *flags);
 	BUG_ON(err < 0);
 
-	return nlmsg_unicast(net->xfrm.nlsk, r_skb, sportid);
+	return xfrm_nlmsg_unicast(net, r_skb, sportid);
 }
 
 static inline unsigned int xfrm_sadinfo_msgsize(void)
@@ -1254,7 +1270,7 @@ static int xfrm_get_sadinfo(struct sk_buff *skb, struct nlmsghdr *nlh,
 	err = build_sadinfo(r_skb, net, sportid, seq, *flags);
 	BUG_ON(err < 0);
 
-	return nlmsg_unicast(net->xfrm.nlsk, r_skb, sportid);
+	return xfrm_nlmsg_unicast(net, r_skb, sportid);
 }
 
 static int xfrm_get_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -1274,7 +1290,7 @@ static int xfrm_get_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (IS_ERR(resp_skb)) {
 		err = PTR_ERR(resp_skb);
 	} else {
-		err = nlmsg_unicast(net->xfrm.nlsk, resp_skb, NETLINK_CB(skb).portid);
+		err = xfrm_nlmsg_unicast(net, resp_skb, NETLINK_CB(skb).portid);
 	}
 	xfrm_state_put(x);
 out_noput:
@@ -1337,7 +1353,7 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto out;
 	}
 
-	err = nlmsg_unicast(net->xfrm.nlsk, resp_skb, NETLINK_CB(skb).portid);
+	err = xfrm_nlmsg_unicast(net, resp_skb, NETLINK_CB(skb).portid);
 
 out:
 	xfrm_state_put(x);
@@ -1903,8 +1919,8 @@ static int xfrm_get_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 		if (IS_ERR(resp_skb)) {
 			err = PTR_ERR(resp_skb);
 		} else {
-			err = nlmsg_unicast(net->xfrm.nlsk, resp_skb,
-					    NETLINK_CB(skb).portid);
+			err = xfrm_nlmsg_unicast(net, resp_skb,
+						 NETLINK_CB(skb).portid);
 		}
 	} else {
 		xfrm_audit_policy_delete(xp, err ? 0 : 1, true);
@@ -2062,7 +2078,7 @@ static int xfrm_get_ae(struct sk_buff *skb, struct nlmsghdr *nlh,
 	err = build_aevent(r_skb, x, &c);
 	BUG_ON(err < 0);
 
-	err = nlmsg_unicast(net->xfrm.nlsk, r_skb, NETLINK_CB(skb).portid);
+	err = xfrm_nlmsg_unicast(net, r_skb, NETLINK_CB(skb).portid);
 	spin_unlock_bh(&x->lock);
 	xfrm_state_put(x);
 	return err;
-- 
2.7.4



