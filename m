Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DC9C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685662173C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+AW9wLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfDKQr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:47:59 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:52801 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfDKQr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:47:59 -0400
Received: by mail-io1-f73.google.com with SMTP id p143so5396053iod.19
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=musgnI8VtM3Y7l+0TXGyVW+hd9UsBLsFq/gUmP1xlDM=;
        b=N+AW9wLPG37I2XuxXc9yshBJ+Y7hIP6OZpm/ZlyMX7bYco4vHo/M5lOUT9HioswMNT
         WyftG9z/x2VkkX/uwJ26vhaukJ1mC+vApQO/e+i+iSS3hzoLp/S/w4DzNdPhzJAejyf4
         ZBYz3dJDUg20judU0aJibvHVmUOIuIxtf2JxJvCDZTyW7YQPXBfURsA84l3kmokvb+6E
         CUpxAg9BIFThqVsOCLpKklhzI8k7JlSILWr9CNKp0CPBg55pwabr3OPudtxiyMQwuRey
         +u1vzyz9qpf3BRINQWsnddmcnP9Iz3nPFqq1GDbTDWosikuKmuOvcfSo90owiFDPavGu
         o1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=musgnI8VtM3Y7l+0TXGyVW+hd9UsBLsFq/gUmP1xlDM=;
        b=qHyxb9EHFbok7mq83jI6VLcW2b4xTEHC1Kd84yOZjwy/uWf03Vuzafyqxz8iHuIvjg
         bipNaXvKDBMs9svcmXwwE5/LgZINV/bTiSvHuJekCLpsTiYNH6VeXpSeiTjcl9+vID2F
         O3+BkhzBHYuPT4Z2759ZKVd3VlpdO9CU1Q0NF0gQ0ZkeiAVgdVIJwNQue2CLhwezUsbt
         a5ukkEu/4zaW2aGTMzrXFERAho1Ze5yXpMf9DWzCNcuCA2lzj8T6zo4Zcf+Z0eItwBwI
         EscR1SurMEtjkYBTWZj7SuYVqrLdtxG6qOo/WHKoW4G2Y23NneI+ndLUDLFTyCnSxdMc
         RfHA==
X-Gm-Message-State: APjAAAV+byc5V7qYn3OeLrrpHYk0ZWU7ey00Z0nX6ssbeyEsZb2LGc+J
        O5CVSJcccRhIsaVDqUpKrXxKF3h9kYkD/oOrJQ==
X-Google-Smtp-Source: APXvYqxh1c6Ufy+WhsRU/qo54xzEWpJLKJY5JsHwrkuSgAaCglZM09iSozcKdwB0bprnkX4DW2t28YDptudUJKnAPQ==
X-Received: by 2002:a24:97cf:: with SMTP id k198mr2833160ite.26.1555001278007;
 Thu, 11 Apr 2019 09:47:58 -0700 (PDT)
Date:   Thu, 11 Apr 2019 09:47:53 -0700
Message-Id: <20190411164753.217899-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] fs: Fix ovl_i_mutex_dir_key/p->lock/cred cred_guard_mutex deadlock
From:   Mina Almasry <almasrymina@google.com>
To:     Mina Almasry <almasrymina@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel B <shakeelb@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These 3 locks are acquired simultaneously in different order causing
deadlock:

https://syzkaller.appspot.com/bug?id=00f119b8bb35a3acbcfafb9d36a2752b364e8d66

======================================================
WARNING: possible circular locking dependency detected
4.19.0-rc5+ #253 Not tainted
------------------------------------------------------
syz-executor1/545 is trying to acquire lock:
00000000b04209e4 (&ovl_i_mutex_dir_key[depth]){++++}, at: inode_lock_shared include/linux/fs.h:748 [inline]
00000000b04209e4 (&ovl_i_mutex_dir_key[depth]){++++}, at: do_last fs/namei.c:3323 [inline]
00000000b04209e4 (&ovl_i_mutex_dir_key[depth]){++++}, at: path_openat+0x250d/0x5160 fs/namei.c:3534

but task is already holding lock:
0000000044500cca (&sig->cred_guard_mutex){+.+.}, at: prepare_bprm_creds+0x53/0x120 fs/exec.c:1404

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #3 (&sig->cred_guard_mutex){+.+.}:
       __mutex_lock_common kernel/locking/mutex.c:925 [inline]
       __mutex_lock+0x166/0x1700 kernel/locking/mutex.c:1072
       mutex_lock_killable_nested+0x16/0x20 kernel/locking/mutex.c:1102
       lock_trace+0x4c/0xe0 fs/proc/base.c:384
       proc_pid_stack+0x196/0x3b0 fs/proc/base.c:420
       proc_single_show+0x101/0x190 fs/proc/base.c:723
       seq_read+0x4af/0x1150 fs/seq_file.c:229
       do_loop_readv_writev fs/read_write.c:700 [inline]
       do_iter_read+0x4a3/0x650 fs/read_write.c:924
       vfs_readv+0x175/0x1c0 fs/read_write.c:986
       do_preadv+0x1cc/0x280 fs/read_write.c:1070
       __do_sys_preadv fs/read_write.c:1120 [inline]
       __se_sys_preadv fs/read_write.c:1115 [inline]
       __x64_sys_preadv+0x9a/0xf0 fs/read_write.c:1115
       do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #2 (&p->lock){+.+.}:
       __mutex_lock_common kernel/locking/mutex.c:925 [inline]
       __mutex_lock+0x166/0x1700 kernel/locking/mutex.c:1072
       mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
       seq_read+0x71/0x1150 fs/seq_file.c:161
       do_loop_readv_writev fs/read_write.c:700 [inline]
       do_iter_read+0x4a3/0x650 fs/read_write.c:924
       vfs_readv+0x175/0x1c0 fs/read_write.c:986
       kernel_readv fs/splice.c:362 [inline]
       default_file_splice_read+0x53c/0xb20 fs/splice.c:417
       do_splice_to+0x12e/0x190 fs/splice.c:881
       splice_direct_to_actor+0x270/0x8f0 fs/splice.c:953
       do_splice_direct+0x2d4/0x420 fs/splice.c:1062
       do_sendfile+0x62a/0xe20 fs/read_write.c:1440
       __do_sys_sendfile64 fs/read_write.c:1495 [inline]
       __se_sys_sendfile64 fs/read_write.c:1487 [inline]
       __x64_sys_sendfile64+0x15d/0x250 fs/read_write.c:1487
       do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (sb_writers#5){.+.+}:
       percpu_down_read_preempt_disable include/linux/percpu-rwsem.h:36 [inline]
       percpu_down_read include/linux/percpu-rwsem.h:59 [inline]
       __sb_start_write+0x214/0x370 fs/super.c:1387
       sb_start_write include/linux/fs.h:1566 [inline]
       mnt_want_write+0x3f/0xc0 fs/namespace.c:360
       ovl_want_write+0x76/0xa0 fs/overlayfs/util.c:24
       ovl_create_object+0x142/0x3a0 fs/overlayfs/dir.c:596
       ovl_create+0x2b/0x30 fs/overlayfs/dir.c:627
       lookup_open+0x1319/0x1b90 fs/namei.c:3234
       do_last fs/namei.c:3324 [inline]
       path_openat+0x15e7/0x5160 fs/namei.c:3534
       do_filp_open+0x255/0x380 fs/namei.c:3564
       do_sys_open+0x568/0x700 fs/open.c:1063
       ksys_open include/linux/syscalls.h:1276 [inline]
       __do_sys_creat fs/open.c:1121 [inline]
       __se_sys_creat fs/open.c:1119 [inline]
       __x64_sys_creat+0x61/0x80 fs/open.c:1119
       do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&ovl_i_mutex_dir_key[depth]){++++}:
       lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3900
       down_read+0xb0/0x1d0 kernel/locking/rwsem.c:24
       inode_lock_shared include/linux/fs.h:748 [inline]
       do_last fs/namei.c:3323 [inline]
       path_openat+0x250d/0x5160 fs/namei.c:3534
       do_filp_open+0x255/0x380 fs/namei.c:3564
       do_open_execat+0x221/0x8e0 fs/exec.c:853
       __do_execve_file.isra.33+0x173f/0x2540 fs/exec.c:1755
       do_execveat_common fs/exec.c:1866 [inline]
       do_execve fs/exec.c:1883 [inline]
       __do_sys_execve fs/exec.c:1964 [inline]
       __se_sys_execve fs/exec.c:1959 [inline]
       __x64_sys_execve+0x8f/0xc0 fs/exec.c:1959
       do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
  &ovl_i_mutex_dir_key[depth] --> &p->lock --> &sig->cred_guard_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sig->cred_guard_mutex);
                               lock(&p->lock);
                               lock(&sig->cred_guard_mutex);
  lock(&ovl_i_mutex_dir_key[depth]);

 *** DEADLOCK ***

Solution: I establish this locking order for these locks:

1. ovl_i_mutex_dir_key
2. p->lock
3. sig->cred_guard_mutex

In this change i fix the locking order of exec.c, which is the only
instance that voilates this order.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 fs/exec.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 2e0033348d8e..423d90bc75cc 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1742,6 +1742,12 @@ static int __do_execve_file(int fd, struct filename *filename,
 	if (retval)
 		goto out_ret;
 
+	if (!file)
+		file = do_open_execat(fd, filename, flags);
+	retval = PTR_ERR(file);
+	if (IS_ERR(file))
+		goto out_free;
+
 	retval = -ENOMEM;
 	bprm = kzalloc(sizeof(*bprm), GFP_KERNEL);
 	if (!bprm)
@@ -1754,12 +1760,6 @@ static int __do_execve_file(int fd, struct filename *filename,
 	check_unsafe_exec(bprm);
 	current->in_execve = 1;
 
-	if (!file)
-		file = do_open_execat(fd, filename, flags);
-	retval = PTR_ERR(file);
-	if (IS_ERR(file))
-		goto out_unmark;
-
 	sched_exec();
 
 	bprm->file = file;
@@ -1775,7 +1775,7 @@ static int __do_execve_file(int fd, struct filename *filename,
 					    fd, filename->name);
 		if (!pathbuf) {
 			retval = -ENOMEM;
-			goto out_unmark;
+			goto out_free;
 		}
 		/*
 		 * Record that a name derived from an O_CLOEXEC fd will be
@@ -1790,7 +1790,7 @@ static int __do_execve_file(int fd, struct filename *filename,
 
 	retval = bprm_mm_init(bprm);
 	if (retval)
-		goto out_unmark;
+		goto out_free;
 
 	retval = prepare_arg_pages(bprm, argv, envp);
 	if (retval < 0)
@@ -1840,10 +1840,6 @@ static int __do_execve_file(int fd, struct filename *filename,
 		mmput(bprm->mm);
 	}
 
-out_unmark:
-	current->fs->in_exec = 0;
-	current->in_execve = 0;
-
 out_free:
 	free_bprm(bprm);
 	kfree(pathbuf);
-- 
2.21.0.392.gf8f6787159e-goog

