Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA15C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670F7214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552421376;
	bh=yjgijAaBKdBqmnarjSvKDPL7qMjKR2DsZvFoTTU95qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=elNVEcUgHboIbAYXvZXdJarYQ+pIOTeRO6NgssIjAZcvthwcJVstmLfA3iWvUNdsk
	 WZ+WceEFWiNMladB+xvcjyiCet5Lx1BYdpXU9GndTwOl0SDKDVZxqvW0MoejLgPgb2
	 7z0/3NgB+WEi5+2jHNBpN4PiOEosrIYO8ycVCiqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfCLUJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:09:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfCLUJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:09:34 -0400
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 629C9206BA;
        Tue, 12 Mar 2019 20:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552421373;
        bh=yjgijAaBKdBqmnarjSvKDPL7qMjKR2DsZvFoTTU95qs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I/w0aYvC7xiRt+UBJMoNqpoj/G1YhoboAW9Euir9pXqBCcPtbOC27ryfClZDhyLz9
         xVxS3CrLYyTdN/6gSKMibkv9a4YsAOgtGcA4kDvW1w0VlwnJRvHgJLRJp3nbFzR4L7
         Mc6hBoxMr3KK077DC1BMRtHvJ6ASUzzG9j/ys3MQ=
Date:   Tue, 12 Mar 2019 13:09:32 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: fix to avoid deadlock in f2fs_read_inline_dir()
Message-ID: <20190312200932.GD45421@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190312074427.75515-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312074427.75515-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12, Chao Yu wrote:
> As Jiqun Li reported in bugzilla:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=202883
> 
> sometimes, dead lock when make system call SYS_getdents64 with fsync() is
> called by another process.
> 
> monkey running on android9.0
> 
> 1.  task 9785 held sbi->cp_rwsem and waiting lock_page()
> 2.  task 10349 held mm_sem and waiting sbi->cp_rwsem
> 3. task 9709 held lock_page() and waiting mm_sem
> 
> so this is a dead lock scenario.
> 
> task stack is show by crash tools as following
> 
> crash_arm64> bt ffffffc03c354080
> PID: 9785   TASK: ffffffc03c354080  CPU: 1   COMMAND: "RxIoScheduler-3"
> >> #7 [ffffffc01b50fac0] __lock_page at ffffff80081b11e8
> 
> crash-arm64> bt 10349
> PID: 10349  TASK: ffffffc018b83080  CPU: 1   COMMAND: "BUGLY_ASYNC_UPL"
> >> #3 [ffffffc01f8cfa40] rwsem_down_read_failed at ffffff8008a93afc
>      PC: 00000033  LR: 00000000  SP: 00000000  PSTATE: ffffffffffffffff
> 
> crash-arm64> bt 9709
> PID: 9709   TASK: ffffffc03e7f3080  CPU: 1   COMMAND: "IntentService[A"
> >> #3 [ffffffc001e67850] rwsem_down_read_failed at ffffff8008a93afc
> >> #8 [ffffffc001e67b80] el1_ia at ffffff8008084fc4
>      PC: ffffff8008274114  [compat_filldir64+120]
>      LR: ffffff80083584d4  [f2fs_fill_dentries+448]
>      SP: ffffffc001e67b80  PSTATE: 80400145
>     X29: ffffffc001e67b80  X28: 0000000000000000  X27: 000000000000001a
>     X26: 00000000000093d7  X25: ffffffc070d52480  X24: 0000000000000008
>     X23: 0000000000000028  X22: 00000000d43dfd60  X21: ffffffc001e67e90
>     X20: 0000000000000011  X19: ffffff80093a4000  X18: 0000000000000000
>     X17: 0000000000000000  X16: 0000000000000000  X15: 0000000000000000
>     X14: ffffffffffffffff  X13: 0000000000000008  X12: 0101010101010101
>     X11: 7f7f7f7f7f7f7f7f  X10: 6a6a6a6a6a6a6a6a   X9: 7f7f7f7f7f7f7f7f
>      X8: 0000000080808000   X7: ffffff800827409c   X6: 0000000080808000
>      X5: 0000000000000008   X4: 00000000000093d7   X3: 000000000000001a
>      X2: 0000000000000011   X1: ffffffc070d52480   X0: 0000000000800238
> >> #9 [ffffffc001e67be0] f2fs_fill_dentries at ffffff80083584d0
>      PC: 0000003c  LR: 00000000  SP: 00000000  PSTATE: 000000d9
>     X12: f48a02ff X11: d4678960 X10: d43dfc00  X9: d4678ae4
>      X8: 00000058  X7: d4678994  X6: d43de800  X5: 000000d9
>      X4: d43dfc0c  X3: d43dfc10  X2: d46799c8  X1: 00000000
>      X0: 00001068
> 
> Below potential deadlock will happen between three threads:
> Thread A		Thread B		Thread C
> - f2fs_do_sync_file
>  - f2fs_write_checkpoint
>   - down_write(&sbi->node_change) -- 1)
> 			- do_page_fault
> 			 - down_write(&mm->mmap_sem) -- 2)
> 			  - do_wp_page
> 			   - f2fs_vm_page_mkwrite
> 						- getdents64
> 						 - f2fs_read_inline_dir
> 						  - lock_page -- 3)
>   - f2fs_sync_node_pages
>    - lock_page -- 3)
> 			    - __do_map_lock
> 			     - down_read(&sbi->node_change) -- 1)
> 						  - f2fs_fill_dentries
> 						   - dir_emit
> 						    - compat_filldir64
> 						     - do_page_fault
> 						      - down_read(&mm->mmap_sem) -- 2)
> 
> Since f2fs_readdir is protected by inode.i_rwsem, there should not be

Well, what about other dir operations which can convert inline_dentry?
How about allocating a buffer shortly like this?

---
 fs/f2fs/inline.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index a1381d05956b..50a946d55778 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -647,12 +647,10 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 	struct inode *inode = file_inode(file);
 	struct page *ipage = NULL;
 	struct f2fs_dentry_ptr d;
-	void *inline_dentry = NULL;
+	void *inline_dentry = NULL, *buf = NULL;
 	int err;
 
-	make_dentry_ptr_inline(inode, &d, inline_dentry);
-
-	if (ctx->pos == d.max)
+	if (ctx->pos >= NR_INLINE_DENTRY(inode))
 		return 0;
 
 	ipage = f2fs_get_node_page(F2FS_I_SB(inode), inode->i_ino);
@@ -660,14 +658,24 @@ int f2fs_read_inline_dir(struct file *file, struct dir_context *ctx,
 		return PTR_ERR(ipage);
 
 	inline_dentry = inline_data_addr(inode, ipage);
+	buf = f2fs_kmalloc(F2FS_I_SB(inode),
+				MAX_INLINE_DATA(inode), GFP_F2FS_ZERO);
+	if (!buf) {
+		f2fs_put_page(ipage, 1);
+		err = -ENOMEM;
+		goto out;
+	}
+	memcpy(buf, inline_dentry, MAX_INLINE_DATA(inode));
+	make_dentry_ptr_inline(inode, &d, buf);
 
-	make_dentry_ptr_inline(inode, &d, inline_dentry);
+	f2fs_put_page(ipage, 1);
 
 	err = f2fs_fill_dentries(ctx, &d, 0, fstr);
 	if (!err)
 		ctx->pos = d.max;
 
-	f2fs_put_page(ipage, 1);
+	kvfree(buf);
+out:
 	return err < 0 ? err : 0;
 }
 
-- 
2.19.0.605.g01d371f741-goog


