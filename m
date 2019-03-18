Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63544C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2550E21734
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901573;
	bh=BG03j7tKj1Si27ev7aX/vvWNrD9F2VVhKiWO2MAaT6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P5ZdTqDvS5IzMcqgRo3xnhk8qhVulDPXTFIFhcZ7iD7BfWfFGH9QA+Rky/sFDoe3b
	 Byt/L8V1wiQ80DtXfEhlu7TtNjRljGcmhZ+Qz5nqJZd2qNJRGPwR2mnMCgNoHiEV3n
	 06UDPxV21TpnL1U02ViMnWnNz6++ByMaI6wDr0OQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfCRJcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbfCRJcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:32:48 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AC66214AF;
        Mon, 18 Mar 2019 09:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901568;
        bh=BG03j7tKj1Si27ev7aX/vvWNrD9F2VVhKiWO2MAaT6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KD903A5YYpleOhuX4zWV8kQMy8hDkaFyeiFtJQquVy1n5wPnr4Gum+hTRuuf/f6TI
         GXrUM5U2l4FgTgXYk7iH4gQr+4zQhM3g9wlEYKNcsJx5olIsted6AHqyBQxOY+dKXq
         TZ5EDQxQDmDO7BGOVsIEq/0D6J05e49sRSLhrOZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 32/52] ipv6: route: enforce RCU protection in ip6_route_check_nh_onlink()
Date:   Mon, 18 Mar 2019 10:25:29 +0100
Message-Id: <20190318084017.318368346@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084013.532280682@linuxfoundation.org>
References: <20190318084013.532280682@linuxfoundation.org>
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

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit bf1dc8bad1d42287164d216d8efb51c5cd381b18 ]

We need a RCU critical section around rt6_info->from deference, and
proper annotation.

Fixes: 4ed591c8ab44 ("net/ipv6: Allow onlink routes to have a device mismatch if it is the default route")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2808,20 +2808,24 @@ static int ip6_route_check_nh_onlink(str
 	u32 tbid = l3mdev_fib_table(dev) ? : RT_TABLE_MAIN;
 	const struct in6_addr *gw_addr = &cfg->fc_gateway;
 	u32 flags = RTF_LOCAL | RTF_ANYCAST | RTF_REJECT;
+	struct fib6_info *from;
 	struct rt6_info *grt;
 	int err;
 
 	err = 0;
 	grt = ip6_nh_lookup_table(net, cfg, gw_addr, tbid, 0);
 	if (grt) {
+		rcu_read_lock();
+		from = rcu_dereference(grt->from);
 		if (!grt->dst.error &&
 		    /* ignore match if it is the default route */
-		    grt->from && !ipv6_addr_any(&grt->from->fib6_dst.addr) &&
+		    from && !ipv6_addr_any(&from->fib6_dst.addr) &&
 		    (grt->rt6i_flags & flags || dev != grt->dst.dev)) {
 			NL_SET_ERR_MSG(extack,
 				       "Nexthop has invalid gateway or device mismatch");
 			err = -EINVAL;
 		}
+		rcu_read_unlock();
 
 		ip6_rt_put(grt);
 	}


