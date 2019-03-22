Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF13C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12E7218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254705;
	bh=7tVHIDM5Y3RCMPC1Pb3cwS191QM+iWTF0N0c+p73s4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vjlQTRFSZNf3Mlz4FTF7qTwb2DH1Q2SLGaB9ZkTy+H+xBfV1mDBCpcnLjs7mQtbhK
	 VBeS9WkDYNJ6M/oUpVfeDHMBQ8LZYXOCSeHkOfKFy3wmmJzoCOeG1S4q7RGT2PzcrY
	 lluwiwZI5PAP6jQqLZLlxvcsYagCRnGSggIQArQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbfCVLiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730953AbfCVLiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:38:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D9E0218B0;
        Fri, 22 Mar 2019 11:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254698;
        bh=7tVHIDM5Y3RCMPC1Pb3cwS191QM+iWTF0N0c+p73s4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D0XPeDonHLAclsSy6r2kdIj15rW+kO5xwPvH9Txaver3zHX0BSCaMe/1OQ+DLHMgt
         ZzWgE1rHbXEFlKC80HVBbF84MUZRPQU6X8A9rn8S9vbViinKufthxG9fdCCRvTn8pE
         0cyUEkLbvkCdC49p9t52TRTYWrzQfZ8BlBrViN/U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Tao <tao.peng@primarydata.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>
Subject: [PATCH 4.4 215/230] NFS41: pop some layoutget errors to application
Date:   Fri, 22 Mar 2019 12:15:53 +0100
Message-Id: <20190322111251.956904461@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Tao <tao.peng@primarydata.com>

commit d600ad1f2bdbf97c4818dcc85b174f72c90c21bd upstream.

For ERESTARTSYS/EIO/EROFS/ENOSPC/E2BIG in layoutget, we
should just bail out instead of hiding the error and
retrying inband IO.

Change all the call sites to pop the error all the way up.

Signed-off-by: Peng Tao <tao.peng@primarydata.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/direct.c                        |   15 ++++++++++++++-
 fs/nfs/filelayout/filelayout.c         |   17 +++++++++++++++--
 fs/nfs/flexfilelayout/flexfilelayout.c |   25 ++++++++++++++++++++++---
 fs/nfs/pagelist.c                      |    9 ++++++++-
 fs/nfs/pnfs.c                          |   24 ++++++++++++++++++------
 fs/nfs/read.c                          |    2 +-
 6 files changed, 78 insertions(+), 14 deletions(-)

--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -670,6 +670,10 @@ static void nfs_direct_write_reschedule(
 
 	req = nfs_list_entry(reqs.next);
 	nfs_direct_setup_mirroring(dreq, &desc, req);
+	if (desc.pg_error < 0) {
+		list_splice_init(&reqs, &failed);
+		goto out_failed;
+	}
 
 	list_for_each_entry_safe(req, tmp, &reqs, wb_list) {
 		if (!nfs_pageio_add_request(&desc, req)) {
@@ -677,13 +681,17 @@ static void nfs_direct_write_reschedule(
 			nfs_list_add_request(req, &failed);
 			spin_lock(cinfo.lock);
 			dreq->flags = 0;
-			dreq->error = -EIO;
+			if (desc.pg_error < 0)
+				dreq->error = desc.pg_error;
+			else
+				dreq->error = -EIO;
 			spin_unlock(cinfo.lock);
 		}
 		nfs_release_request(req);
 	}
 	nfs_pageio_complete(&desc);
 
+out_failed:
 	while (!list_empty(&failed)) {
 		req = nfs_list_entry(failed.next);
 		nfs_list_remove_request(req);
@@ -898,6 +906,11 @@ static ssize_t nfs_direct_write_schedule
 			}
 
 			nfs_direct_setup_mirroring(dreq, &desc, req);
+			if (desc.pg_error < 0) {
+				nfs_free_request(req);
+				result = desc.pg_error;
+				break;
+			}
 
 			nfs_lock_request(req);
 			req->wb_index = pos >> PAGE_SHIFT;
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -882,13 +882,19 @@ static void
 filelayout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 			struct nfs_page *req)
 {
-	if (!pgio->pg_lseg)
+	if (!pgio->pg_lseg) {
 		pgio->pg_lseg = pnfs_update_layout(pgio->pg_inode,
 					   req->wb_context,
 					   0,
 					   NFS4_MAX_UINT64,
 					   IOMODE_READ,
 					   GFP_KERNEL);
+		if (IS_ERR(pgio->pg_lseg)) {
+			pgio->pg_error = PTR_ERR(pgio->pg_lseg);
+			pgio->pg_lseg = NULL;
+			return;
+		}
+	}
 	/* If no lseg, fall back to read through mds */
 	if (pgio->pg_lseg == NULL)
 		nfs_pageio_reset_read_mds(pgio);
@@ -901,13 +907,20 @@ filelayout_pg_init_write(struct nfs_page
 	struct nfs_commit_info cinfo;
 	int status;
 
-	if (!pgio->pg_lseg)
+	if (!pgio->pg_lseg) {
 		pgio->pg_lseg = pnfs_update_layout(pgio->pg_inode,
 					   req->wb_context,
 					   0,
 					   NFS4_MAX_UINT64,
 					   IOMODE_RW,
 					   GFP_NOFS);
+		if (IS_ERR(pgio->pg_lseg)) {
+			pgio->pg_error = PTR_ERR(pgio->pg_lseg);
+			pgio->pg_lseg = NULL;
+			return;
+		}
+	}
+
 	/* If no lseg, fall back to write through mds */
 	if (pgio->pg_lseg == NULL)
 		goto out_mds;
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -786,13 +786,19 @@ ff_layout_pg_init_read(struct nfs_pageio
 	int ds_idx;
 
 	/* Use full layout for now */
-	if (!pgio->pg_lseg)
+	if (!pgio->pg_lseg) {
 		pgio->pg_lseg = pnfs_update_layout(pgio->pg_inode,
 						   req->wb_context,
 						   0,
 						   NFS4_MAX_UINT64,
 						   IOMODE_READ,
 						   GFP_KERNEL);
+		if (IS_ERR(pgio->pg_lseg)) {
+			pgio->pg_error = PTR_ERR(pgio->pg_lseg);
+			pgio->pg_lseg = NULL;
+			return;
+		}
+	}
 	/* If no lseg, fall back to read through mds */
 	if (pgio->pg_lseg == NULL)
 		goto out_mds;
@@ -826,13 +832,19 @@ ff_layout_pg_init_write(struct nfs_pagei
 	int i;
 	int status;
 
-	if (!pgio->pg_lseg)
+	if (!pgio->pg_lseg) {
 		pgio->pg_lseg = pnfs_update_layout(pgio->pg_inode,
 						   req->wb_context,
 						   0,
 						   NFS4_MAX_UINT64,
 						   IOMODE_RW,
 						   GFP_NOFS);
+		if (IS_ERR(pgio->pg_lseg)) {
+			pgio->pg_error = PTR_ERR(pgio->pg_lseg);
+			pgio->pg_lseg = NULL;
+			return;
+		}
+	}
 	/* If no lseg, fall back to write through mds */
 	if (pgio->pg_lseg == NULL)
 		goto out_mds;
@@ -868,18 +880,25 @@ static unsigned int
 ff_layout_pg_get_mirror_count_write(struct nfs_pageio_descriptor *pgio,
 				    struct nfs_page *req)
 {
-	if (!pgio->pg_lseg)
+	if (!pgio->pg_lseg) {
 		pgio->pg_lseg = pnfs_update_layout(pgio->pg_inode,
 						   req->wb_context,
 						   0,
 						   NFS4_MAX_UINT64,
 						   IOMODE_RW,
 						   GFP_NOFS);
+		if (IS_ERR(pgio->pg_lseg)) {
+			pgio->pg_error = PTR_ERR(pgio->pg_lseg);
+			pgio->pg_lseg = NULL;
+			goto out;
+		}
+	}
 	if (pgio->pg_lseg)
 		return FF_LAYOUT_MIRROR_COUNT(pgio->pg_lseg);
 
 	/* no lseg means that pnfs is not in use, so no mirroring here */
 	nfs_pageio_reset_write_mds(pgio);
+out:
 	return 1;
 }
 
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -872,6 +872,9 @@ static int nfs_pageio_setup_mirroring(st
 
 	mirror_count = pgio->pg_ops->pg_get_mirror_count(pgio, req);
 
+	if (pgio->pg_error < 0)
+		return pgio->pg_error;
+
 	if (!mirror_count || mirror_count > NFS_PAGEIO_DESCRIPTOR_MIRROR_MAX)
 		return -EINVAL;
 
@@ -980,6 +983,8 @@ static int nfs_pageio_do_add_request(str
 	} else {
 		if (desc->pg_ops->pg_init)
 			desc->pg_ops->pg_init(desc, req);
+		if (desc->pg_error < 0)
+			return 0;
 		mirror->pg_base = req->wb_pgbase;
 	}
 	if (!nfs_can_coalesce_requests(prev, req, desc))
@@ -1145,6 +1150,8 @@ int nfs_pageio_add_request(struct nfs_pa
 	bytes = req->wb_bytes;
 
 	nfs_pageio_setup_mirroring(desc, req);
+	if (desc->pg_error < 0)
+		return 0;
 
 	for (midx = 0; midx < desc->pg_mirror_count; midx++) {
 		if (midx) {
@@ -1230,7 +1237,7 @@ int nfs_pageio_resend(struct nfs_pageio_
 	nfs_pageio_complete(desc);
 	if (!list_empty(&failed)) {
 		list_move(&failed, &hdr->pages);
-		return -EIO;
+		return desc->pg_error < 0 ? desc->pg_error : -EIO;
 	}
 	return 0;
 }
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -909,14 +909,15 @@ send_layoutget(struct pnfs_layout_hdr *l
 
 	if (IS_ERR(lseg)) {
 		switch (PTR_ERR(lseg)) {
-		case -ENOMEM:
 		case -ERESTARTSYS:
+		case -EIO:
+		case -ENOSPC:
+		case -EROFS:
+		case -E2BIG:
 			break;
 		default:
-			/* remember that LAYOUTGET failed and suspend trying */
-			pnfs_layout_io_set_failed(lo, range->iomode);
+			return NULL;
 		}
-		return NULL;
 	} else
 		pnfs_layout_clear_fail_bit(lo,
 				pnfs_iomode_to_fail_bit(range->iomode));
@@ -1625,7 +1626,7 @@ out:
 			"(%s, offset: %llu, length: %llu)\n",
 			__func__, ino->i_sb->s_id,
 			(unsigned long long)NFS_FILEID(ino),
-			lseg == NULL ? "not found" : "found",
+			IS_ERR_OR_NULL(lseg) ? "not found" : "found",
 			iomode==IOMODE_RW ?  "read/write" : "read-only",
 			(unsigned long long)pos,
 			(unsigned long long)count);
@@ -1804,6 +1805,11 @@ pnfs_generic_pg_init_read(struct nfs_pag
 						   rd_size,
 						   IOMODE_READ,
 						   GFP_KERNEL);
+		if (IS_ERR(pgio->pg_lseg)) {
+			pgio->pg_error = PTR_ERR(pgio->pg_lseg);
+			pgio->pg_lseg = NULL;
+			return;
+		}
 	}
 	/* If no lseg, fall back to read through mds */
 	if (pgio->pg_lseg == NULL)
@@ -1816,13 +1822,19 @@ void
 pnfs_generic_pg_init_write(struct nfs_pageio_descriptor *pgio,
 			   struct nfs_page *req, u64 wb_size)
 {
-	if (pgio->pg_lseg == NULL)
+	if (pgio->pg_lseg == NULL) {
 		pgio->pg_lseg = pnfs_update_layout(pgio->pg_inode,
 						   req->wb_context,
 						   req_offset(req),
 						   wb_size,
 						   IOMODE_RW,
 						   GFP_NOFS);
+		if (IS_ERR(pgio->pg_lseg)) {
+			pgio->pg_error = PTR_ERR(pgio->pg_lseg);
+			pgio->pg_lseg = NULL;
+			return;
+		}
+	}
 	/* If no lseg, fall back to write through mds */
 	if (pgio->pg_lseg == NULL)
 		nfs_pageio_reset_write_mds(pgio);
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -115,7 +115,7 @@ int nfs_readpage_async(struct nfs_open_c
 	pgm = &pgio.pg_mirrors[0];
 	NFS_I(inode)->read_io += pgm->pg_bytes_written;
 
-	return 0;
+	return pgio.pg_error < 0 ? pgio.pg_error : 0;
 }
 
 static void nfs_readpage_release(struct nfs_page *req)


