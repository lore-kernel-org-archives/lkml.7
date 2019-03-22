Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE1BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9A12082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256373;
	bh=2lNWOdiUFCHN0LFSYgH4Yldz4nscNDxzyHxtwBn1dRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WUnp1/ODQmSCOP/fQ3LEp0uWCzRO9hd8Zj5DEBfWTR+/V45TSnlIS9aDk7JxXghpQ
	 fykFkrzQ+FGoDDPCUwN+nZIXUZVrGk2djgSPr8U0LTgSYaANO4yiMobPCf3zYQcMlG
	 IqZoqCzXyKOPH5Khs/4L64IQHoI02skMdo4y1PvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388905AbfCVMGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:06:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388888AbfCVMGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:06:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 903BB206C0;
        Fri, 22 Mar 2019 12:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256369;
        bh=2lNWOdiUFCHN0LFSYgH4Yldz4nscNDxzyHxtwBn1dRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MmjRRX7IStZ4+pvC6UmRMV5hHTdt1xNKMUqQtQYG+lu1H7juTQLBcX9lmQMQr1pTv
         aTAHWX3CDLpi+3paQTtyC+ypjKXo5t91nOrgO3GX2sdNDIFQPMonb9baaOoOhVC2Tv
         o8V0Q8cY36oHyZzPiq188I+X4J5i1DOT8T8L2BNE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 168/280] Btrfs: setup a nofs context for memory allocation at btrfs_create_tree()
Date:   Fri, 22 Mar 2019 12:15:21 +0100
Message-Id: <20190322111323.923063772@linuxfoundation.org>
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

From: Filipe Manana <fdmanana@suse.com>

commit b89f6d1fcb30a8cbdc18ce00c7d93792076af453 upstream.

We are holding a transaction handle when creating a tree, therefore we can
not allocate the root using GFP_KERNEL, as we could deadlock if reclaim is
triggered by the allocation, therefore setup a nofs context.

Fixes: 74e4d82757f74 ("btrfs: let callers of btrfs_alloc_root pass gfp flags")
CC: stable@vger.kernel.org # 4.9+
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/disk-io.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -17,6 +17,7 @@
 #include <linux/semaphore.h>
 #include <linux/error-injection.h>
 #include <linux/crc32c.h>
+#include <linux/sched/mm.h>
 #include <asm/unaligned.h>
 #include "ctree.h"
 #include "disk-io.h"
@@ -1236,10 +1237,17 @@ struct btrfs_root *btrfs_create_tree(str
 	struct btrfs_root *tree_root = fs_info->tree_root;
 	struct btrfs_root *root;
 	struct btrfs_key key;
+	unsigned int nofs_flag;
 	int ret = 0;
 	uuid_le uuid = NULL_UUID_LE;
 
+	/*
+	 * We're holding a transaction handle, so use a NOFS memory allocation
+	 * context to avoid deadlock if reclaim happens.
+	 */
+	nofs_flag = memalloc_nofs_save();
 	root = btrfs_alloc_root(fs_info, GFP_KERNEL);
+	memalloc_nofs_restore(nofs_flag);
 	if (!root)
 		return ERR_PTR(-ENOMEM);
 


