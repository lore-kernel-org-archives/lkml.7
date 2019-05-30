Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD4BC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC16257D5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gq3XfaGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfE3ILh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:11:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47187 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfE3ILg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:11:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U8BCfR2904281
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:11:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U8BCfR2904281
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203873;
        bh=wW6xJlKFnFshNMk6RG561ELO6hiX87to0nlnZdTwvFY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gq3XfaGqT1W2zly83Tpb6cE93DAjeTRz4UskDBvMF4B+XRtbTIS1gy897Duwmeyzi
         Fh4368GtDjN+BAMN4GRoZkaE0xvR9xF/MJISDdqFQizz/+ZVjK8D4euQCPD32Aj7Ge
         qZVXVPukmxAn2MfOEtGFrHRqVK7E4C6Nt7pNMGvPuqaRR7Y23iExr5HHnJ1V5/z4Jx
         CFuB4XwnCPtxXQMsICUvaln70Qycvampw7sXegBBJf8uipyAtMi6d/yUns9qoWDQJb
         AzH5kGuQ9axtKS1bO85WklT3FE+xXmvjTHXbaIi0XyTYIABrP5fPJgj3f/bMb5uIDY
         vNDXO7ihIPL0g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U8BCtG2904278;
        Thu, 30 May 2019 01:11:12 -0700
Date:   Thu, 30 May 2019 01:11:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-1c4924220c96392d17e0222c113509fd7b9a0854@git.kernel.org>
Cc:     adrian.hunter@intel.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        namhyung@kernel.org, songliubraving@fb.com, acme@redhat.com,
        hpa@zytor.com, mingo@kernel.org, ak@linux.intel.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org, sdf@google.com
Reply-To: songliubraving@fb.com, acme@redhat.com, tglx@linutronix.de,
          namhyung@kernel.org, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
          sdf@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
          ak@linux.intel.com, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20190508132010.14512-8-jolsa@kernel.org>
References: <20190508132010.14512-8-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script: Pad DSO name for --call-trace
Git-Commit-ID: 1c4924220c96392d17e0222c113509fd7b9a0854
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

Commit-ID:  1c4924220c96392d17e0222c113509fd7b9a0854
Gitweb:     https://git.kernel.org/tip/1c4924220c96392d17e0222c113509fd7b9a0854
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 8 May 2019 15:20:05 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:44 -0300

perf script: Pad DSO name for --call-trace

Pad the DSO name in --call-trace so we don't have the indent screwed by
different DSO name lengths, as now for kernel there's also BPF code
displayed.

  # perf-with-kcore record pt -e intel_pt//ku -- sleep 1
  # perf-core/perf-with-kcore script pt --call-trace

Before:

   sleep 3660 [16] 57036.806464404: ([kernel.kallsyms])                      kretprobe_perf_func
   sleep 3660 [16] 57036.806464404: ([kernel.kallsyms])                          trace_call_bpf
   sleep 3660 [16] 57036.806464404: ([kernel.kallsyms])                              __x86_indirect_thunk_rax
   sleep 3660 [16] 57036.806464404: ([kernel.kallsyms])                                  __x86_indirect_thunk_rax
   sleep 3660 [16] 57036.806464725: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                         bpf_get_current_pid_tgid
   sleep 3660 [16] 57036.806464725: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                         bpf_ktime_get_ns
   sleep 3660 [16] 57036.806464725: ([kernel.kallsyms])                                          __x86_indirect_thunk_rax
   sleep 3660 [16] 57036.806464725: ([kernel.kallsyms])                                              __x86_indirect_thunk_rax
   sleep 3660 [16] 57036.806465045: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                         __htab_map_lookup_elem
   sleep 3660 [16] 57036.806465366: ([kernel.kallsyms])                                          memcmp
   sleep 3660 [16] 57036.806465687: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                         bpf_probe_read
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms])                                          probe_kernel_read
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms])                                              __check_object_size
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms])                                                  check_stack_object
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms])                                              copy_user_enhanced_fast_string
   sleep 3660 [16] 57036.806465687: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                         bpf_probe_read
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms])                                          probe_kernel_read
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms])                                              __check_object_size
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms])                                                  check_stack_object
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms])                                              copy_user_enhanced_fast_string
   sleep 3660 [16] 57036.806466008: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                         bpf_get_current_uid_gid
   sleep 3660 [16] 57036.806466008: ([kernel.kallsyms])                                          from_kgid
   sleep 3660 [16] 57036.806466008: ([kernel.kallsyms])                                          from_kuid
   sleep 3660 [16] 57036.806466008: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                         bpf_perf_event_output
   sleep 3660 [16] 57036.806466328: ([kernel.kallsyms])                                          perf_event_output
   sleep 3660 [16] 57036.806466328: ([kernel.kallsyms])                                              perf_prepare_sample
   sleep 3660 [16] 57036.806466328: ([kernel.kallsyms])                                                  perf_misc_flags
   sleep 3660 [16] 57036.806466328: ([kernel.kallsyms])                                                      __x86_indirect_thunk_rax
   sleep 3660 [16] 57036.806466328: ([kernel.kallsyms])                                                          __x86_indirect_thunk_rax
   sleep 3660 [16] 57036.806466328: ([kvm])                                                      kvm_is_in_guest
   sleep 3660 [16] 57036.806466649: ([kernel.kallsyms])                                                  __perf_event_header__init_id.isra.0
   sleep 3660 [16] 57036.806466649: ([kernel.kallsyms])                                              perf_output_begin

After:

   sleep 3660 [16] 57036.806464404: ([kernel.kallsyms]                      )     kretprobe_perf_func
   sleep 3660 [16] 57036.806464404: ([kernel.kallsyms]                      )         trace_call_bpf
   sleep 3660 [16] 57036.806464404: ([kernel.kallsyms]                      )             __x86_indirect_thunk_rax
   sleep 3660 [16] 57036.806464404: ([kernel.kallsyms]                      )                 __x86_indirect_thunk_rax
   sleep 3660 [16] 57036.806464725: (bpf_prog_da4fe6b3d2c29b25_trace_return )                     bpf_get_current_pid_tgid
   sleep 3660 [16] 57036.806464725: (bpf_prog_da4fe6b3d2c29b25_trace_return )                     bpf_ktime_get_ns
   sleep 3660 [16] 57036.806464725: ([kernel.kallsyms]                      )                         __x86_indirect_thunk_rax
   sleep 3660 [16] 57036.806464725: ([kernel.kallsyms]                      )                             __x86_indirect_thunk_rax
   sleep 3660 [16] 57036.806465045: (bpf_prog_da4fe6b3d2c29b25_trace_return )                     __htab_map_lookup_elem
   sleep 3660 [16] 57036.806465366: ([kernel.kallsyms]                      )                         memcmp
   sleep 3660 [16] 57036.806465687: (bpf_prog_da4fe6b3d2c29b25_trace_return )                     bpf_probe_read
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms]                      )                         probe_kernel_read
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms]                      )                             __check_object_size
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms]                      )                                 check_stack_object
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms]                      )                             copy_user_enhanced_fast_string
   sleep 3660 [16] 57036.806465687: (bpf_prog_da4fe6b3d2c29b25_trace_return )                     bpf_probe_read
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms]                      )                         probe_kernel_read
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms]                      )                             __check_object_size
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms]                      )                                 check_stack_object
   sleep 3660 [16] 57036.806465687: ([kernel.kallsyms]                      )                             copy_user_enhanced_fast_string
   sleep 3660 [16] 57036.806466008: (bpf_prog_da4fe6b3d2c29b25_trace_return )                     bpf_get_current_uid_gid
   sleep 3660 [16] 57036.806466008: ([kernel.kallsyms]                      )                         from_kgid
   sleep 3660 [16] 57036.806466008: ([kernel.kallsyms]                      )                         from_kuid
   sleep 3660 [16] 57036.806466008: (bpf_prog_da4fe6b3d2c29b25_trace_return )                     bpf_perf_event_output
   sleep 3660 [16] 57036.806466328: ([kernel.kallsyms]                      )                         perf_event_output
   sleep 3660 [16] 57036.806466328: ([kernel.kallsyms]                      )                             perf_prepare_sample
   sleep 3660 [16] 57036.806466328: ([kernel.kallsyms]                      )                                 perf_misc_flags
   sleep 3660 [16] 57036.806466328: ([kernel.kallsyms]                      )                                     __x86_indirect_thunk_rax
   sleep 3660 [16] 57036.806466328: ([kernel.kallsyms]                      )                                         __x86_indirect_thunk_rax

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190508132010.14512-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/kernel.h  |  1 +
 tools/lib/vsprintf.c          | 19 +++++++++++++++++++
 tools/perf/builtin-script.c   |  1 +
 tools/perf/util/map.c         |  6 ++++++
 tools/perf/util/symbol_conf.h |  1 +
 5 files changed, 28 insertions(+)

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 857d9e22826e..cba226948a0c 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -102,6 +102,7 @@
 
 int vscnprintf(char *buf, size_t size, const char *fmt, va_list args);
 int scnprintf(char * buf, size_t size, const char * fmt, ...);
+int scnprintf_pad(char * buf, size_t size, const char * fmt, ...);
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
 
diff --git a/tools/lib/vsprintf.c b/tools/lib/vsprintf.c
index e08ee147eab4..8780b4cdab21 100644
--- a/tools/lib/vsprintf.c
+++ b/tools/lib/vsprintf.c
@@ -23,3 +23,22 @@ int scnprintf(char * buf, size_t size, const char * fmt, ...)
 
        return (i >= ssize) ? (ssize - 1) : i;
 }
+
+int scnprintf_pad(char * buf, size_t size, const char * fmt, ...)
+{
+	ssize_t ssize = size;
+	va_list args;
+	int i;
+
+	va_start(args, fmt);
+	i = vscnprintf(buf, size, fmt, args);
+	va_end(args);
+
+	if (i < (int) size) {
+		for (; i < (int) size; i++)
+			buf[i] = ' ';
+		buf[i] = 0x0;
+	}
+
+	return (i >= ssize) ? (ssize - 1) : i;
+}
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 61cfd8f70989..7adaa6c63a0b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3297,6 +3297,7 @@ static int parse_call_trace(const struct option *opt __maybe_unused,
 	parse_output_fields(NULL, "-ip,-addr,-event,-period,+callindent", 0);
 	itrace_parse_synth_opts(opt, "cewp", 0);
 	symbol_conf.nanosecs = true;
+	symbol_conf.pad_output_len_dso = 50;
 	return 0;
 }
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index ee71efb9db62..6fce983c6115 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -405,6 +405,7 @@ size_t map__fprintf(struct map *map, FILE *fp)
 
 size_t map__fprintf_dsoname(struct map *map, FILE *fp)
 {
+	char buf[symbol_conf.pad_output_len_dso + 1];
 	const char *dsoname = "[unknown]";
 
 	if (map && map->dso) {
@@ -414,6 +415,11 @@ size_t map__fprintf_dsoname(struct map *map, FILE *fp)
 			dsoname = map->dso->name;
 	}
 
+	if (symbol_conf.pad_output_len_dso) {
+		scnprintf_pad(buf, symbol_conf.pad_output_len_dso, "%s", dsoname);
+		dsoname = buf;
+	}
+
 	return fprintf(fp, "%s", dsoname);
 }
 
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 6c55fa6fccec..382ba63fc554 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -69,6 +69,7 @@ struct symbol_conf {
 			*tid_list;
 	const char	*symfs;
 	int		res_sample;
+	int		pad_output_len_dso;
 };
 
 extern struct symbol_conf symbol_conf;
