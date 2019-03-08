Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359F2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C8120449
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050099;
	bh=mvOZzQreiLnJ7GeHZF9fHQLuL3HKA8eF6YBBOxnkAUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V7kf3JoQ5UWc4sKtE8lLmbiL2wJD3hPo7C09LnpBlAxLzpTFYLFw4goLSAZZtMpJO
	 DK6fV2LhnxFYztKdJJ9gRSxCi9VeIYpCmru2SsGO4U9+WDAMDZ7j8uUepWztt7c0Cv
	 bTT73BvD2a2geLL4TYdwHpC6Y6cZ7ZmNq+H0ob9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfCHNBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:01:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:38426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbfCHNBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:01:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4416920449;
        Fri,  8 Mar 2019 13:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552050071;
        bh=mvOZzQreiLnJ7GeHZF9fHQLuL3HKA8eF6YBBOxnkAUk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hnl9TzVBSB1kWZ8rucpqSlEdTp3gLdZqTKVG3YXcpqPTdbs3kzCZcd9yotg/NMAA6
         iumIxYyU3+iTXaJ+hWwbQ3oVLPxYBrdeWgzF9/I0N+mVADIhqmYPaJHon9TCLHgob+
         bSQ5bNig6CUa8o/9QAeu1qBpfWjs1PrHQeLdq1Qk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 45/68] ipv6: Return error for RTA_VIA attribute
Date:   Fri,  8 Mar 2019 13:50:15 +0100
Message-Id: <20190308124912.905390911@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>

[ Upstream commit e3818541b49fb88650ba339d33cc53e4095da5b3 ]

IPv6 currently does not support nexthops outside of the AF_INET6 family.
Specifically, it does not handle RTA_VIA attribute. If it is passed
in a route add request, the actual route added only uses the device
which is clearly not what the user intended:

  $ ip -6 ro add 2001:db8:2::/64 via inet 172.16.1.1 dev eth0
  $ ip ro ls
  ...
  2001:db8:2::/64 dev eth0 metric 1024 pref medium

Catch this and fail the route add:
  $ ip -6 ro add 2001:db8:2::/64 via inet 172.16.1.1 dev eth0
  Error: IPv6 does not support RTA_VIA attribute.

Fixes: 03c0566542f4c ("mpls: Netlink commands to add, remove, and dump routes")
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4213,6 +4213,10 @@ static int rtm_to_fib6_config(struct sk_
 		cfg->fc_gateway = nla_get_in6_addr(tb[RTA_GATEWAY]);
 		cfg->fc_flags |= RTF_GATEWAY;
 	}
+	if (tb[RTA_VIA]) {
+		NL_SET_ERR_MSG(extack, "IPv6 does not support RTA_VIA attribute");
+		goto errout;
+	}
 
 	if (tb[RTA_DST]) {
 		int plen = (rtm->rtm_dst_len + 7) >> 3;


