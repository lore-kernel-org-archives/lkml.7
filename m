Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76CCC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C4825227
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189698;
	bh=IMvOMrwfmvlEvp9BbnZTOcWW0xU9lq/DlMKMHRjOHos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oZkS5Hwg97/6Saf7hKyc66x6tRC473SfvO/a+qL+zTZnGa3/ET/+N3bMYDXm96g+L
	 62/H5FXK5euqsXzy6aA3eWKejcQo079l9CZ65vhu4hks5kC8E+Tuoh5bwFG2Yw8ytl
	 ChN16QnGCe/8EISLogRhE3GLhvrXGksqQTbepp2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbfE3EO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730588AbfE3DQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:16:06 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F15C82458A;
        Thu, 30 May 2019 03:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186166;
        bh=IMvOMrwfmvlEvp9BbnZTOcWW0xU9lq/DlMKMHRjOHos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eQC4kKmgllhC5LnVhEhoD0Px4lST3TH1EpstctPUnFrIlL+7UsGtovUmPNiCUk0ij
         XzY8Fpl9qksqHynf2pJEEaVqeo5gESof/yBEteFRuB5YOo2mRlytTlkzRxEMiGBBGX
         5UTyMTMqdx4OaTrlIZ72kW2rLB1C6BcYimMPUmBc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 018/276] Btrfs: do not abort transaction at btrfs_update_root() after failure to COW path
Date:   Wed, 29 May 2019 20:02:56 -0700
Message-Id: <20190530030525.139495426@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

commit 72bd2323ec87722c115a5906bc6a1b31d11e8f54 upstream.

Currently when we fail to COW a path at btrfs_update_root() we end up
always aborting the transaction. However all the current callers of
btrfs_update_root() are able to deal with errors returned from it, many do
end up aborting the transaction themselves (directly or not, such as the
transaction commit path), other BUG_ON() or just gracefully cancel whatever
they were doing.

When syncing the fsync log, we call btrfs_update_root() through
tree-log.c:update_log_root(), and if it returns an -ENOSPC error, the log
sync code does not abort the transaction, instead it gracefully handles
the error and returns -EAGAIN to the fsync handler, so that it falls back
to a transaction commit. Any other error different from -ENOSPC, makes the
log sync code abort the transaction.

So remove the transaction abort from btrfs_update_log() when we fail to
COW a path to update the root item, so that if an -ENOSPC failure happens
we avoid aborting the current transaction and have a chance of the fsync
succeeding after falling back to a transaction commit.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203413
Fixes: 79787eaab46121 ("btrfs: replace many BUG_ONs with proper error handling")
Cc: stable@vger.kernel.org # 4.4+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/root-tree.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -132,10 +132,8 @@ int btrfs_update_root(struct btrfs_trans
 		return -ENOMEM;
 
 	ret = btrfs_search_slot(trans, root, key, path, 0, 1);
-	if (ret < 0) {
-		btrfs_abort_transaction(trans, ret);
+	if (ret < 0)
 		goto out;
-	}
 
 	if (ret != 0) {
 		btrfs_print_leaf(path->nodes[0]);


