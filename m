Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680A9C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFCC2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221174;
	bh=F1gy2f16v2Iy0gWQY2bRvLT77KZ1qRUvgsWe8g85ZbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lQ6YuP1UlpDrm6F1u/eo5sja62AePC+1Zg9/aDyw0W1KKbP5rSztPLJ+JeGmvRz5C
	 lFYVXzvopfGzI1O/8iu4ECHspe7H1cX15EG6RckO6Jnc5BEtGEtD+hlqUBNRT3k2uC
	 NeYheo4vlKsE8V/CjYU47iKvEqrHTiqN+Qc44uZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfDBQGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:06:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729364AbfDBQGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:06:10 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A97C920856;
        Tue,  2 Apr 2019 16:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221168;
        bh=F1gy2f16v2Iy0gWQY2bRvLT77KZ1qRUvgsWe8g85ZbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PvfwWNxSaDFgB4W9Tqg3dzssNRENotSdtgg8itOMY/P4l+wmw+WaOk+jGpEH3F8up
         p0CwwB5R45VZo0HgVoJTveTEoNEQs1RE9Uu2pAv8gKHxemHTon6j9p1/oCAV58yd/8
         9DlPYkhv/NG9eTNMkP3VDcBV0U45hGIPupRbCLvM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 02/44] perf augmented_raw_syscalls: Copy strings from all syscalls with 1st or 2nd string arg
Date:   Tue,  2 Apr 2019 13:05:07 -0300
Message-Id: <20190402160549.13544-3-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Gets the augmented_raw_syscalls a bit more useful as-is, add a comment
stating that the intent is to have all this in a map populated by
userspace via the 'syscalls' BPF map, that right now has only a flag
stating if the syscall is filtered or not.

With it:

  # grep -B1 augmented_raw ~/.perfconfig
  [trace]
	add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  #
  # perf trace -e string
  weechat/6001 stat("/etc/localtime", 0x7ffe22c23d10)  = 0
  gnome-shell/1943 openat(AT_FDCWD, "/proc/self/stat", O_RDONLY) = 81
  weechat/6001 stat("/etc/localtime", 0x7ffe22c23d10)  = 0
  gmain/2475 inotify_add_watch(20<anon_inode:inotify>, "/home/acme/.config/firewall", 16789454) = -1 ENOENT (No such file or directory)
  gmain/2391 inotify_add_watch(3<anon_inode:inotify>, "", 16789454) = -1 ENOENT (No such file or directory)
  gmain/2391 inotify_add_watch(3<anon_inode:inotify>, "/var/cache/app-info/yaml", 16789454) = -1 ENOENT (No such file or directory)
  gmain/2391 inotify_add_watch(3<anon_inode:inotify>, "/var/lib/app-info/xmls", 16789454) = -1 ENOENT (No such file or directory)
  gmain/2391 inotify_add_watch(3<anon_inode:inotify>, "/var/lib/app-info/yaml", 16789454) = -1 ENOENT (No such file or directory)
  gmain/2391 inotify_add_watch(3<anon_inode:inotify>, "/usr/share/app-info/yaml", 16789454) = -1 ENOENT (No such file or directory)
  gmain/2391 inotify_add_watch(3<anon_inode:inotify>, "/usr/local/share/app-info/xmls", 16789454) = -1 ENOENT (No such file or directory)
  gmain/2391 inotify_add_watch(3<anon_inode:inotify>, "/usr/local/share/app-info/yaml", 16789454) = -1 ENOENT (No such file or directory)
  gmain/2391 inotify_add_watch(3<anon_inode:inotify>, "/home/acme/.local/share/app-info/yaml", 16789454) = -1 ENOENT (No such file or directory)
  gmain/1121 inotify_add_watch(12<anon_inode:inotify>, "/etc/NetworkManager/VPN", 16789454) = -1 ENOENT (No such file or directory)
  weechat/6001 stat("/etc/localtime", 0x7ffe22c23d10)  = 0
  gmain/2050 inotify_add_watch(8<anon_inode:inotify>, "/home/acme/~", 16789454) = -1 ENOENT (No such file or directory)
  gmain/2521 inotify_add_watch(6<anon_inode:inotify>, "/var/lib/fwupd/remotes.d/lvfs-testing", 16789454) = -1 ENOENT (No such file or directory)
  weechat/6001 stat("/etc/localtime", 0x7ffe22c23d10)  = 0
  DOM Worker/22714  ... [continued]: openat())             = 257
  FS Broker 3982/3990 openat(AT_FDCWD, "/dev/urandom", O_RDONLY|O_CLOEXEC|O_NOCTTY) = 187
  DOMCacheThread/16652 mkdir("/home/acme/.mozilla/firefox/ina67tev.default/storage/default/https+++web.whatsapp.com/cache/morgue/192", S_IRUGO|S_IXUGO|S_IWUSR) = -1 EEXIST (File exists)
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-a1hxffoy8t43e0wq6bzhp23u@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../examples/bpf/augmented_raw_syscalls.c     | 150 +++++++++++++++++-
 1 file changed, 147 insertions(+), 3 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index f9b2161e1ca4..9f8b31ad7a49 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -44,9 +44,78 @@ struct augmented_filename {
 	char		value[256];
 };
 
-#define SYS_OPEN 2
-#define SYS_ACCESS 21
-#define SYS_OPENAT 257
+/* syscalls where the first arg is a string */
+#define SYS_OPEN                 2
+#define SYS_STAT                 4
+#define SYS_LSTAT                6
+#define SYS_ACCESS              21
+#define SYS_EXECVE              59
+#define SYS_TRUNCATE            76
+#define SYS_CHDIR               80
+#define SYS_RENAME              82
+#define SYS_MKDIR               83
+#define SYS_RMDIR               84
+#define SYS_CREAT               85
+#define SYS_LINK                86
+#define SYS_UNLINK              87
+#define SYS_SYMLINK             88
+#define SYS_READLINK            89
+#define SYS_CHMOD               90
+#define SYS_CHOWN               92
+#define SYS_LCHOWN              94
+#define SYS_MKNOD              133
+#define SYS_STATFS             137
+#define SYS_PIVOT_ROOT         155
+#define SYS_CHROOT             161
+#define SYS_ACCT               163
+#define SYS_SWAPON             167
+#define SYS_SWAPOFF            168
+#define SYS_DELETE_MODULE      176
+#define SYS_SETXATTR           188
+#define SYS_LSETXATTR          189
+#define SYS_GETXATTR           191
+#define SYS_LGETXATTR          192
+#define SYS_LISTXATTR          194
+#define SYS_LLISTXATTR         195
+#define SYS_REMOVEXATTR        197
+#define SYS_LREMOVEXATTR       198
+#define SYS_MQ_OPEN            240
+#define SYS_MQ_UNLINK          241
+#define SYS_ADD_KEY            248
+#define SYS_REQUEST_KEY        249
+#define SYS_SYMLINKAT          266
+#define SYS_MEMFD_CREATE       319
+
+/* syscalls where the first arg is a string */
+
+#define SYS_PWRITE64            18
+#define SYS_EXECVE              59
+#define SYS_RENAME              82
+#define SYS_QUOTACTL           179
+#define SYS_FSETXATTR          190
+#define SYS_FGETXATTR          193
+#define SYS_FREMOVEXATTR       199
+#define SYS_MQ_TIMEDSEND       242
+#define SYS_REQUEST_KEY        249
+#define SYS_INOTIFY_ADD_WATCH  254
+#define SYS_OPENAT             257
+#define SYS_MKDIRAT            258
+#define SYS_MKNODAT            259
+#define SYS_FCHOWNAT           260
+#define SYS_FUTIMESAT          261
+#define SYS_NEWFSTATAT         262
+#define SYS_UNLINKAT           263
+#define SYS_RENAMEAT           264
+#define SYS_LINKAT             265
+#define SYS_READLINKAT         267
+#define SYS_FCHMODAT           268
+#define SYS_FACCESSAT          269
+#define SYS_UTIMENSAT          280
+#define SYS_NAME_TO_HANDLE_AT  303
+#define SYS_FINIT_MODULE       313
+#define SYS_RENAMEAT2          316
+#define SYS_EXECVEAT           322
+#define SYS_STATX              332
 
 pid_filter(pids_filtered);
 
@@ -109,11 +178,86 @@ int sys_enter(struct syscall_enter_args *args)
 	 *
 	 * 	 after the ctx memory access to prevent their down stream merging.
 	 */
+	/*
+	 * This table of what args are strings will be provided by userspace,
+	 * in the syscalls map, i.e. we will already have to do the lookup to
+	 * see if this specific syscall is filtered, so we can as well get more
+	 * info about what syscall args are strings or pointers, and how many
+	 * bytes to copy, per arg, etc.
+	 *
+	 * For now hard code it, till we have all the basic mechanisms in place
+	 * to automate everything and make the kernel part be completely driven
+	 * by information obtained in userspace for each kernel version and
+	 * processor architecture, making the kernel part the same no matter what
+	 * kernel version or processor architecture it runs on.
+	 */
 	switch (augmented_args.args.syscall_nr) {
+	case SYS_ACCT:
+	case SYS_ADD_KEY:
+	case SYS_CHDIR:
+	case SYS_CHMOD:
+	case SYS_CHOWN:
+	case SYS_CHROOT:
+	case SYS_CREAT:
+	case SYS_DELETE_MODULE:
+	case SYS_EXECVE:
+	case SYS_GETXATTR:
+	case SYS_LCHOWN:
+	case SYS_LGETXATTR:
+	case SYS_LINK:
+	case SYS_LISTXATTR:
+	case SYS_LLISTXATTR:
+	case SYS_LREMOVEXATTR:
+	case SYS_LSETXATTR:
+	case SYS_LSTAT:
+	case SYS_MEMFD_CREATE:
+	case SYS_MKDIR:
+	case SYS_MKNOD:
+	case SYS_MQ_OPEN:
+	case SYS_MQ_UNLINK:
+	case SYS_PIVOT_ROOT:
+	case SYS_READLINK:
+	case SYS_REMOVEXATTR:
+	case SYS_RENAME:
+	case SYS_REQUEST_KEY:
+	case SYS_RMDIR:
+	case SYS_SETXATTR:
+	case SYS_STAT:
+	case SYS_STATFS:
+	case SYS_SWAPOFF:
+	case SYS_SWAPON:
+	case SYS_SYMLINK:
+	case SYS_SYMLINKAT:
+	case SYS_TRUNCATE:
+	case SYS_UNLINK:
 	case SYS_ACCESS:
 	case SYS_OPEN:	 filename_arg = (const void *)args->args[0];
 			__asm__ __volatile__("": : :"memory");
 			 break;
+	case SYS_EXECVEAT:
+	case SYS_FACCESSAT:
+	case SYS_FCHMODAT:
+	case SYS_FCHOWNAT:
+	case SYS_FGETXATTR:
+	case SYS_FINIT_MODULE:
+	case SYS_FREMOVEXATTR:
+	case SYS_FSETXATTR:
+	case SYS_FUTIMESAT:
+	case SYS_INOTIFY_ADD_WATCH:
+	case SYS_LINKAT:
+	case SYS_MKDIRAT:
+	case SYS_MKNODAT:
+	case SYS_MQ_TIMEDSEND:
+	case SYS_NAME_TO_HANDLE_AT:
+	case SYS_NEWFSTATAT:
+	case SYS_PWRITE64:
+	case SYS_QUOTACTL:
+	case SYS_READLINKAT:
+	case SYS_RENAMEAT:
+	case SYS_RENAMEAT2:
+	case SYS_STATX:
+	case SYS_UNLINKAT:
+	case SYS_UTIMENSAT:
 	case SYS_OPENAT: filename_arg = (const void *)args->args[1];
 			 break;
 	}
-- 
2.20.1

