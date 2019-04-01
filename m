Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA21EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7011A21924
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138388;
	bh=9CV7+nSd6kIKXRHlTxtdckGbg57cmsMS00v3spp6Jqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wOYw+oKdZkwNPcXsUGS5U4GA6jS7kmpiqYY2V59O/Q1itDKGyvDGxsUtiBhsbugy5
	 Ifk+J43vOenLcCil5GLFQNbIHl130uzta2ztONOSk9iaBmaSibEPRSS65x+9qX4QHi
	 zcWq8xET1cAzgoJulIG9krxJpq1SAicTyZ2gnxAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfDARG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729216AbfDARGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:06:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8709721924;
        Mon,  1 Apr 2019 17:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138384;
        bh=9CV7+nSd6kIKXRHlTxtdckGbg57cmsMS00v3spp6Jqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Huci3oSLMWe9vl8ropOz8BNrdJJ+lnrbHVo1hgC84QRhrrrh78crKC59DyJRnyVkX
         NbH8fbdpAWWhSzAKAwcrPE00q32HKzS/qGB6onhAU4u42NQUYlxFwPNlpCZj4dm8C8
         kh/zTxc2iZxRD0fhewB71C3b0JEdJZFKW3JxtS+o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.0 043/146] btrfs: Avoid possible qgroup_rsv_size overflow in btrfs_calculate_inode_block_rsv_size
Date:   Mon,  1 Apr 2019 19:00:55 +0200
Message-Id: <20190401170052.186034840@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

From: Nikolay Borisov <nborisov@suse.com>

commit 139a56170de67101791d6e6c8e940c6328393fe9 upstream.

qgroup_rsv_size is calculated as the product of
outstanding_extent * fs_info->nodesize. The product is calculated with
32 bit precision since both variables are defined as u32. Yet
qgroup_rsv_size expects a 64 bit result.

Avoid possible multiplication overflow by casting outstanding_extent to
u64. Such overflow would in the worst case (64K nodesize) require more
than 65536 extents, which is quite large and i'ts not likely that it
would happen in practice.

Fixes-coverity-id: 1435101
Fixes: ff6bc37eb7f6 ("btrfs: qgroup: Use independent and accurate per inode qgroup rsv")
CC: stable@vger.kernel.org # 4.19+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent-tree.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6115,7 +6115,7 @@ static void btrfs_calculate_inode_block_
 	 *
 	 * This is overestimating in most cases.
 	 */
-	qgroup_rsv_size = outstanding_extents * fs_info->nodesize;
+	qgroup_rsv_size = (u64)outstanding_extents * fs_info->nodesize;
 
 	spin_lock(&block_rsv->lock);
 	block_rsv->size = reserve_size;


