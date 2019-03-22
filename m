Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F003C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021D32070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258448;
	bh=UVwpdG331tIdfKF8FsJScqU04M8ae2jkndZsuWZa3FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KsT6IUi6g5OqDsrSNs592SCMVVzckIA90Jk6BQDgq1XHxIMbbt5FtkbXqKYxZgvb/
	 Iv6reW2QtmQKPS7CyFDHQubELQK4HKSgjc5fui2wDO5QqJx2EUr+5baRWnKbnm2lCF
	 1RLvKaYgOieObEw7enWjikV8AVt4/FiC4FEy8pxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388285AbfCVMGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:06:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388277AbfCVMGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:06:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57E7C206C0;
        Fri, 22 Mar 2019 12:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256371;
        bh=UVwpdG331tIdfKF8FsJScqU04M8ae2jkndZsuWZa3FM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOkkHWafjp8Ngzru4MUxD9AWsqAc6jh55mi014JWIMJ/7OmPd3PgTQizNBu/HDcQD
         4HwQXnyqb9T4EOknaTUcfvQy11hX4m9llnbISJoOamfa774Fuwf7hlLyko6OigD3qj
         ZZZQBQp/1Y8PedoVIJ93nNon+looDjII+4erBGZ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 169/280] Btrfs: setup a nofs context for memory allocation at __btrfs_set_acl
Date:   Fri, 22 Mar 2019 12:15:22 +0100
Message-Id: <20190322111324.135782195@linuxfoundation.org>
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


