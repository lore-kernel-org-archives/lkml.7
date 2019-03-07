Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2904EC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D1E208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980764;
	bh=4ScEkFvStfkvkSh9xpQmYGJe2q3Aj6G+sOUlEZUDfow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w+QPX3N2k650d8fFatMjEIEyNA3L3BWYfSQ7UHxC9s8u6rkyclYWYYbZcd5HV3EVB
	 WuhvsSfblswOm7EQFPf1fG6bnQBemFsV1Ouf/QWRxexPme4kVNPSEIkoMZMXbVEo3j
	 cOXP5A8uIQA4d8MknP3FLfSlzxrGrXysDgr5vnFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfCGRqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:46:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfCGRqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:46:00 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19FD220854;
        Thu,  7 Mar 2019 17:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980758;
        bh=4ScEkFvStfkvkSh9xpQmYGJe2q3Aj6G+sOUlEZUDfow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rze6y6txAkDQ/YoZDSyx3RhM4+5NppkjMV63WyeJMsLjS8MB0Y8zr89/mKPJqyd96
         rxQ0BP7ZEfICMbIYtuST86q6a+I/yuWtN5e1Cc5jSkE536y0aUYyev5tIc3DbuHYkK
         J8qORFEBICii+qyN9H8Kb/OSoR/cLi9An1MCR8UQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH 17/35] perf bpf: Automatically add BTF ELF markers
Date:   Thu,  7 Mar 2019 14:44:15 -0300
Message-Id: <20190307174433.28819-18-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The libbpf loader expects that some __btf_map_<MAP_NAME> structs be in
place with the keys and values types of maps so that one can store the
struct definitions and have them sent to the kernel via sys_bpf(fd, cmd
= BTF_LOAD) and then later be retrievable via sys_bpf(fd, cmd =
BPF_OBJ_GET_INFO_BY_FD) for use by tools such as 'bpftool map dump id
MAP_ID'.

Since we already have this for defining maps in 'perf trace' BPF events:

   bpf_map(name, _type, type_key, type_val, _max_entries)

As used in the tools/perf/examples/bpf/augmented_raw_syscalls.c:

 --- 8< ---

struct syscall {
        bool    enabled;
};

bpf_map(syscalls, ARRAY, int, struct syscall, 512);

 --- 8< ---

All we need is to get all that already available info, piggyback on the
'bpf_map' define in tools/perf/include/bpf/bpf.h, that is included by
'perf trace' BPF programs and do that without requiring changes to the
BPF programs already defining maps using 'bpf_map()'.

So this is what we have before this patch:

1) With this in ~/.perfconfig to dump .c events as .o, aka save a copy
   so that we can use the .o later as a pre-compiled BPF bytecode:

  # grep '\[llvm\]' -A2 ~/.perfconfig
  [llvm]
	dump-obj = true
	clang-opt = -g

  #
  # clang --version
  clang version 9.0.0 (https://git.llvm.org/git/clang.git/ 7906282d3afec5dfdc2b27943fd6c0309086c507) (https://git.llvm.org/git/llvm.git/ a1b5de1ff8ae8bc79dc8e86e1f82565229bd0500)
  Target: x86_64-unknown-linux-gnu
  Thread model: posix
  InstalledDir: /opt/llvm/bin

2) Note the -g there so that we get clang to generate debuginfo, and
   since the target is 'bpf' it will generate the BTF info in this
   clang version (9.0).

3) Run a simple 'perf record' specifiying as an event the augmented_raw_syscalls.c
   source code:

  # perf record -e /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c sleep 1
  LLVM: dumping /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.025 MB perf.data ]

  # file /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o: ELF 64-bit LSB relocatable, eBPF, version 1 (SYSV), with debug_info, not stripped

4) Look at the BTF structs encoded in it:

  # pahole -F btf --sizes /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  syscall_enter_args	64	0
  augmented_filename	264	0
  syscall	1	0
  syscall_exit_args	24	0
  bpf_map	28	0
  #
  # pahole -F btf -C syscalls /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  # pahole -F btf -C syscall /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  struct syscall {
	  bool                       enabled;              /*     0     1 */

	  /* size: 1, cachelines: 1, members: 1 */
	  /* last cacheline: 1 bytes */
  };
  #

5) Ok, with just this we don't have the markers expected by the libbpf
   loader and when we run with this BPF bytecode, because we have:

  # grep '\[trace\]' -A1 ~/.perfconfig
  [trace]
	add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  #

6) Lets do a 'perf trace' system wide session using this BPF program:

   # perf trace -e *mmsg,open*
  Cache2 I/O/6885 openat(AT_FDCWD, "/home/acme/.cache/mozilla/firefox/ina67tev.default/cache2/entries/BA220AB2914006A7AE96D27BE6EA13DD77519FCA", O_RDWR|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR) = 106
  Cache2 I/O/6885 openat(AT_FDCWD, "/proc/self/mountinfo", O_RDONLY) = 121
  Cache2 I/O/6885 openat(AT_FDCWD, "/proc/self/mountinfo", O_RDONLY) = 121
  Cache2 I/O/6885 openat(AT_FDCWD, "/proc/self/mountinfo", O_RDONLY) = 121
  Cache2 I/O/6885 openat(AT_FDCWD, "/proc/self/mountinfo", O_RDONLY) = 121
  DNS Res~ver #3/23340 openat(AT_FDCWD, "/etc/hosts", O_RDONLY|O_CLOEXEC) = 106
  DNS Res~ver #3/23340 sendmmsg(106<socket:[3482690]>, 0x7f252f1fcaf0, 2, MSG_NOSIGNAL) = 2
  Cache2 I/O/6885 openat(AT_FDCWD, "/home/acme/.cache/mozilla/firefox/ina67tev.default/cache2/entries/BA220AB2914006A7AE96D27BE6EA13DD77519FCA", O_RDWR) = 106
  lighttpd/18915 openat(AT_FDCWD, "/proc/loadavg", O_RDONLY) = 12

7) While it runs lets see the maps that 'perf trace' + libbpf's BPF
  loader loaded into the kernel via sys_bpf(fd, BPF_BTF_LOAD, ...):

  # bpftool map list | tail -6
  149: perf_event_array  name __augmented_sys  flags 0x0
	  key 4B  value 4B  max_entries 8  memlock 4096B
  150: array  name syscalls  flags 0x0
	  key 4B  value 1B  max_entries 512  memlock 8192B
  151: hash  name pids_filtered  flags 0x0
	  key 4B  value 1B  max_entries 64  memlock 8192B
  #

8) Dump the "pids_filtered", map, that will have one entry per PID that
   'perf trace' wants filtered, which includes its own, to avoid a
   tracing feedback loop (perf trace shows the syscalls it does which
   generates more syscalls that it has to show that...), it also
   auto-filters the 'gnome-terminal' and 'sshd' parent PIDs, for the
   same reason:

  # bpftool map dump id 151
  key: a5 0c 00 00  value: 01
  key: 14 63 00 00  value: 01
  Found 2 elements
  #

9) Since there is no BTF info available, it does a generic hex dump :-\

10) Now, with this patch applied, we'll do steps 3 to 6 again and look
    with pahole if there are extra structs encoded in BTF:

  # pahole -F btf --sizes /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  syscall_enter_args	64	0
  augmented_filename	264	0
  syscall	1	0
  syscall_exit_args	24	0
  bpf_map	28	0
  ____btf_map___augmented_syscalls__	8	0
  ____btf_map_syscalls	8	0
  ____btf_map_pids_filtered	8	0
  #

11) Yes, those __btf_map_ + the map names, lets see how they look like:

  # pahole -F btf -C ____btf_map_syscalls /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  struct ____btf_map_syscalls {
	  int                        key;                  /*     0     4 */
	  struct syscall             value;                /*     4     1 */

	  /* size: 8, cachelines: 1, members: 2 */
	  /* padding: 3 */
	  /* last cacheline: 8 bytes */
  };
  #

12) Lets repeat step 7 to get the new map ids:

  # bpftool map list | tail -6
  155: perf_event_array  name __augmented_sys  flags 0x0
	  key 4B  value 4B  max_entries 8  memlock 4096B
  156: array  name syscalls  flags 0x0
	  key 4B  value 1B  max_entries 512  memlock 8192B
  157: hash  name pids_filtered  flags 0x0
	  key 4B  value 1B  max_entries 64  memlock 8192B
  #

13) And finally lets dump the 'pids_filtered':

  # bpftool map dump id 157
  [{
        "key": 3237,
        "value": true
    },{
        "key": 26435,
        "value": true
    }
  ]
  #

Looks much better! BTF info was used to interpret the key as an integer
and the value as a struct with just one boolean member, so to make it
more compact, show just the 'true' value where we saw '01'.

Now to make 'perf trace --dump-map' to use BTF!

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@fb.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-ybuf9wpkm30xk28iq7jbwb40@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/bpf.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index 5df7ed9d9020..2eac6d804b2d 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -24,7 +24,13 @@ struct bpf_map SEC("maps") name = {				\
 	.key_size    = sizeof(type_key),			\
 	.value_size  = sizeof(type_val),			\
 	.max_entries = _max_entries,				\
-}
+};								\
+struct ____btf_map_##name {					\
+	type_key key;						\
+	type_val value;                                 	\
+};								\
+struct ____btf_map_##name __attribute__((section(".maps." #name), used)) \
+	____btf_map_##name = { }
 
 /*
  * FIXME: this should receive .max_entries as a parameter, as careful
-- 
2.20.1

