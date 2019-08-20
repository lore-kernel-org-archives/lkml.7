Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E58CC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A14E206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 10:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfHTKEf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 06:04:35 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25451 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728426AbfHTKEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 06:04:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566295435; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=hG2OPW+QxI+5uVRsxmo8lbPUNQvqp2aT4uCT/zKQ8MZPlvCwTPk7kpxB2vyUOR81oD76XWTAy+2KvAFTOl/lJusnWvJ6tuHllKX8kQ2xJEFueCv971EX+C+7GE/Z7RT+2av/hrmdeLwveweiNfo4Z87gtg44eFYQDSEtJL+RCu4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1566295435; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=qWDUnb9Mvb2aBEhtl+DI3fDd1UcOPYz2zkXQ59ewVy4=; 
        b=quNOa9OSA6wqDL+7VzIL2bhP7wco1eXzY9HCFfGE+60tzb0R6NqfFNpX45mVLejGVeSULxONuL+334ezFtJNHPPzqu+3m8khw1si0RXBrToqL2+qbJlU371I3fMevKepbP7oogE3jdYJwo2UOhoUgq1BfivOp34Tj39wiW7778o=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 156629543308886.05180690754912; Tue, 20 Aug 2019 18:03:53 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@zoho.com.cn>
Message-ID: <20190820100325.10313-1-cgxu519@zoho.com.cn>
Subject: [PATCH] 9p: avoid attaching writeback_fid on mmap with type PRIVATE
Date:   Tue, 20 Aug 2019 18:03:25 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on mmap cache policy, we always attach writeback_fid
whether mmap type is SHARED or PRIVATE. However, in the use case
of kata-container which combines 9p(Guest OS) with overlayfs(Host OS),
this behavior will trigger overlayfs' copy-up when excute command
inside container.

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
 fs/9p/vfs_file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 4cc966a31cb3..fe7f0bd2048e 100644
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



