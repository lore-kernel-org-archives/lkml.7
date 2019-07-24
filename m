Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C51C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B67621955
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kyqJcq2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfGXHPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 03:15:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfGXHPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 03:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l6NljtNLW32m46d8tO++xFaZ5Jj0Gx0bNYJ5xuRoRKA=; b=kyqJcq2YXImwoDd1wgMNuEwgd
        /fZ2jKO1S/UkAEmqv7RHW+jQEZT9dMbzAoHjBzWCBFfth6V6H2w+YNy6UvdR8/aaShCIaxCe6h/jo
        PcDNPdVWl5AxHssgJlHwrOXlpWwnS7jm+Bc6sGMMmF913pd3t1x76ANfDhH85el5yDIvnyUXq68Qq
        yD7ZJPL722DLaAmkCNGTkqC7IQfZTq+IVz2Fl1dvv1wfL7AophLSbzQTNcjK5DhtUdUQH3TrHsWKq
        zmtVkOaAxDV2lODNykCpljmtIfZ+oXhOOZqng2OH++lxAPWMsKqD0FzTr+wBmrVE3OoQHepObu6C6
        GyJqDT0QA==;
Received: from 089144207240.atnat0016.highway.bob.at ([89.144.207.240] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqBUl-0005zU-NQ; Wed, 24 Jul 2019 07:15:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     dwmw2@infradead.org, richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH] jffs2: remove jffs2_gc_fetch_page and jffs2_gc_release_page
Date:   Wed, 24 Jul 2019 09:15:25 +0200
Message-Id: <20190724071525.18960-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge these two helpers into the only callers to get rid of some
amazingly bad calling conventions.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/jffs2/fs.c       | 27 ---------------------------
 fs/jffs2/gc.c       | 21 +++++++++++++--------
 fs/jffs2/os-linux.h |  3 ---
 3 files changed, 13 insertions(+), 38 deletions(-)

diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index 8a20ddd25f2d..a3193c0f3a9b 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -678,33 +678,6 @@ struct jffs2_inode_info *jffs2_gc_fetch_inode(struct jffs2_sb_info *c,
 	return JFFS2_INODE_INFO(inode);
 }
 
-unsigned char *jffs2_gc_fetch_page(struct jffs2_sb_info *c,
-				   struct jffs2_inode_info *f,
-				   unsigned long offset,
-				   unsigned long *priv)
-{
-	struct inode *inode = OFNI_EDONI_2SFFJ(f);
-	struct page *pg;
-
-	pg = read_cache_page(inode->i_mapping, offset >> PAGE_SHIFT,
-			     jffs2_do_readpage_unlock, inode);
-	if (IS_ERR(pg))
-		return (void *)pg;
-
-	*priv = (unsigned long)pg;
-	return kmap(pg);
-}
-
-void jffs2_gc_release_page(struct jffs2_sb_info *c,
-			   unsigned char *ptr,
-			   unsigned long *priv)
-{
-	struct page *pg = (void *)*priv;
-
-	kunmap(pg);
-	put_page(pg);
-}
-
 static int jffs2_flash_setup(struct jffs2_sb_info *c) {
 	int ret = 0;
 
diff --git a/fs/jffs2/gc.c b/fs/jffs2/gc.c
index 9ed0f26cf023..373b3b7c9f44 100644
--- a/fs/jffs2/gc.c
+++ b/fs/jffs2/gc.c
@@ -1165,12 +1165,13 @@ static int jffs2_garbage_collect_dnode(struct jffs2_sb_info *c, struct jffs2_era
 				       struct jffs2_inode_info *f, struct jffs2_full_dnode *fn,
 				       uint32_t start, uint32_t end)
 {
+	struct inode *inode = OFNI_EDONI_2SFFJ(f);
 	struct jffs2_full_dnode *new_fn;
 	struct jffs2_raw_inode ri;
 	uint32_t alloclen, offset, orig_end, orig_start;
 	int ret = 0;
 	unsigned char *comprbuf = NULL, *writebuf;
-	unsigned long pg;
+	struct page *page;
 	unsigned char *pg_ptr;
 
 	memset(&ri, 0, sizeof(ri));
@@ -1325,15 +1326,18 @@ static int jffs2_garbage_collect_dnode(struct jffs2_sb_info *c, struct jffs2_era
 	 * end up here trying to GC the *same* page that jffs2_write_begin() is
 	 * trying to write out, read_cache_page() will not deadlock. */
 	mutex_unlock(&f->sem);
-	pg_ptr = jffs2_gc_fetch_page(c, f, start, &pg);
-	mutex_lock(&f->sem);
-
-	if (IS_ERR(pg_ptr)) {
+	page = read_cache_page(inode->i_mapping, start >> PAGE_SHIFT,
+			       jffs2_do_readpage_unlock, inode);
+	if (IS_ERR(page)) {
 		pr_warn("read_cache_page() returned error: %ld\n",
-			PTR_ERR(pg_ptr));
-		return PTR_ERR(pg_ptr);
+			PTR_ERR(page));
+		mutex_lock(&f->sem);
+		return PTR_ERR(page);
 	}
 
+	pg_ptr = kmap(page);
+	mutex_lock(&f->sem);
+
 	offset = start;
 	while(offset < orig_end) {
 		uint32_t datalen;
@@ -1396,6 +1400,7 @@ static int jffs2_garbage_collect_dnode(struct jffs2_sb_info *c, struct jffs2_era
 		}
 	}
 
-	jffs2_gc_release_page(c, pg_ptr, &pg);
+	kunmap(page);
+	put_page(page);
 	return ret;
 }
diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
index bd3d5f0ddc34..f4895dda26a3 100644
--- a/fs/jffs2/os-linux.h
+++ b/fs/jffs2/os-linux.h
@@ -183,9 +183,6 @@ unsigned char *jffs2_gc_fetch_page(struct jffs2_sb_info *c,
 				   struct jffs2_inode_info *f,
 				   unsigned long offset,
 				   unsigned long *priv);
-void jffs2_gc_release_page(struct jffs2_sb_info *c,
-			   unsigned char *pg,
-			   unsigned long *priv);
 void jffs2_flash_cleanup(struct jffs2_sb_info *c);
 
 
-- 
2.20.1

