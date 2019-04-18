Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54BDC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0022083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQL+lk/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388149AbfDRHfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 03:35:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37479 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbfDRHfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 03:35:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id w23so758208ply.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 00:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GEut7x8mWK2OvXtD9vsZ+m8iNhmSDYxjjvQvjNoGM14=;
        b=FQL+lk/oUKOdFOOQcnrsEdE1BjeXuogcyzZXbsiVTSBqbm6kD3Zl8TXF8ElOipWP+p
         FW6PaZU2XqEhaJgAw9pQfBxsza58dL3VqSsvLEpyELiMjQPCxwlgN0CNKMPqlADQO4+d
         422Lwp7NPlqQCp7wQLDvSdJV407gQvg61Jxj21+x7ScURtU0HPjVj6X6iDnVWUJULw3e
         bntNxEeugnXAiP8TZTwQ5RbfuOKcvhPf7GVc49H5nrtHP/VSVM6/qLUXqOcbTEoUmy8O
         BWfh2JOdCXdlIexTHKwxxPbFtObMay2huS4XJ8J6W5draabHguxvuIGcIS+U/jHUlybn
         LtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GEut7x8mWK2OvXtD9vsZ+m8iNhmSDYxjjvQvjNoGM14=;
        b=OpceSAOKLnEHG1qmrrLuPqpqDkcSaLnllrfT5ujZa7UwBbrGJu/BDFJrQ7zymSamtc
         Q0VxbqAj0ry8jZR+IqVHG5PGv9ipZn4BKvGYuIhQwpQ7qWdry0bVJmHhGnSJVk3cTEOs
         q+x2NHRUGvVDNedKN4osanQP4XpauVRJkgn73vvfW6Ch4HsfLynZxgR9Ia1b5x+9hYCA
         Om+1sv0uv08jpRIHMj5FBhY/DBriUt6K+S16lBxnKnbqpXRY1zX2cyoc3YI+OTIVALu7
         UfR3eNDURSY/2AGr+9XWyGn+EdFLYI4nFc8uzZFJArg8gkGCrhmrQuoG05RO6kqUprl4
         bhmg==
X-Gm-Message-State: APjAAAXRzHaKViUQ1+/0pLliH90rKavKSU8wCF77kudupBmpAPtKEPnm
        V4V5lYG4vdo6p6kupTCZU9A=
X-Google-Smtp-Source: APXvYqyaaJqPsa4ffCYD+WHnn/c0SfZy8XqCcA68LF43zAjjuGcrCRdSCzy8n3wH8S9aaR1WS31RRQ==
X-Received: by 2002:a17:902:1c9:: with SMTP id b67mr72223815plb.158.1555572916580;
        Thu, 18 Apr 2019 00:35:16 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id p128sm2639334pfp.30.2019.04.18.00.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 00:35:16 -0700 (PDT)
Date:   Thu, 18 Apr 2019 13:05:10 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     jaegeuk@kernel.org, yuchao0@huawei.com
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux.bhar@gmail.com
Subject: [PATCH] f2fs: Force type conversion from __le32 to u32
Message-ID: <20190418073510.GA11396@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch forces type conversion from __le32 to u32 to prevent sparse
warnings like:
warning: restricted __le32 degrades to integer

dir.c:
fscrypt_fname_disk_to_usr takes a hash of type u32 as it's second arg
but de->hash_code is of type __le32.

node.c
NULL_ADDR is of type u32 but block_addr is of type __le32.

Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 fs/f2fs/dir.c  | 2 +-
 fs/f2fs/node.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 59bc460..4f39872 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -828,7 +828,7 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			int save_len = fstr->len;
 
 			err = fscrypt_fname_disk_to_usr(d->inode,
-						(u32)de->hash_code, 0,
+						(__force u32)de->hash_code, 0,
 						&de_name, fstr);
 			if (err)
 				goto out;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3f99ab2..9e333a5 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2706,7 +2706,7 @@ static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
 		i = 1;
 	}
 	for (; i < NAT_ENTRY_PER_BLOCK; i++) {
-		if (nat_blk->entries[i].block_addr != NULL_ADDR)
+		if ((__force u32)nat_blk->entries[i].block_addr != NULL_ADDR)
 			valid++;
 	}
 	if (valid == 0) {
-- 
2.7.4

