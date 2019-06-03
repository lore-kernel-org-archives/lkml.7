Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1B4C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE1327E78
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559553118;
	bh=+9FvUUl097hlFjRGGEZfiRxbpeiccsHlXb1z5QkWtc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f0V0tycwGXkZyY+0qFu0vvpUwbdy8JThFHkbIK/2Qxf03H5TUgu27PlQod1U5FKqj
	 VUb2hpNtDN3J1WWGCvTsQEIa++whMbfEyae/kkE01q7WRtdKOX+8ogtah35Rtc6X/v
	 pfRXrCq7ejEru6ozYFX6N1hAnAFgZanzH3nVSyPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfFCJL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:11:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:57256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728529AbfFCJLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:11:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BD9B27E66;
        Mon,  3 Jun 2019 09:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559553114;
        bh=+9FvUUl097hlFjRGGEZfiRxbpeiccsHlXb1z5QkWtc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xFrGuZnTZTGwAIYLVJFHGCWa/7rGuTLsmopCPaKn8lDYedTwTq/YuLqNnZ46xTuIU
         ZidrDIWgxy5yPBVQ0Qu5EZk8Y6VI/uEdEk/1oNOVpPROhRgUwSTRAhfyBstNTVgXxW
         zUjvw/Ja9OYk5jaeDWsJJXV3b4FrxZcjCQwopkcA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Manning <mmanning@vyatta.att-mail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 06/36] ipv6: Consider sk_bound_dev_if when binding a raw socket to an address
Date:   Mon,  3 Jun 2019 11:08:54 +0200
Message-Id: <20190603090521.372530333@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603090520.998342694@linuxfoundation.org>
References: <20190603090520.998342694@linuxfoundation.org>
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
@@ -287,7 +287,9 @@ static int rawv6_bind(struct sock *sk, s
 			/* Binding to link-local address requires an interface */
 			if (!sk->sk_bound_dev_if)
 				goto out_unlock;
+		}
 
+		if (sk->sk_bound_dev_if) {
 			err = -ENODEV;
 			dev = dev_get_by_index_rcu(sock_net(sk),
 						   sk->sk_bound_dev_if);


