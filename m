Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A97C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18695206C3
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099835;
	bh=JO0QbtSHoY1Um2a6MXI0+F0H3TgAbnA9vxq3qMoPyDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WKXrLRrMm04MtsC1Kxm3XnU+94pXJrs7HYO3oKbbFaVXI66Ka6lGsozny/oTXz0+M
	 v1Nf1s5ZopDYEZ25Z/9ncI1dbaTE0JlKox+EHLK3VX0AWLFAa3jln4EBgURkAURpT1
	 jpzs+b03ddMcR8F8/wKPqPcx9X2po2xG5kOmAkgc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388522AbfFIRDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387428AbfFIRDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:03:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0583206C3;
        Sun,  9 Jun 2019 17:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099831;
        bh=JO0QbtSHoY1Um2a6MXI0+F0H3TgAbnA9vxq3qMoPyDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZkdK9K3X0I/GaNIjDUDDmrwTZMN16ypyp8xYAMOllPBN71XnPWH6SuOxHoAOxrjrr
         MByIWYGnBZNDNMhnwXClL9hMlscmW5MFAn1D+qo6WBuL3mgKjPXAWCBpmgXcbmhk4r
         1pbJLi34xd31rSdz11v1+ZW4GqF23/s24zDFBj4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Manning <mmanning@vyatta.att-mail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 180/241] ipv6: Consider sk_bound_dev_if when binding a raw socket to an address
Date:   Sun,  9 Jun 2019 18:42:02 +0200
Message-Id: <20190609164153.046442483@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Manning <mmanning@vyatta.att-mail.com>

[ Upstream commit 72f7cfab6f93a8ea825fab8ccfb016d064269f7f ]

IPv6 does not consider if the socket is bound to a device when binding
to an address. The result is that a socket can be bound to eth0 and
then bound to the address of eth1. If the device is a VRF, the result
is that a socket can only be bound to an address in the default VRF.

Resolve by considering the device if sk_bound_dev_if is set.

Signed-off-by: Mike Manning <mmanning@vyatta.att-mail.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Tested-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/raw.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -283,7 +283,9 @@ static int rawv6_bind(struct sock *sk, s
 			/* Binding to link-local address requires an interface */
 			if (!sk->sk_bound_dev_if)
 				goto out_unlock;
+		}
 
+		if (sk->sk_bound_dev_if) {
 			err = -ENODEV;
 			dev = dev_get_by_index_rcu(sock_net(sk),
 						   sk->sk_bound_dev_if);


