Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A1DC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB0121D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="fY3IpwIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389115AbfKGN2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:28:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40241 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389011AbfKGN2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:28:04 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2so2263557ljg.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HndIHZhi1V4klogN/yQM3Nv6M9bfr3SYUR/xFCo/TcI=;
        b=fY3IpwIkBYFhv8/3jzUtKtmWAT1Q9ZlNH/vG/7iqg3XzSwn10wgZAaZ56Oo54gxgp0
         Lkz0GKPQHsCobBcpfjeOpxpEO0xlWOLG+mZZBnkHLLYMkEYi9xOYRGIJkrBXEoHgagq+
         poFqI7h5McobnJQaSVADJgjX5OJj/KMFq71oHu4h4DHWkjNi0/Nmfccy+jvxf7QAFyvS
         DWGBF5rQe2sEVB5tRikwGR9hoVAe17oyk3VsINjW71HVYbw0NOSzgTIckd3L/BF3GjBV
         r+IsyrCyzAsS2Ao4ev7iF+qe99YKu5UoKLrCe9SLncIbJU2/xo8px6XoddXsVRySZMCO
         F/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HndIHZhi1V4klogN/yQM3Nv6M9bfr3SYUR/xFCo/TcI=;
        b=oVJZmT9fCn6T16Bbc+gNVdZOUI+pKwWf2jaDrMHF1K1N1mp0bI+PACueaLITxcPITr
         +hoEXWRVu7e9O6zdspW5KgKX2Nje/5GKL0Ch38/oBvaUDgFm9um7JWC20QPAbXhF+oKe
         5tDU1CahhBAfYCT+QWyydXFlbrNzxq0xUhsrb84UY397nn6WwEdN5jB2D2GjDCOJTdI1
         h8jzr8yFAZP6Zw+ZTLg+21leYjLnaakCC8GxEA28UJHcp65AWgjxKiWaDRwKybRZwi94
         5yLf0/LdVsHm4tOL9JX1vfSJ3zSvWR90msYgr/mG7ojR+ul/T6zCShDCNasaGcc2+pTh
         I+bg==
X-Gm-Message-State: APjAAAXclYwJB1I2H1bFckO5dkgGapx2VWSSUhNHpv0c2060vXCMruRv
        eQc9uI3dt+IWk+0Q4JigZMoY+A==
X-Google-Smtp-Source: APXvYqwIcZxKrGTGvi5IDGwgODQQbURmwBtxesxkD+Xx2dA7gjtYFCtIPTejhpUXt25mp605s5df1g==
X-Received: by 2002:a2e:a418:: with SMTP id p24mr2231076ljn.112.1573133282659;
        Thu, 07 Nov 2019 05:28:02 -0800 (PST)
Received: from mimer.lan (h-137-65.A159.priv.bahnhof.se. [81.170.137.65])
        by smtp.gmail.com with ESMTPSA id y20sm3151507ljd.99.2019.11.07.05.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 05:28:02 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     nicolas.dichtel@6wind.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v3 3/6] rtnetlink: allow RTM_NEWLINK to act upon interfaces in arbitrary namespaces
Date:   Thu,  7 Nov 2019 14:27:52 +0100
Message-Id: <20191107132755.8517-4-jonas@norrbonn.se>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191107132755.8517-1-jonas@norrbonn.se>
References: <20191107132755.8517-1-jonas@norrbonn.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTM_NEWLINK can be used mostly interchangeably with RTM_SETLINK for
modifying device configuration.  As such, this method requires the same
logic as RTM_SETLINK for finding the device to act on.

With this patch, the IFLA_TARGET_NETNSID selects the namespace in which
to search for the interface to act upon.  This allows, for example, to
set the namespace of an interface outside the current namespace by
selecting it with the (IFLA_TARGET_NETNSID,ifi->ifi_index) pair and
specifying the namespace with one of IFLA_NET_NS_[PID|FD].

Since rtnl_newlink branches off into do_setlink, we need to provide the
same backwards compatibility check as we do for RTM_SETLINK:  if the
device is not found in the namespace given by IFLA_TARGET_NETNSID then
we search for it in the current namespace.  If found there, it's
namespace will be changed, as before.

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 net/core/rtnetlink.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index a21e7d47135b..bcfabda3fc73 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3021,6 +3021,7 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	const struct rtnl_link_ops *m_ops = NULL;
 	struct net_device *master_dev = NULL;
 	struct net *net = sock_net(skb->sk);
+	struct net *tgt_net = NULL;
 	const struct rtnl_link_ops *ops;
 	struct nlattr *tb[IFLA_MAX + 1];
 	struct net *dest_net, *link_net;
@@ -3049,6 +3050,15 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	else
 		ifname[0] = '\0';
 
+	if (tb[IFLA_TARGET_NETNSID]) {
+		s32 netnsid = nla_get_s32(tb[IFLA_TARGET_NETNSID]);
+
+		tgt_net = rtnl_get_net_ns_capable(NETLINK_CB(skb).sk, netnsid);
+		if (IS_ERR(tgt_net))
+			return PTR_ERR(tgt_net);
+		net = tgt_net;
+	}
+
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0)
 		dev = __dev_get_by_index(net, ifm->ifi_index);
@@ -3059,6 +3069,23 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			dev = NULL;
 	}
 
+	/* A hack to preserve kernel<->userspace interface.
+	 * It was previously allowed to pass the IFLA_TARGET_NETNSID
+	 * attribute as a way to _set_ the network namespace.  In this
+	 * case, the device interface was assumed to be in the  _current_
+	 * namespace.
+	 * If the device cannot be found in the target namespace then we
+	 * assume that the request is to set the device in the current
+	 * namespace and thus we attempt to find the device there.
+	 */
+	if (!dev && tgt_net) {
+		net = sock_net(skb->sk);
+		if (ifm->ifi_index > 0)
+			dev = __dev_get_by_index(net, ifm->ifi_index);
+		else if (tb[IFLA_IFNAME])
+			dev = __dev_get_by_name(net, ifname);
+	}
+
 	if (dev) {
 		master_dev = netdev_master_upper_dev_get(dev);
 		if (master_dev)
@@ -3253,6 +3280,8 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			goto out_unregister;
 	}
 out:
+	if (tgt_net)
+		put_net(tgt_net);
 	if (link_net)
 		put_net(link_net);
 	put_net(dest_net);
-- 
2.20.1

