Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB80C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3027C218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfCUBkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:40:03 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:57376 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCUBkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:40:01 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1h6mgW-0006YX-FV; Thu, 21 Mar 2019 09:39:56 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1h6mgS-0002cR-7D; Thu, 21 Mar 2019 09:39:52 +0800
Date:   Thu, 21 Mar 2019 09:39:52 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Josh Hunt <joshhunt00@gmail.com>
Cc:     Josh Elsasser <jelsasser@appneta.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Graf <tgraf@suug.ch>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [v3 PATCH] rhashtable: Still do rehash when we get EEXIST
Message-ID: <20190321013952.3quw6bsqptyngzo5@gondor.apana.org.au>
References: <20190123211758.104275-1-jelsasser@appneta.com>
 <20190124030841.n4jtsqka5zji3e62@gondor.apana.org.au>
 <D5A6C2E7-2AB1-46D0-8876-2D6AAAA3937F@appneta.com>
 <A247F887-832E-44AD-AC41-C22E124E44EE@appneta.com>
 <CAKA=qzY4Pzee9BVzRCciW32toeHSz7t0q9LuvQXKLG2fX9fBbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKA=qzY4Pzee9BVzRCciW32toeHSz7t0q9LuvQXKLG2fX9fBbg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 03:29:17PM -0700, Josh Hunt wrote:
>
> Herbert
> 
> We're seeing this pretty regularly on 4.14 LTS kernels. I didn't see your
> change in any of the regular trees. Are there plans to submit this? If so,
> can it get queued up for 4.14 stable too?

Hi Josh:

Thanks for reminding me.  Looks like this one slipped through the
cracks.

Dave, could you please apply this? Thanks!

---8<---
As it stands if a shrink is delayed because of an outstanding
rehash, we will go into a rescheduling loop without ever doing
the rehash.

This patch fixes this by still carrying out the rehash and then
rescheduling so that we can shrink after the completion of the
rehash should it still be necessary.

The return value of EEXIST captures this case and other cases
(e.g., another thread expanded/rehashed the table at the same
time) where we should still proceed with the rehash.

Fixes: da20420f83ea ("rhashtable: Add nested tables")
Reported-by: Josh Elsasser <jelsasser@appneta.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 852ffa5160f1..4edcf3310513 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -416,8 +416,12 @@ static void rht_deferred_worker(struct work_struct *work)
 	else if (tbl->nest)
 		err = rhashtable_rehash_alloc(ht, tbl, tbl->size);
 
-	if (!err)
-		err = rhashtable_rehash_table(ht);
+	if (!err || err == -EEXIST) {
+		int nerr;
+
+		nerr = rhashtable_rehash_table(ht);
+		err = err ?: nerr;
+	}
 
 	mutex_unlock(&ht->mutex);

-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
