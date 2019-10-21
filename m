Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B644CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385DB2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387641AbfJVAFV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:05:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387615AbfJVAFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:05:18 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgx0-0003xO-QY; Tue, 22 Oct 2019 01:18:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B02B91C0489;
        Tue, 22 Oct 2019 01:18:57 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:18:57 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Pass a syscall_arg to syscall_arg_fmt->strtoul()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-c6mgkjt8ujnc263eld5tb7q3@git.kernel.org>
References: <tip-c6mgkjt8ujnc263eld5tb7q3@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157169993725.29376.72854596027164518.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9afec87ec1f832b8a521da42a72b73a44a59949d
Gitweb:        https://git.kernel.org/tip/9afec87ec1f832b8a521da42a72b73a44a59949d
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 18 Oct 2019 11:15:55 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 19 Oct 2019 15:34:48 -03:00

perf trace: Pass a syscall_arg to syscall_arg_fmt->strtoul()

With just what we need for the STUL_STRARRAY, i.e. the 'struct strarray'
pointer to be used, just like with syscall_arg_fmt->scnprintf() for the
other direction (number -> string).

With this all the strarrays that are associated with syscalls can be
used with '-e syscalls:sys_enter_SYSCALLNAME --filter', and soon will be
possible as well to use with the strace-like shorter form, with just the
syscall names, i.e. something like:

   -e lseek/whence==END/

For now we have to use the longer form:

    # perf trace -e syscalls:sys_enter_lseek
       0.000 pool/2242 syscalls:sys_enter_lseek(fd: 14<anon_inode:[timerfd]>, offset: 0, whence: CUR)
       0.031 pool/2242 syscalls:sys_enter_lseek(fd: 15<anon_inode:[timerfd]>, offset: 0, whence: CUR)
       0.046 pool/2242 syscalls:sys_enter_lseek(fd: 16<anon_inode:[timerfd]>, offset: 0, whence: CUR)
    5003.528 pool/2242 syscalls:sys_enter_lseek(fd: 14<anon_inode:[timerfd]>, offset: 0, whence: CUR)
    5003.575 pool/2242 syscalls:sys_enter_lseek(fd: 15<anon_inode:[timerfd]>, offset: 0, whence: CUR)
    5003.593 pool/2242 syscalls:sys_enter_lseek(fd: 16<anon_inode:[timerfd]>, offset: 0, whence: CUR)
   10002.017 pool/2242 syscalls:sys_enter_lseek(fd: 14<anon_inode:[timerfd]>, offset: 0, whence: CUR)
   10002.051 pool/2242 syscalls:sys_enter_lseek(fd: 15<anon_inode:[timerfd]>, offset: 0, whence: CUR)
   10002.068 pool/2242 syscalls:sys_enter_lseek(fd: 16<anon_inode:[timerfd]>, offset: 0, whence: CUR)
  ^C# perf trace -e syscalls:sys_enter_lseek --filter="whence!=CUR"
       0.000 sshd/24476 syscalls:sys_enter_lseek(fd: 3, offset: 9032, whence: SET)
       0.060 sshd/24476 syscalls:sys_enter_lseek(fd: 3</usr/lib64/libcrypt.so.2.0.0>, offset: 9032, whence: SET)
       0.187 sshd/24476 syscalls:sys_enter_lseek(fd: 3</usr/lib64/libcrypt.so.2.0.0>, offset: 118632, whence: SET)
       0.203 sshd/24476 syscalls:sys_enter_lseek(fd: 3</usr/lib64/libcrypt.so.2.0.0>, offset: 118632, whence: SET)
       0.349 sshd/24476 syscalls:sys_enter_lseek(fd: 3</usr/lib64/libcrypt.so.2.0.0>, offset: 61936, whence: SET)
  ^C#

And for those curious about what are those lseek(DSO, offset, SET), well, its the loader:

  # perf trace -e syscalls:sys_enter_lseek/max-stack=16/ --filter="whence!=CUR"
     0.000 sshd/24495 syscalls:sys_enter_lseek(fd: 3</usr/lib64/libgcrypt.so.20.2.5>, offset: 9032, whence: SET)
                                       __libc_lseek64 (/usr/lib64/ld-2.29.so)
                                       _dl_map_object (/usr/lib64/ld-2.29.so)
     0.067 sshd/24495 syscalls:sys_enter_lseek(fd: 3</usr/lib64/libgcrypt.so.20.2.5>, offset: 9032, whence: SET)
                                       __libc_lseek64 (/usr/lib64/ld-2.29.so)
                                       _dl_map_object_from_fd (/usr/lib64/ld-2.29.so)
                                       _dl_map_object (/usr/lib64/ld-2.29.so)
     0.198 sshd/24495 syscalls:sys_enter_lseek(fd: 3</usr/lib64/libgcrypt.so.20.2.5>, offset: 118632, whence: SET)
                                       __libc_lseek64 (/usr/lib64/ld-2.29.so)
                                       _dl_map_object (/usr/lib64/ld-2.29.so)
     0.219 sshd/24495 syscalls:sys_enter_lseek(fd: 3</usr/lib64/libgcrypt.so.20.2.5>, offset: 118632, whence: SET)
                                       __libc_lseek64 (/usr/lib64/ld-2.29.so)
                                       _dl_map_object_from_fd (/usr/lib64/ld-2.29.so)
                                       _dl_map_object (/usr/lib64/ld-2.29.so)
  ^C#

:-)

With this we can use strings in strarrays in filters, which allows us to
reuse all these that are in place for syscalls:

  $ find tools/perf/trace/beauty/ -name "*.c" | xargs grep -w DEFINE_STRARRAY
  tools/perf/trace/beauty/fcntl.c:	static DEFINE_STRARRAY(fcntl_setlease, "F_");
  tools/perf/trace/beauty/mmap.c:       static DEFINE_STRARRAY(mmap_flags, "MAP_");
  tools/perf/trace/beauty/mmap.c:       static DEFINE_STRARRAY(madvise_advices, "MADV_");
  tools/perf/trace/beauty/sync_file_range.c:       static DEFINE_STRARRAY(sync_file_range_flags, "SYNC_FILE_RANGE_");
  tools/perf/trace/beauty/socket.c:	static DEFINE_STRARRAY(socket_ipproto, "IPPROTO_");
  tools/perf/trace/beauty/mount_flags.c:	static DEFINE_STRARRAY(mount_flags, "MS_");
  tools/perf/trace/beauty/pkey_alloc.c:	static DEFINE_STRARRAY(pkey_alloc_access_rights, "PKEY_");
  tools/perf/trace/beauty/sockaddr.c:DEFINE_STRARRAY(socket_families, "PF_");
  tools/perf/trace/beauty/tracepoints/x86_irq_vectors.c:static DEFINE_STRARRAY(x86_irq_vectors, "_VECTOR");
  tools/perf/trace/beauty/tracepoints/x86_msr.c:static DEFINE_STRARRAY(x86_MSRs, "MSR_");
  tools/perf/trace/beauty/prctl.c:	static DEFINE_STRARRAY(prctl_options, "PR_");
  tools/perf/trace/beauty/prctl.c:	static DEFINE_STRARRAY(prctl_set_mm_options, "PR_SET_MM_");
  tools/perf/trace/beauty/fspick.c:       static DEFINE_STRARRAY(fspick_flags, "FSPICK_");
  tools/perf/trace/beauty/ioctl.c:	static DEFINE_STRARRAY(ioctl_tty_cmd, "");
  tools/perf/trace/beauty/ioctl.c:	static DEFINE_STRARRAY(drm_ioctl_cmds, "");
  tools/perf/trace/beauty/ioctl.c:	static DEFINE_STRARRAY(sndrv_pcm_ioctl_cmds, "");
  tools/perf/trace/beauty/ioctl.c:	static DEFINE_STRARRAY(sndrv_ctl_ioctl_cmds, "");
  tools/perf/trace/beauty/ioctl.c:	static DEFINE_STRARRAY(kvm_ioctl_cmds, "");
  tools/perf/trace/beauty/ioctl.c:	static DEFINE_STRARRAY(vhost_virtio_ioctl_cmds, "");
  tools/perf/trace/beauty/ioctl.c:	static DEFINE_STRARRAY(vhost_virtio_ioctl_read_cmds, "");
  tools/perf/trace/beauty/ioctl.c:	static DEFINE_STRARRAY(perf_ioctl_cmds, "");
  tools/perf/trace/beauty/ioctl.c:	static DEFINE_STRARRAY(usbdevfs_ioctl_cmds, "");
  tools/perf/trace/beauty/fsmount.c:       static DEFINE_STRARRAY(fsmount_attr_flags, "MOUNT_ATTR_");
  tools/perf/trace/beauty/renameat.c:       static DEFINE_STRARRAY(rename_flags, "RENAME_");
  tools/perf/trace/beauty/kcmp.c:	static DEFINE_STRARRAY(kcmp_types, "KCMP_");
  tools/perf/trace/beauty/move_mount.c:       static DEFINE_STRARRAY(move_mount_flags, "MOVE_MOUNT_");
  $

Well, some, as the mmap flags are like:

  $ tools/perf/trace/beauty/mmap_flags.sh
  static const char *mmap_flags[] = {
  	[ilog2(0x40) + 1] = "32BIT",
  	[ilog2(0x01) + 1] = "SHARED",
  	[ilog2(0x02) + 1] = "PRIVATE",
  	[ilog2(0x10) + 1] = "FIXED",
  	[ilog2(0x20) + 1] = "ANONYMOUS",
  	[ilog2(0x008000) + 1] = "POPULATE",
  	[ilog2(0x010000) + 1] = "NONBLOCK",
  	[ilog2(0x020000) + 1] = "STACK",
  	[ilog2(0x040000) + 1] = "HUGETLB",
  	[ilog2(0x080000) + 1] = "SYNC",
  	[ilog2(0x100000) + 1] = "FIXED_NOREPLACE",
  	[ilog2(0x0100) + 1] = "GROWSDOWN",
  	[ilog2(0x0800) + 1] = "DENYWRITE",
  	[ilog2(0x1000) + 1] = "EXECUTABLE",
  	[ilog2(0x2000) + 1] = "LOCKED",
  	[ilog2(0x4000) + 1] = "NORESERVE",
  };
  $

So we'll need a strarray__strtoul_flags() that will break donw the flags
into tokens separated by '|' before doing the lookup and then go on
reconstructing the value from, say:

      # perf trace -e syscalls:sys_enter_mmap --filter="flags==PRIVATE|FIXED|DENYWRITE"

into:

      # perf trace -e syscalls:sys_enter_mmap --filter="flags==0x2|0x10|0x0800"

and finally into:

      # perf trace -e syscalls:sys_enter_mmap --filter="flags==0x812"

That is what we see if we don't use the augmented view obtained from:

  # perf trace -e mmap
  <SNIP>
  211792.885 procmail/15393 mmap(addr: 0x7fcd11645000, len: 8192, prot: READ, flags: PRIVATE|FIXED|DENYWRITE, fd: 8, off: 0xa000) = 0x7fcd11645000
  <SNIP>

But plain use tracefs:

        procmail-15559 [000] .... 54557.178262: sys_mmap(addr: 7f5c9bf7a000, len: 9b000, prot: 1, flags: 812, fd: 3, off: a9000)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-c6mgkjt8ujnc263eld5tb7q3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1aaf7b2..0e7fc7c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3696,7 +3696,11 @@ static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel
 
 			if (fmt->strtoul) {
 				u64 val;
-				if (fmt->strtoul(right, right_size, NULL, &val)) {
+				struct syscall_arg syscall_arg = {
+					.parm = fmt->parm,
+				};
+
+				if (fmt->strtoul(right, right_size, &syscall_arg, &val)) {
 					char *n, expansion[19];
 					int expansion_lenght = scnprintf(expansion, sizeof(expansion), "%#" PRIx64, val);
 					int expansion_offset = right - new_filter;
