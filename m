Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B52DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A6D2133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049649;
	bh=JjMPhPuK7g0dElr0gzATEb/N0LT0hcgpryU7BNjJ2Yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zi2gmO87ovsPTLSrEupBi7GQ7nck/jKf4dekkv69FmmoW6IEMwydXitM2DkBNjzyX
	 rKlH9nXcq5io/MsKtMBYrBYG0/qDnPuLwNeOFUznq/T3eMKsd82jch5JJo2a7DZ38c
	 uYTXedV0vk8S6EdmwpVjiEGbkvZRTUqRSCfj10k4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfCHMyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:54:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbfCHMyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:54:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8FDD208E4;
        Fri,  8 Mar 2019 12:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049645;
        bh=JjMPhPuK7g0dElr0gzATEb/N0LT0hcgpryU7BNjJ2Yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B8Ceme/ekX2P+7v/GJSZwsr3EHui6+H9ccQs8nQ+QdGw6ZF2PyuInc17gbI6m88AB
         iP6+RDvUFWf+5tcTPFWdM8CFLgZnztyG9w/SfEKH1+3h/H+8JGNtq31hTNfF8DB78a
         l8h/T/YlgbkkMqPJxy4C+ndpLZPUh21gggn/qtqY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4.20 02/76] staging: erofs: fix mis-acted TAIL merging behavior
Date:   Fri,  8 Mar 2019 13:49:14 +0100
Message-Id: <20190308124914.878286563@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <gaoxiang25@huawei.com>

commit a112152f6f3a2a88caa6f414d540bd49e406af60 upstream.

EROFS has an optimized path called TAIL merging, which is designed
to merge multiple reads and the corresponding decompressions into
one if these requests read continuous pages almost at the same time.

In general, it behaves as follows:
 ________________________________________________________________
  ... |  TAIL  .  HEAD  |  PAGE  |  PAGE  |  TAIL    . HEAD | ...
 _____|_combined page A_|________|________|_combined page B_|____
        1  ]  ->  [  2                          ]  ->  [ 3
If the above three reads are requested in the order 1-2-3, it will
generate a large work chain rather than 3 individual work chains
to reduce scheduling overhead and boost up sequential read.

However, if Read 2 is processed slightly earlier than Read 1,
currently it still generates 2 individual work chains (chain 1, 2)
but it does in-place decompression for combined page A, moreover,
if chain 2 decompresses ahead of chain 1, it will be a race and
lead to corrupted decompressed page. This patch fixes it.

Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/erofs/unzip_vle.c |   70 ++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 25 deletions(-)

--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -59,15 +59,30 @@ enum z_erofs_vle_work_role {
 	Z_EROFS_VLE_WORK_SECONDARY,
 	Z_EROFS_VLE_WORK_PRIMARY,
 	/*
-	 * The current work has at least been linked with the following
-	 * processed chained works, which means if the processing page
-	 * is the tail partial page of the work, the current work can
-	 * safely use the whole page, as illustrated below:
-	 * +--------------+-------------------------------------------+
-	 * |  tail page   |      head page (of the previous work)     |
-	 * +--------------+-------------------------------------------+
-	 *   /\  which belongs to the current work
-	 * [  (*) this page can be used for the current work itself.  ]
+	 * The current work was the tail of an exist chain, and the previous
+	 * processed chained works are all decided to be hooked up to it.
+	 * A new chain should be created for the remaining unprocessed works,
+	 * therefore different from Z_EROFS_VLE_WORK_PRIMARY_FOLLOWED,
+	 * the next work cannot reuse the whole page in the following scenario:
+	 *  ________________________________________________________________
+	 * |      tail (partial) page     |       head (partial) page       |
+	 * |  (belongs to the next work)  |  (belongs to the current work)  |
+	 * |_______PRIMARY_FOLLOWED_______|________PRIMARY_HOOKED___________|
+	 */
+	Z_EROFS_VLE_WORK_PRIMARY_HOOKED,
+	/*
+	 * The current work has been linked with the processed chained works,
+	 * and could be also linked with the potential remaining works, which
+	 * means if the processing page is the tail partial page of the work,
+	 * the current work can safely use the whole page (since the next work
+	 * is under control) for in-place decompression, as illustrated below:
+	 *  ________________________________________________________________
+	 * |  tail (partial) page  |          head (partial) page           |
+	 * | (of the current work) |         (of the previous work)         |
+	 * |  PRIMARY_FOLLOWED or  |                                        |
+	 * |_____PRIMARY_HOOKED____|____________PRIMARY_FOLLOWED____________|
+	 *
+	 * [  (*) the above page can be used for the current work itself.  ]
 	 */
 	Z_EROFS_VLE_WORK_PRIMARY_FOLLOWED,
 	Z_EROFS_VLE_WORK_MAX
@@ -236,10 +251,10 @@ static int z_erofs_vle_work_add_page(
 	return ret ? 0 : -EAGAIN;
 }
 
-static inline bool try_to_claim_workgroup(
-	struct z_erofs_vle_workgroup *grp,
-	z_erofs_vle_owned_workgrp_t *owned_head,
-	bool *hosted)
+static enum z_erofs_vle_work_role
+try_to_claim_workgroup(struct z_erofs_vle_workgroup *grp,
+		       z_erofs_vle_owned_workgrp_t *owned_head,
+		       bool *hosted)
 {
 	DBG_BUGON(*hosted == true);
 
@@ -253,6 +268,9 @@ retry:
 
 		*owned_head = grp;
 		*hosted = true;
+		/* lucky, I am the followee :) */
+		return Z_EROFS_VLE_WORK_PRIMARY_FOLLOWED;
+
 	} else if (grp->next == Z_EROFS_VLE_WORKGRP_TAIL) {
 		/*
 		 * type 2, link to the end of a existing open chain,
@@ -262,12 +280,11 @@ retry:
 		if (Z_EROFS_VLE_WORKGRP_TAIL != cmpxchg(&grp->next,
 			Z_EROFS_VLE_WORKGRP_TAIL, *owned_head))
 			goto retry;
-
 		*owned_head = Z_EROFS_VLE_WORKGRP_TAIL;
-	} else
-		return false;	/* :( better luck next time */
+		return Z_EROFS_VLE_WORK_PRIMARY_HOOKED;
+	}
 
-	return true;	/* lucky, I am the followee :) */
+	return Z_EROFS_VLE_WORK_PRIMARY; /* :( better luck next time */
 }
 
 struct z_erofs_vle_work_finder {
@@ -345,12 +362,9 @@ z_erofs_vle_work_lookup(const struct z_e
 	*f->hosted = false;
 	if (!primary)
 		*f->role = Z_EROFS_VLE_WORK_SECONDARY;
-	/* claim the workgroup if possible */
-	else if (try_to_claim_workgroup(grp, f->owned_head, f->hosted))
-		*f->role = Z_EROFS_VLE_WORK_PRIMARY_FOLLOWED;
-	else
-		*f->role = Z_EROFS_VLE_WORK_PRIMARY;
-
+	else	/* claim the workgroup if possible */
+		*f->role = try_to_claim_workgroup(grp, f->owned_head,
+						  f->hosted);
 	return work;
 }
 
@@ -410,6 +424,9 @@ z_erofs_vle_work_register(const struct z
 	return work;
 }
 
+#define builder_is_hooked(builder) \
+	((builder)->role >= Z_EROFS_VLE_WORK_PRIMARY_HOOKED)
+
 #define builder_is_followed(builder) \
 	((builder)->role >= Z_EROFS_VLE_WORK_PRIMARY_FOLLOWED)
 
@@ -584,7 +601,7 @@ static int z_erofs_do_read_page(struct z
 	struct z_erofs_vle_work_builder *const builder = &fe->builder;
 	const loff_t offset = page_offset(page);
 
-	bool tight = builder_is_followed(builder);
+	bool tight = builder_is_hooked(builder);
 	struct z_erofs_vle_work *work = builder->work;
 
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
@@ -649,7 +666,7 @@ repeat:
 		builder->role = Z_EROFS_VLE_WORK_PRIMARY;
 #endif
 
-	tight &= builder_is_followed(builder);
+	tight &= builder_is_hooked(builder);
 	work = builder->work;
 hitted:
 	cur = end - min_t(unsigned int, offset + end - map->m_la, end);
@@ -664,6 +681,9 @@ hitted:
 			(tight ? Z_EROFS_PAGE_TYPE_EXCLUSIVE :
 				Z_EROFS_VLE_PAGE_TYPE_TAIL_SHARED));
 
+	if (cur)
+		tight &= builder_is_followed(builder);
+
 retry:
 	err = z_erofs_vle_work_add_page(builder, page, page_type);
 	/* should allocate an additional staging page for pagevec */


