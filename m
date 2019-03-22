Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBBCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFCE21916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255536;
	bh=2b8S8d5sn9CXAxZrZdH8FuhtuTYLQZfS90J28Rvisg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IAzOjLBR+nfYWsEgMtBZSIs9af+1pLg8YwMDGBG9xvBR57is4DwONq67aFPIRMYeZ
	 Qa1XnwrT7vc+3QJz41uTikb0KQko3U4B1P/rkmbxKUgxqhwhwiU4YY6DxsVeDL5Aq3
	 2SaHZAyN9dP3cIRltQgKYntlSZ6hcyYGM97l6wIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732868AbfCVLwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732850AbfCVLwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:52:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C57320850;
        Fri, 22 Mar 2019 11:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255529;
        bh=2b8S8d5sn9CXAxZrZdH8FuhtuTYLQZfS90J28Rvisg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tHgXC24Nv6SBNVTUXvE4q6LbSbaIdkD919Y+/zFFKb8kCipNXrcvPhM2kuLJVXaef
         fpRNu7NX+TqG6WbLO85ElH044t7QhHcn1QHodnL7BO53CvHVZDGVHIFz/Lf8Rc1pIU
         7bjBafKVodeLjDkb/v/2IqfRAt4YC4WLbrlOcpEI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 103/183] btrfs: ensure that a DUP or RAID1 block group has exactly two stripes
Date:   Fri, 22 Mar 2019 12:15:31 +0100
Message-Id: <20190322111249.152612544@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6420,10 +6420,10 @@ static int btrfs_check_chunk_valid(struc
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
 		btrfs_err(fs_info,


