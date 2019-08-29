Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBD3C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 00:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4799E22CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 00:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="d5plNcg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfH2AuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 20:50:13 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.181]:31312 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726279AbfH2AuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 20:50:13 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 0E18229EE
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 19:50:12 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 38dgivqNf4FKp38dgi02rE; Wed, 28 Aug 2019 19:50:12 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=R0JxrP8NyO1yZfaW9U4QUfRp14vcog+lDIYpXStsrMg=; b=d5plNcg8eo4N9I+2/S6cdvxdoL
        yiW2rpvKEPVtq8NCVhw+53ThouZ1xozijBX2dPtX6vAViBkwnNxNOMujvSDkGAhE91Xc0bE94BDwC
        F//KavazcY9XE+R99KcwS3BVR5sHpe9LCuTX2g7bgEN72ZhxA27+HU0umEQgOyScxMq2vl4K2kA4X
        URgJCeN7Trg/R4RWXhHlo2XMj11O/9P0Ur6UVAVT1urHU+Wujp2hgWVy0uiPSbAr0594U/U3J5jGe
        CcGT9gZQ+eRoPGa+pAWc5v6DCSbOPps95AJMx5xrsbUBS3ccF2sqbwvlzqanuGwK/k46xqIf22E+P
        KOnh8GFg==;
Received: from [189.152.216.116] (port=56370 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1i38de-003ypw-Aa; Wed, 28 Aug 2019 19:50:10 -0500
Date:   Wed, 28 Aug 2019 19:50:09 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ubifs: super: Use struct_size() helper
Message-ID: <20190829005009.GA5895@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.152.216.116
X-Source-L: No
X-Exim-ID: 1i38de-003ypw-Aa
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.152.216.116]:56370
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct ubifs_znode {
	...
        struct ubifs_zbranch zbranch[];
};

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

So, replace the following form:

sizeof(struct ubifs_znode) + c->fanout * sizeof(struct ubifs_zbranch)

with:

struct_size(c->cnext, zbranch, c->fanout)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 fs/ubifs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 2706f13e3eb9..ca86489048c8 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -661,8 +661,7 @@ static int init_constants_sb(struct ubifs_info *c)
 	long long tmp64;
 
 	c->main_bytes = (long long)c->main_lebs * c->leb_size;
-	c->max_znode_sz = sizeof(struct ubifs_znode) +
-				c->fanout * sizeof(struct ubifs_zbranch);
+	c->max_znode_sz = struct_size(c->cnext, zbranch, c->fanout);
 
 	tmp = ubifs_idx_node_sz(c, 1);
 	c->ranges[UBIFS_IDX_NODE].min_len = tmp;
-- 
2.23.0

