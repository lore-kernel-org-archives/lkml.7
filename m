Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E595AC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24D12168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569948100;
	bh=kjBBx1owjHoHOHK+PfnP7vwaB5MJ/Cp+vuwoeSfQum4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GEEyyt1lbWVQ3ysewpA0P35U7eXfLXY4hqmxsm/TjSHeeQfBQZTXVfcbyLAEXlbwP
	 nI1X1/tQrw3jT7rdzBeCIzxDnKzvhB1z36kSB3C5J39H+g6PkA+75q4AbbiSFEXvgx
	 zoV9udxhsB3X4NOdFusZpIn4357eNlnSHG9U9uiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbfJAQlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:41:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731144AbfJAQlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:41:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E285C20B7C;
        Tue,  1 Oct 2019 16:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569948095;
        bh=kjBBx1owjHoHOHK+PfnP7vwaB5MJ/Cp+vuwoeSfQum4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MhYsN9qOdr9A26KIfRcbsVp4Ik+HCAFPpB+tgio5u32+d9ls657osclLpX8DG4HX/
         XGn424WLHuU25sUu5UZbjMg4BKrtUGXppOq2bgZ0iOfCaAIQXbvDP4P5n9AhOXo9gL
         fP5HHyL4FFY8MffX66OX6npts+c/zWvrRNX5bSBU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chengguang Xu <cgxu519@zoho.com.cn>,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>,
        v9fs-developer@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.2 07/63] 9p: avoid attaching writeback_fid on mmap with type PRIVATE
Date:   Tue,  1 Oct 2019 12:40:29 -0400
Message-Id: <20191001164125.15398-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191001164125.15398-1-sashal@kernel.org>
References: <20191001164125.15398-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengguang Xu <cgxu519@zoho.com.cn>

[ Upstream commit c87a37ebd40b889178664c2c09cc187334146292 ]

Currently on mmap cache policy, we always attach writeback_fid
whether mmap type is SHARED or PRIVATE. However, in the use case
of kata-container which combines 9p(Guest OS) with overlayfs(Host OS),
this behavior will trigger overlayfs' copy-up when excute command
inside container.

Link: http://lkml.kernel.org/r/20190820100325.10313-1-cgxu519@zoho.com.cn
Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 4cc966a31cb37..fe7f0bd2048e4 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -513,6 +513,7 @@ v9fs_mmap_file_mmap(struct file *filp, struct vm_area_struct *vma)
 	v9inode = V9FS_I(inode);
 	mutex_lock(&v9inode->v_mutex);
 	if (!v9inode->writeback_fid &&
+	    (vma->vm_flags & VM_SHARED) &&
 	    (vma->vm_flags & VM_WRITE)) {
 		/*
 		 * clone a fid and add it to writeback_fid
@@ -614,6 +615,8 @@ static void v9fs_mmap_vm_close(struct vm_area_struct *vma)
 			(vma->vm_end - vma->vm_start - 1),
 	};
 
+	if (!(vma->vm_flags & VM_SHARED))
+		return;
 
 	p9_debug(P9_DEBUG_VFS, "9p VMA close, %p, flushing", vma);
 
-- 
2.20.1

