Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3CEC10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DAD21741
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901291;
	bh=RE0V6NJWiS1Dag6y4J3sRmYI9ScjJXt+puofC33sMjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zAo8JpgjvBK3HjXx+abEQZRHTORAS0RxHU7lG1aS3lGRcxYFVRYslruuC+TadcUvt
	 1tJJQGUacDHbMK8acTQcCRDybVwx9Pt2pF07kYDlbaBle1a7UzqgTzcPMAzVHwJWlQ
	 DVTa8Md4+b8iXGclNHPimDirHKIww7t/5/PZcDqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfCRJ2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:28:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbfCRJ2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:28:03 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AADEA2186A;
        Mon, 18 Mar 2019 09:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901283;
        bh=RE0V6NJWiS1Dag6y4J3sRmYI9ScjJXt+puofC33sMjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u9/AgGePU3VQ5aA5/wvoZR31vPm5FVE+HOoykZ9l1PRd/lm2Up6pmWxjlX0diTbxK
         +3OLkG5En0otUiMUxesKGpQT55+gxghOW+9GKVhcPQfIzDRM/EZ1yggUaNcY5FARbb
         OnvJE55E6sjmz94SiXnTcoqNBCUtlOo2xgSEpZ9k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tianhao Zhao <tizhao@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 04/43] ipv4/route: fail early when inet dev is missing
Date:   Mon, 18 Mar 2019 10:23:56 +0100
Message-Id: <20190318083716.007270522@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083715.877441740@linuxfoundation.org>
References: <20190318083715.877441740@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 22c74764aa2943ecdf9f07c900d8a9c8ba6c9265 ]

If a non local multicast packet reaches ip_route_input_rcu() while
the ingress device IPv4 private data (in_dev) is NULL, we end up
doing a NULL pointer dereference in IN_DEV_MFORWARD().

Since the later call to ip_route_input_mc() is going to fail if
!in_dev, we can fail early in such scenario and avoid the dangerous
code path.

v1 -> v2:
 - clarified the commit message, no code changes

Reported-by: Tianhao Zhao <tizhao@redhat.com>
Fixes: e58e41596811 ("net: Enable support for VRF with ipv4 multicast")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/route.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2144,12 +2144,13 @@ int ip_route_input_rcu(struct sk_buff *s
 		int our = 0;
 		int err = -EINVAL;
 
-		if (in_dev)
-			our = ip_check_mc_rcu(in_dev, daddr, saddr,
-					      ip_hdr(skb)->protocol);
+		if (!in_dev)
+			return err;
+		our = ip_check_mc_rcu(in_dev, daddr, saddr,
+				      ip_hdr(skb)->protocol);
 
 		/* check l3 master if no match yet */
-		if ((!in_dev || !our) && netif_is_l3_slave(dev)) {
+		if (!our && netif_is_l3_slave(dev)) {
 			struct in_device *l3_in_dev;
 
 			l3_in_dev = __in_dev_get_rcu(skb->dev);


