Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A193CC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C340214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412594;
	bh=P4jAV2tzxKuCNlEfcZtqTy9t39o28Rm8bgP/G1KAFPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qK0W9nnX/5JmL5NZ+lV7Lvn1UByZon3DsIf8lHHA9zOLgnY4/cS9sBVaY11ZX8JxO
	 EDnqV3lfEgTtpOWEkiztFXQcBhPumj2sy2Wwpre5hUdrPM4/Dw0jBHcgz4lmTsH3J6
	 M0NBA9DAE2FpG7hMPm+zQm25+JL1QVqZT0k6QJFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfCLRnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:43:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728885AbfCLRPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:49 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE43C2087C;
        Tue, 12 Mar 2019 17:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410948;
        bh=P4jAV2tzxKuCNlEfcZtqTy9t39o28Rm8bgP/G1KAFPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPN1UpESsiJKSzU4Wvx6XoCzsqC6tTUb8GiOdRKgAie8W67askkm9w5T9J4BxQ6gw
         M1j/N7dgQDmk7pRZjOB3dvGxYy+lyvzuvhO9mzU/TfkdIwzqIfbolFb1OMjb1i6qY9
         NmThm9EsLYaEfVHWZDIlIg5B99Wp/f3w/S35YJyM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 029/135] ipv6: Return error for RTA_VIA attribute
Date:   Tue, 12 Mar 2019 10:07:56 -0700
Message-Id: <20190312170343.836758372@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3024,6 +3024,10 @@ static int rtm_to_fib6_config(struct sk_
 		cfg->fc_gateway = nla_get_in6_addr(tb[RTA_GATEWAY]);
 		cfg->fc_flags |= RTF_GATEWAY;
 	}
+	if (tb[RTA_VIA]) {
+		NL_SET_ERR_MSG(extack, "IPv6 does not support RTA_VIA attribute");
+		goto errout;
+	}
 
 	if (tb[RTA_DST]) {
 		int plen = (rtm->rtm_dst_len + 7) >> 3;


