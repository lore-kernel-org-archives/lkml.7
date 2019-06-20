Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAA8C48BE1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AB5208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054581;
	bh=tD2RAf82b2kqlaZW6P4sPKJfmUPs4KxIDFFk2dbs47s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BFgR6BGwGf8Lx0J3QVpTAkjY9kqmPrYBonmPvcCr6LBZmSGm9vS1c78LRwfkrZPb3
	 5nO6WOeWlKwGqjni+C19S3X7hJUEJySWPR7JHH6S8s8e/QbSVQfzXBDCafDQk6uiSa
	 7P0ML2a9Etg4Q3f5CYmSwRddvF4XAZN3G2hm33VY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbfFTSQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729505AbfFTSQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:16:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E1F205F4;
        Thu, 20 Jun 2019 18:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054571;
        bh=tD2RAf82b2kqlaZW6P4sPKJfmUPs4KxIDFFk2dbs47s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZSkkx5H7UNo3EIquZ3aHaiO3rlonUaDJur2Pf1sDclnrYf27AGEcRrW1aMkDBprtN
         PrEgyRhQpnU1wOeyGptSLFKesMKO3IpptDXvXN3V6mLeBOWX/bVRJzRtfPRmAvkqKv
         118lGonJmdAeXFFVbi57EK6wzyabK8y26clIj54A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gen Zhang <blackgod016574@gmail.com>,
        Paulo Alcantara <palcantara@suse.de>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 74/98] dfs_cache: fix a wrong use of kfree in flush_cache_ent()
Date:   Thu, 20 Jun 2019 19:57:41 +0200
Message-Id: <20190620174352.941043088@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 50fbc13dc12666f3604dc2555a47fc8c4e29162b ]

In flush_cache_ent(), 'ce->ce_path' is allocated by kstrdup_const().
It should be freed by kfree_const(), rather than kfree().

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
Reviewed-by: Paulo Alcantara <palcantara@suse.de>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/dfs_cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index 09b7d0d4f6e4..007cfa39be5f 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -131,7 +131,7 @@ static inline void flush_cache_ent(struct dfs_cache_entry *ce)
 		return;
 
 	hlist_del_init_rcu(&ce->ce_hlist);
-	kfree(ce->ce_path);
+	kfree_const(ce->ce_path);
 	free_tgts(ce);
 	dfs_cache_count--;
 	call_rcu(&ce->ce_rcu, free_cache_entry);
@@ -421,7 +421,7 @@ alloc_cache_entry(const char *path, const struct dfs_info3_param *refs,
 
 	rc = copy_ref_data(refs, numrefs, ce, NULL);
 	if (rc) {
-		kfree(ce->ce_path);
+		kfree_const(ce->ce_path);
 		kmem_cache_free(dfs_cache_slab, ce);
 		ce = ERR_PTR(rc);
 	}
-- 
2.20.1



