Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D478CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16592083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257077;
	bh=bkeEgTzU/XwxWdjoiiW7zcJPJV41QVra/ez+8OUt1ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0n5e2sguHkrWe+a0r/lMEdd4lxz4NR6U2AWHQxjhH4unnseqshpulZ8XA5ask3A/4
	 lCXTztJYfWBYmNHToUd/+o8PMy6SD/tuKziVordbokzmAkELDZw25ApORLBNuRV29a
	 kbEGk/gU66TI4lik/DJTukO3Zn6Oh2UMcgcR07bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390437AbfCVMR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:17:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390028AbfCVMRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:17:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21A6F21900;
        Fri, 22 Mar 2019 12:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257072;
        bh=bkeEgTzU/XwxWdjoiiW7zcJPJV41QVra/ez+8OUt1ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B56sbSW4WMuTLut0t/qPHcJZzvxRpMDr9GIzVCiQSHaj8XnYXJYvXHRkrtfnUjPAP
         DpbfJJYvqEJExWL+J0Z+hAHiomiFzMJQR2LWl4Quoi+c97VKGSl40eZ07XPdMKInRI
         oe4oEhK3fB8GS0YblDLbxIei+/OhBdMNwPyfdDZo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.0 092/238] Btrfs: setup a nofs context for memory allocation at __btrfs_set_acl
Date:   Fri, 22 Mar 2019 12:15:11 +0100
Message-Id: <20190322111304.006504743@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit a0873490660246db587849a9e172f2b7b21fa88a upstream.

We are holding a transaction handle when setting an acl, therefore we can
not allocate the xattr value buffer using GFP_KERNEL, as we could deadlock
if reclaim is triggered by the allocation, therefore setup a nofs context.

Fixes: 39a27ec1004e8 ("btrfs: use GFP_KERNEL for xattr and acl allocations")
CC: stable@vger.kernel.org # 4.9+
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/acl.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/btrfs/acl.c
+++ b/fs/btrfs/acl.c
@@ -9,6 +9,7 @@
 #include <linux/posix_acl_xattr.h>
 #include <linux/posix_acl.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/slab.h>
 
 #include "ctree.h"
@@ -72,8 +73,16 @@ static int __btrfs_set_acl(struct btrfs_
 	}
 
 	if (acl) {
+		unsigned int nofs_flag;
+
 		size = posix_acl_xattr_size(acl->a_count);
+		/*
+		 * We're holding a transaction handle, so use a NOFS memory
+		 * allocation context to avoid deadlock if reclaim happens.
+		 */
+		nofs_flag = memalloc_nofs_save();
 		value = kmalloc(size, GFP_KERNEL);
+		memalloc_nofs_restore(nofs_flag);
 		if (!value) {
 			ret = -ENOMEM;
 			goto out;


