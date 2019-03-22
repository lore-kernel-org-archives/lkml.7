Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81032C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0992082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255041;
	bh=kDNoqnQFtY8p2PIY6c0Pb668liJpU7t3w1cQj1/SnaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wKQMI8tQvB6P06FEC+iL8KAZR1mQXscRCv/qriFE4z6QG3rzjxBwXStL+iQATuppI
	 z69Tc6SeSkvYh3IPjORMQU1SprQsxJIrVLq3XRBFprNTr3u51GN2CaCMAS2UZAHqtG
	 kj4TukOy6dqcUBvG14y3MbEo7iC8tu7nMReVzYok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731757AbfCVLoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731721AbfCVLnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:43:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E932121925;
        Fri, 22 Mar 2019 11:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255026;
        bh=kDNoqnQFtY8p2PIY6c0Pb668liJpU7t3w1cQj1/SnaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AniQpjyfIQMlz6eOnES/BfNCi5hXRJ94MEzpgR1h3qt+VHHD23cZgpsOKimI0BPGQ
         oaq01qQpA0p05GpRwSAD8wv612EtKMEAE7eDj2nmg/3PZzL1ALg+uVXtOh/kvEm2YI
         GsE4/sU7ljuetvQ8jgZSMtFjzIySbGgrppxdYPYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.9 066/118] btrfs: ensure that a DUP or RAID1 block group has exactly two stripes
Date:   Fri, 22 Mar 2019 12:15:38 +0100
Message-Id: <20190322111221.308421562@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <jthumshirn@suse.de>

commit 349ae63f40638a28c6fce52e8447c2d14b84cc0c upstream.

We recently had a customer issue with a corrupted filesystem. When
trying to mount this image btrfs panicked with a division by zero in
calc_stripe_length().

The corrupt chunk had a 'num_stripes' value of 1. calc_stripe_length()
takes this value and divides it by the number of copies the RAID profile
is expected to have to calculate the amount of data stripes. As a DUP
profile is expected to have 2 copies this division resulted in 1/2 = 0.
Later then the 'data_stripes' variable is used as a divisor in the
stripe length calculation which results in a division by 0 and thus a
kernel panic.

When encountering a filesystem with a DUP block group and a
'num_stripes' value unequal to 2, refuse mounting as the image is
corrupted and will lead to unexpected behaviour.

Code inspection showed a RAID1 block group has the same issues.

Fixes: e06cd3dd7cea ("Btrfs: add validadtion checks for chunk loading")
CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/volumes.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6439,10 +6439,10 @@ static int btrfs_check_chunk_valid(struc
 	}
 
 	if ((type & BTRFS_BLOCK_GROUP_RAID10 && sub_stripes != 2) ||
-	    (type & BTRFS_BLOCK_GROUP_RAID1 && num_stripes < 1) ||
+	    (type & BTRFS_BLOCK_GROUP_RAID1 && num_stripes != 2) ||
 	    (type & BTRFS_BLOCK_GROUP_RAID5 && num_stripes < 2) ||
 	    (type & BTRFS_BLOCK_GROUP_RAID6 && num_stripes < 3) ||
-	    (type & BTRFS_BLOCK_GROUP_DUP && num_stripes > 2) ||
+	    (type & BTRFS_BLOCK_GROUP_DUP && num_stripes != 2) ||
 	    ((type & BTRFS_BLOCK_GROUP_PROFILE_MASK) == 0 &&
 	     num_stripes != 1)) {
 		btrfs_err(root->fs_info,


