Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3CAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722B2214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368866;
	bh=N5kc2olOPduKa+Pk+gx7Qb277zuRT520PDCo514OHrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dSOjuCP8yUhkxBQnI5MqD87Uyh5clRBiRnlGwBMyDbS0PZoslV9qsi4N7wVGUPP3w
	 tcfs5IdODBMvLsN52zAZcGELzNlSz+vzAwUbOQk+mU+BchSgkZvXWgHSzdUSMz/HDn
	 UOXZ1fBrg0qoKiLG3RX7vKjeWod85rFKgH6I/BBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732557AbfDDJHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:07:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732545AbfDDJHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:07:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8E7821741;
        Thu,  4 Apr 2019 09:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368861;
        bh=N5kc2olOPduKa+Pk+gx7Qb277zuRT520PDCo514OHrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VUKPdVNw6A4PdldOmIBED6T4TAa7O5N+yysX0x29utEIwb3okZvyolUayAcyawZ7U
         ffPol22G/Au2QG+kB5AApGJBPVSJBTQs3UOy/5B7d8i5SL6VEd1D2Yfsqn9HoKmqr3
         yGoujG3J7ddO5rufowprdEWJVeMVMLcsyf4knuj8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jari Ruusu <jari.ruusu@gmail.com>
Subject: [PATCH 5.0 001/246] ext4: cleanup bh release code in ext4_ind_remove_space()
Date:   Thu,  4 Apr 2019 10:45:01 +0200
Message-Id: <20190404084619.308275834@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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
@@ -1219,6 +1219,7 @@ int ext4_ind_remove_space(handle_t *hand
 	ext4_lblk_t offsets[4], offsets2[4];
 	Indirect chain[4], chain2[4];
 	Indirect *partial, *partial2;
+	Indirect *p = NULL, *p2 = NULL;
 	ext4_lblk_t max_block;
 	__le32 nr = 0, nr2 = 0;
 	int n = 0, n2 = 0;
@@ -1260,7 +1261,7 @@ int ext4_ind_remove_space(handle_t *hand
 		}
 
 
-		partial = ext4_find_shared(inode, n, offsets, chain, &nr);
+		partial = p = ext4_find_shared(inode, n, offsets, chain, &nr);
 		if (nr) {
 			if (partial == chain) {
 				/* Shared branch grows from the inode */
@@ -1285,13 +1286,11 @@ int ext4_ind_remove_space(handle_t *hand
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
@@ -1321,16 +1320,14 @@ end_range:
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
@@ -1387,15 +1384,7 @@ end_range:
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
@@ -1410,8 +1399,6 @@ end_range:
 					   partial->p + 1,
 					   (__le32 *)partial->bh->b_data+addr_per_block,
 					   (chain+n-1) - partial);
-			BUFFER_TRACE(partial->bh, "call brelse");
-			brelse(partial->bh);
 			partial--;
 		}
 		if (partial2 > chain2 && depth2 <= depth) {
@@ -1419,11 +1406,21 @@ end_range:
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
@@ -1431,7 +1428,7 @@ do_indirects:
 	switch (offsets[0]) {
 	default:
 		if (++n >= n2)
-			return 0;
+			break;
 		nr = i_data[EXT4_IND_BLOCK];
 		if (nr) {
 			ext4_free_branches(handle, inode, NULL, &nr, &nr+1, 1);
@@ -1439,7 +1436,7 @@ do_indirects:
 		}
 	case EXT4_IND_BLOCK:
 		if (++n >= n2)
-			return 0;
+			break;
 		nr = i_data[EXT4_DIND_BLOCK];
 		if (nr) {
 			ext4_free_branches(handle, inode, NULL, &nr, &nr+1, 2);
@@ -1447,7 +1444,7 @@ do_indirects:
 		}
 	case EXT4_DIND_BLOCK:
 		if (++n >= n2)
-			return 0;
+			break;
 		nr = i_data[EXT4_TIND_BLOCK];
 		if (nr) {
 			ext4_free_branches(handle, inode, NULL, &nr, &nr+1, 3);
@@ -1456,5 +1453,5 @@ do_indirects:
 	case EXT4_TIND_BLOCK:
 		;
 	}
-	return 0;
+	goto cleanup;
 }


