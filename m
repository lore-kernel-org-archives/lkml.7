Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2ADC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6F22192C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257090;
	bh=MpEJFuOS72BMW2v3oTCbRpFnx6PeKlHsyJ/3jQLwGho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PA5+CRa/4B3BYRcEsd2E0eU8Nv0M8YKUAi0gLeQCxPvUYq6xZueR2AxXNJNmqv2rl
	 9C3w0z4bfRSUAFlJDQS2EkEYbpm3xFC1huJ71NY19WXrLjowdiG+uj+iaIaS9DSKZn
	 /n1OqkHaFIPPMBjQvWQWZIGFv1H2zi8iyAJL4LeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390061AbfCVMSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:18:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390028AbfCVMSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:18:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F4262082C;
        Fri, 22 Mar 2019 12:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257083;
        bh=MpEJFuOS72BMW2v3oTCbRpFnx6PeKlHsyJ/3jQLwGho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eOqHbu8k9tr4nF1NTACE5HnNrL4W9rJJbJknixcq+GJITgdrKJnlg+oqhevQ5Z5A9
         03vuDWSl7IdaueqpSZ9S/FxuwuDPLnrZLdEFAQEnuoqOqStBG8fyU4TGS5XhPKjTr8
         TfTiq0nZ0ySViHbathZwhT6sY2/DaRhcuI1AUltA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.0 095/238] btrfs: ensure that a DUP or RAID1 block group has exactly two stripes
Date:   Fri, 22 Mar 2019 12:15:14 +0100
Message-Id: <20190322111304.178662563@linuxfoundation.org>
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
@@ -6782,10 +6782,10 @@ static int btrfs_check_chunk_valid(struc
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


