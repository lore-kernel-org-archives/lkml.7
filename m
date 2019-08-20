Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178AAC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 06:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9231214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 06:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfHTGXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 02:23:07 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39665 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbfHTGXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 02:23:06 -0400
Received: by mail-yw1-f66.google.com with SMTP id x74so1956272ywx.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 23:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/o7lpvdOJNBA2JPF2P6JSLDCuaJ3DsC1gxrwOwJhdgU=;
        b=SetFbITNXK1J/cBGKCiK/aB56zqx1bu1Jko0oGUd53xVWMm4Wrc9D39GFgFmpFP8C8
         7VumvwoBKBJIhXbEYe3yxeJGFj6WyGA1Mk6i9GHWkKVG/+b+oTvO/BHWmPVd9uhQvZLv
         12MwuYQ+NShn2dNCJyJ6FdNGgaLe82C+kjnZT9x1t4nghzwFFL/I88nJIA1d2OOdqGeN
         WynnaDLl1UhJkmw1rZtlLPxKwfTjB1pdVlN/T09FPLd4FZiNa2I2g1OcjxC767d8Uw5h
         ti01uxXCxhyIBaXmmP/v+FlDBkL8SEb6pO4DF1Ag0iQi1T3rzBmQIUpGRj3SLsNUzNjz
         q9NQ==
X-Gm-Message-State: APjAAAWbBsefKZq83fgFohRWYKkjkv9bpDelGKnvxSYN+gUGRNvzKXXD
        BbhnImdduUJP51He3Lq46t0=
X-Google-Smtp-Source: APXvYqwlClCwLLzfigujctjD/Bfa28v2jri23GdytMxEW8y3zzRuJG/cpsrgCEvkeCKyzaBE8WJ2vQ==
X-Received: by 2002:a81:6283:: with SMTP id w125mr19357489ywb.335.1566282185786;
        Mon, 19 Aug 2019 23:23:05 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id q81sm3387307ywc.24.2019.08.19.23.23.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Aug 2019 23:23:04 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Bob Copeland <me@bobcopeland.com>,
        linux-karma-devel@lists.sourceforge.net (open list:OMFS FILESYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] omfs: Fix a memory leak bug
Date:   Tue, 20 Aug 2019 01:22:59 -0500
Message-Id: <1566282180-10485-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In omfs_get_imap(), 'sbi->s_imap' is allocated through kcalloc(). However,
it is not deallocated in the following execution if 'block' is not less
than 'sbi->s_num_blocks', leading to a memory leak bug. To fix this issue,
go to the 'nomem_free' label to free 'sbi->s_imap'.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 fs/omfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index 08226a8..e4d89a6 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -356,7 +356,7 @@ static int omfs_get_imap(struct super_block *sb)
 
 	block = clus_to_blk(sbi, sbi->s_bitmap_ino);
 	if (block >= sbi->s_num_blocks)
-		goto nomem;
+		goto nomem_free;
 
 	ptr = sbi->s_imap;
 	for (count = bitmap_size; count > 0; count -= sb->s_blocksize) {
-- 
2.7.4

