Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E587C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338A321903
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 16:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="eW/IcYg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbfC3Qm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:42:29 -0400
Received: from forward500p.mail.yandex.net ([77.88.28.110]:56123 "EHLO
        forward500p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730154AbfC3Qm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 12:42:29 -0400
Received: from mxback20j.mail.yandex.net (mxback20j.mail.yandex.net [IPv6:2a02:6b8:0:1619::114])
        by forward500p.mail.yandex.net (Yandex) with ESMTP id A95F4940261;
        Sat, 30 Mar 2019 19:42:24 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback20j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 9Vf1ajHZpZ-gHlu9bVR;
        Sat, 30 Mar 2019 19:42:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1553964143;
        bh=LM7LeHa743lvi4DRsEXm/wIP8IcZHVpJpFo+a5ZMhVw=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=eW/IcYg6/RpPaSzkLffrx92XO5yXFOEGS0RtoLfHfe9pAEGODdkr0DHEOeJI6RBng
         A45I2EP0IRBDDn7yaImdAlKNyoosHxa4zRYjaoh0XFTqB0qhq/KLjgxmBxIttBmoox
         JDNt0+Zv9+UW6b714qhDMfy1rLiJkUFwzaiItOAM=
Authentication-Results: mxback20j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt3-c7e5d17fe013.qloud-c.yandex.net with HTTP;
        Sat, 30 Mar 2019 19:42:17 +0300
From:   Andrey Abramov <st5pub@yandex.ru>
To:     "vgupta@synopsys.com" <vgupta@synopsys.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "richard@nod.at" <richard@nod.at>,
        "dedekind1@gmail.com" <dedekind1@gmail.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        George Spelvin <lkml@sdf.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
Cc:     "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        Morton Andrew <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "malat@debian.org" <malat@debian.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "jannh@google.com" <jannh@google.com>,
        "jslaby@suse.cz" <jslaby@suse.cz>,
        "ge.changwei@h3c.com" <ge.changwei@h3c.com>,
        "jiangyiwen@huawei.com" <jiangyiwen@huawei.com>,
        "piaojun@huawei.com" <piaojun@huawei.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "ashish.samant@oracle.com" <ashish.samant@oracle.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "lchen@suse.com" <lchen@suse.com>,
        "jiang.biao2@zte.com.cn" <jiang.biao2@zte.com.cn>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "kamalesh@linux.vnet.ibm.com" <kamalesh@linux.vnet.ibm.com>
In-Reply-To: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
References: <18626931553963861@sas1-b3ec53dbc12b.qloud-c.yandex.net>
Subject: [PATCH 3/5] ocfs2: dir,refcounttree,xattr: replace swap functions with built-in one
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 30 Mar 2019 19:42:17 +0300
Message-Id: <3079511553964137@myt3-c7e5d17fe013.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace dx_leaf_sort_swap, swap_refcount_rec and swap_xe functions
with built-in one, because they do only a simple byte to byte swap.

Signed-off-by: Andrey Abramov <st5pub@yandex.ru>
---
 fs/ocfs2/dir.c          | 13 +------------
 fs/ocfs2/refcounttree.c | 13 +++----------
 fs/ocfs2/xattr.c        | 15 +++------------
 3 files changed, 7 insertions(+), 34 deletions(-)

diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index c121abbdfc7d..4b86b181df0a 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -3529,16 +3529,6 @@ static int dx_leaf_sort_cmp(const void *a, const void *b)
 	return 0;
 }
 
-static void dx_leaf_sort_swap(void *a, void *b, int size)
-{
-	struct ocfs2_dx_entry *entry1 = a;
-	struct ocfs2_dx_entry *entry2 = b;
-
-	BUG_ON(size != sizeof(*entry1));
-
-	swap(*entry1, *entry2);
-}
-
 static int ocfs2_dx_leaf_same_major(struct ocfs2_dx_leaf *dx_leaf)
 {
 	struct ocfs2_dx_entry_list *dl_list = &dx_leaf->dl_list;
@@ -3799,8 +3789,7 @@ static int ocfs2_dx_dir_rebalance(struct ocfs2_super *osb, struct inode *dir,
 	 * This block is changing anyway, so we can sort it in place.
 	 */
 	sort(dx_leaf->dl_list.de_entries, num_used,
-	     sizeof(struct ocfs2_dx_entry), dx_leaf_sort_cmp,
-	     dx_leaf_sort_swap);
+	     sizeof(struct ocfs2_dx_entry), dx_leaf_sort_cmp, NULL);
 
 	ocfs2_journal_dirty(handle, dx_leaf_bh);
 
diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index 1dc9a08e8bdc..7bbc94d23a0c 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -1400,13 +1400,6 @@ static int cmp_refcount_rec_by_cpos(const void *a, const void *b)
 	return 0;
 }
 
-static void swap_refcount_rec(void *a, void *b, int size)
-{
-	struct ocfs2_refcount_rec *l = a, *r = b;
-
-	swap(*l, *r);
-}
-
 /*
  * The refcount cpos are ordered by their 64bit cpos,
  * But we will use the low 32 bit to be the e_cpos in the b-tree.
@@ -1482,7 +1475,7 @@ static int ocfs2_divide_leaf_refcount_block(struct buffer_head *ref_leaf_bh,
 	 */
 	sort(&rl->rl_recs, le16_to_cpu(rl->rl_used),
 	     sizeof(struct ocfs2_refcount_rec),
-	     cmp_refcount_rec_by_low_cpos, swap_refcount_rec);
+	     cmp_refcount_rec_by_low_cpos, NULL);
 
 	ret = ocfs2_find_refcount_split_pos(rl, &cpos, &split_index);
 	if (ret) {
@@ -1507,11 +1500,11 @@ static int ocfs2_divide_leaf_refcount_block(struct buffer_head *ref_leaf_bh,
 
 	sort(&rl->rl_recs, le16_to_cpu(rl->rl_used),
 	     sizeof(struct ocfs2_refcount_rec),
-	     cmp_refcount_rec_by_cpos, swap_refcount_rec);
+	     cmp_refcount_rec_by_cpos, NULL);
 
 	sort(&new_rl->rl_recs, le16_to_cpu(new_rl->rl_used),
 	     sizeof(struct ocfs2_refcount_rec),
-	     cmp_refcount_rec_by_cpos, swap_refcount_rec);
+	     cmp_refcount_rec_by_cpos, NULL);
 
 	*split_cpos = cpos;
 	return 0;
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 3a24ce3deb01..b3e6f42baf78 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -4175,15 +4175,6 @@ static int cmp_xe(const void *a, const void *b)
 	return 0;
 }
 
-static void swap_xe(void *a, void *b, int size)
-{
-	struct ocfs2_xattr_entry *l = a, *r = b, tmp;
-
-	tmp = *l;
-	memcpy(l, r, sizeof(struct ocfs2_xattr_entry));
-	memcpy(r, &tmp, sizeof(struct ocfs2_xattr_entry));
-}
-
 /*
  * When the ocfs2_xattr_block is filled up, new bucket will be created
  * and all the xattr entries will be moved to the new bucket.
@@ -4249,7 +4240,7 @@ static void ocfs2_cp_xattr_block_to_bucket(struct inode *inode,
 	trace_ocfs2_cp_xattr_block_to_bucket_end(offset, size, off_change);
 
 	sort(target + offset, count, sizeof(struct ocfs2_xattr_entry),
-	     cmp_xe, swap_xe);
+	     cmp_xe, NULL);
 }
 
 /*
@@ -4444,7 +4435,7 @@ static int ocfs2_defrag_xattr_bucket(struct inode *inode,
 	 */
 	sort(entries, le16_to_cpu(xh->xh_count),
 	     sizeof(struct ocfs2_xattr_entry),
-	     cmp_xe_offset, swap_xe);
+	     cmp_xe_offset, NULL);
 
 	/* Move all name/values to the end of the bucket. */
 	xe = xh->xh_entries;
@@ -4486,7 +4477,7 @@ static int ocfs2_defrag_xattr_bucket(struct inode *inode,
 	/* sort the entries by their name_hash. */
 	sort(entries, le16_to_cpu(xh->xh_count),
 	     sizeof(struct ocfs2_xattr_entry),
-	     cmp_xe, swap_xe);
+	     cmp_xe, NULL);
 
 	buf = bucket_buf;
 	for (i = 0; i < bucket->bu_blocks; i++, buf += blocksize)
-- 
2.21.0


