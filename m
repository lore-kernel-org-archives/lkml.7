Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37ECC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2AF21905
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126215;
	bh=Iu5e9ZoxFnZXV9BoeD7yjWV/H+LrEQ7kmeRSaupRf2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TXPfncWXCYOpVarOFQDgOfWq5L5baj8+5Sn3BZ6EjimvhRHRn4PNnQ397EXL9//fK
	 K20e81itb4UFC1NrsWBrt4Szd+pwhfJyscnSBq5X5dIOFbpp/fLdklUddsxCxu3ydb
	 LNGfbC05lpPZ0vx8IUi2w4CtnJR0tkFTyeiUbOYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbfDXRQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:16:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388081AbfDXRQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:16:52 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71CD92190C;
        Wed, 24 Apr 2019 17:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126210;
        bh=Iu5e9ZoxFnZXV9BoeD7yjWV/H+LrEQ7kmeRSaupRf2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pkRMlnDBWnU/bIqwsQHPOKkb83OXATHjlHmSqnewC1zdxmobsfwpFyNF6soWVwXgG
         1B4KWe4RpGxO86wrJLKbGPVMaD78jzdi2O6w4vAxKzUQ3TDvhj3NgECqiwqWy4svFh
         xI74ENIyHilwp/axUNlJ9LopsdUESi8/y4Ex7bps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jari Ruusu <jari.ruusu@gmail.com>
Subject: [PATCH 4.4 003/168] ext4: cleanup bh release code in ext4_ind_remove_space()
Date:   Wed, 24 Apr 2019 19:07:27 +0200
Message-Id: <20190424170923.651391223@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangyi (F) <yi.zhang@huawei.com>

commit 5e86bdda41534e17621d5a071b294943cae4376e upstream.

Currently, we are releasing the indirect buffer where we are done with
it in ext4_ind_remove_space(), so we can see the brelse() and
BUFFER_TRACE() everywhere.  It seems fragile and hard to read, and we
may probably forget to release the buffer some day.  This patch cleans
up the code by putting of the code which releases the buffers to the
end of the function.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Jari Ruusu <jari.ruusu@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/indirect.c |   47 ++++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -1323,6 +1323,7 @@ int ext4_ind_remove_space(handle_t *hand
 	ext4_lblk_t offsets[4], offsets2[4];
 	Indirect chain[4], chain2[4];
 	Indirect *partial, *partial2;
+	Indirect *p = NULL, *p2 = NULL;
 	ext4_lblk_t max_block;
 	__le32 nr = 0, nr2 = 0;
 	int n = 0, n2 = 0;
@@ -1364,7 +1365,7 @@ int ext4_ind_remove_space(handle_t *hand
 		}
 
 
-		partial = ext4_find_shared(inode, n, offsets, chain, &nr);
+		partial = p = ext4_find_shared(inode, n, offsets, chain, &nr);
 		if (nr) {
 			if (partial == chain) {
 				/* Shared branch grows from the inode */
@@ -1389,13 +1390,11 @@ int ext4_ind_remove_space(handle_t *hand
 				partial->p + 1,
 				(__le32 *)partial->bh->b_data+addr_per_block,
 				(chain+n-1) - partial);
-			BUFFER_TRACE(partial->bh, "call brelse");
-			brelse(partial->bh);
 			partial--;
 		}
 
 end_range:
-		partial2 = ext4_find_shared(inode, n2, offsets2, chain2, &nr2);
+		partial2 = p2 = ext4_find_shared(inode, n2, offsets2, chain2, &nr2);
 		if (nr2) {
 			if (partial2 == chain2) {
 				/*
@@ -1425,16 +1424,14 @@ end_range:
 					   (__le32 *)partial2->bh->b_data,
 					   partial2->p,
 					   (chain2+n2-1) - partial2);
-			BUFFER_TRACE(partial2->bh, "call brelse");
-			brelse(partial2->bh);
 			partial2--;
 		}
 		goto do_indirects;
 	}
 
 	/* Punch happened within the same level (n == n2) */
-	partial = ext4_find_shared(inode, n, offsets, chain, &nr);
-	partial2 = ext4_find_shared(inode, n2, offsets2, chain2, &nr2);
+	partial = p = ext4_find_shared(inode, n, offsets, chain, &nr);
+	partial2 = p2 = ext4_find_shared(inode, n2, offsets2, chain2, &nr2);
 
 	/* Free top, but only if partial2 isn't its subtree. */
 	if (nr) {
@@ -1491,15 +1488,7 @@ end_range:
 					   partial->p + 1,
 					   partial2->p,
 					   (chain+n-1) - partial);
-			while (partial > chain) {
-				BUFFER_TRACE(partial->bh, "call brelse");
-				brelse(partial->bh);
-			}
-			while (partial2 > chain2) {
-				BUFFER_TRACE(partial2->bh, "call brelse");
-				brelse(partial2->bh);
-			}
-			return 0;
+			goto cleanup;
 		}
 
 		/*
@@ -1514,8 +1503,6 @@ end_range:
 					   partial->p + 1,
 					   (__le32 *)partial->bh->b_data+addr_per_block,
 					   (chain+n-1) - partial);
-			BUFFER_TRACE(partial->bh, "call brelse");
-			brelse(partial->bh);
 			partial--;
 		}
 		if (partial2 > chain2 && depth2 <= depth) {
@@ -1523,11 +1510,21 @@ end_range:
 					   (__le32 *)partial2->bh->b_data,
 					   partial2->p,
 					   (chain2+n2-1) - partial2);
-			BUFFER_TRACE(partial2->bh, "call brelse");
-			brelse(partial2->bh);
 			partial2--;
 		}
 	}
+
+cleanup:
+	while (p && p > chain) {
+		BUFFER_TRACE(p->bh, "call brelse");
+		brelse(p->bh);
+		p--;
+	}
+	while (p2 && p2 > chain2) {
+		BUFFER_TRACE(p2->bh, "call brelse");
+		brelse(p2->bh);
+		p2--;
+	}
 	return 0;
 
 do_indirects:
@@ -1535,7 +1532,7 @@ do_indirects:
 	switch (offsets[0]) {
 	default:
 		if (++n >= n2)
-			return 0;
+			break;
 		nr = i_data[EXT4_IND_BLOCK];
 		if (nr) {
 			ext4_free_branches(handle, inode, NULL, &nr, &nr+1, 1);
@@ -1543,7 +1540,7 @@ do_indirects:
 		}
 	case EXT4_IND_BLOCK:
 		if (++n >= n2)
-			return 0;
+			break;
 		nr = i_data[EXT4_DIND_BLOCK];
 		if (nr) {
 			ext4_free_branches(handle, inode, NULL, &nr, &nr+1, 2);
@@ -1551,7 +1548,7 @@ do_indirects:
 		}
 	case EXT4_DIND_BLOCK:
 		if (++n >= n2)
-			return 0;
+			break;
 		nr = i_data[EXT4_TIND_BLOCK];
 		if (nr) {
 			ext4_free_branches(handle, inode, NULL, &nr, &nr+1, 3);
@@ -1560,5 +1557,5 @@ do_indirects:
 	case EXT4_TIND_BLOCK:
 		;
 	}
-	return 0;
+	goto cleanup;
 }


