Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107AFC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF083213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558354854;
	bh=p/F0Eyhuvuh8BFZ332m6Psyifb9HDAehpKdQ6ZdZLyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v8dcatSt3laA6itbXxj5vzq/FQ8nOJJDSfRwIklYrmCzw4NlhcA8UtWJySY92cMGh
	 yynhWW6YheNxMifg3goUf/Ie7Z4q6ZMGq2twU3NxurZ/NIVrtjw+/EI2hd3dc75L34
	 KJPAEGEYHJ0a85f1AZkzb2eGA1oJ9M8bfeFDyufE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388052AbfETMUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731797AbfETMUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:20:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B4B8213F2;
        Mon, 20 May 2019 12:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558354849;
        bh=p/F0Eyhuvuh8BFZ332m6Psyifb9HDAehpKdQ6ZdZLyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QooHau7SQCBO0y2G1TAmEBmETFx1YON/KXKNzktbmFOi8NkYVYn1SOFbhWZIIrRAQ
         +E7Sth7vWm8hEmk03h2DKGc1asmfwRhG6czrKEQEjCYj0x4mavFdtwjIVfEc6YQ3R8
         yQEUoMZ7FYiSvXgYPALJmE5HAJMZoKr9apIF3++M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>, stable@kernel.org
Subject: [PATCH 4.14 59/63] ext4: fix use-after-free in dx_release()
Date:   Mon, 20 May 2019 14:14:38 +0200
Message-Id: <20190520115237.422924505@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115231.137981521@linuxfoundation.org>
References: <20190520115231.137981521@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sahitya Tummala <stummala@codeaurora.org>

commit 08fc98a4d6424af66eb3ac4e2cedd2fc927ed436 upstream.

The buffer_head (frames[0].bh) and it's corresping page can be
potentially free'd once brelse() is done inside the for loop
but before the for loop exits in dx_release(). It can be free'd
in another context, when the page cache is flushed via
drop_caches_sysctl_handler(). This results into below data abort
when accessing info->indirect_levels in dx_release().

Unable to handle kernel paging request at virtual address ffffffc17ac3e01e
Call trace:
 dx_release+0x70/0x90
 ext4_htree_fill_tree+0x2d4/0x300
 ext4_readdir+0x244/0x6f8
 iterate_dir+0xbc/0x160
 SyS_getdents64+0x94/0x174

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/namei.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -870,12 +870,15 @@ static void dx_release(struct dx_frame *
 {
 	struct dx_root_info *info;
 	int i;
+	unsigned int indirect_levels;
 
 	if (frames[0].bh == NULL)
 		return;
 
 	info = &((struct dx_root *)frames[0].bh->b_data)->info;
-	for (i = 0; i <= info->indirect_levels; i++) {
+	/* save local copy, "info" may be freed after brelse() */
+	indirect_levels = info->indirect_levels;
+	for (i = 0; i <= indirect_levels; i++) {
 		if (frames[i].bh == NULL)
 			break;
 		brelse(frames[i].bh);


