Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBABC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A7B21851
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752613;
	bh=a5PkzckWTg221NMOOt/P5PkDXBIYIDBB3qKCU7mMVE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2QtO/PT4nnPAJc3dtISVfSOcbhs74Etd0Gix4L1qP9EEAHjuyj0Lkq5x+YEihG19o
	 Av9U8E1XbeK1YbB6xc/E6PRei1RsV4QFSicWe9BNMz3bpvUPNfiuHzXpaUc+lsK9rI
	 Sg8b14pgXrs/UqJ0oauO2iq1P3D5h7jKeJMnuLSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404020AbfHBNaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389224AbfHBNY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:24:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BAC3217D4;
        Fri,  2 Aug 2019 13:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752268;
        bh=a5PkzckWTg221NMOOt/P5PkDXBIYIDBB3qKCU7mMVE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=icileZ3pokQibgDsVZBneKXiYQ64K6L2KXtohOFNKJPaiTclHLRuct5+88D70+3ab
         oDOB+bcMrZ9Tn+gUDPQh9ylG3cABUw/Wx3VRYPaUQ10yjy5/IOs0RrKKZgOmQTr+f4
         +SNHUWVsuA+LExrRzn0WJAJTnAVUMwnLzUe8Xymo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Laura Garcia Liebana <nevola@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 04/30] netfilter: nft_hash: fix symhash with modulus one
Date:   Fri,  2 Aug 2019 09:23:56 -0400
Message-Id: <20190802132422.13963-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802132422.13963-1-sashal@kernel.org>
References: <20190802132422.13963-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laura Garcia Liebana <nevola@gmail.com>

[ Upstream commit 28b1d6ef53e3303b90ca8924bb78f31fa527cafb ]

The rule below doesn't work as the kernel raises -ERANGE.

nft add rule netdev nftlb lb01 ip daddr set \
	symhash mod 1 map { 0 : 192.168.0.10 } fwd to "eth0"

This patch allows to use the symhash modulus with one
element, in the same way that the other types of hashes and
algorithms that uses the modulus parameter.

Signed-off-by: Laura Garcia Liebana <nevola@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_hash.c b/net/netfilter/nft_hash.c
index 24f2f7567ddb7..010a565b40001 100644
--- a/net/netfilter/nft_hash.c
+++ b/net/netfilter/nft_hash.c
@@ -131,7 +131,7 @@ static int nft_symhash_init(const struct nft_ctx *ctx,
 	priv->dreg = nft_parse_register(tb[NFTA_HASH_DREG]);
 
 	priv->modulus = ntohl(nla_get_be32(tb[NFTA_HASH_MODULUS]));
-	if (priv->modulus <= 1)
+	if (priv->modulus < 1)
 		return -ERANGE;
 
 	if (priv->offset + priv->modulus - 1 < priv->offset)
-- 
2.20.1

