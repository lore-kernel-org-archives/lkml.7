Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B347C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6A82082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255607;
	bh=SknzV6Meb5O2BMKhF6/srXb0+eSe3xq+HyNHRC+nBp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=voQTfrr6QwqnDMpmdXT/MPHFKFTXH/RZALD841AF9LKHgCKcClLP5rsQr1XSx7iml
	 SLU9zOmRgAlYOsOI9GLW1TISs1o1oZ/zwqI7s3B0IQ8iK6DX0NvVPSJsU3DSwvCzEc
	 nqYd+ME4RjYNqC37Js5GRoluC2FjOpxf33HZkHFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733039AbfCVLxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732456AbfCVLxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:53:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F79020693;
        Fri, 22 Mar 2019 11:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255602;
        bh=SknzV6Meb5O2BMKhF6/srXb0+eSe3xq+HyNHRC+nBp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sgphStpwoC8iqwlUcKGE8OYB8V9ABHwL6xz/YAg0ViD53fRqrcGSloKxQQ2ce37xA
         s8AKZQmvt6mFt9OgnuzO8+JDVuSmqTVVf3omAsrWlRNdfYH9IHo8S6SYa93/HSsMDh
         Nmmh1AqKIXbq7+FTDpQwhnnm5AMWLYc+eB9/8U0s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.14 112/183] ext4: fix crash during online resizing
Date:   Fri, 22 Mar 2019 12:15:40 +0100
Message-Id: <20190322111249.817276740@linuxfoundation.org>
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
@@ -1930,7 +1930,8 @@ retry:
 				le16_to_cpu(es->s_reserved_gdt_blocks);
 			n_group = n_desc_blocks * EXT4_DESC_PER_BLOCK(sb);
 			n_blocks_count = (ext4_fsblk_t)n_group *
-				EXT4_BLOCKS_PER_GROUP(sb);
+				EXT4_BLOCKS_PER_GROUP(sb) +
+				le32_to_cpu(es->s_first_data_block);
 			n_group--; /* set to last group number */
 		}
 


