Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50977C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1677A217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411028;
	bh=74no4vfZFSfXgDRRKVOO3FiXPoLSQuQ3hBLreIO/aBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i8MQYqMq59oKpLoHmh19zGK6EJKJeUK0L+LwzXWlXgcGLoICaH8SYpbUqWIpq6WI3
	 ytQDg8DgEV7D5ysP3wxrM5eWWZdLFZZFp5QxqGiqcyZLIWqj357DqD//F5s4/mHOW/
	 VFlTU+XUXLDx3fd8h2dQTGSqEpLA3MqfBE+MqvPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbfCLRRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:17:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728945AbfCLRP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:58 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00E662183F;
        Tue, 12 Mar 2019 17:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410958;
        bh=74no4vfZFSfXgDRRKVOO3FiXPoLSQuQ3hBLreIO/aBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EYlxB6Run5sKabsk/Z9qAkDDLarKl8fGrSA+vMN6ZIy4mrsMn4o4SDcVxGZ2Ps6In
         x9DDfDbuOfvIqindG9ffyv60EYonqRGt07kPlahzPVCvkYkov6XbgS3gt8LAAJw2PP
         L3JYFixUZeYcT22BUupiLF0h8xfAGjOTpxmORNTw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 028/135] ipv4: Return error for RTA_VIA attribute
Date:   Tue, 12 Mar 2019 10:07:55 -0700
Message-Id: <20190312170343.749756467@linuxfoundation.org>
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

[ Upstream commit b6e9e5df4ecf100f6a10ab2ade8e46d47a4b9779 ]

IPv4 currently does not support nexthops outside of the AF_INET family.
Specifically, it does not handle RTA_VIA attribute. If it is passed
in a route add request, the actual route added only uses the device
which is clearly not what the user intended:

  $ ip ro add 172.16.1.0/24 via inet6 2001:db8:1::1 dev eth0
  $ ip ro ls
  ...
  172.16.1.0/24 dev eth0

Catch this and fail the route add:
  $ ip ro add 172.16.1.0/24 via inet6 2001:db8:1::1 dev eth0
  Error: IPv4 does not support RTA_VIA attribute.

Fixes: 03c0566542f4c ("mpls: Netlink commands to add, remove, and dump routes")
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/fib_frontend.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -675,6 +675,10 @@ static int rtm_to_fib_config(struct net
 		case RTA_GATEWAY:
 			cfg->fc_gw = nla_get_be32(attr);
 			break;
+		case RTA_VIA:
+			NL_SET_ERR_MSG(extack, "IPv4 does not support RTA_VIA attribute");
+			err = -EINVAL;
+			goto errout;
 		case RTA_PRIORITY:
 			cfg->fc_priority = nla_get_u32(attr);
 			break;


