Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8C9C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601D020656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfEHGwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 02:52:38 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:45120 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfEHGwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 02:52:36 -0400
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id 9isZ2000Z3XaVaC01isZ40; Wed, 08 May 2019 08:52:34 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hOGRN-0002Y8-HJ; Wed, 08 May 2019 08:52:33 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hOGRN-000669-EY; Wed, 08 May 2019 08:52:33 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Pravin B Shelar <pshelar@ovn.org>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Flavio Leitner <fbl@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netdev@vger.kernel.org, dev@openvswitch.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] openvswitch: Replace removed NF_NAT_NEEDED with IS_ENABLED(CONFIG_NF_NAT)
Date:   Wed,  8 May 2019 08:52:32 +0200
Message-Id: <20190508065232.23400-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4806e975729f99c7 ("netfilter: replace NF_NAT_NEEDED with
IS_ENABLED(CONFIG_NF_NAT)") removed CONFIG_NF_NAT_NEEDED, but a new user
popped up afterwards.

Fixes: fec9c271b8f1bde1 ("openvswitch: load and reference the NAT helper.")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 net/openvswitch/conntrack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 333ec5f298fe5fe8..4c597a0bb1683be3 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1322,7 +1322,7 @@ static int ovs_ct_add_helper(struct ovs_conntrack_info *info, const char *name,
 		return -ENOMEM;
 	}
 
-#ifdef CONFIG_NF_NAT_NEEDED
+#if IS_ENABLED(CONFIG_NF_NAT)
 	if (info->nat) {
 		ret = nf_nat_helper_try_module_get(name, info->family,
 						   key->ip.proto);
@@ -1811,7 +1811,7 @@ void ovs_ct_free_action(const struct nlattr *a)
 static void __ovs_ct_free_action(struct ovs_conntrack_info *ct_info)
 {
 	if (ct_info->helper) {
-#ifdef CONFIG_NF_NAT_NEEDED
+#if IS_ENABLED(CONFIG_NF_NAT)
 		if (ct_info->nat)
 			nf_nat_helper_put(ct_info->helper);
 #endif
-- 
2.17.1

