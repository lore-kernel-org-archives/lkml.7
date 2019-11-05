Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A58DCA9ED9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346F7214B2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 08:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="CJVbbECj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388272AbfKEILe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 03:11:34 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40261 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388246AbfKEILc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 03:11:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id q2so14144026ljg.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 00:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7JtZli8T/5qgvjqfbtGkN60omtz/hTR9rSjR6Y0rKHM=;
        b=CJVbbECj6aGGg+hIEEbocCgkrdm3AsQikzYGksyN7i+sRa0JA1gHmPanR+8G/jHFed
         MvZZlYzB53BSiaFvsEzagYf1Zyks6Z4u+sNNfl5OvKx11lvVTHM33SfwyEdoXkyRTYqP
         XjSAgtoBmvGeYTOhVQLwXOmJ3Psj7gcnJmIJ1Cw6EaSqzn0ZLef6GAB+8KrZRPQ5mfUP
         DRXAflKYdwl3//Qvvbe15+bbr8ogA0F4zPjQFsxtNxFRSevE8+dVYuzUDXUpKIoyrrM9
         nLmqFizdZiStkfHqo4nRGDT85qI0ZNdpaGadP8TN8QT2le0ZP2ZlMMYfMFzvfZUq4R6i
         D56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7JtZli8T/5qgvjqfbtGkN60omtz/hTR9rSjR6Y0rKHM=;
        b=j+Umh0VSgHPtyjmZl43CMj6j01aI+VMIDqYKhy05v7gCtOBu+PVCB76I2VBqUS7u1c
         1ObKYeXEO4OINsAE4B/Tr1gSdbCJONmYxyXt9n6BknlynT4BB7gvy+K5LwZLEsbQv/uy
         YWVtRWvDca6CyaHHol4uRdwu/uQlcREr786Lzn0eJboJmVdJ0XmpkZEU9dRlWmiRkMl1
         FNjf1AFQ2kh5kpmtAgTOs2D5zzCTKKEMoCqFoMCYlSU94Wu5m7+8OKbdWUOv70qtu5Vy
         LQOdM72aOuy+cqPZRUXsMFVAbVDqn+NYWQ5kwuj96yw/+yYZQT8fStM8Njcp5uVZl+Ye
         mvYg==
X-Gm-Message-State: APjAAAXPEbH2S+EIzEWgWE6t9kmEb03M+IoUb+r30wRb3WPpIMcczINX
        CBWqxfACE9Vqmw/LtvAuPhOadg==
X-Google-Smtp-Source: APXvYqwz+EmUOpdm0CS5RAurWJx0lENtb4ciG3VnxkE+bHHGopgI9a7R34AyduqQQ2JtEwEUJapT0w==
X-Received: by 2002:a05:651c:10e:: with SMTP id a14mr21359869ljb.177.1572941488657;
        Tue, 05 Nov 2019 00:11:28 -0800 (PST)
Received: from mimer.lulea.netrounds.lan ([195.22.87.57])
        by smtp.gmail.com with ESMTPSA id m7sm7275986lfp.22.2019.11.05.00.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 00:11:28 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     nicolas.dichtel@6wind.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 4/5] net: ipv4: allow setting address on interface outside current namespace
Date:   Tue,  5 Nov 2019 09:11:11 +0100
Message-Id: <20191105081112.16656-5-jonas@norrbonn.se>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191105081112.16656-1-jonas@norrbonn.se>
References: <20191105081112.16656-1-jonas@norrbonn.se>
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
 net/ipv4/devinet.c | 56 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index a4b5bd4d2c89..459fb39b4a56 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -813,22 +813,17 @@ static void set_ifa_lifetime(struct in_ifaddr *ifa, __u32 valid_lft,
 		ifa->ifa_cstamp = ifa->ifa_tstamp;
 }
 
-static struct in_ifaddr *rtm_to_ifaddr(struct net *net, struct nlmsghdr *nlh,
+static struct in_ifaddr *rtm_to_ifaddr(struct nlattr* tb[],
+					struct net *net, struct nlmsghdr *nlh,
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
@@ -922,16 +917,37 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 			    struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
+	struct net *tgt_net = NULL;
 	struct in_ifaddr *ifa;
 	struct in_ifaddr *ifa_existing;
 	__u32 valid_lft = INFINITY_LIFE_TIME;
 	__u32 prefered_lft = INFINITY_LIFE_TIME;
+	struct nlattr *tb[IFA_MAX+1];
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
+		int32_t netnsid = nla_get_s32(tb[IFA_TARGET_NETNSID]);
+
+		tgt_net = rtnl_get_net_ns_capable(NETLINK_CB(skb).sk, netnsid);
+		if (IS_ERR(net)) {
+			NL_SET_ERR_MSG(extack, "ipv4: Invalid target network namespace id");
+			return PTR_ERR(net);
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
@@ -945,10 +961,11 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 			if (ret < 0) {
 				inet_free_ifa(ifa);
-				return ret;
+				err = ret;
+				goto out;
 			}
 		}
-		return __inet_insert_ifa(ifa, nlh, NETLINK_CB(skb).portid,
+		err = __inet_insert_ifa(ifa, nlh, NETLINK_CB(skb).portid,
 					 extack);
 	} else {
 		u32 new_metric = ifa->ifa_rt_priority;
@@ -956,8 +973,10 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
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
@@ -971,7 +990,14 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
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

