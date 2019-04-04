Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC64BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCCA21741
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368882;
	bh=Jj5p7QPu008Y7A9xnkj0tT6r3cW1QwYXsdYqMo07q38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=We09VdqH3z9Gh+W5ulepum3DZQ0HmA0fNWqeXF36Ts81qLkgBguygNb8AId+3UT9A
	 IUQAJb7ZCA2IAkfpSpXuP4ct6KVUnF8BemPyJqnjjX9tXHRi6JicI0n+tRxTGG7xvj
	 CGwJNVfyZnXSwUfd3fyj+YvBFcsVhtri4isn16pY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732155AbfDDJIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731570AbfDDJH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:07:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00D252177E;
        Thu,  4 Apr 2019 09:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368877;
        bh=Jj5p7QPu008Y7A9xnkj0tT6r3cW1QwYXsdYqMo07q38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jceSoSmONXpOcbE8YE061CargvB4J8EOliJ/meMSFUfkiNU9etyRKMEHeCUX1ji0h
         onOK1E/OsNqzu9G4npFblq132TduXLqEkZ0ST7/GmhVF8uiW1FvJuIRhA0tJFAaSMF
         /xbq8S9Bo1A+isrcAPnz+oqJjtP/Y/St5R0Lue+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiqun Li <jiqun.li@unisoc.com>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 007/246] f2fs: fix to avoid deadlock in f2fs_read_inline_dir()
Date:   Thu,  4 Apr 2019 10:45:07 +0200
Message-Id: <20190404084619.481465235@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

[ Upstream commit aadcef64b22f668c1a107b86d3521d9cac915c24 ]

As Jiqun Li reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=202883

sometimes, dead lock when make system call SYS_getdents64 with fsync() is
called by another process.

monkey running on android9.0

1.  task 9785 held sbi->cp_rwsem and waiting lock_page()
2.  task 10349 held mm_sem and waiting sbi->cp_rwsem
3. task 9709 held lock_page() and waiting mm_sem

so this is a dead lock scenario.

task stack is show by crash tools as following

crash_arm64> bt ffffffc03c354080
PID: 9785   TASK: ffffffc03c354080  CPU: 1   COMMAND: "RxIoScheduler-3"
>> #7 [ffffffc01b50fac0] __lock_page at ffffff80081b11e8

crash-arm64> bt 10349
PID: 10349  TASK: ffffffc018b83080  CPU: 1   COMMAND: "BUGLY_ASYNC_UPL"
>> #3 [ffffffc01f8cfa40] rwsem_down_read_failed at ffffff8008a93afc
     PC: 00000033  LR: 00000000  SP: 00000000  PSTATE: ffffffffffffffff

crash-arm64> bt 9709
PID: 9709   TASK: ffffffc03e7f3080  CPU: 1   COMMAND: "IntentService[A"
>> #3 [ffffffc001e67850] rwsem_down_read_failed at ffffff8008a93afc
>> #8 [ffffffc001e67b80] el1_ia at ffffff8008084fc4
     PC: ffffff8008274114  [compat_filldir64+120]
     LR: ffffff80083584d4  [f2fs_fill_dentries+448]
     SP: ffffffc001e67b80  PSTATE: 80400145
    X29: ffffffc001e67b80  X28: 0000000000000000  X27: 000000000000001a
    X26: 00000000000093d7  X25: ffffffc070d52480  X24: 0000000000000008
    X23: 0000000000000028  X22: 00000000d43dfd60  X21: ffffffc001e67e90
    X20: 0000000000000011  X19: ffffff80093a4000  X18: 0000000000000000
    X17: 0000000000000000  X16: 0000000000000000  X15: 0000000000000000
    X14: ffffffffffffffff  X13: 0000000000000008  X12: 0101010101010101
    X11: 7f7f7f7f7f7f7f7f  X10: 6a6a6a6a6a6a6a6a   X9: 7f7f7f7f7f7f7f7f
     X8: 0000000080808000   X7: ffffff800827409c   X6: 0000000080808000
     X5: 0000000000000008   X4: 00000000000093d7   X3: 000000000000001a
     X2: 0000000000000011   X1: ffffffc070d52480   X0: 0000000000800238
>> #9 [ffffffc001e67be0] f2fs_fill_dentries at ffffff80083584d0
     PC: 0000003c  LR: 00000000  SP: 00000000  PSTATE: 000000d9
    X12: f48a02ff X11: d4678960 X10: d43dfc00  X9: d4678ae4
     X8: 00000058  X7: d4678994  X6: d43de800  X5: 000000d9
     X4: d43dfc0c  X3: d43dfc10  X2: d46799c8  X1: 00000000
     X0: 00001068

Below potential deadlock will happen between three threads:
Thread A		Thread B		Thread C
- f2fs_do_sync_file
 - f2fs_write_checkpoint
  - down_write(&sbi->node_change) -- 1)
			- do_page_fault
			 - down_write(&mm->mmap_sem) -- 2)
			  - do_wp_page
			   - f2fs_vm_page_mkwrite
						- getdents64
						 - f2fs_read_inline_dir
						  - lock_page -- 3)
  - f2fs_sync_node_pages
   - lock_page -- 3)
			    - __do_map_lock
			     - down_read(&sbi->node_change) -- 1)
						  - f2fs_fill_dentries
						   - dir_emit
						    - compat_filldir64
						     - do_page_fault
						      - down_read(&mm->mmap_sem) -- 2)

Since f2fs_readdir is protected by inode.i_rwsem, there should not be
any updates in inode page, we're safe to lookup dents in inode page
without its lock held, so taking off the lock to improve concurrency
of readdir and avoid potential deadlock.

Reported-by: Jiqun Li <jiqun.li@unisoc.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/inline.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index d636cbcf68f2..aacbb864ec1e 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -659,6 +659,12 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 	if (IS_ERR(ipage))
 		return PTR_ERR(ipage);
 
+	/*
+	 * f2fs_readdir was protected by inode.i_rwsem, it is safe to access
+	 * ipage without page's lock held.
+	 */
+	unlock_page(ipage);
+
 	inline_dentry = inline_data_addr(inode, ipage);
 
 	make_dentry_ptr_inline(inode, &d, inline_dentry);
@@ -667,7 +673,7 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 	if (!err)
 		ctx->pos = d.max;
 
-	f2fs_put_page(ipage, 1);
+	f2fs_put_page(ipage, 0);
 	return err < 0 ? err : 0;
 }
 
-- 
2.19.1



