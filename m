Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E2BC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD5521873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259462;
	bh=TwIzy3FxDzvZ6pJLMHZe1ospJvhB/racGeR8Zebyndg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QTX1v/6kt7Kdf031vh7ZLRNyZi0hZVmt7nEc2LdkdeghFbYoD86+AmSX0FQiga0NM
	 oFOhF1rlojlRtN8/zJO86PHTh36r6QLoMGIbIVX+VAcB9+T/q5ygc6mXdfkIjkYMxr
	 Ng8B5KJSEHJOtyPaihWQanoNGscnb6Obw5kaW+/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbfCVLrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732158AbfCVLrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:47:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D30E7218B0;
        Fri, 22 Mar 2019 11:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255236;
        bh=TwIzy3FxDzvZ6pJLMHZe1ospJvhB/racGeR8Zebyndg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HV5e6dV5jGeZUDT5n8Ip2a+mqKWN2AlAbMVigk3xCaG38oFlevPmYSTedLmbLEuNq
         etMcY2QFZTkfnTahDP8mT0Zb9aV5TGjvnQEWOdWk2aqMsXdLX6ODgKKKJ10k2/HASM
         jh7hA5neDerCp/6+sMu9KHSTFyoH13SVZGoDgX+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Coddington <bcodding@redhat.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 028/183] NFS: Dont use page_file_mapping after removing the page
Date:   Fri, 22 Mar 2019 12:14:16 +0100
Message-Id: <20190322111243.784596897@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d2ceb7e57086750ea6198a31fd942d98099a0786 ]

If nfs_page_async_flush() removes the page from the mapping, then we can't
use page_file_mapping() on it as nfs_updatepate() is wont to do when
receiving an error.  Instead, push the mapping to the stack before the page
is possibly truncated.

Fixes: 8fc75bed96bb ("NFS: Fix up return value on fatal errors in nfs_page_async_flush()")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/write.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 2d956a7d5378..50ed3944d183 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -236,9 +236,9 @@ out:
 }
 
 /* A writeback failed: mark the page as bad, and invalidate the page cache */
-static void nfs_set_pageerror(struct page *page)
+static void nfs_set_pageerror(struct address_space *mapping)
 {
-	nfs_zap_mapping(page_file_mapping(page)->host, page_file_mapping(page));
+	nfs_zap_mapping(mapping->host, mapping);
 }
 
 /*
@@ -994,7 +994,7 @@ static void nfs_write_completion(struct nfs_pgio_header *hdr)
 		nfs_list_remove_request(req);
 		if (test_bit(NFS_IOHDR_ERROR, &hdr->flags) &&
 		    (hdr->good_bytes < bytes)) {
-			nfs_set_pageerror(req->wb_page);
+			nfs_set_pageerror(page_file_mapping(req->wb_page));
 			nfs_context_set_write_error(req->wb_context, hdr->error);
 			goto remove_req;
 		}
@@ -1330,7 +1330,8 @@ int nfs_updatepage(struct file *file, struct page *page,
 		unsigned int offset, unsigned int count)
 {
 	struct nfs_open_context *ctx = nfs_file_open_context(file);
-	struct inode	*inode = page_file_mapping(page)->host;
+	struct address_space *mapping = page_file_mapping(page);
+	struct inode	*inode = mapping->host;
 	int		status = 0;
 
 	nfs_inc_stats(inode, NFSIOS_VFSUPDATEPAGE);
@@ -1348,7 +1349,7 @@ int nfs_updatepage(struct file *file, struct page *page,
 
 	status = nfs_writepage_setup(ctx, page, offset, count);
 	if (status < 0)
-		nfs_set_pageerror(page);
+		nfs_set_pageerror(mapping);
 	else
 		__set_page_dirty_nobuffers(page);
 out:
-- 
2.19.1



