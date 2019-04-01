Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C471C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0393620663
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141981;
	bh=t+Tlm/kpfL97NuEjXm2QbOfF7qXQgWgO46UA0YnYV80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xnbpHATuedzhOoLdElyKriSrZcHy9fCC7Q2WHe6ORo/DAdFUmwQl7bMy0NHCD/grq
	 WYmoh73hysp8HAVYiOOib13Co871w4Rg2W2bXZCJ2Y/Uz5Vb9vfeMNQ5YLKK0J+ZGE
	 AHT8Dfk5HYUInPd19332bIYBkmuTiAkhVtLifZjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbfDASGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:06:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729542AbfDARM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:12:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23AFA20883;
        Mon,  1 Apr 2019 17:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138776;
        bh=t+Tlm/kpfL97NuEjXm2QbOfF7qXQgWgO46UA0YnYV80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a1bwrFJaCFZ2FLJkCqFTMXSjjTlao6C0T3gbTeQDcJzWqPxBH1qjdrUpgLgV5QN0u
         jvQDOJTy5cwSvEFF5Me2aOUbXId4nh2AD/9rmW7nwmFJpy/vQT1sj9wV0CPSeWZIpG
         B5PiM2M3GYv6igmOAvYeYvhTjIH1eIni2XYakxJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josh Elsasser <jelsasser@appneta.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 018/134] rhashtable: Still do rehash when we get EEXIST
Date:   Mon,  1 Apr 2019 19:00:54 +0200
Message-Id: <20190401170046.285097671@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -416,8 +416,12 @@ static void rht_deferred_worker(struct w
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
 


