Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7CFECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6752A21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571262867;
	bh=2i8+d2TT3yX8/1+HhuIWKqY7fbcAmg4UD+/uh4pIKuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r+Tmh8x9iboR8QsN7Qx4MurYVloSdew2IadY6Tr34ISKtycWMMlks7091q6Z5ItRk
	 4469I1KmkYRS2iMLP4NHtgPanD8L+fUUkyYhgQXqboHh7kfv0eRs1+lQmRlNayjxJP
	 6YztxH2Fz7Q4+VkYGXj/ZpbJsfdJnknXum2z+wSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394997AbfJPVy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:54:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437700AbfJPVyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:54:11 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C54D2218DE;
        Wed, 16 Oct 2019 21:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262851;
        bh=2i8+d2TT3yX8/1+HhuIWKqY7fbcAmg4UD+/uh4pIKuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pWtfigqn0yS+IwShFbbfKTy4NDeKwmAKt2pGrS0aEIFdl5y29oSDFSkkfogaJchg9
         cXENLzmnM781neTXsGwpkDPDTByJUeWvICf9pjs+DSiLME1QJYvHbyqCFXiqEKuBSu
         512uy/VqCQJnboss8ml0MPICTsTJs7OXUSmnPylI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 17/92] 9p: avoid attaching writeback_fid on mmap with type PRIVATE
Date:   Wed, 16 Oct 2019 14:49:50 -0700
Message-Id: <20191016214815.045948092@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214759.600329427@linuxfoundation.org>
References: <20191016214759.600329427@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 79ff727254bb6..e963b83afc717 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -528,6 +528,7 @@ v9fs_mmap_file_mmap(struct file *filp, struct vm_area_struct *vma)
 	v9inode = V9FS_I(inode);
 	mutex_lock(&v9inode->v_mutex);
 	if (!v9inode->writeback_fid &&
+	    (vma->vm_flags & VM_SHARED) &&
 	    (vma->vm_flags & VM_WRITE)) {
 		/*
 		 * clone a fid and add it to writeback_fid
@@ -629,6 +630,8 @@ static void v9fs_mmap_vm_close(struct vm_area_struct *vma)
 			(vma->vm_end - vma->vm_start - 1),
 	};
 
+	if (!(vma->vm_flags & VM_SHARED))
+		return;
 
 	p9_debug(P9_DEBUG_VFS, "9p VMA close, %p, flushing", vma);
 
-- 
2.20.1



