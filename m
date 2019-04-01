Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E2FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E583721934
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138834;
	bh=iad/hsVUp40k6l2KtdOJoAbfj/kXj9mfZrUqnrtBiaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U5LcctJc8ct73DPvYufOmycqH98Zyu32cI1tB0A0YhPjV6UXjQHqcG75QBcelrH51
	 vMqqovFMjaOdrSI4Cgi1S/XtvxL1jbHcfEkUj4B6SXfQEoXYy9ObpkscgISeQq5A+g
	 V1pVHGgF8sIRpItZiA/LaXqW9srE6BCnuf1fwYXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbfDARNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729872AbfDARNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:13:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DBCB21934;
        Mon,  1 Apr 2019 17:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138830;
        bh=iad/hsVUp40k6l2KtdOJoAbfj/kXj9mfZrUqnrtBiaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D7v3i+ZraS5axaDg91pIyFElTBk07nNxo/RXR3LcrSLGBV71qlc7l2MkL3m3FtgFL
         CD36QU3sMQegaU1eb8Q8Njte2urc7GWUOC7p3k9R29MsSda/Q1xserdqrTK9VAwpnU
         Zd+pQVmvflKVLAqKZFSvVv6HUyyDcz7lzo2evgBo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        David Ahern <dsahern@gmail.com>, Wei Wang <weiwan@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 007/134] ipv6: make ip6_create_rt_rcu return ip6_null_entry instead of NULL
Date:   Mon,  1 Apr 2019 19:00:43 +0200
Message-Id: <20190401170044.994164524@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 1c87e79a002f6a159396138cd3f3ab554a2a8887 ]

Jianlin reported a crash:

  [  381.484332] BUG: unable to handle kernel NULL pointer dereference at 0000000000000068
  [  381.619802] RIP: 0010:fib6_rule_lookup+0xa3/0x160
  [  382.009615] Call Trace:
  [  382.020762]  <IRQ>
  [  382.030174]  ip6_route_redirect.isra.52+0xc9/0xf0
  [  382.050984]  ip6_redirect+0xb6/0xf0
  [  382.066731]  icmpv6_notify+0xca/0x190
  [  382.083185]  ndisc_redirect_rcv+0x10f/0x160
  [  382.102569]  ndisc_rcv+0xfb/0x100
  [  382.117725]  icmpv6_rcv+0x3f2/0x520
  [  382.133637]  ip6_input_finish+0xbf/0x460
  [  382.151634]  ip6_input+0x3b/0xb0
  [  382.166097]  ipv6_rcv+0x378/0x4e0

It was caused by the lookup function __ip6_route_redirect() returns NULL in
fib6_rule_lookup() when ip6_create_rt_rcu() returns NULL.

So we fix it by simply making ip6_create_rt_rcu() return ip6_null_entry
instead of NULL.

v1->v2:
  - move down 'fallback:' to make it more readable.

Fixes: e873e4b9cc7e ("ipv6: use fib6_info_hold_safe() when necessary")
Reported-by: Jianlin Shi <jishi@redhat.com>
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Acked-by: Wei Wang <weiwan@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1048,14 +1048,20 @@ static struct rt6_info *ip6_create_rt_rc
 	struct rt6_info *nrt;
 
 	if (!fib6_info_hold_safe(rt))
-		return NULL;
+		goto fallback;
 
 	nrt = ip6_dst_alloc(dev_net(dev), dev, flags);
-	if (nrt)
-		ip6_rt_copy_init(nrt, rt);
-	else
+	if (!nrt) {
 		fib6_info_release(rt);
+		goto fallback;
+	}
+
+	ip6_rt_copy_init(nrt, rt);
+	return nrt;
 
+fallback:
+	nrt = dev_net(dev)->ipv6.ip6_null_entry;
+	dst_hold(&nrt->dst);
 	return nrt;
 }
 
@@ -1104,10 +1110,6 @@ restart:
 		dst_hold(&rt->dst);
 	} else {
 		rt = ip6_create_rt_rcu(f6i);
-		if (!rt) {
-			rt = net->ipv6.ip6_null_entry;
-			dst_hold(&rt->dst);
-		}
 	}
 
 	rcu_read_unlock();


