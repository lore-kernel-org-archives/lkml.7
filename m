Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15142C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8F5206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620542;
	bh=t5k0d5Hlbptx9JzbKotbIA33MLcsaAYFkrvVTiPqKCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rb3/ZkTbOdnv+nIU8f0cfwL7tUp5+mhjmkWav43mG1cdu3OPhml+y3LAH46eEwDNI
	 ATl4aGfxPuwpqcmagHnpcDC+l6UMrsuCCMRGYU8pk3fP+Pdv/OXEpCSkd10eMcqjDS
	 f3nZEJ5yWWZc5OqLrRqCEL/yFA9/kPt5RH/IQnvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389879AbfIDSJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:09:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389875AbfIDSJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:09:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA78D206B8;
        Wed,  4 Sep 2019 18:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620539;
        bh=t5k0d5Hlbptx9JzbKotbIA33MLcsaAYFkrvVTiPqKCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FlOwsUr1FjIeDkJ336dSN2E0qQtEA+XQuQthBr9jmpLyOft3A8s85wLEi0JXnYcRc
         dUnp2Lg/CckOr3K/2EbHUMDvgqhQD1b/T2JTCyD3ySGWUfSFiRlT5nXxy5+FpS5rn7
         gQenUmiwHUAuSf+xKrkysnYWYGYKZ+ln4fgZi2mM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 89/93] NFS: Pass error information to the pgio error cleanup routine
Date:   Wed,  4 Sep 2019 19:54:31 +0200
Message-Id: <20190904175310.804759726@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175302.845828956@linuxfoundation.org>
References: <20190904175302.845828956@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit df3accb849607a86278a37c35e6b313635ccc48b ]

Allow the caller to pass error information when cleaning up a failed
I/O request so that we can conditionally take action to cancel the
request altogether if the error turned out to be fatal.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/direct.c         |  4 ++--
 fs/nfs/pagelist.c       |  5 +++--
 fs/nfs/read.c           |  2 +-
 fs/nfs/write.c          | 11 +++++++++--
 include/linux/nfs_xdr.h |  2 +-
 5 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 1377ee20ecf91..0fd811ac08b52 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -428,7 +428,7 @@ out_put:
 	hdr->release(hdr);
 }
 
-static void nfs_read_sync_pgio_error(struct list_head *head)
+static void nfs_read_sync_pgio_error(struct list_head *head, int error)
 {
 	struct nfs_page *req;
 
@@ -820,7 +820,7 @@ out_put:
 	hdr->release(hdr);
 }
 
-static void nfs_write_sync_pgio_error(struct list_head *head)
+static void nfs_write_sync_pgio_error(struct list_head *head, int error)
 {
 	struct nfs_page *req;
 
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 9cbd829b4ed5f..7f0b9409202cc 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -994,7 +994,7 @@ nfs_pageio_cleanup_request(struct nfs_pageio_descriptor *desc,
 	LIST_HEAD(head);
 
 	nfs_list_move_request(req, &head);
-	desc->pg_completion_ops->error_cleanup(&head);
+	desc->pg_completion_ops->error_cleanup(&head, desc->pg_error);
 }
 
 /**
@@ -1130,7 +1130,8 @@ static void nfs_pageio_error_cleanup(struct nfs_pageio_descriptor *desc)
 
 	for (midx = 0; midx < desc->pg_mirror_count; midx++) {
 		mirror = &desc->pg_mirrors[midx];
-		desc->pg_completion_ops->error_cleanup(&mirror->pg_list);
+		desc->pg_completion_ops->error_cleanup(&mirror->pg_list,
+				desc->pg_error);
 	}
 }
 
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 48d7277c60a97..09d5c282f50e9 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -205,7 +205,7 @@ static void nfs_initiate_read(struct nfs_pgio_header *hdr,
 }
 
 static void
-nfs_async_read_error(struct list_head *head)
+nfs_async_read_error(struct list_head *head, int error)
 {
 	struct nfs_page	*req;
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 51d0b7913c04c..5ab997912d8d5 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1394,20 +1394,27 @@ static void nfs_redirty_request(struct nfs_page *req)
 	nfs_release_request(req);
 }
 
-static void nfs_async_write_error(struct list_head *head)
+static void nfs_async_write_error(struct list_head *head, int error)
 {
 	struct nfs_page	*req;
 
 	while (!list_empty(head)) {
 		req = nfs_list_entry(head->next);
 		nfs_list_remove_request(req);
+		if (nfs_error_is_fatal(error)) {
+			nfs_context_set_write_error(req->wb_context, error);
+			if (nfs_error_is_fatal_on_server(error)) {
+				nfs_write_error_remove_page(req);
+				continue;
+			}
+		}
 		nfs_redirty_request(req);
 	}
 }
 
 static void nfs_async_write_reschedule_io(struct nfs_pgio_header *hdr)
 {
-	nfs_async_write_error(&hdr->pages);
+	nfs_async_write_error(&hdr->pages, 0);
 	filemap_fdatawrite_range(hdr->inode->i_mapping, hdr->args.offset,
 			hdr->args.offset + hdr->args.count - 1);
 }
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index bd1c889a9ed95..cab24a127feb3 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1539,7 +1539,7 @@ struct nfs_commit_data {
 };
 
 struct nfs_pgio_completion_ops {
-	void	(*error_cleanup)(struct list_head *head);
+	void	(*error_cleanup)(struct list_head *head, int);
 	void	(*init_hdr)(struct nfs_pgio_header *hdr);
 	void	(*completion)(struct nfs_pgio_header *hdr);
 	void	(*reschedule_io)(struct nfs_pgio_header *hdr);
-- 
2.20.1



