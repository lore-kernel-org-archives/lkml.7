Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08501C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B2B21D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="iAkahMtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389030AbfKGN2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:28:03 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38468 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKGN2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:28:02 -0500
Received: by mail-lj1-f196.google.com with SMTP id v8so2273750ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sEAT7kVo7CPKx1DnJ0JK5MfBj+6hH1SGj7x3FUK4ycw=;
        b=iAkahMtBJ1aPK3g6xL9DdpTFb2amemXBH6dC2mzq27rv+EFYhOZxIsmc7poGbu2Ht6
         aXqUIXMuSV4z8XqMfdM7I7S3NI3/R/yjqvnhB3cB3ULdx6zyFBOpVOr+XrlJe18YUwIW
         VSvmcYvEeqIfutBZieUR3sJ8cXJLYALMaGiI0aIkxeW4ZrHicNzUmP1pMi0u1mpbxKqy
         hwHmD9U9/cNMkX4AnmNwqtKQ7aImi/mmPXmhFJQgLKS44qe6WOHnxaQhjU2+GHcERu3O
         tCvxwzI8THN5ai8+oiYsBQwnZV20WG+zak1GNAhb81kXlR4OO4j+KrLiBMZLn004ZwO/
         AVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sEAT7kVo7CPKx1DnJ0JK5MfBj+6hH1SGj7x3FUK4ycw=;
        b=IsLcLY4Xedf0mcemJhEhsjSecchJcMIgcZ39S/5ThgK81wJjiR60U+U2NLU9XfHivM
         cMkczQ7/7r7kgyXwiqC7fxlt36pYo030j9OXGiMe2J9QKSwDtvOxhV70Ibykx9laE+Cy
         tTTwm6PSWNowmW3RmiIzndR40dKstmtj1VI01bqOPHmo4R9V6Ophy3wr8s8632QiWVrR
         /zf8V8TwVwoUJXLPSbCNAbXbzn6XuoMu2Agc6FPSoo1kU1i8tcrFueMwoHXpRnbcFu0Z
         0GpDmBG1TLx855iEnjtYJN2HE+R9uqGeb4P3eReQHFi7NIMUfDotOGilOC8YMjmiNbFN
         tiUw==
X-Gm-Message-State: APjAAAXxNKP6UgQxPN8YGWZRvM9z88Tfczr/EvZuoPrExHPxf7YXWGmn
        ITh2kZrCIuKIbkC4xpt5us+qPA==
X-Google-Smtp-Source: APXvYqy97GNG2ayJfbhFqVY8eTvdO1LYHbqMDrsX29BDieFyu3S4vkd4YaNra4zit6S5hdLrn0y4Cg==
X-Received: by 2002:a2e:505e:: with SMTP id v30mr623136ljd.244.1573133280404;
        Thu, 07 Nov 2019 05:28:00 -0800 (PST)
Received: from mimer.lan (h-137-65.A159.priv.bahnhof.se. [81.170.137.65])
        by smtp.gmail.com with ESMTPSA id y20sm3151507ljd.99.2019.11.07.05.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 05:27:59 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     nicolas.dichtel@6wind.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v3 1/6] rtnetlink: allow RTM_SETLINK to reference other namespaces
Date:   Thu,  7 Nov 2019 14:27:50 +0100
Message-Id: <20191107132755.8517-2-jonas@norrbonn.se>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191107132755.8517-1-jonas@norrbonn.se>
References: <20191107132755.8517-1-jonas@norrbonn.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Netlink currently has partial support for acting on interfaces outside
the current namespace.  This patch extends RTM_SETLINK with this
functionality.

The current implementation has an unfortunate semantic ambiguity in the
IFLA_TARGET_NETNSID attribute.  For setting the interface namespace, one
may pass the IFLA_TARGET_NETNSID attribute with the namespace to move the
interface to.  This conflicts with the meaning of this attribute for all
other methods where IFLA_TARGET_NETNSID identifies the namespace in
which to search for the interface to act upon:  the pair (namespace,
ifindex) is generally given by (IFLA_TARGET_NETNSID, ifi->ifi_index).

In order to change the namespace of an interface outside the current
namespace, we would need to specify both an IFLA_TARGET_NETNSID
attribute and a namespace to move to using IFLA_NET_NS_[PID|FD].  This is
currently now allowed as only one of these three flags may be specified.

This patch loosens the restrictions a bit but tries to maintain
compatibility with the previous behaviour:
i)  IFLA_TARGET_NETNSID may be passed together with one of
IFLA_NET_NS_[PID|FD]
ii)  IFLA_TARGET_NETNSID is primarily defined to be the namespace in
which to find the interface to act upon
iii)  In order to maintain backwards compatibility, if the device is not
found in the specified namespace, we also look for it in the current
namespace
iv)  If only IFLA_TARGET_NETNSID is given, the device is still moved to
that namespace, as before; and, as before, IFLA_NET_NS_[PID|FD] take
precedence as namespace selectors

Ideally, IFLA_TARGET_NETNSID would only ever have been used to select the
namespace of the device to act upon.  A separate flag, IFLA_NET_NS_ID
would have been made available for changing namespaces

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 net/core/rtnetlink.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index c81cd80114d9..aa3924c9813c 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2109,13 +2109,7 @@ static int rtnl_ensure_unique_netns(struct nlattr *tb[],
 		return -EOPNOTSUPP;
 	}
 
-	if (tb[IFLA_TARGET_NETNSID] && (tb[IFLA_NET_NS_PID] || tb[IFLA_NET_NS_FD]))
-		goto invalid_attr;
-
-	if (tb[IFLA_NET_NS_PID] && (tb[IFLA_TARGET_NETNSID] || tb[IFLA_NET_NS_FD]))
-		goto invalid_attr;
-
-	if (tb[IFLA_NET_NS_FD] && (tb[IFLA_TARGET_NETNSID] || tb[IFLA_NET_NS_PID]))
+	if (tb[IFLA_NET_NS_PID] && tb[IFLA_NET_NS_FD])
 		goto invalid_attr;
 
 	return 0;
@@ -2727,6 +2721,7 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
+	struct net *tgt_net = NULL;
 	struct ifinfomsg *ifm;
 	struct net_device *dev;
 	int err;
@@ -2742,6 +2737,15 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto errout;
 
+	if (tb[IFLA_TARGET_NETNSID]) {
+		s32 netnsid = nla_get_s32(tb[IFLA_TARGET_NETNSID]);
+
+		tgt_net = rtnl_get_net_ns_capable(NETLINK_CB(skb).sk, netnsid);
+		if (IS_ERR(net))
+			return PTR_ERR(net);
+		net = tgt_net;
+	}
+
 	if (tb[IFLA_IFNAME])
 		nla_strlcpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
 	else
@@ -2756,6 +2760,23 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	else
 		goto errout;
 
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
 	if (dev == NULL) {
 		err = -ENODEV;
 		goto errout;
@@ -2763,6 +2784,8 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	err = do_setlink(skb, dev, ifm, extack, tb, ifname, 0);
 errout:
+	if (tgt_net)
+		put_net(tgt_net);
 	return err;
 }
 
-- 
2.20.1

