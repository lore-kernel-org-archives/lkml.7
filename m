Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC28C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B56020651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356264;
	bh=eEUlxKqf14zB/d+w3+bpwIum4KqZ7JtGZiNuL2rHqQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dUryat0kP+eee21iwi0VwqcSwpE3IMYvClJsc+NNfnCdXeKa9/KOTdN0ugObzye5q
	 3vM3g+CphPQPxNOpkg54RiHQ0bYv1pg1oUoeq3zChzZfFjYEL0NcCfbMEKqoV1hcUL
	 qEL14QmwpGLFwrKXfasi+SKFmfldF8UKGoDTHOKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbfDOTG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729886AbfDOTGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:06:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF1F1218A1;
        Mon, 15 Apr 2019 19:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355177;
        bh=eEUlxKqf14zB/d+w3+bpwIum4KqZ7JtGZiNuL2rHqQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a36L74ovLljYxiS//QguAmL6sRJDNkPi9kzsUyCgmbXTKlUwlID7PW85Q906+1O2+
         FSijywLPPYaOfkTvucpB7VTLfoujYEbzBcTY3HfQCSrwk+nojzHpbGmdOpiojiZiY+
         b72CC9b592L0mDpum5FNP4d2+0izC06EzO+g/Bd4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Zubin Mithra <zsm@chromium.org>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.19 042/101] netfilter: nfnetlink_cttimeout: pass default timeout policy to obj_to_nlattr
Date:   Mon, 15 Apr 2019 20:58:40 +0200
Message-Id: <20190415183742.687800187@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 8866df9264a34e675b4ee8a151db819b87cce2d3 upstream

Otherwise, we hit a NULL pointer deference since handlers always assume
default timeout policy is passed.

  netlink: 24 bytes leftover after parsing attributes in process `syz-executor2'.
  kasan: CONFIG_KASAN_INLINE enabled
  kasan: GPF could be caused by NULL-ptr deref or user memory access
  general protection fault: 0000 [#1] PREEMPT SMP KASAN
  CPU: 0 PID: 9575 Comm: syz-executor1 Not tainted 4.19.0+ #312
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
  RIP: 0010:icmp_timeout_obj_to_nlattr+0x77/0x170 net/netfilter/nf_conntrack_proto_icmp.c:297

Fixes: c779e849608a ("netfilter: conntrack: remove get_timeout() indirection")
Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Zubin Mithra <zsm@chromium.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 net/netfilter/nfnetlink_cttimeout.c | 46 +++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
index a30f8ba4b89a..1dc4ea327cbe 100644
--- a/net/netfilter/nfnetlink_cttimeout.c
+++ b/net/netfilter/nfnetlink_cttimeout.c
@@ -392,7 +392,8 @@ err:
 static int
 cttimeout_default_fill_info(struct net *net, struct sk_buff *skb, u32 portid,
 			    u32 seq, u32 type, int event,
-			    const struct nf_conntrack_l4proto *l4proto)
+			    const struct nf_conntrack_l4proto *l4proto,
+			    const unsigned int *timeouts)
 {
 	struct nlmsghdr *nlh;
 	struct nfgenmsg *nfmsg;
@@ -421,7 +422,7 @@ cttimeout_default_fill_info(struct net *net, struct sk_buff *skb, u32 portid,
 		if (!nest_parms)
 			goto nla_put_failure;
 
-		ret = l4proto->ctnl_timeout.obj_to_nlattr(skb, NULL);
+		ret = l4proto->ctnl_timeout.obj_to_nlattr(skb, timeouts);
 		if (ret < 0)
 			goto nla_put_failure;
 
@@ -444,6 +445,7 @@ static int cttimeout_default_get(struct net *net, struct sock *ctnl,
 				 struct netlink_ext_ack *extack)
 {
 	const struct nf_conntrack_l4proto *l4proto;
+	unsigned int *timeouts = NULL;
 	struct sk_buff *skb2;
 	int ret, err;
 	__u16 l3num;
@@ -456,12 +458,44 @@ static int cttimeout_default_get(struct net *net, struct sock *ctnl,
 	l4num = nla_get_u8(cda[CTA_TIMEOUT_L4PROTO]);
 	l4proto = nf_ct_l4proto_find_get(l3num, l4num);
 
-	/* This protocol is not supported, skip. */
-	if (l4proto->l4proto != l4num) {
-		err = -EOPNOTSUPP;
+	err = -EOPNOTSUPP;
+	if (l4proto->l4proto != l4num)
 		goto err;
+
+	switch (l4proto->l4proto) {
+	case IPPROTO_ICMP:
+		timeouts = &net->ct.nf_ct_proto.icmp.timeout;
+		break;
+	case IPPROTO_TCP:
+		timeouts = net->ct.nf_ct_proto.tcp.timeouts;
+		break;
+	case IPPROTO_UDP:
+		timeouts = net->ct.nf_ct_proto.udp.timeouts;
+		break;
+	case IPPROTO_DCCP:
+#ifdef CONFIG_NF_CT_PROTO_DCCP
+		timeouts = net->ct.nf_ct_proto.dccp.dccp_timeout;
+#endif
+		break;
+	case IPPROTO_ICMPV6:
+		timeouts = &net->ct.nf_ct_proto.icmpv6.timeout;
+		break;
+	case IPPROTO_SCTP:
+#ifdef CONFIG_NF_CT_PROTO_SCTP
+		timeouts = net->ct.nf_ct_proto.sctp.timeouts;
+#endif
+		break;
+	case 255:
+		timeouts = &net->ct.nf_ct_proto.generic.timeout;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		break;
 	}
 
+	if (!timeouts)
+		goto err;
+
 	skb2 = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (skb2 == NULL) {
 		err = -ENOMEM;
@@ -472,7 +506,7 @@ static int cttimeout_default_get(struct net *net, struct sock *ctnl,
 					  nlh->nlmsg_seq,
 					  NFNL_MSG_TYPE(nlh->nlmsg_type),
 					  IPCTNL_MSG_TIMEOUT_DEFAULT_SET,
-					  l4proto);
+					  l4proto, timeouts);
 	if (ret <= 0) {
 		kfree_skb(skb2);
 		err = -ENOMEM;
-- 
2.19.1



