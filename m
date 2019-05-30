Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B109C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347A92601C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559192325;
	bh=zgiv+qFIzyKL+BVY8zd+kxmbe99pwOeqQq748lSnyHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lJwipD64vdR3/eZ7VgsBNqIfeQjOJ4wx29tpFQZUCIfdCbBspwml2+DCIhvDFMarp
	 YIgOsreoPviURZzYQl9pJCY5XD4IM/68ZYxdYPsjQUlHS9edlT2smLnjkcsnB60RQJ
	 vAQLZQCAH3c/Z6C4CEqpeWe/4GfsKJvkPGcaKf5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfE3DJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:09:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbfE3DJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:09:38 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F62A24499;
        Thu, 30 May 2019 03:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185777;
        bh=zgiv+qFIzyKL+BVY8zd+kxmbe99pwOeqQq748lSnyHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KxkYWPH1XnRdYv6dv2TP1X3P5yrX+RTyMSW1FRvk/yYdiEg4oscZDVTIX/IEZTgpS
         7bYGsawzR5sMUm25AYpdj3OUN6uFdz1CIcmBbh+xYA910n9E05wkIptE3TBsbnpVOY
         W1wq5qx03bPk7boxkQs6fGSw1dBqcWDQH2T9mCG4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 5.1 033/405] fbdev: fix WARNING in __alloc_pages_nodemask bug
Date:   Wed, 29 May 2019 20:00:31 -0700
Message-Id: <20190530030542.416410721@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiufei Xue <jiufei.xue@linux.alibaba.com>

commit 8c40292be9169a9cbe19aadd1a6fc60cbd1af82f upstream.

Syzkaller hit 'WARNING in __alloc_pages_nodemask' bug.

WARNING: CPU: 1 PID: 1473 at mm/page_alloc.c:4377
__alloc_pages_nodemask+0x4da/0x2130
Kernel panic - not syncing: panic_on_warn set ...

Call Trace:
 alloc_pages_current+0xb1/0x1e0
 kmalloc_order+0x1f/0x60
 kmalloc_order_trace+0x1d/0x120
 fb_alloc_cmap_gfp+0x85/0x2b0
 fb_set_user_cmap+0xff/0x370
 do_fb_ioctl+0x949/0xa20
 fb_ioctl+0xdd/0x120
 do_vfs_ioctl+0x186/0x1070
 ksys_ioctl+0x89/0xa0
 __x64_sys_ioctl+0x74/0xb0
 do_syscall_64+0xc8/0x550
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

This is a warning about order >= MAX_ORDER and the order is from
userspace ioctl. Add flag __NOWARN to silence this warning.

Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/core/fbcmap.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/video/fbdev/core/fbcmap.c
+++ b/drivers/video/fbdev/core/fbcmap.c
@@ -94,6 +94,8 @@ int fb_alloc_cmap_gfp(struct fb_cmap *cm
 	int size = len * sizeof(u16);
 	int ret = -ENOMEM;
 
+	flags |= __GFP_NOWARN;
+
 	if (cmap->len != len) {
 		fb_dealloc_cmap(cmap);
 		if (!len)


