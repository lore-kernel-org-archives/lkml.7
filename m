Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF674C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7949E218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258822;
	bh=VWOnUoRwhlfH+YcVc99feLpZsvDxyOFEnxCZnY7WCvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y/Y7RGmwePcUWM4TzherKPIvddjxJpELlDtQ9vz2TFIg90Fx7yPNIYaQ8uBvIHhq+
	 +pE1qrGM7WDINx3js021tBSBIC4ms9eKp+eGiRbbntaSfLSW6sc/u8+o0awx4e205X
	 JVhkngvLlCqyYmxlebX+HsZPr+qX1CNi+k6YB06o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388091AbfCVMrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:47:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733174AbfCVL6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:58:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FC9E20850;
        Fri, 22 Mar 2019 11:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255921;
        bh=VWOnUoRwhlfH+YcVc99feLpZsvDxyOFEnxCZnY7WCvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FGpFXjtQICBeZfUpNwlYpzMm0ygw1i3uY/QrioZmZPLpO5+nyyhKFayqJYSSzJq0r
         TBAl6Kr1lLdpMBJOJ0RwgMaHxV2PtHiPUVUaDLjCoe9jahaRwPSGu5uEH2cmJF1wfN
         YZv/aN4JjUjyIlF1HnYZAeWG/RDhyrtv99sp7YD0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Coddington <bcodding@redhat.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 055/280] NFS: Dont use page_file_mapping after removing the page
Date:   Fri, 22 Mar 2019 12:13:28 +0100
Message-Id: <20190322111309.381984643@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index d790faff8e47..51d0b7913c04 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -238,9 +238,9 @@ out:
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



