Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA725C48BE0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 00:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C98B2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 00:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hl7fifOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbfFTAyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 20:54:51 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40698 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfFTAyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 20:54:50 -0400
Received: by mail-ot1-f65.google.com with SMTP id e8so991142otl.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 17:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rfkobxRjanEVPCRzEAlI3lKJ7cTgn4WDB+7+usu4syE=;
        b=Hl7fifOLF3zsppBuVoauVT7fR3CaL7bwjYcs0H2HVa5M1lg9/IKBOlDS2oYcFteuTg
         3QzPsxx1maxQIquc0c/XDCBpyZRaWHLGgrcWnEzdD/o+gwlf2Xc0dVxjNEACsUsZfVo/
         dWOeLgBflO34tNXvMCl7cGzKPEb4VH66EXodGi94r6J8GDyhtsqRcqRqK+cZfLcpFt+4
         jlr7W2H8AEB5+JdZe2z8dZ6G4KOkYB7WAapV6vrFyPvtH26H/MDvuSXGzmpu8ptzCPPu
         G8k/enGH978yQ5rDIgMzgTvoYoAi5xPdXM1DOTzdpZu2W2z0YWZsEwllfV30TQOwpRLu
         xaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rfkobxRjanEVPCRzEAlI3lKJ7cTgn4WDB+7+usu4syE=;
        b=WzIpFCjRaY3nb0hasK1UaUvmBY5EUNI5wkSK962xOLmsRX8aqBzJ4VQGya2SEWquPc
         M1lkbbfhwFuU0e+jrhu2YyMObpbR28dbvN3A3cRrgEXUO+bHD/UuBjr/T1jUf1jeE4VP
         Z9spnRRY7dkxuwy4mR9b97ZxODO+qhJKvjwmyoZXJwrtd2Zkvd++gnhNOZ0jto2NfwxO
         ck1wpwszQgXdHRF3ubFRi0N19oviw7Njc17U4qddMz7pPvb8Eiqp75PnltnWM7Q1dL/k
         tSj4rx/3BBoKC+m9u9NCljYQxnqldDYg+7xJag3d1GWP6yr1PY+VB89QvXaf9lTFsS6Q
         dFzA==
X-Gm-Message-State: APjAAAVjIAPWq4hwyWirxJ6G8OaXAAMllx8Fvzsq2n4+S+qLmp6OIaNk
        aiccXrQgFXF5VAUGW+Tc1GrCfw==
X-Google-Smtp-Source: APXvYqxXPjVnT9XqaWX2E7u7FhdKuVhuOsWrDioXcGKD7g2ZY54jNpEtB7fZrDBdyo2i9tvOaEANFg==
X-Received: by 2002:a9d:1d22:: with SMTP id m31mr36691749otm.92.1560992089586;
        Wed, 19 Jun 2019 17:54:49 -0700 (PDT)
Received: from localhost.localdomain (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id c19sm7327761otl.70.2019.06.19.17.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 17:54:48 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        coresight@lists.linaro.org
Subject: [PATCH v2] perf cs-etm: Improve completeness for kernel address space
Date:   Thu, 20 Jun 2019 08:54:28 +0800
Message-Id: <20190620005428.20883-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm and arm64 architecture reserve some memory regions prior to the
symbol '_stext' and these memory regions later will be used by device
module and BPF jit.  The current code misses to consider these memory
regions thus any address in the regions will be taken as user space
mode, but perf cannot find the corresponding dso with the wrong CPU
mode so we misses to generate samples for device module and BPF
related trace data.

This patch parse the link scripts to get the memory size prior to start
address and reduce this size from 'etmq->etm->kernel_start', then can
get a fixed up kernel start address which contain memory regions for
device module and BPF.  Finally, cs_etm__cpu_mode() can return right
mode for these memory regions and perf can successfully generate
samples.

The reason for parsing the link scripts is Arm architecture changes text
offset dependent on different platforms, which define multiple text
offsets in $kernel/arch/arm/Makefile.  This offset is decided when build
kernel and the final value is extended in the link script, so we can
extract the used value from the link script.  We use the same way to
parse arm64 link script as well.  If fail to find the link script, the
pre start memory size is assumed as zero, in this case it has no any
change caused with this patch.

Below is detailed info for testing this patch:

- Build LLVM/Clang 8.0 or later version;

- Configure perf with ~/.perfconfig:

  root@debian:~# cat ~/.perfconfig
  # this file is auto-generated.
  [llvm]
          clang-path = /mnt/build/llvm-build/build/install/bin/clang
          kbuild-dir = /mnt/linux-kernel/linux-cs-dev/
          clang-opt = "-g"
          dump-obj = true

  [trace]
          show_zeros = yes
          show_duration = no
          no_inherit = yes
          show_timestamp = no
          show_arg_names = no
          args_alignment = 40
          show_prefix = yes

- Run 'perf trace' command with eBPF event:

  root@debian:~# perf trace -e string \
      -e $kernel/tools/perf/examples/bpf/augmented_raw_syscalls.c

- Read eBPF program memory mapping in kernel:

  root@debian:~# echo 1 > /proc/sys/net/core/bpf_jit_kallsyms
  root@debian:~# cat /proc/kallsyms | grep -E "bpf_prog_.+_sys_[enter|exit]"
  ffff000000086a84 t bpf_prog_f173133dc38ccf87_sys_enter  [bpf]
  ffff000000088618 t bpf_prog_c1bd85c092d6e4aa_sys_exit   [bpf]

- Launch any program which accesses file system frequently so can hit
  the system calls trace flow with eBPF event;

- Capture CoreSight trace data with filtering eBPF program:

  root@debian:~# perf record -e cs_etm/@20070000.etr/ \
	  --filter 'filter 0xffff000000086a84/0x800' -a sleep 5s

- Annotate for symbol 'bpf_prog_f173133dc38ccf87_sys_enter':

  root@debian:~# perf report
  Then select 'branches' samples and press 'a' to annotate symbol
  'bpf_prog_f173133dc38ccf87_sys_enter', press 'P' to print to the
  bpf_prog_f173133dc38ccf87_sys_enter.annotation file:

  root@debian:~# cat bpf_prog_f173133dc38ccf87_sys_enter.annotation

  bpf_prog_f173133dc38ccf87_sys_enter() bpf_prog_f173133dc38ccf87_sys_enter
  Event: branches

  Percent      int sys_enter(struct syscall_enter_args *args)
                 stp  x29, x30, [sp, #-16]!

               	int key = 0;
                 mov  x29, sp

                       augmented_args = bpf_map_lookup_elem(&augmented_filename_map, &key);
                 stp  x19, x20, [sp, #-16]!

                       augmented_args = bpf_map_lookup_elem(&augmented_filename_map, &key);
                 stp  x21, x22, [sp, #-16]!

                 stp  x25, x26, [sp, #-16]!

               	return bpf_get_current_pid_tgid();
                 mov  x25, sp

               	return bpf_get_current_pid_tgid();
                 mov  x26, #0x0                   	// #0

                 sub  sp, sp, #0x10

               	return bpf_map_lookup_elem(pids, &pid) != NULL;
                 add  x19, x0, #0x0

                 mov  x0, #0x0                   	// #0

                 mov  x10, #0xfffffffffffffff8    	// #-8

               	if (pid_filter__has(&pids_filtered, getpid()))
                 str  w0, [x25, x10]

               	probe_read(&augmented_args->args, sizeof(augmented_args->args), args);
                 add  x1, x25, #0x0

               	probe_read(&augmented_args->args, sizeof(augmented_args->args), args);
                 mov  x10, #0xfffffffffffffff8    	// #-8

               	syscall = bpf_map_lookup_elem(&syscalls, &augmented_args->args.syscall_nr);
                 add  x1, x1, x10

               	syscall = bpf_map_lookup_elem(&syscalls, &augmented_args->args.syscall_nr);
                 mov  x0, #0xffff8009ffffffff    	// #-140694538682369

                 movk x0, #0x6698, lsl #16

                 movk x0, #0x3e00

                 mov  x10, #0xffffffffffff1040    	// #-61376

               	if (syscall == NULL || !syscall->enabled)
                 movk x10, #0x1023, lsl #16

               	if (syscall == NULL || !syscall->enabled)
                 movk x10, #0x0, lsl #32

               	loop_iter_first()
    3.69       → blr  bpf_prog_f173133dc38ccf87_sys_enter
               	loop_iter_first()
                 add  x7, x0, #0x0

               	loop_iter_first()
                 add  x20, x7, #0x0

               	int size = probe_read_str(&augmented_filename->value, filename_len, filename_arg);
                 mov  x0, #0x1                   	// #1

  [...]

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/Makefile.config | 20 ++++++++++++++++++++
 tools/perf/util/cs-etm.c   | 19 ++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 51dd00f65709..cf5906d667aa 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -418,6 +418,26 @@ ifdef CORESIGHT
     endif
     LDFLAGS += $(LIBOPENCSD_LDFLAGS)
     EXTLIBS += $(OPENCSDLIBS)
+    ARM_PRE_START_SIZE := 0
+    ifeq ($(SRCARCH),arm64)
+      # Extract info from lds:
+      #  . = ((((((((0xffffffffffffffff)) - (((1)) << (48)) + 1) + (0)) + (0x08000000))) + (0x08000000))) + 0x00080000;
+      # ARM_PRE_START_SIZE := (0x08000000 + 0x08000000 + 0x00080000)
+      ARM_PRE_START_SIZE := $(shell egrep ' \. \= \({8}0x[0-9a-fA-F]+\){2}' \
+        $(srctree)/arch/arm64/kernel/vmlinux.lds | \
+        sed -e 's/[(|)|.|=|+|<|;|-]//g' -e 's/ \+/ /g' -e 's/^[ \t]*//' | \
+        awk -F' ' '{print "("$$6 "+"  $$7 "+" $$8")"}' 2>/dev/null)
+    endif
+    ifeq ($(SRCARCH),arm)
+      # Extract info from lds:
+      #   . = ((0xC0000000)) + 0x00208000;
+      # ARM_PRE_START_SIZE := 0x00208000
+      ARM_PRE_START_SIZE := $(shell egrep ' \. \= \({2}0x[0-9a-fA-F]+\){2}' \
+        $(srctree)/arch/arm/kernel/vmlinux.lds | \
+        sed -e 's/[(|)|.|=|+|<|;|-]//g' -e 's/ \+/ /g' -e 's/^[ \t]*//' | \
+        awk -F' ' '{print "("$$2")"}' 2>/dev/null)
+    endif
+    CFLAGS += -DARM_PRE_START_SIZE="$(ARM_PRE_START_SIZE)"
     $(call detected,CONFIG_LIBOPENCSD)
     ifdef CSTRACE_RAW
       CFLAGS += -DCS_DEBUG_RAW
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 0c7776b51045..5fa0be3a3904 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -613,10 +613,27 @@ static void cs_etm__free(struct perf_session *session)
 static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address)
 {
 	struct machine *machine;
+	u64 fixup_kernel_start = 0;
 
 	machine = etmq->etm->machine;
 
-	if (address >= etmq->etm->kernel_start) {
+	/*
+	 * Since arm and arm64 specify some memory regions prior to
+	 * 'kernel_start', kernel addresses can be less than 'kernel_start'.
+	 *
+	 * For arm architecture, the 16MB virtual memory space prior to
+	 * 'kernel_start' is allocated to device modules, a PMD table if
+	 * CONFIG_HIGHMEM is enabled and a PGD table.
+	 *
+	 * For arm64 architecture, the root PGD table, device module memory
+	 * region and BPF jit region are prior to 'kernel_start'.
+	 *
+	 * To reflect the complete kernel address space, compensate these
+	 * pre-defined regions for kernel start address.
+	 */
+	fixup_kernel_start = etmq->etm->kernel_start - ARM_PRE_START_SIZE;
+
+	if (address >= fixup_kernel_start) {
 		if (machine__is_host(machine))
 			return PERF_RECORD_MISC_KERNEL;
 		else
-- 
2.17.1

