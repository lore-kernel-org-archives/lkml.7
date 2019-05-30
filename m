Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCE7C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02ECD244A1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559185782;
	bh=oQi+LBWQl62U/gK8w8KtJLAKDAtJ6dbUAVFw0YbHPF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qMey5okC8eH4djLMkbaVYOwci3E2lE3N7CQwD3qfn4cPJX8xnkRG05zagW9AXXzt+
	 BmdT9DKvwyNnJHQ5avRywn+CyclCg6TTCgaRTL4IibPviGeMnwF1FeeHgYJ4PET+SA
	 Ufbg0KYa3n9Q3YvzRIkpulwgxLtqYtUIoQj6E9q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfE3DJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727610AbfE3DJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:09:31 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73A7A2447E;
        Thu, 30 May 2019 03:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185771;
        bh=oQi+LBWQl62U/gK8w8KtJLAKDAtJ6dbUAVFw0YbHPF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m3zYsf7aPIoBGk5ryhTDTpxX6YVhCtYfXT0C24acHqWL8HrTqR8Pg37FxkOsvgenT
         dmWulWdl9loqjQmkzEM4Gp6tAUCO+2kxC6046jQiIktL2UreRTizmMmCkxy4j18Ukb
         zqjhmxzKwuDEHd1YmPHV9yEu1X/8QSijRJ5d6A48=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.1 023/405] btrfs: dont double unlock on error in btrfs_punch_hole
Date:   Wed, 29 May 2019 20:00:21 -0700
Message-Id: <20190530030541.801761585@linuxfoundation.org>
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

From: Josef Bacik <josef@toxicpanda.com>

commit 8fca955057b9c58467d1b231e43f19c4cf26ae8c upstream.

If we have an error writing out a delalloc range in
btrfs_punch_hole_lock_range we'll unlock the inode and then goto
out_only_mutex, where we will again unlock the inode.  This is bad,
don't do this.

Fixes: f27451f22996 ("Btrfs: add support for fallocate's zero range operation")
CC: stable@vger.kernel.org # 4.19+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/file.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2546,10 +2546,8 @@ static int btrfs_punch_hole(struct inode
 
 	ret = btrfs_punch_hole_lock_range(inode, lockstart, lockend,
 					  &cached_state);
-	if (ret) {
-		inode_unlock(inode);
+	if (ret)
 		goto out_only_mutex;
-	}
 
 	path = btrfs_alloc_path();
 	if (!path) {


