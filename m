Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39474C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059DF27ED9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559553314;
	bh=+7d4OCibSL/vzG2h8deYlW9pebm6+EQ9i6cAAH/QxyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=njlCy0Atw1PRwF5Ntc6FljH8ylNPbITz94PViiMMyQMt5OFAFxJ4Dh3102E7seIZg
	 AiKNXMPNxk1PIz/b1JnzcaTUijOb78LMAIr5cD1HX2joW9mpSwIXQnevaar4eKK+zy
	 bnJbxH1vw5LkPkRrw0SFjeSaVerwC8TJPd0bVGGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfFCJPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbfFCJOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:14:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C360C27ED3;
        Mon,  3 Jun 2019 09:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559553245;
        bh=+7d4OCibSL/vzG2h8deYlW9pebm6+EQ9i6cAAH/QxyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ip3CM3h3gbeNVthD3eLRFU3M61XPJvGdthTyBOP7SFkJVZS/6qlQd6gz7ja3D/p1F
         QGu9d4fyPTL8d6+vRo/j4/UUNdbOY6paEL3AlLEroME9uE7zNafiAxjsPZCD8QPbA2
         0+f342lIChu/qzKXx7m387cGvYUZURRHZ+vsCl0w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 08/40] ipv6: Fix redirect with VRF
Date:   Mon,  3 Jun 2019 11:09:01 +0200
Message-Id: <20190603090523.150641928@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603090522.617635820@linuxfoundation.org>
References: <20190603090522.617635820@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

[ Upstream commit 31680ac265802397937d75461a2809a067b9fb93 ]

IPv6 redirect is broken for VRF. __ip6_route_redirect walks the FIB
entries looking for an exact match on ifindex. With VRF the flowi6_oif
is updated by l3mdev_update_flow to the l3mdev index and the
FLOWI_FLAG_SKIP_NH_OIF set in the flags to tell the lookup to skip the
device match. For redirects the device match is requires so use that
flag to know when the oif needs to be reset to the skb device index.

Fixes: ca254490c8df ("net: Add VRF support to IPv6 stack")
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2442,6 +2442,12 @@ static struct rt6_info *__ip6_route_redi
 	struct fib6_info *rt;
 	struct fib6_node *fn;
 
+	/* l3mdev_update_flow overrides oif if the device is enslaved; in
+	 * this case we must match on the real ingress device, so reset it
+	 */
+	if (fl6->flowi6_flags & FLOWI_FLAG_SKIP_NH_OIF)
+		fl6->flowi6_oif = skb->dev->ifindex;
+
 	/* Get the "current" route for this destination and
 	 * check if the redirect has come from appropriate router.
 	 *


