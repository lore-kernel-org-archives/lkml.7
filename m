Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FFDC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4122173E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557321642;
	bh=kdklMWKdHiqxOGl3tXID7BJUYSk4oSyPClGPY7LSZkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NT7rX5tF378LgdBfRhlajEo6FL378Z6rtssw6E/sRICHwS+fMWSR7H5cpZRTugYlp
	 8kCCeySZRLdA5Bp2ZXwK4Mi3fSUfkM5p7wy0ECxLssON5a+XwW687siYo/6Suk8+C6
	 5KnMSca1XmkyQpL1qpik9R8DjAbXDGYj003sVgN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfEHNUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:20:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbfEHNUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:20:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3571D307D9CF;
        Wed,  8 May 2019 13:20:38 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-49.brq.redhat.com [10.40.204.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87ADD1018A2A;
        Wed,  8 May 2019 13:20:35 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 07/12] perf script: Pad dso name for --call-trace
Date:   Wed,  8 May 2019 15:20:05 +0200
Message-Id: <20190508132010.14512-8-jolsa@kernel.org>
In-Reply-To: <20190508132010.14512-1-jolsa@kernel.org>
References: <20190508132010.14512-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 08 May 2019 13:20:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Padding dso name for --call-trace so we don't have the
indent screwed by different dso name lengths, as now
for kernel there's also bpf code displayed.

  # perf-with-kcore record pt -e intel_pt//ku -- sleep 1
  # perf-core/perf-with-kcore script pt --call-trace

Before:
           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms])                                  kretprobe_perf_func
           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms])                                      trace_call_bpf
           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms])                                          __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms])                                              __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806464725: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                                     bpf_get_current_pid_tgid
           sleep 36660 [016] 1057036.806464725: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                                     bpf_ktime_get_ns
           sleep 36660 [016] 1057036.806464725: ([kernel.kallsyms])                                                      __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806464725: ([kernel.kallsyms])                                                          __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806465045: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                                     __htab_map_lookup_elem
           sleep 36660 [016] 1057036.806465366: ([kernel.kallsyms])                                                      memcmp
           sleep 36660 [016] 1057036.806465687: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                                     bpf_probe_read
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])                                                      probe_kernel_read
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])                                                          __check_object_size
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])                                                              check_stack_object
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])                                                          copy_user_enhanced_fast_string
           sleep 36660 [016] 1057036.806465687: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                                     bpf_probe_read
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])                                                      probe_kernel_read
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])                                                          __check_object_size
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])                                                              check_stack_object
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms])                                                          copy_user_enhanced_fast_string
           sleep 36660 [016] 1057036.806466008: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                                     bpf_get_current_uid_gid
           sleep 36660 [016] 1057036.806466008: ([kernel.kallsyms])                                                      from_kgid
           sleep 36660 [016] 1057036.806466008: ([kernel.kallsyms])                                                      from_kuid
           sleep 36660 [016] 1057036.806466008: (bpf_prog_da4fe6b3d2c29b25_trace_return)                                                     bpf_perf_event_output
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms])                                                      perf_event_output
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms])                                                          perf_prepare_sample
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms])                                                              perf_misc_flags
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms])                                                                  __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms])                                                                      __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806466328: ([kvm])                                                                  kvm_is_in_guest
           sleep 36660 [016] 1057036.806466649: ([kernel.kallsyms])                                                              __perf_event_header__init_id.isra.0
           sleep 36660 [016] 1057036.806466649: ([kernel.kallsyms])                                                          perf_output_begin

After:
           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]                       )                kretprobe_perf_func
           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]                       )                    trace_call_bpf
           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]                       )                        __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806464404: ([kernel.kallsyms]                       )                            __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806464725: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_get_current_pid_tgid
           sleep 36660 [016] 1057036.806464725: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_ktime_get_ns
           sleep 36660 [016] 1057036.806464725: ([kernel.kallsyms]                       )                                    __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806464725: ([kernel.kallsyms]                       )                                        __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806465045: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                __htab_map_lookup_elem
           sleep 36660 [016] 1057036.806465366: ([kernel.kallsyms]                       )                                    memcmp
           sleep 36660 [016] 1057036.806465687: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_probe_read
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                    probe_kernel_read
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                        __check_object_size
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                            check_stack_object
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                        copy_user_enhanced_fast_string
           sleep 36660 [016] 1057036.806465687: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_probe_read
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                    probe_kernel_read
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                        __check_object_size
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                            check_stack_object
           sleep 36660 [016] 1057036.806465687: ([kernel.kallsyms]                       )                                        copy_user_enhanced_fast_string
           sleep 36660 [016] 1057036.806466008: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_get_current_uid_gid
           sleep 36660 [016] 1057036.806466008: ([kernel.kallsyms]                       )                                    from_kgid
           sleep 36660 [016] 1057036.806466008: ([kernel.kallsyms]                       )                                    from_kuid
           sleep 36660 [016] 1057036.806466008: (bpf_prog_da4fe6b3d2c29b25_trace_return  )                                bpf_perf_event_output
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]                       )                                    perf_event_output
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]                       )                                        perf_prepare_sample
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]                       )                                            perf_misc_flags
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]                       )                                                __x86_indirect_thunk_rax
           sleep 36660 [016] 1057036.806466328: ([kernel.kallsyms]                       )                                                    __x86_indirect_thunk_rax

Link: http://lkml.kernel.org/n/tip-99g9rg4p20a1o99vr0nkjhq8@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
-- 
2.20.1

