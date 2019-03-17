Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BE7C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 17:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F5A21019
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 17:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfCQR1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 13:27:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52350 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfCQR1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 13:27:17 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1h5ZYx-0007Dy-6E; Sun, 17 Mar 2019 17:27:07 +0000
From:   Colin King <colin.king@canonical.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S . Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] netfilter: nf_tables: remove unused parameter ctx
Date:   Sun, 17 Mar 2019 17:27:06 +0000
Message-Id: <20190317172706.26050-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Function nf_tables_set_desc_parse parameter ctx is not being used
so remove it as it is redundant.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 net/netfilter/nf_tables_api.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index faf6bd10a19f..e9d6f4c32a03 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3434,8 +3434,7 @@ static int nf_tables_getset(struct net *net, struct sock *nlsk,
 	return err;
 }
 
-static int nf_tables_set_desc_parse(const struct nft_ctx *ctx,
-				    struct nft_set_desc *desc,
+static int nf_tables_set_desc_parse(struct nft_set_desc *desc,
 				    const struct nlattr *nla)
 {
 	struct nlattr *da[NFTA_SET_DESC_MAX + 1];
@@ -3561,7 +3560,7 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 		policy = ntohl(nla_get_be32(nla[NFTA_SET_POLICY]));
 
 	if (nla[NFTA_SET_DESC] != NULL) {
-		err = nf_tables_set_desc_parse(&ctx, &desc, nla[NFTA_SET_DESC]);
+		err = nf_tables_set_desc_parse(&desc, nla[NFTA_SET_DESC]);
 		if (err < 0)
 			return err;
 	}
-- 
2.20.1

