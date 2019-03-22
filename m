Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27612C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB05D218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254990;
	bh=NoGkgYPjIRqneXQOauPfaJH4dSnnm7+1zCHqT6+dXT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jUDbHC7WJ/4Ag0hbs2xWSkC/Ho2SaOqpS8G6qyLEPE4Nq34qs2c0hBN/aYXLnwCPR
	 EamHi7OrbN0KoUEevONxkJh2CMEtMzaYBeOT4RLnd3Q1XuaYWDslaTQmyA7oR/o4Nh
	 fVt/j8o/dMm3RIYBuSRqRYALvHI+r0Uh6xpXPouc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbfCVLnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731619AbfCVLnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:43:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6BA3218B0;
        Fri, 22 Mar 2019 11:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254986;
        bh=NoGkgYPjIRqneXQOauPfaJH4dSnnm7+1zCHqT6+dXT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PsZKJHXnai5Z++nGAY86Jn0xuf2RUNySiojn97n8eRaf31pBOWFXQG38/dj8AMVIw
         vfbN78/4WIB+7h13x+H11RwmDISQw8uZ2DgRCdC/GQlwz8KT1o8hrcI195K/DgNApC
         HZaYcebpZ7zxIHw8e4Pi/6fP5Klmr+ZWqT4jC6LY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.9 072/118] ext4: fix crash during online resizing
Date:   Fri, 22 Mar 2019 12:15:44 +0100
Message-Id: <20190322111221.742909148@linuxfoundation.org>
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
@@ -1928,7 +1928,8 @@ retry:
 				le16_to_cpu(es->s_reserved_gdt_blocks);
 			n_group = n_desc_blocks * EXT4_DESC_PER_BLOCK(sb);
 			n_blocks_count = (ext4_fsblk_t)n_group *
-				EXT4_BLOCKS_PER_GROUP(sb);
+				EXT4_BLOCKS_PER_GROUP(sb) +
+				le32_to_cpu(es->s_first_data_block);
 			n_group--; /* set to last group number */
 		}
 


