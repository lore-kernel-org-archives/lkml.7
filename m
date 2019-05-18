Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23E7C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEEB20882
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UhKmp6BM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730040AbfERJcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:32:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33133 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:32:08 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9W0Jl1742102
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:32:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9W0Jl1742102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558171921;
        bh=eTmpATsAv4NbvDbMC8kXrrdD6yHFNKQOoQTPJh7MR8A=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=UhKmp6BMJQGqmesunFHZUKuC7q5JUMyyY6K7CBCcOTQP7DLgew90WeYzRlqU3Nz8G
         5AyaUYdGdvbcPkt9rQwG2TTOHnf6OveQmSV5+gl+oIDYljLeTaKv5/M9TUdPkQusl/
         eHtn2jUtDlpMbZLUM2omrme0g0RXp94vVamNAhAE8YpwoZxN5iE+XhAVHyq7kuDA36
         NAfds8I2k34xpjYpsUOO3rRfZzGRDC9QE6ZFeGPbaBEeNj6wq/LHUdpiRgJ0xwE2w2
         qwR8+osgG/7sGzwLqJYsIEMgtqqXKLlTqHLJxvzV+gcwBqLLMc/oQWn79LUdCO/8m9
         M7q2liFc8xVIw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9VxU91742099;
        Sat, 18 May 2019 02:31:59 -0700
Date:   Sat, 18 May 2019 02:31:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-6466ec14aaf44ff14a05369dcf0929d0f01171c6@git.kernel.org>
Cc:     ak@linux.intel.com, jolsa@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        kan.liang@linux.intel.com, acme@redhat.com, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          ak@linux.intel.com, jolsa@kernel.org, acme@redhat.com,
          mingo@kernel.org, hpa@zytor.com, kan.liang@linux.intel.com
In-Reply-To: <1557865174-56264-3-git-send-email-kan.liang@linux.intel.com>
References: <1557865174-56264-3-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf regs x86: Add X86 specific
 arch__intr_reg_mask()
Git-Commit-ID: 6466ec14aaf44ff14a05369dcf0929d0f01171c6
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

Commit-ID:  6466ec14aaf44ff14a05369dcf0929d0f01171c6
Gitweb:     https://git.kernel.org/tip/6466ec14aaf44ff14a05369dcf0929d0f01171c6
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 14 May 2019 13:19:34 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 16 May 2019 14:17:23 -0300

perf regs x86: Add X86 specific arch__intr_reg_mask()

XMM registers can be collected on Icelake and later platforms.

Add specific arch__intr_reg_mask(), which creating an event to check if
the kernel and hardware can collect XMM registers.

Test on Skylake which doesn't support XMM registers collection. There is
nothing changed.

   #perf record -I?
   available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9
   R10 R11 R12 R13 R14 R15

   Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -I, --intr-regs[=<any register>]
                          sample selected machine registers on
   interrupt, use '-I?' to list register names

   #perf record -I
   [ perf record: Woken up 1 times to write data ]
   [ perf record: Captured and wrote 0.905 MB perf.data (2520 samples) ]

   #perf evlist -v
   cycles: size: 112, { sample_period, sample_freq }: 4000, sample_type:
   IP|TID|TIME|CPU|PERIOD|REGS_INTR, read_format: ID, disabled: 1,
   inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3,
   sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol:
   1, bpf_event: 1, sample_regs_intr: 0xff0fff

Test on Icelake which support XMM registers collection.

   #perf record -I?
   available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
   R11 R12 R13 R14 R15 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 XMM9
   XMM10 XMM11 XMM12 XMM13 XMM14 XMM15

   Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -I, --intr-regs[=<any register>]
                          sample selected machine registers on
   interrupt, use '-I?' to list register names

   #perf record -I
   [ perf record: Woken up 1 times to write data ]
   [ perf record: Captured and wrote 0.800 MB perf.data (318 samples) ]

   #perf evlist -v
   cycles: size: 112, { sample_period, sample_freq }: 4000, sample_type:
   IP|TID|TIME|CPU|PERIOD|REGS_INTR, read_format: ID, disabled: 1,
   inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3,
   sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol:
   1, bpf_event: 1, sample_regs_intr: 0xffffffff00ff0fff

Committer notes:

Don't set attr.sample_period as a named struct init, as it is part of an
unnamed union in 'struct perf_event_attr', and doing so breaks the build
on older gcc versions, such as:

  gcc version 4.1.2 20080704 (Red Hat 4.1.2-55)
  gcc version 4.4.7 20120313 (Red Hat 4.4.7-23) (GCC)

  arch/x86/util/perf_regs.c: In function 'arch__intr_reg_mask':
  arch/x86/util/perf_regs.c:279: error: unknown field 'sample_period' specified in initializer
  cc1: warnings being treated as errors
  arch/x86/util/perf_regs.c:279: warning: missing braces around initializer
  arch/x86/util/perf_regs.c:279: warning: (near initialization for 'attr.<anonymous>')

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
[ Only on a lenovo t480s, a skylake machine, where the XMM registers didn't show up in -I?/--user-regs=? as expected ]
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/1557865174-56264-3-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/include/perf_regs.h |  1 +
 tools/perf/arch/x86/util/perf_regs.c    | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/tools/perf/arch/x86/include/perf_regs.h b/tools/perf/arch/x86/include/perf_regs.h
index b7321337d100..b7cd91a9014f 100644
--- a/tools/perf/arch/x86/include/perf_regs.h
+++ b/tools/perf/arch/x86/include/perf_regs.h
@@ -9,6 +9,7 @@
 void perf_regs_load(u64 *regs);
 
 #define PERF_REGS_MAX PERF_REG_X86_XMM_MAX
+#define PERF_XMM_REGS_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
 #ifndef HAVE_ARCH_X86_64_SUPPORT
 #define PERF_REGS_MASK ((1ULL << PERF_REG_X86_32_MAX) - 1)
 #define PERF_SAMPLE_REGS_ABI PERF_SAMPLE_REGS_ABI_32
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 71d7604dbf0b..7886ca5263e3 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -270,3 +270,31 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
 
 	return SDT_ARG_VALID;
 }
+
+uint64_t arch__intr_reg_mask(void)
+{
+	struct perf_event_attr attr = {
+		.type			= PERF_TYPE_HARDWARE,
+		.config			= PERF_COUNT_HW_CPU_CYCLES,
+		.sample_type		= PERF_SAMPLE_REGS_INTR,
+		.sample_regs_intr	= PERF_XMM_REGS_MASK,
+		.precise_ip		= 1,
+		.disabled 		= 1,
+		.exclude_kernel		= 1,
+	};
+	int fd;
+	/*
+	 * In an unnamed union, init it here to build on older gcc versions
+	 */
+	attr.sample_period = 1;
+
+	event_attr_init(&attr);
+
+	fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
+	if (fd != -1) {
+		close(fd);
+		return (PERF_XMM_REGS_MASK | PERF_REGS_MASK);
+	}
+
+	return PERF_REGS_MASK;
+}
