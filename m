Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27746C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBFE2083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257102;
	bh=7Kb4Nzdt5mu11PDTeGB4O/Jye+8sFQfdJJHyufy1iHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2SD4vR6JLsCr6ZW/qlvDFOwTxGvFK2tw/8CwIG6DsvTi5Sh+QMxWgj7UXz0CwyIkc
	 uP8GzY7JxA3oOfF7Wi8vgRD7dwFUe7vCki1n30PjRnWQ6ArIj9L3H0V20N7wRpQgct
	 CL2zy4y74WxjtcxHikd9c5A6i4A5heDo54s0t5NA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390484AbfCVMSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:18:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390465AbfCVMSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:18:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF5E32083D;
        Fri, 22 Mar 2019 12:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257096;
        bh=7Kb4Nzdt5mu11PDTeGB4O/Jye+8sFQfdJJHyufy1iHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HWd3x4Q+wx9i1fb86O1t5XAOqLjwXBS6If45QxE+VLZqU3bym2V5lo0n0kvOLS0Os
         iwYq5TtvbmLcn45LYc4SxEcHH97dPUhC4GdPis2SJMWgWCk0NYy8+cNBTFMAx/jGKi
         xZ/GZqwUfrfDZNr56O8X8J413J0igswe0gmkM9q8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.0 123/238] ext4: fix crash during online resizing
Date:   Fri, 22 Mar 2019 12:15:42 +0100
Message-Id: <20190322111305.777385901@linuxfoundation.org>
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

From: Jan Kara <jack@suse.cz>

commit f96c3ac8dfc24b4e38fc4c2eba5fea2107b929d1 upstream.

When computing maximum size of filesystem possible with given number of
group descriptor blocks, we forget to include s_first_data_block into
the number of blocks. Thus for filesystems with non-zero
s_first_data_block it can happen that computed maximum filesystem size
is actually lower than current filesystem size which confuses the code
and eventually leads to a BUG_ON in ext4_alloc_group_tables() hitting on
flex_gd->count == 0. The problem can be reproduced like:

truncate -s 100g /tmp/image
mkfs.ext4 -b 1024 -E resize=262144 /tmp/image 32768
mount -t ext4 -o loop /tmp/image /mnt
resize2fs /dev/loop0 262145
resize2fs /dev/loop0 300000

Fix the problem by properly including s_first_data_block into the
computed number of filesystem blocks.

Fixes: 1c6bd7173d66 "ext4: convert file system to meta_bg if needed..."
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/resize.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1960,7 +1960,8 @@ retry:
 				le16_to_cpu(es->s_reserved_gdt_blocks);
 			n_group = n_desc_blocks * EXT4_DESC_PER_BLOCK(sb);
 			n_blocks_count = (ext4_fsblk_t)n_group *
-				EXT4_BLOCKS_PER_GROUP(sb);
+				EXT4_BLOCKS_PER_GROUP(sb) +
+				le32_to_cpu(es->s_first_data_block);
 			n_group--; /* set to last group number */
 		}
 


