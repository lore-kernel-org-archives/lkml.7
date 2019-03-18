Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194ACC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDCA21738
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901413;
	bh=vUTFL7kcYu2OurL96qK3bzB6YqcGSp6d//Kgsjc/SVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LqwI/Z4zn4x+Ox+SNujlOp334GD4EOf6GiVdnHENsCBzEPfnrJQWBVkDSmpH9/xbU
	 DLL+qdh3W1UuMUITpt1AueOcIOOM0eLoBVHD4PYm2LAl1sd9SCrs+OXL8gpT+A4P9Y
	 lqgoD4z98nWcaten3E2BlzoBW+poBhaZX7YSjAnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfCRJaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728006AbfCRJaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:30:10 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4C03214AF;
        Mon, 18 Mar 2019 09:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901410;
        bh=vUTFL7kcYu2OurL96qK3bzB6YqcGSp6d//Kgsjc/SVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yg47ldgA/Jq0qQj+aU6SETbC6M/F15d6YN8o8mT+CdNtVHVVzmOu4eth6XmvL/Kb0
         jhXocZFMdd9V3Dwb/5akASaHA+sfhTbbX1/XQRjWjVgPoNtxnkGs+YK2f725Fw/t8d
         xjqhgVF75dUWMceBRUFuy44WpF8x8arrc9J89Vlg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 35/52] ipv6: route: enforce RCU protection in ip6_route_check_nh_onlink()
Date:   Mon, 18 Mar 2019 10:25:22 +0100
Message-Id: <20190318083847.480216970@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083843.398913295@linuxfoundation.org>
References: <20190318083843.398913295@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2752,20 +2752,24 @@ static int ip6_route_check_nh_onlink(str
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


