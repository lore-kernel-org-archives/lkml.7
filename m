Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6CDC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 04:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2912B208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 04:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfFXEB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 00:01:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59142 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbfFXEB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 00:01:26 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5AA599E7CDD25E43015C;
        Mon, 24 Jun 2019 12:01:23 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Jun 2019
 12:01:12 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <sdf@google.com>, <jianbol@mellanox.com>,
        <jiri@mellanox.com>, <mirq-linux@rere.qmqm.pl>,
        <willemb@google.com>, <sdf@fomichev.me>, <jiri@resnulli.us>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2] flow_dissector: Fix vlan header offset in __skb_flow_dissect
Date:   Mon, 24 Jun 2019 11:49:13 +0800
Message-ID: <20190624034913.40328-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20190622.161955.2030310177158651781.davem@davemloft.net>
References: <20190622.161955.2030310177158651781.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We build vlan on top of bonding interface, which vlan offload
is off, bond mode is 802.3ad (LACP) and xmit_hash_policy is
BOND_XMIT_POLICY_ENCAP34.

__skb_flow_dissect() fails to get information from protocol headers
encapsulated within vlan, because 'nhoff' is points to IP header,
so bond hashing is based on layer 2 info, which fails to distribute
packets across slaves.

Fixes: d5709f7ab776 ("flow_dissector: For stripped vlan, get vlan info from skb->vlan_tci")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: remove redundant spaces
---
 net/core/flow_dissector.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 01ad60b..ff85934 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -998,6 +998,9 @@ bool __skb_flow_dissect(const struct net *net,
 		    skb && skb_vlan_tag_present(skb)) {
 			proto = skb->protocol;
 		} else {
+			if (dissector_vlan == FLOW_DISSECTOR_KEY_MAX)
+				nhoff -= sizeof(*vlan);
+
 			vlan = __skb_header_pointer(skb, nhoff, sizeof(_vlan),
 						    data, hlen, &_vlan);
 			if (!vlan) {
-- 
2.7.4


