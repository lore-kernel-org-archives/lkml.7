Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3D4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CA9218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257830;
	bh=Zs5Y4vqFbl95dBlixixrCwd6KL926WnkExpQx4FdJy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jWuzHj0YuWlGDhxmZyRoAR5xRj5at41nQ5bLc1dMl2InagzEA+8/KqoRHaFeQ1Sm6
	 e03eoI01aE/Fyjv/cPLpbsx/LxSVtw08JmZuqy8sc7bT4IatWd1j/+Twp/kqsdk53+
	 e4OXcL1/BqLm4gHdFkBzn2Y3KQc9KFtorRClalxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390462AbfCVMSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:18:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390440AbfCVMSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:18:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53D462082C;
        Fri, 22 Mar 2019 12:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257085;
        bh=Zs5Y4vqFbl95dBlixixrCwd6KL926WnkExpQx4FdJy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u1Bd5C3qHtGUA3T6IgyDKRXunhrjoVNptGtjiJ3iJlhhx3FZkT2QpiAZ+fk0tmWUO
         RaMadMmmsx9XBzywPNLSn3jyXHgvmdx9bbcw803OnBh0Qo6OlsvyCiEiwdklSVcDb6
         ziesd8wRIkALd74GnP20bnCDhbB44ES/ph8xuG1k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Dan Robertson <dan@dlrobertson.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.0 096/238] btrfs: init csum_list before possible free
Date:   Fri, 22 Mar 2019 12:15:15 +0100
Message-Id: <20190322111304.241075199@linuxfoundation.org>
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

From: Dan Robertson <dan@dlrobertson.com>

commit e49be14b8d80e23bb7c53d78c21717a474ade76b upstream.

The scrub_ctx csum_list member must be initialized before scrub_free_ctx
is called. If the csum_list is not initialized beforehand, the
list_empty call in scrub_free_csums will result in a null deref if the
allocation fails in the for loop.

Fixes: a2de733c78fa ("btrfs: scrub")
CC: stable@vger.kernel.org # 3.0+
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Dan Robertson <dan@dlrobertson.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/scrub.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -584,6 +584,7 @@ static noinline_for_stack struct scrub_c
 	sctx->pages_per_rd_bio = SCRUB_PAGES_PER_RD_BIO;
 	sctx->curr = -1;
 	sctx->fs_info = fs_info;
+	INIT_LIST_HEAD(&sctx->csum_list);
 	for (i = 0; i < SCRUB_BIOS_PER_SCTX; ++i) {
 		struct scrub_bio *sbio;
 
@@ -608,7 +609,6 @@ static noinline_for_stack struct scrub_c
 	atomic_set(&sctx->workers_pending, 0);
 	atomic_set(&sctx->cancel_req, 0);
 	sctx->csum_size = btrfs_super_csum_size(fs_info->super_copy);
-	INIT_LIST_HEAD(&sctx->csum_list);
 
 	spin_lock_init(&sctx->list_lock);
 	spin_lock_init(&sctx->stat_lock);


