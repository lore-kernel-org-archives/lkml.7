Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93257CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C432173B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665249;
	bh=zjTjIj5tYIoQjzMIWU2LG0kWkpqR/g3pKSbfeLV67uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lHP2nlzZopfSbhBzCNQLXnOKvGOO9LACzEJqOhMJIW//p4sqWk4kl7VT0GHIG/zxg
	 hmifuLrREvPTjD2rGOAmjoRU1jg3R3mQ1OaIWBdN7v00mq1g6RPmwsDwAc41d2L5hO
	 0v4G2Tr/pimHl2Q697xzW3U9XGqkrZtKiHJkcp00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbfJUNkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729555AbfJUNkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:40:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6D26214AE;
        Mon, 21 Oct 2019 13:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665242;
        bh=zjTjIj5tYIoQjzMIWU2LG0kWkpqR/g3pKSbfeLV67uk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FsRv52F+TLQST7i03d8OF2duVc3UDQ/sG7FL7YKptLQvu21Y3G5XCropHNpj5098Z
         ZZYSEzGQB6RAXeXPRpMxrZo/YLIdLxQm9hj1K5m57RcjzrsFmvk0Kd8n0ky2pnDqL9
         2wvcFKSDFhIN7E+tPfyKaAbA1hIhD/pHZ0O1ABNo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 38/57] perf trace: Pass a syscall_arg to syscall_arg_fmt->strtoul()
Date:   Mon, 21 Oct 2019 10:38:15 -0300
Message-Id: <20191021133834.25998-39-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index 1aaf7b28eec4..0e7fc7cc42d9 100644
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
-- 
2.21.0

