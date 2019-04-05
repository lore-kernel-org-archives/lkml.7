Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCE9C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5E42186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbfDELeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:34:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39125 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730497AbfDELeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:34:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35BYHcQ2733898
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 04:34:17 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35BYGEv2733895;
        Fri, 5 Apr 2019 04:34:16 -0700
Date:   Fri, 5 Apr 2019 04:34:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-6fh1myvn7ulf4xwq9iz3o776@git.kernel.org>
Cc:     adrian.hunter@intel.com, acme@redhat.com, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de, lclaudio@redhat.com,
        namhyung@kernel.org, wangnan0@huawei.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: lclaudio@redhat.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          wangnan0@huawei.com, adrian.hunter@intel.com, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Add 'string' event alias to select
 syscalls with string args
Git-Commit-ID: 2b64b2ed277ff23e785fbdb65098ee7e1252d64f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2b64b2ed277ff23e785fbdb65098ee7e1252d64f
Gitweb:     https://git.kernel.org/tip/2b64b2ed277ff23e785fbdb65098ee7e1252d64f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 22 Mar 2019 14:18:21 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Apr 2019 14:49:24 -0300

perf trace: Add 'string' event alias to select syscalls with string args

Will be used in conjunction with the change to augmented_raw_syscalls.c
in the next cset that adds all syscalls with a first or second arg
string.

With just what we have in the syscall tracepoints we get:

  # perf trace -e string ls > /dev/null
         ? (         ): ls/22382  ... [continued]: execve())                                           = 0
     0.043 ( 0.004 ms): ls/22382 access(filename: 0x51ad420, mode: R)                                  = -1 ENOENT (No such file or directory)
     0.051 ( 0.004 ms): ls/22382 openat(dfd: CWD, filename: 0x51aa8b3, flags: RDONLY|CLOEXEC)          = 3
     0.071 ( 0.004 ms): ls/22382 openat(dfd: CWD, filename: 0x51b4d00, flags: RDONLY|CLOEXEC)          = 3
     0.138 ( 0.009 ms): ls/22382 openat(dfd: CWD, filename: 0x51684d0, flags: RDONLY|CLOEXEC)          = 3
     0.192 ( 0.004 ms): ls/22382 openat(dfd: CWD, filename: 0x51689c0, flags: RDONLY|CLOEXEC)          = 3
     0.255 ( 0.004 ms): ls/22382 openat(dfd: CWD, filename: 0x5168eb0, flags: RDONLY|CLOEXEC)          = 3
     0.342 ( 0.003 ms): ls/22382 openat(dfd: CWD, filename: 0x51693a0, flags: RDONLY|CLOEXEC)          = 3
     0.380 ( 0.003 ms): ls/22382 openat(dfd: CWD, filename: 0x5169950, flags: RDONLY|CLOEXEC)          = 3
     0.670 ( 0.011 ms): ls/22382 statfs(pathname: 0x515c783, buf: 0x7fff54d75b70)                      = 0
     0.683 ( 0.005 ms): ls/22382 statfs(pathname: 0x515c783, buf: 0x7fff54d75a60)                      = 0
     0.725 ( 0.004 ms): ls/22382 access(filename: 0x515c7ab)                                           = 0
     0.744 ( 0.005 ms): ls/22382 openat(dfd: CWD, filename: 0x50fba20, flags: RDONLY|CLOEXEC)          = 3
     0.793 ( 0.004 ms): ls/22382 openat(dfd: CWD, filename: 0x9e3e8390, flags: RDONLY|CLOEXEC|DIRECTORY|NONBLOCK) = 3
     0.921 ( 0.006 ms): ls/22382 openat(dfd: CWD, filename: 0x50f7d90)                                 = 3
  #

If we put the vfs_getname probe point in place:

  # perf probe 'vfs_getname=getname_flags:73 pathname=result->name:string'
  Added new events:
    probe:vfs_getname    (on getname_flags:73 with pathname=result->name:string)
    probe:vfs_getname_1  (on getname_flags:73 with pathname=result->name:string)

  You can now use it in all perf tools, such as:

	perf record -e probe:vfs_getname_1 -aR sleep 1

  # perf trace -e string ls > /dev/null
         ? (         ): ls/22440  ... [continued]: execve())                                           = 0
     0.048 ( 0.008 ms): ls/22440 access(filename: /etc/ld.so.preload, mode: R)                         = -1 ENOENT (No such file or directory)
     0.061 ( 0.007 ms): ls/22440 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: RDONLY|CLOEXEC)   = 3
     0.092 ( 0.008 ms): ls/22440 openat(dfd: CWD, filename: /lib64/libselinux.so.1, flags: RDONLY|CLOEXEC) = 3
     0.165 ( 0.007 ms): ls/22440 openat(dfd: CWD, filename: /lib64/libcap.so.2, flags: RDONLY|CLOEXEC) = 3
     0.216 ( 0.007 ms): ls/22440 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: RDONLY|CLOEXEC)   = 3
     0.282 ( 0.007 ms): ls/22440 openat(dfd: CWD, filename: /lib64/libpcre2-8.so.0, flags: RDONLY|CLOEXEC) = 3
     0.340 ( 0.007 ms): ls/22440 openat(dfd: CWD, filename: /lib64/libdl.so.2, flags: RDONLY|CLOEXEC)  = 3
     0.383 ( 0.007 ms): ls/22440 openat(dfd: CWD, filename: /lib64/libpthread.so.0, flags: RDONLY|CLOEXEC) = 3
     0.697 ( 0.021 ms): ls/22440 statfs(pathname: /sys/fs/selinux, buf: 0x7ffee7dc9010)                = 0
     0.720 ( 0.007 ms): ls/22440 statfs(pathname: /sys/fs/selinux, buf: 0x7ffee7dc8f00)                = 0
     0.757 ( 0.007 ms): ls/22440 access(filename: /etc/selinux/config)                                 = 0
     0.779 ( 0.009 ms): ls/22440 openat(dfd: CWD, filename: /usr/lib/locale/locale-archive, flags: RDONLY|CLOEXEC) = 3
     0.830 ( 0.006 ms): ls/22440 openat(dfd: CWD, filename: ., flags: RDONLY|CLOEXEC|DIRECTORY|NONBLOCK) = 3
     0.958 ( 0.010 ms): ls/22440 openat(dfd: CWD, filename: /usr/lib64/gconv/gconv-modules.cache)      = 3
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-6fh1myvn7ulf4xwq9iz3o776@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/strace/groups/string | 65 +++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/perf/trace/strace/groups/string b/tools/perf/trace/strace/groups/string
new file mode 100644
index 000000000000..c87129a3e3c4
--- /dev/null
+++ b/tools/perf/trace/strace/groups/string
@@ -0,0 +1,65 @@
+access
+acct
+add_key
+chdir
+chmod
+chown
+chroot
+creat
+delete_module
+execve
+execveat
+faccessat
+fchmodat
+fchownat
+fgetxattr
+finit_module
+fremovexattr
+fsetxattr
+futimesat
+getxattr
+inotify_add_watch
+lchown
+lgetxattr
+link
+linkat
+listxattr
+llistxattr
+lremovexattr
+lsetxattr
+lstat
+memfd_create
+mkdir
+mkdirat
+mknod
+mknodat
+mq_open
+mq_timedsend
+mq_unlink
+name_to_handle_at
+newfstatat
+open
+openat
+pivot_root
+pwrite64
+quotactl
+readlink
+readlinkat
+removexattr
+rename
+renameat
+renameat2
+request_key
+rmdir
+setxattr
+stat
+statfs
+statx
+swapoff
+swapon
+symlink
+symlinkat
+truncate
+unlink
+unlinkat
+utimensat
