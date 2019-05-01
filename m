Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C780FC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 13:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976F720866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 13:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfEANmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 09:42:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47651 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfEANmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 09:42:08 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hLpUp-000820-OF; Wed, 01 May 2019 13:42:03 +0000
From:   Colin King <colin.king@canonical.com>
To:     Pravin B Shelar <pshelar@ovn.org>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        dev@openvswitch.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] openvswitch: check for null pointer return from nla_nest_start_noflag
Date:   Wed,  1 May 2019 14:41:58 +0100
Message-Id: <20190501134158.15307-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The call to nla_nest_start_noflag can return null in the unlikely
event that nla_put returns -EMSGSIZE.  Check for this condition to
avoid a null pointer dereference on pointer nla_reply.

Addresses-Coverity: ("Dereference null return value")
Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/openvswitch/conntrack.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index c4128082f88b..333ec5f298fe 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -2175,6 +2175,10 @@ static int ovs_ct_limit_cmd_get(struct sk_buff *skb, struct genl_info *info)
 		return PTR_ERR(reply);
 
 	nla_reply = nla_nest_start_noflag(reply, OVS_CT_LIMIT_ATTR_ZONE_LIMIT);
+	if (!nla_reply) {
+		err = -EMSGSIZE;
+		goto exit_err;
+	}
 
 	if (a[OVS_CT_LIMIT_ATTR_ZONE_LIMIT]) {
 		err = ovs_ct_limit_get_zone_limit(
-- 
2.20.1

