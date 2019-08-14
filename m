Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9E5C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A6320665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802798;
	bh=wvmpk6+fz8d+5hIrcn2Y0L+EjVGwztU49Pg1//2cPKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2b2EbWASSyj5frVgxrX3VjaDTHTndFqWU/J9ho6EKcBlH4WGEOcTepQUyzu0vj5vF
	 TiRNgBWRA1TlwLpzFnSft+5DuHJvkrOJsmbfSjzBq1bCvXV3G+dWUc2qo3s3c9c39s
	 g9/+VNGmW/oktUt8QEvbijKtNH+xQlx21bRYSWVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbfHNRNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730828AbfHNRNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:13:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F03632084D;
        Wed, 14 Aug 2019 17:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802792;
        bh=wvmpk6+fz8d+5hIrcn2Y0L+EjVGwztU49Pg1//2cPKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qVXEol2dHgf+aTleqxLy9WE+Qe4WG7D86ClndSBvbmIIFs1HZ8OI4Nhcjv4nBpCuE
         cz9nier2yYZmlIf0Uob7PBt94IJ9tmy6dr+Deys47jk6+sLWf/D4oB6bd+wQ5zo2TI
         x2KFmOFHFWNO9dSut+DOFLvLX5BTtVTvr5HAgCW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laura Garcia Liebana <nevola@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 28/69] netfilter: nft_hash: fix symhash with modulus one
Date:   Wed, 14 Aug 2019 19:01:26 +0200
Message-Id: <20190814165747.428288200@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165744.822314328@linuxfoundation.org>
References: <20190814165744.822314328@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



