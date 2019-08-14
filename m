Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AEEC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572FB214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565748976;
	bh=ME8uYdcbeBKsE0Xjdsl7NR7jCQx95cYJx8uo04L6Xko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OUnzNO2+mjLIU4DV4X4mMkThgU5ed+Fro75BtOXLPKrYTXvVPh9pbSnQLpXjOXbAb
	 kGVz2OrcuS1/eNKD/ms6KNMhvomU++ChQ93yrHgYH9TBqEwzn21znfONMfL103wgvR
	 2ioRHwOVMEzKKCdLynC+0q8KCFen9XQhtEUpnd+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfHNCQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728946AbfHNCQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:16:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A4BA2085A;
        Wed, 14 Aug 2019 02:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748970;
        bh=ME8uYdcbeBKsE0Xjdsl7NR7jCQx95cYJx8uo04L6Xko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t2xqkumMe4vZkg1ymKD5tm6HvWmtc8Z6wRWf9U2SzHjR8yP51ScNsZSrPKlAjPLcs
         wx0XTw1K8pOF/jBpr8soI1xAowjgArT7MxTvDfV+M51QgdSVIKSB3l9c+ZmWdO8WU2
         kNBONykCQxTiU90koaxzqg+sctV/miZo1zvAoR8g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ido Schimmel <idosch@mellanox.com>,
        Stephen Suryaputra <ssuryaextr@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 12/68] selftests: forwarding: gre_multipath: Fix flower filters
Date:   Tue, 13 Aug 2019 22:14:50 -0400
Message-Id: <20190814021548.16001-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021548.16001-1-sashal@kernel.org>
References: <20190814021548.16001-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 1be79d89b7ae96e004911bd228ce8c2b5cc6415f ]

The TC filters used in the test do not work with veth devices because the
outer Ethertype is 802.1Q and not IPv4. The test passes with mlxsw
netdevs since the hardware always looks at "The first Ethertype that
does not point to either: VLAN, CNTAG or configurable Ethertype".

Fix this by matching on the VLAN ID instead, but on the ingress side.
The reason why this is not performed at egress is explained in the
commit cited below.

Fixes: 541ad323db3a ("selftests: forwarding: gre_multipath: Update next-hop statistics match criteria")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reported-by: Stephen Suryaputra <ssuryaextr@gmail.com>
Tested-by: Stephen Suryaputra <ssuryaextr@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/net/forwarding/gre_multipath.sh | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/gre_multipath.sh b/tools/testing/selftests/net/forwarding/gre_multipath.sh
index 37d7297e1cf8a..a8d8e8b3dc819 100755
--- a/tools/testing/selftests/net/forwarding/gre_multipath.sh
+++ b/tools/testing/selftests/net/forwarding/gre_multipath.sh
@@ -93,18 +93,10 @@ sw1_create()
 	ip route add vrf v$ol1 192.0.2.16/28 \
 	   nexthop dev g1a \
 	   nexthop dev g1b
-
-	tc qdisc add dev $ul1 clsact
-	tc filter add dev $ul1 egress pref 111 prot ipv4 \
-	   flower dst_ip 192.0.2.66 action pass
-	tc filter add dev $ul1 egress pref 222 prot ipv4 \
-	   flower dst_ip 192.0.2.82 action pass
 }
 
 sw1_destroy()
 {
-	tc qdisc del dev $ul1 clsact
-
 	ip route del vrf v$ol1 192.0.2.16/28
 
 	ip route del vrf v$ol1 192.0.2.82/32 via 192.0.2.146
@@ -139,10 +131,18 @@ sw2_create()
 	ip route add vrf v$ol2 192.0.2.0/28 \
 	   nexthop dev g2a \
 	   nexthop dev g2b
+
+	tc qdisc add dev $ul2 clsact
+	tc filter add dev $ul2 ingress pref 111 prot 802.1Q \
+	   flower vlan_id 111 action pass
+	tc filter add dev $ul2 ingress pref 222 prot 802.1Q \
+	   flower vlan_id 222 action pass
 }
 
 sw2_destroy()
 {
+	tc qdisc del dev $ul2 clsact
+
 	ip route del vrf v$ol2 192.0.2.0/28
 
 	ip route del vrf v$ol2 192.0.2.81/32 via 192.0.2.145
@@ -215,15 +215,15 @@ multipath4_test()
 	   nexthop dev g1a weight $weight1 \
 	   nexthop dev g1b weight $weight2
 
-	local t0_111=$(tc_rule_stats_get $ul1 111 egress)
-	local t0_222=$(tc_rule_stats_get $ul1 222 egress)
+	local t0_111=$(tc_rule_stats_get $ul2 111 ingress)
+	local t0_222=$(tc_rule_stats_get $ul2 222 ingress)
 
 	ip vrf exec v$h1 \
 	   $MZ $h1 -q -p 64 -A 192.0.2.1 -B 192.0.2.18 \
 	       -d 1msec -t udp "sp=1024,dp=0-32768"
 
-	local t1_111=$(tc_rule_stats_get $ul1 111 egress)
-	local t1_222=$(tc_rule_stats_get $ul1 222 egress)
+	local t1_111=$(tc_rule_stats_get $ul2 111 ingress)
+	local t1_222=$(tc_rule_stats_get $ul2 222 ingress)
 
 	local d111=$((t1_111 - t0_111))
 	local d222=$((t1_222 - t0_222))
-- 
2.20.1

