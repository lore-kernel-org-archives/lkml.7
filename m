Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA13C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0785A207E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100711;
	bh=TCF4iOKzqxIevE/NV8uMl5PmPulEYK8lW6EYnBVeMdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1VgoCmrk/XbXcZnySpA+SSvYOvzyY634k25DKWvy4g5PijM3RRW7RzJeqfADbD8tI
	 KM2mArwmxEdbFd6UglIwFn1Wyo+RTSdmp8glvmLfHIkyGG7UHqVW8W5gz5sV66DMHm
	 mn+uQ2IcpC6sZKfuxx/QQ6T8Ukgl16AXJ9HT8S5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbfFIRSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731690AbfFIQuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:50:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DC142070B;
        Sun,  9 Jun 2019 16:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099018;
        bh=TCF4iOKzqxIevE/NV8uMl5PmPulEYK8lW6EYnBVeMdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wA1IwhbvtoMWds8Pinq1oa0zdz89UpDTog2I6VZ9uNiK0yQrkfj6yR7FLYbGW9o5C
         Wfj+thaNXANlfjr8e5593Swk/BjKo77ymv0wqUVbvcUo4mj8L+MbEsIzb96VUx/sMF
         76NaO9LBAOsb4viFbfQBNj5C9dOK7pYi8d8C+9Yo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Olivier Matz <olivier.matz@6wind.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 07/35] ipv6: fix EFAULT on sendto with icmpv6 and hdrincl
Date:   Sun,  9 Jun 2019 18:42:13 +0200
Message-Id: <20190609164125.944252126@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164125.377368385@linuxfoundation.org>
References: <20190609164125.377368385@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olivier Matz <olivier.matz@6wind.com>

[ Upstream commit b9aa52c4cb457e7416cc0c95f475e72ef4a61336 ]

The following code returns EFAULT (Bad address):

  s = socket(AF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
  setsockopt(s, SOL_IPV6, IPV6_HDRINCL, 1);
  sendto(ipv6_icmp6_packet, addr);   /* returns -1, errno = EFAULT */

The IPv4 equivalent code works. A workaround is to use IPPROTO_RAW
instead of IPPROTO_ICMPV6.

The failure happens because 2 bytes are eaten from the msghdr by
rawv6_probe_proto_opt() starting from commit 19e3c66b52ca ("ipv6
equivalent of "ipv4: Avoid reading user iov twice after
raw_probe_proto_opt""), but at that time it was not a problem because
IPV6_HDRINCL was not yet introduced.

Only eat these 2 bytes if hdrincl == 0.

Fixes: 715f504b1189 ("ipv6: add IPV6_HDRINCL option for raw sockets")
Signed-off-by: Olivier Matz <olivier.matz@6wind.com>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/raw.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -889,11 +889,14 @@ static int rawv6_sendmsg(struct sock *sk
 	opt = ipv6_fixup_options(&opt_space, opt);
 
 	fl6.flowi6_proto = proto;
-	rfv.msg = msg;
-	rfv.hlen = 0;
-	err = rawv6_probe_proto_opt(&rfv, &fl6);
-	if (err)
-		goto out;
+
+	if (!hdrincl) {
+		rfv.msg = msg;
+		rfv.hlen = 0;
+		err = rawv6_probe_proto_opt(&rfv, &fl6);
+		if (err)
+			goto out;
+	}
 
 	if (!ipv6_addr_any(daddr))
 		fl6.daddr = *daddr;


