Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2677C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734152187F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="yTnr9Gzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389076AbfKGN2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:28:07 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41663 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389036AbfKGN2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:28:06 -0500
Received: by mail-lj1-f196.google.com with SMTP id m9so2256364ljh.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 05:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=40B2Zn2Vh8quTHaXoUrYBWwbsEUJYUqvqRevZ1/Cbtg=;
        b=yTnr9GzwAmtrT3FypoDLtM77E5ZGvMIEGEA4pDCzlAb2QCnz7SvFAf6i8/kPX6DXkA
         v5WoApRqKL/LKbicI6Dtuq7cHcZWii1Gj6hPHQv67fUeYyaEixQKlUnB1SsP/mVU2t/R
         hubAcvty8aPMeCwQOU0roAwhRqJX6hehAWK6ZoV04ku6O1rz6DqjozHy+TkZvbLaz9bM
         sRTKxGNZBjqDY8wWGu9SEEHN6UCm6fTj4pSoiRjrgD6MpmOpfXduUh3NGzekVs+p+MLg
         yg8GnJ6KJIonIE9stMp8KTpnYSGMPJOI8z0AWuIfm3SsJuVtLofsq78JGVIu3phYIKqy
         GHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=40B2Zn2Vh8quTHaXoUrYBWwbsEUJYUqvqRevZ1/Cbtg=;
        b=OphK6OiNuJkFJhl+OKf+oa+sZf+ceEFYy3ivAa35OpPV/PVlKjKPuHc04/JdyeMivb
         CBlBcd2KsUbT3SBk1QTkpLuhKyyeCNsbN0K89hGbK7YQMBT30Doned/7Xm/0CmbZ1E4+
         zMNHgwyGieBrLEV51nr2hh204anP9R4ng3ZKwX6tijBL+Ct3zibWQLlij21hE73JR+P0
         H1BrPL0YCQaIWfOu8C/92DWvKZDwt/OxsrxjvsTBFKiyaQiB0pgWdgunoiwjiY4lZc5Z
         v32xPQdHLrzPK4wj9X6wHyvK2tqLvFrIYbMjqpokFOFnUmCvn7qiURBy+O8/PxGGCljj
         Ea+g==
X-Gm-Message-State: APjAAAXAX1QSGeuK2piC2YUb5RfkYf8Y0bUW4WLlY+Z2zRhboPGX2LJj
        8XUHZxgJc211WV+XfWv4kmbrn+EewmA=
X-Google-Smtp-Source: APXvYqxptWQiJ6c22NPMOCLPEfahYPLDjhRJVXNYrDQr7bhMA6GXv0HYeEv2xfXyPfWv8U6IxF6dAw==
X-Received: by 2002:a2e:22c1:: with SMTP id i184mr2542820lji.1.1573133283717;
        Thu, 07 Nov 2019 05:28:03 -0800 (PST)
Received: from mimer.lan (h-137-65.A159.priv.bahnhof.se. [81.170.137.65])
        by smtp.gmail.com with ESMTPSA id y20sm3151507ljd.99.2019.11.07.05.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 05:28:03 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     nicolas.dichtel@6wind.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH v3 4/6] net: ipv4: allow setting address on interface outside current namespace
Date:   Thu,  7 Nov 2019 14:27:53 +0100
Message-Id: <20191107132755.8517-5-jonas@norrbonn.se>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191107132755.8517-1-jonas@norrbonn.se>
References: <20191107132755.8517-1-jonas@norrbonn.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows an interface outside of the current namespace to be
selected when setting a new IPv4 address for a device.  This uses the
IFA_TARGET_NETNSID attribute to select the namespace in which to search
for the interface to act upon.

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
---
 net/ipv4/devinet.c | 61 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index a4b5bd4d2c89..eecd1b0bb7d2 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -813,22 +813,17 @@ static void set_ifa_lifetime(struct in_ifaddr *ifa, __u32 valid_lft,
 		ifa->ifa_cstamp = ifa->ifa_tstamp;
 }
 
-static struct in_ifaddr *rtm_to_ifaddr(struct net *net, struct nlmsghdr *nlh,
+static struct in_ifaddr *rtm_to_ifaddr(struct nlattr *tb[],
+				       struct net *net, struct nlmsghdr *nlh,
 				       __u32 *pvalid_lft, __u32 *pprefered_lft,
 				       struct netlink_ext_ack *extack)
 {
-	struct nlattr *tb[IFA_MAX+1];
 	struct in_ifaddr *ifa;
 	struct ifaddrmsg *ifm;
 	struct net_device *dev;
 	struct in_device *in_dev;
 	int err;
 
-	err = nlmsg_parse_deprecated(nlh, sizeof(*ifm), tb, IFA_MAX,
-				     ifa_ipv4_policy, extack);
-	if (err < 0)
-		goto errout;
-
 	ifm = nlmsg_data(nlh);
 	err = -EINVAL;
 	if (ifm->ifa_prefixlen > 32 || !tb[IFA_LOCAL])
@@ -922,16 +917,38 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 			    struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
+	struct net *tgt_net = NULL;
 	struct in_ifaddr *ifa;
 	struct in_ifaddr *ifa_existing;
 	__u32 valid_lft = INFINITY_LIFE_TIME;
 	__u32 prefered_lft = INFINITY_LIFE_TIME;
+	struct nlattr *tb[IFA_MAX + 1];
+	int err;
 
 	ASSERT_RTNL();
 
-	ifa = rtm_to_ifaddr(net, nlh, &valid_lft, &prefered_lft, extack);
-	if (IS_ERR(ifa))
-		return PTR_ERR(ifa);
+	err = nlmsg_parse_deprecated(nlh, sizeof(struct ifaddrmsg), tb, IFA_MAX,
+				     ifa_ipv4_policy, extack);
+	if (err < 0)
+		return err;
+
+	if (tb[IFA_TARGET_NETNSID]) {
+		s32 netnsid = nla_get_s32(tb[IFA_TARGET_NETNSID]);
+
+		tgt_net = rtnl_get_net_ns_capable(NETLINK_CB(skb).sk, netnsid);
+		if (IS_ERR(tgt_net)) {
+			NL_SET_ERR_MSG(extack,
+				"ipv4: Invalid target network namespace id");
+			return PTR_ERR(tgt_net);
+		}
+		net = tgt_net;
+	}
+
+	ifa = rtm_to_ifaddr(tb, net, nlh, &valid_lft, &prefered_lft, extack);
+	if (IS_ERR(ifa)) {
+		err = PTR_ERR(ifa);
+		goto out;
+	}
 
 	ifa_existing = find_matching_ifa(ifa);
 	if (!ifa_existing) {
@@ -945,19 +962,24 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 			if (ret < 0) {
 				inet_free_ifa(ifa);
-				return ret;
+				err = ret;
+				goto out;
 			}
 		}
-		return __inet_insert_ifa(ifa, nlh, NETLINK_CB(skb).portid,
-					 extack);
+		err = __inet_insert_ifa(ifa, nlh, NETLINK_CB(skb).portid,
+					extack);
+		if (err < 0)
+			goto out;
 	} else {
 		u32 new_metric = ifa->ifa_rt_priority;
 
 		inet_free_ifa(ifa);
 
 		if (nlh->nlmsg_flags & NLM_F_EXCL ||
-		    !(nlh->nlmsg_flags & NLM_F_REPLACE))
-			return -EEXIST;
+		    !(nlh->nlmsg_flags & NLM_F_REPLACE)) {
+			err = -EEXIST;
+			goto out;
+		}
 		ifa = ifa_existing;
 
 		if (ifa->ifa_rt_priority != new_metric) {
@@ -971,7 +993,14 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 				&check_lifetime_work, 0);
 		rtmsg_ifa(RTM_NEWADDR, ifa, nlh, NETLINK_CB(skb).portid);
 	}
-	return 0;
+
+	err = 0;
+
+out:
+	if (tgt_net)
+		put_net(tgt_net);
+
+	return err;
 }
 
 /*
-- 
2.20.1

