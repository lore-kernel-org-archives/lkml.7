Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C86C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30433214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901400;
	bh=ACWP4Alz0KffQtPehXns1emhWt8z8jLaNtYC+bWi9FU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TyFzyNkkbdGenXFkv6yPh6cswz5gcpI5bBoYveYn1Pa6b28ouQjQY2uc5jcaAydKG
	 uYMiLNEjSMDuvsD/k7ayv6oWsS162pqJQwJIv7zYR0j08BNBKa89IVl//A7jTTX6I1
	 AVvTJBBJBEwVFEgnJ7kw6riTMcXwf6lXSDMY+o5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfCRJ36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:29:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728298AbfCRJ3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:29:55 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEBA2214AF;
        Mon, 18 Mar 2019 09:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901394;
        bh=ACWP4Alz0KffQtPehXns1emhWt8z8jLaNtYC+bWi9FU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X0zz4Kkfs/J3qAtu6Hy92ulpdR16/U6evVE4QTYPMIVSs/yZmyt+cCYGdtSqozqS2
         /465GltOc+DqzAZ1SuF8Tf2HW5lhMHo9K57ZR49XK9UAqkl6nD6yerZqZ9iDeQkp7n
         MPShJbf7zPAahuP0Rxj+oCh0Fn2A4VvlYyMaWYkY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 31/52] ipv6: route: purge exception on removal
Date:   Mon, 18 Mar 2019 10:25:18 +0100
Message-Id: <20190318083847.071295959@linuxfoundation.org>
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

[ Upstream commit f5b51fe804ec2a6edce0f8f6b11ea57283f5857b ]

When a netdevice is unregistered, we flush the relevant exception
via rt6_sync_down_dev() -> fib6_ifdown() -> fib6_del() -> fib6_del_route().

Finally, we end-up calling rt6_remove_exception(), where we release
the relevant dst, while we keep the references to the related fib6_info and
dev. Such references should be released later when the dst will be
destroyed.

There are a number of caches that can keep the exception around for an
unlimited amount of time - namely dst_cache, possibly even socket cache.
As a result device registration may hang, as demonstrated by this script:

ip netns add cl
ip netns add rt
ip netns add srv
ip netns exec rt sysctl -w net.ipv6.conf.all.forwarding=1

ip link add name cl_veth type veth peer name cl_rt_veth
ip link set dev cl_veth netns cl
ip -n cl link set dev cl_veth up
ip -n cl addr add dev cl_veth 2001::2/64
ip -n cl route add default via 2001::1

ip -n cl link add tunv6 type ip6tnl mode ip6ip6 local 2001::2 remote 2002::1 hoplimit 64 dev cl_veth
ip -n cl link set tunv6 up
ip -n cl addr add 2013::2/64 dev tunv6

ip link set dev cl_rt_veth netns rt
ip -n rt link set dev cl_rt_veth up
ip -n rt addr add dev cl_rt_veth 2001::1/64

ip link add name rt_srv_veth type veth peer name srv_veth
ip link set dev srv_veth netns srv
ip -n srv link set dev srv_veth up
ip -n srv addr add dev srv_veth 2002::1/64
ip -n srv route add default via 2002::2

ip -n srv link add tunv6 type ip6tnl mode ip6ip6 local 2002::1 remote 2001::2 hoplimit 64 dev srv_veth
ip -n srv link set tunv6 up
ip -n srv addr add 2013::1/64 dev tunv6

ip link set dev rt_srv_veth netns rt
ip -n rt link set dev rt_srv_veth up
ip -n rt addr add dev rt_srv_veth 2002::2/64

ip netns exec srv netserver & sleep 0.1
ip netns exec cl ping6 -c 4 2013::1
ip netns exec cl netperf -H 2013::1 -t TCP_STREAM -l 3 & sleep 1
ip -n rt link set dev rt_srv_veth mtu 1400
wait %2

ip -n cl link del cl_veth

This commit addresses the issue purging all the references held by the
exception at time, as we currently do for e.g. ipv6 pcpu dst entries.

v1 -> v2:
 - re-order the code to avoid accessing dst and net after dst_dev_put()

Fixes: 93531c674315 ("net/ipv6: separate handling of FIB entries from dst based routes")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1272,18 +1272,29 @@ static DEFINE_SPINLOCK(rt6_exception_loc
 static void rt6_remove_exception(struct rt6_exception_bucket *bucket,
 				 struct rt6_exception *rt6_ex)
 {
+	struct fib6_info *from;
 	struct net *net;
 
 	if (!bucket || !rt6_ex)
 		return;
 
 	net = dev_net(rt6_ex->rt6i->dst.dev);
+	net->ipv6.rt6_stats->fib_rt_cache--;
+
+	/* purge completely the exception to allow releasing the held resources:
+	 * some [sk] cache may keep the dst around for unlimited time
+	 */
+	from = rcu_dereference_protected(rt6_ex->rt6i->from,
+					 lockdep_is_held(&rt6_exception_lock));
+	rcu_assign_pointer(rt6_ex->rt6i->from, NULL);
+	fib6_info_release(from);
+	dst_dev_put(&rt6_ex->rt6i->dst);
+
 	hlist_del_rcu(&rt6_ex->hlist);
 	dst_release(&rt6_ex->rt6i->dst);
 	kfree_rcu(rt6_ex, rcu);
 	WARN_ON_ONCE(!bucket->depth);
 	bucket->depth--;
-	net->ipv6.rt6_stats->fib_rt_cache--;
 }
 
 /* Remove oldest rt6_ex in bucket and free the memory


