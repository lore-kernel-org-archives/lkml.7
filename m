Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A443C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8912084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221170;
	bh=0Gtljj3yx3ypyMkp63y/C++sn6VBUF6aJi6xqw0lEPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I1x8y0m2VlYKqcaMOvBX/32kNUPb87OwahwjRWZf9wN7KoL/oqISQ2s7GVtwpUiU6
	 fuqVoL6zu3BtviZWTuMfEuYr12Tfi634CKyRXT8wLQY+WCarkOLKpcBL14pIvm3r2e
	 XBTEvGW56kwA9xnrMTXMAEhW8oqb6U/XvJ7cA2Ck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfDBQGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:06:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfDBQGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:06:06 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92BA920840;
        Tue,  2 Apr 2019 16:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221165;
        bh=0Gtljj3yx3ypyMkp63y/C++sn6VBUF6aJi6xqw0lEPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/6fOv1tYWHcHJ95Mt4+M0vmOzH+Sw1AgShfC5sBJDp54zZoTmFxCf5JFtrYD3EsW
         jKG5982fgHFFXP1arMCiq5uj1tEmsZyEsl/WSN5OQtWU2rmVH+3J5vDSbIT5+R4nGa
         ob/Kx3vEZvnq1oHiwHsTi3jT3mg6rsmV1fzoMHe4=
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
Subject: [PATCH 01/44] perf trace: Add 'string' event alias to select syscalls with string args
Date:   Tue,  2 Apr 2019 13:05:06 -0300
Message-Id: <20190402160549.13544-2-acme@kernel.org>
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
 tools/perf/trace/strace/groups/string | 65 +++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 tools/perf/trace/strace/groups/string

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
-- 
2.20.1

