Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B46C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 21:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F01D2082C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 21:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbfC3Vmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 17:42:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57815 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730582AbfC3Vmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 17:42:43 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hALkP-0004jh-Jx; Sat, 30 Mar 2019 21:42:41 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: dsa: fix negative loop bound error on for loop
Date:   Sat, 30 Mar 2019 21:42:41 +0000
Message-Id: <20190330214241.15311-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the for-loop using an unsigned int for the loop counter
which is problematic when comparing it to the signed int count
This is an issue because if the signed int is negative then
the negative loop bound is implicitly cast to an unsigned int on
the comparison to loop counter i and will yield a very large value,
eventually causing an error when memmove/memcpy'ing outside the
allocated region pointed to by ndata.

Fix this by simply making the loop counter i a signed int;

Fixes: f2f2356685bc ("net: dsa: move master ethtool code")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/dsa/master.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/dsa/master.c b/net/dsa/master.c
index c58f33931be1..1b659647a303 100644
--- a/net/dsa/master.c
+++ b/net/dsa/master.c
@@ -87,8 +87,7 @@ static void dsa_master_get_strings(struct net_device *dev, uint32_t stringset,
 	struct dsa_switch *ds = cpu_dp->ds;
 	int port = cpu_dp->index;
 	int len = ETH_GSTRING_LEN;
-	int mcount = 0, count;
-	unsigned int i;
+	int mcount = 0, count, i;
 	uint8_t pfx[4];
 	uint8_t *ndata;
 
-- 
2.20.1

