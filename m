Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E61C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F77206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XrvYRdS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfFQS6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:58:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34157 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFQS6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:58:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HIwUxL3553942
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 11:58:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HIwUxL3553942
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560797910;
        bh=LlFEYI85AD3lvLx51Yk5gb54/LZCOwx7L2Zxy0JATz4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=XrvYRdS6EklFXv8RLt2xF6blrBaXmk1W7Erv55ENlzjZkThA75Ssi2TLZgnkdqE8M
         xof09sfW2GPilZGTdGnukHVQIXKS6UFhBRx4K5XBEhDzrpf69sDkxHqC+8pOTEbNN6
         ZDb4Z+MaGMZwCcgIAtTJrVsLQqFqUC+n3tXMkFdvwMmFYsXQ7m+WAXxclO3djz0z2+
         5mw4nB57OpvLEWbt3YH84cLSDhR6gZPk4dlu15/a/GjhodYtXEQXwbb4Lbi/XyGczE
         h3wkslXHYdJpkKmOfSv6YFOvqu2yFojFDPquTAQtiN+1F3NOafj2iu/w4gqIBlGX2e
         2AAUfFLF0/bnQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HIwU3o3553939;
        Mon, 17 Jun 2019 11:58:30 -0700
Date:   Mon, 17 Jun 2019 11:58:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexey Budankov <tipbot@zytor.com>
Message-ID: <tip-d194d8fccf610a3f5cdfa94f2bbbe6b89e11a295@git.kernel.org>
Cc:     ak@linux.intel.com, peterz@infradead.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, acme@redhat.com, hpa@zytor.com,
        alexey.budankov@linux.intel.com, mingo@kernel.org,
        namhyung@kernel.org
Reply-To: alexey.budankov@linux.intel.com, hpa@zytor.com, acme@redhat.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, jolsa@redhat.com,
          peterz@infradead.org, ak@linux.intel.com
In-Reply-To: <e7fd37b1-af22-0d94-a0dc-5895e803bbfe@linux.intel.com>
References: <e7fd37b1-af22-0d94-a0dc-5895e803bbfe@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf record: Allow mixing --user-regs with
 --call-graph=dwarf
Git-Commit-ID: d194d8fccf610a3f5cdfa94f2bbbe6b89e11a295
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

Commit-ID:  d194d8fccf610a3f5cdfa94f2bbbe6b89e11a295
Gitweb:     https://git.kernel.org/tip/d194d8fccf610a3f5cdfa94f2bbbe6b89e11a295
Author:     Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate: Thu, 30 May 2019 22:03:36 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:54 -0300

perf record: Allow mixing --user-regs with --call-graph=dwarf

When DWARF stacks were requested and at the same time that the user
specifies a register set using the --user-regs option the full register
context was being captured on samples:

  $ perf record -g --call-graph dwarf,1024 --user-regs=IP,SP,BP -- stack_test2.g.O3

  188143843893585 0x6b48 [0x4f8]: PERF_RECORD_SAMPLE(IP, 0x4002): 23828/23828: 0x401236 period: 1363819 addr: 0x7ffedbdd51ac
  ... FP chain: nr:0
  ... user regs: mask 0xff0fff ABI 64-bit
  .... AX    0x53b
  .... BX    0x7ffedbdd3cc0
  .... CX    0xffffffff
  .... DX    0x33d3a
  .... SI    0x7f09b74c38d0
  .... DI    0x0
  .... BP    0x401260
  .... SP    0x7ffedbdd3cc0
  .... IP    0x401236
  .... FLAGS 0x20a
  .... CS    0x33
  .... SS    0x2b
  .... R8    0x7f09b74c3800
  .... R9    0x7f09b74c2da0
  .... R10   0xfffffffffffff3ce
  .... R11   0x246
  .... R12   0x401070
  .... R13   0x7ffedbdd5db0
  .... R14   0x0
  .... R15   0x0
  ... ustack: size 1024, offset 0xe0
   . data_src: 0x5080021
   ... thread: stack_test2.g.O:23828
   ...... dso: /root/abudanko/stacks/stack_test2.g.O3

I.e. the --user-regs=IP,SP,BP was being ignored, being overridden by the
needs of --call-graph=dwarf.

After applying the change in this patch the sample data contains the
user specified register, but making sure that at least the minimal set
of register needed for DWARF unwinding (DWARF_MINIMAL_REGS) is
requested.

The user is warned that DWARF unwinding may not work if extra registers
end up being needed.

  -g call-graph dwarf,K                         full_regs
  --user-regs=user_regs                         user_regs
  -g call-graph dwarf,K --user-regs=user_regs	user_regs + DWARF_MINIMAL_REGS

  $ perf record -g --call-graph dwarf,1024 --user-regs=BP -- ls
  WARNING: The use of --call-graph=dwarf may require all the user registers, specifying a subset with --user-regs may render DWARF unwinding unreliable, so the minimal registers set (IP, SP) is explicitly forced.
  arch   COPYING	Documentation  include	Kbuild	 lbuild    MAINTAINERS	modules.builtin		 Module.symvers  perf.data.old	scripts   System.map  virt
  block  CREDITS	drivers        init	Kconfig  lib	   Makefile	modules.builtin.modinfo  net		 README		security  tools       vmlinux
  certs  crypto	fs	       ipc	kernel	 LICENSES  mm		modules.order		 perf.data	 samples	sound	  usr	      vmlinux.o
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.030 MB perf.data (10 samples) ]

  188368474305373 0x5e40 [0x470]: PERF_RECORD_SAMPLE(IP, 0x4002): 23839/23839: 0x401236 period: 1260507 addr: 0x7ffd3d85e96c
  ... FP chain: nr:0
  ... user regs: mask 0x1c0 ABI 64-bit
  .... BP    0x401260
  .... SP    0x7ffd3d85cc20
  .... IP    0x401236
  ... ustack: size 1024, offset 0x58
   . data_src: 0x5080021

Committer notes:

Detected build failures on arches where PERF_REGS_ is not available,
such as debian:experimental-x-{mips,mips64,mipsel}, fedora 24 and 30 for
ARC uClibc and glibc, reported to Alexey that provided a patch moving
the DWARF_MINIMAL_REGS from evsel.c to util/perf_regs.h, where it is
guarded by an HAVE_PERF_REGS_SUPPORT ifdef.

Committer testing:

  # perf record --user-regs=bp,ax -a sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.955 MB perf.data (1773 samples) ]
  # perf script -F+uregs | grep AX: | head -5
     perf 1719 [000] 181.272398:    1 cycles: ffffffffba06a7c4 native_write_msr+0x4 (/lib/modules/5.2.0-rc1+/build/vmlinux) ABI:2 AX:0xffffffffffffffda BP:0x7ffef828fb00
     perf 1719 [000] 181.272402:    1 cycles: ffffffffba06a7c4 native_write_msr+0x4 (/lib/modules/5.2.0-rc1+/build/vmlinux) ABI:2 AX:0xffffffffffffffda BP:0x7ffef828fb00
     perf 1719 [000] 181.272403:    8 cycles: ffffffffba06a7c4 native_write_msr+0x4 (/lib/modules/5.2.0-rc1+/build/vmlinux) ABI:2 AX:0xffffffffffffffda BP:0x7ffef828fb00
     perf 1719 [000] 181.272405:  181 cycles: ffffffffba06a7c6 native_write_msr+0x6 (/lib/modules/5.2.0-rc1+/build/vmlinux) ABI:2 AX:0xffffffffffffffda BP:0x7ffef828fb00
     perf 1719 [000] 181.272406: 4405 cycles: ffffffffba06a7c4 native_write_msr+0x4 (/lib/modules/5.2.0-rc1+/build/vmlinux) ABI:2 AX:0xffffffffffffffda BP:0x7ffef828fb00
  # perf record --call-graph=dwarf --user-regs=bp,ax -a sleep 1
  WARNING: The use of --call-graph=dwarf may require all the user registers, specifying a subset with --user-regs may render DWARF unwinding unreliable, so the minimal registers set (IP, SP) is explicitly forced.
  [ perf record: Woken up 55 times to write data ]
  [ perf record: Captured and wrote 24.184 MB perf.data (2841 samples) ]
  [root@quaco ~]# perf script --hide-call-graph -F+uregs | grep AX: | head -5
     perf 1729 [000] 211.268006:    1 cycles: ffffffffba06a7c4 native_write_msr+0x4 (/lib/modules/5.2.0-rc1+/build/vmlinux) ABI:2 AX:0xffffffffffffffda BP:0x7ffc8679abb0 SP:0x7ffc8679ab78 IP:0x7fa75223a0db
     perf 1729 [000] 211.268014:    1 cycles: ffffffffba06a7c4 native_write_msr+0x4 (/lib/modules/5.2.0-rc1+/build/vmlinux) ABI:2 AX:0xffffffffffffffda BP:0x7ffc8679abb0 SP:0x7ffc8679ab78 IP:0x7fa75223a0db
     perf 1729 [000] 211.268017:    5 cycles: ffffffffba06a7c4 native_write_msr+0x4 (/lib/modules/5.2.0-rc1+/build/vmlinux) ABI:2 AX:0xffffffffffffffda BP:0x7ffc8679abb0 SP:0x7ffc8679ab78 IP:0x7fa75223a0db
     perf 1729 [000] 211.268020:   48 cycles: ffffffffba06a7c6 native_write_msr+0x6 (/lib/modules/5.2.0-rc1+/build/vmlinux) ABI:2 AX:0xffffffffffffffda BP:0x7ffc8679abb0 SP:0x7ffc8679ab78 IP:0x7fa75223a0db
     perf 1729 [000] 211.268024:  490 cycles: ffffffffba00e471 intel_bts_enable_local+0x21 (/lib/modules/5.2.0-rc1+/build/vmlinux) ABI:2 AX:0xffffffffffffffda BP:0x7ffc8679abb0 SP:0x7ffc8679ab78 IP:0x7fa75223a0db
  #

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/e7fd37b1-af22-0d94-a0dc-5895e803bbfe@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c     | 9 ++++++++-
 tools/perf/util/perf_regs.h | 4 ++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a6f572a40deb..cc6e7a0dda92 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -702,7 +702,14 @@ static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
 		if (!function) {
 			perf_evsel__set_sample_bit(evsel, REGS_USER);
 			perf_evsel__set_sample_bit(evsel, STACK_USER);
-			attr->sample_regs_user |= PERF_REGS_MASK;
+			if (opts->sample_user_regs && DWARF_MINIMAL_REGS != PERF_REGS_MASK) {
+				attr->sample_regs_user |= DWARF_MINIMAL_REGS;
+				pr_warning("WARNING: The use of --call-graph=dwarf may require all the user registers, "
+					   "specifying a subset with --user-regs may render DWARF unwinding unreliable, "
+					   "so the minimal registers set (IP, SP) is explicitly forced.\n");
+			} else {
+				attr->sample_regs_user |= PERF_REGS_MASK;
+			}
 			attr->sample_stack_user = param->dump_size;
 			attr->exclude_callchain_user = 1;
 		} else {
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index cb9c246c8962..47fe34e5f7d5 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -29,12 +29,16 @@ uint64_t arch__user_reg_mask(void);
 #ifdef HAVE_PERF_REGS_SUPPORT
 #include <perf_regs.h>
 
+#define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
+
 int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
 
 #else
 #define PERF_REGS_MASK	0
 #define PERF_REGS_MAX	0
 
+#define DWARF_MINIMAL_REGS PERF_REGS_MASK
+
 static inline const char *perf_reg_name(int id __maybe_unused)
 {
 	return NULL;
