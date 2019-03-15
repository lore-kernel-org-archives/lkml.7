Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D6CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8B9218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfCOXHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:07:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727487AbfCOXHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:07:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A734624DF;
        Fri, 15 Mar 2019 23:00:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B5C65C219;
        Fri, 15 Mar 2019 23:00:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/10] afs: Improve dir check failure reports
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 15 Mar 2019 23:00:07 +0000
Message-ID: <155269080775.8537.9854043799542826114.stgit@warthog.procyon.org.uk>
In-Reply-To: <155269076033.8537.10785090349210421514.stgit@warthog.procyon.org.uk>
References: <155269076033.8537.10785090349210421514.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 15 Mar 2019 23:00:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve the content of directory check failure reports from:

	kAFS: afs_dir_check_page(6d57): bad magic 1/2 is 0000

to dump more information about the individual blocks in a directory page.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c |   38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 8a2562e3a316..378a96a1116e 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -159,6 +159,38 @@ static bool afs_dir_check_page(struct afs_vnode *dvnode, struct page *page,
 	return false;
 }
 
+/*
+ * Check the contents of a directory that we've just read.
+ */
+static bool afs_dir_check_pages(struct afs_vnode *dvnode, struct afs_read *req)
+{
+	struct afs_xdr_dir_page *dbuf;
+	unsigned int i, j, qty = PAGE_SIZE / sizeof(union afs_xdr_dir_block);
+
+	for (i = 0; i < req->nr_pages; i++)
+		if (!afs_dir_check_page(dvnode, req->pages[i], req->actual_len))
+			goto bad;
+	return true;
+
+bad:
+	pr_warn("DIR %llx:%llx f=%llx l=%llx al=%llx r=%llx\n",
+		dvnode->fid.vid, dvnode->fid.vnode,
+		req->file_size, req->len, req->actual_len, req->remain);
+	pr_warn("DIR %llx %x %x %x\n",
+		req->pos, req->index, req->nr_pages, req->offset);
+
+	for (i = 0; i < req->nr_pages; i++) {
+		dbuf = kmap(req->pages[i]);
+		for (j = 0; j < qty; j++) {
+			union afs_xdr_dir_block *block = &dbuf->blocks[j];
+
+			pr_warn("[%02x] %32phN\n", i * qty + j, block);
+		}
+		kunmap(req->pages[i]);
+	}
+	return false;
+}
+
 /*
  * open an AFS directory file
  */
@@ -288,10 +320,8 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 
 		/* Validate the data we just read. */
 		ret = -EIO;
-		for (i = 0; i < req->nr_pages; i++)
-			if (!afs_dir_check_page(dvnode, req->pages[i],
-						req->actual_len))
-				goto error_unlock;
+		if (!afs_dir_check_pages(dvnode, req))
+			goto error_unlock;
 
 		// TODO: Trim excess pages
 

