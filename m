Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BEEC4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E133020578
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381455;
	bh=U0wNzKNYCMHHDFndm0nBkAk0ouQ99rkHQ5WSLEg6I8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DeGFmOT4SmMk4GrwQ19HLykUlpmUrH8mW9uYGO4d0PiqBvuXcAn6y1aSJcfP8yyEt
	 dK7mZYTSkbKfvfMnSWOWRSNdxEvNmVWnitHmo8Q+BOFB7DYUuvJCefJ1YG17fUVjYo
	 CIcRsEZbx4N7vxKTVlUVLRuQvBMabJh3dM39CL40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389775AbfIMNQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389198AbfIMNPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:15:55 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECE9B206BB;
        Fri, 13 Sep 2019 13:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380554;
        bh=U0wNzKNYCMHHDFndm0nBkAk0ouQ99rkHQ5WSLEg6I8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MWSqJGRUstOCbMSpvrU4m5GdHxnDMUbbPYjryYa/40aAH6jO542ZUmS0I6Opm9j3C
         zjbzmH3Rlzrsfv3SOfMb+kXhKF3H/H5wVhHZgYKtgWVTCzg6DVE1fICJdJ+Ls4xMi6
         bbbbBnjI/foPOmy+9G8VJ1Ho4LCPznU2rqSOhra0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Dan Robertson <dan@dlrobertson.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 102/190] btrfs: init csum_list before possible free
Date:   Fri, 13 Sep 2019 14:05:57 +0100
Message-Id: <20190913130607.741324726@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e49be14b8d80e23bb7c53d78c21717a474ade76b ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/scrub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a08a4d6f540f9..916c397704679 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -592,6 +592,7 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 	sctx->pages_per_rd_bio = SCRUB_PAGES_PER_RD_BIO;
 	sctx->curr = -1;
 	sctx->fs_info = fs_info;
+	INIT_LIST_HEAD(&sctx->csum_list);
 	for (i = 0; i < SCRUB_BIOS_PER_SCTX; ++i) {
 		struct scrub_bio *sbio;
 
@@ -616,7 +617,6 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 	atomic_set(&sctx->workers_pending, 0);
 	atomic_set(&sctx->cancel_req, 0);
 	sctx->csum_size = btrfs_super_csum_size(fs_info->super_copy);
-	INIT_LIST_HEAD(&sctx->csum_list);
 
 	spin_lock_init(&sctx->list_lock);
 	spin_lock_init(&sctx->stat_lock);
-- 
2.20.1



