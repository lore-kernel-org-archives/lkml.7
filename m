Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D05C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA68C20830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120759;
	bh=LAc87+6+D18o5QYyIggT21SCRMDuq8+tv+1iJvp/tug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ju681nxXZ14j0iKFHAI5s8BHr7yNvCqwFuwpJNkRG6jeaUQiWI7/GT+j97w9LVrjN
	 Q5+ivTGUOnV8vIPC7ak97KMF365T4Dsx2q2keZvCkkV4ECAD46sLD414NiFywqOq++
	 QZhHGoRlJYDERyokd4F9aOIpHhbgjvllrXEjrQJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404732AbfJCQjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:39:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404041AbfJCQjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:39:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC72E20830;
        Thu,  3 Oct 2019 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120756;
        bh=LAc87+6+D18o5QYyIggT21SCRMDuq8+tv+1iJvp/tug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jyKWV5yx4fbKIx4F/qLXM4q/xUirKOup1RpwXIjZZ/k3Qq10l/b0r4q3N16EYFX79
         4KQ+lpC1RVZ5ZwOl5V/Zzn++PKibzSMoWH7d92Qty7pcOMbBhvgsOyDVQtilMkT+s0
         0WO3QKJUIrPNWeovzGVoJfNHCHzlaf+oTtOY/pnI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Wei Wang <weiwan@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.3 003/344] ipv6: do not free rt if FIB_LOOKUP_NOREF is set on suppress rule
Date:   Thu,  3 Oct 2019 17:49:28 +0200
Message-Id: <20191003154540.394699981@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

[ Upstream commit ca7a03c4175366a92cee0ccc4fec0038c3266e26 ]

Commit 7d9e5f422150 removed references from certain dsts, but accounting
for this never translated down into the fib6 suppression code. This bug
was triggered by WireGuard users who use wg-quick(8), which uses the
"suppress-prefix" directive to ip-rule(8) for routing all of their
internet traffic without routing loops. The test case added here
causes the reference underflow by causing packets to evaluate a suppress
rule.

Fixes: 7d9e5f422150 ("ipv6: convert major tx path to use RT6_LOOKUP_F_DST_NOREF")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Acked-by: Wei Wang <weiwan@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/fib6_rules.c                    |    3 ++-
 tools/testing/selftests/net/fib_tests.sh |   17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -287,7 +287,8 @@ static bool fib6_rule_suppress(struct fi
 	return false;
 
 suppress_route:
-	ip6_rt_put(rt);
+	if (!(arg->flags & FIB_LOOKUP_NOREF))
+		ip6_rt_put(rt);
 	return true;
 }
 
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -9,7 +9,7 @@ ret=0
 ksft_skip=4
 
 # all tests in this script. Can be overridden with -t option
-TESTS="unregister down carrier nexthop ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter"
+TESTS="unregister down carrier nexthop suppress ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter"
 
 VERBOSE=0
 PAUSE_ON_FAIL=no
@@ -614,6 +614,20 @@ fib_nexthop_test()
 	cleanup
 }
 
+fib_suppress_test()
+{
+	$IP link add dummy1 type dummy
+	$IP link set dummy1 up
+	$IP -6 route add default dev dummy1
+	$IP -6 rule add table main suppress_prefixlength 0
+	ping -f -c 1000 -W 1 1234::1 || true
+	$IP -6 rule del table main suppress_prefixlength 0
+	$IP link del dummy1
+
+	# If we got here without crashing, we're good.
+	return 0
+}
+
 ################################################################################
 # Tests on route add and replace
 
@@ -1591,6 +1605,7 @@ do
 	fib_carrier_test|carrier)	fib_carrier_test;;
 	fib_rp_filter_test|rp_filter)	fib_rp_filter_test;;
 	fib_nexthop_test|nexthop)	fib_nexthop_test;;
+	fib_suppress_test|suppress)	fib_suppress_test;;
 	ipv6_route_test|ipv6_rt)	ipv6_route_test;;
 	ipv4_route_test|ipv4_rt)	ipv4_route_test;;
 	ipv6_addr_metric)		ipv6_addr_metric_test;;


