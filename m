Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3287EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FF4206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139230;
	bh=/Oa42ootfa3ePucnBBTmLbvfgR9umwGL0Djqk/EGRn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nu130khn6HijhJiIp70/YCc3D0y6jHVCFhQUZE5YecNEM2QwQREE8k9ly/G4ns6ts
	 2lT2QVQSf4lQYaxDVQJ2UNPRLHM+88O/Y+UeOlBmmW0x7dYzEnPwkusyuyMtOEFUur
	 HKQyxanHma8oA1Efi8OpfCJsxEV4EHkTg7c+SfGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbfDARU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:20:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731638AbfDARUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:20:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F076206C0;
        Mon,  1 Apr 2019 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139224;
        bh=/Oa42ootfa3ePucnBBTmLbvfgR9umwGL0Djqk/EGRn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ji50ZanL5sdMgKiIGkwLqqSMrF4mlbsmuUthKMF5PQH3xW9XffRBUiOzoihl5eK9/
         KwCrtk1p56p522r5XyeL64/xEfP2SUj4hrAq+ryJt0D5iNmd7hlIIM1shByk+xUwMG
         AlO2BZDOwB9ZpCBPeRrT5KQwGXNSGPeW8oRKSkhM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Elsasser <jelsasser@appneta.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 014/107] rhashtable: Still do rehash when we get EEXIST
Date:   Mon,  1 Apr 2019 19:01:29 +0200
Message-Id: <20190401170046.831657502@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 408f13ef358aa5ad56dc6230c2c7deb92cf462b1 ]

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
Tested-by: Josh Elsasser <jelsasser@appneta.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/rhashtable.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -459,8 +459,12 @@ static void rht_deferred_worker(struct w
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
 


