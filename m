Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4068C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771922339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566977519;
	bh=5L/hvs7f5rys+r3/73YOTUWIXDGG2jdhlWBMxT2E1LA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UpM6AzYwAGnilRYv1Qf67fv6pZUN2qEFYBYgxFtW9M8iBPQQ58GH9EUNUHjBlD905
	 kKCIOnyOWuHkJnI1CowgVMUlPzd5UYqsLdNMSMYqVxieOodYxaPXnTMw4o41CJPPBf
	 ax2JfS8ytDHd9/eH2nGBJHPxdsa6pyCUYBadVHK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfH1Hb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:31:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41252 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfH1Hb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:31:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id 196so1130643pfz.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GBUwQWJq8FnWbCDNT4XRoMCBxneLd3S2zHD0wke0DzU=;
        b=k5GmE31GUbd0t7oj3T1BjpEcLfRTC+BqSq5lG+UgO0gT+W31rajNDNkoiC/r7zCpvu
         QnBe2B62y7FUFWu7JL0SXWMjdJDtHliDH2IbvMYbMoEl/RHXSbCd9g35sgsNIMzP/bCH
         /IJ/TdcS2Cva0c652RoTBeyTrveICUlD1DBl4GWZ2Bf41aJZm8+1CWpLVzaCR1Q/GfH8
         RXhPYCdRCpxPJmXq91m9YzvoB/mBfBXqlugsam59V0NghBryiXAvwrJaVYKq4rsE3N62
         rts5tNZjH6kWEwFiOjyoGpVmHwNErmp/rtNkqWn3fH/3tAt3mJfC3jZKga4l75fWXuxS
         AZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GBUwQWJq8FnWbCDNT4XRoMCBxneLd3S2zHD0wke0DzU=;
        b=bwr5fZZOTM58PNSeV9TgoIRQnSetp35nKAb6QMlDnz60yGYOVqN/XmzfFlVD7TfwJ1
         9BZuy2p9effHkcWZxB/sElakFxY8Le+5K0R9Q0pF7DYFTz0/Zkes3BS9Nyxwi9Y/fQRp
         9CxxLJiTPy+eHhwBbuiGDZR8GdpPH1lVW3CLggi7kSUQRpqayqrb9FPGJIOTHiu6ngeC
         SlkzbIcUag+kpntZnNa9nh4uaEKtgmnB+Ud2hmBkq3+45BBQqa4Q6TdvlNRJmEAtqMuX
         +SEhE5N1HcstNUVBUQYS4AO7t6MZrHY8R7Wa8tXgAedwiIDVDGcdbvDifAiCXM0l1Zy/
         mkYA==
X-Gm-Message-State: APjAAAVj/5gEPbAJEt0OgxndxdM61Gf/6QB2KNKdmdnIZbGyfpTYqI2O
        33kFHUzlydC06BFag4iNxj9E3EOM
X-Google-Smtp-Source: APXvYqyDnDLv85A8wZmTosqn4SAgjCFb2uYFAdSgFsvkGtTZ8PPOiOiyg5ZFd3QGc0MPJWcy080R4w==
X-Received: by 2002:a62:1444:: with SMTP id 65mr2994096pfu.145.1566977514651;
        Wed, 28 Aug 2019 00:31:54 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:0:1034:ec6b:8056:9e93])
        by smtp.gmail.com with ESMTPSA id v145sm1677054pfc.31.2019.08.28.00.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:31:54 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/9] perf tools: Basic support for CGROUP event
Date:   Wed, 28 Aug 2019 16:31:24 +0900
Message-Id: <20190828073130.83800-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190828073130.83800-1-namhyung@kernel.org>
References: <20190828073130.83800-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement basic functionality to support cgroup tracking.  Each cgroup
can be identified by inode number which can be read from userspace
too.  The actual cgroup processing will come in the later patch.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/linux/perf_event.h | 17 +++++++++++++++--
 tools/perf/builtin-diff.c             |  1 +
 tools/perf/builtin-report.c           |  1 +
 tools/perf/lib/include/perf/event.h   |  7 +++++++
 tools/perf/util/event.c               | 18 ++++++++++++++++++
 tools/perf/util/event.h               |  7 +++++++
 tools/perf/util/evsel.c               |  7 +++++++
 tools/perf/util/machine.c             | 12 ++++++++++++
 tools/perf/util/machine.h             |  3 +++
 tools/perf/util/session.c             |  4 ++++
 tools/perf/util/tool.h                |  1 +
 11 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index bb7b271397a6..91a552bf9611 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -141,8 +141,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_TRANSACTION			= 1U << 17,
 	PERF_SAMPLE_REGS_INTR			= 1U << 18,
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
+	PERF_SAMPLE_CGROUP			= 1U << 20,
 
-	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -375,7 +376,8 @@ struct perf_event_attr {
 				ksymbol        :  1, /* include ksymbol events */
 				bpf_event      :  1, /* include bpf events */
 				aux_output     :  1, /* generate AUX records instead of events */
-				__reserved_1   : 32;
+				cgroup         :  1, /* include cgroup events */
+				__reserved_1   : 31;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1000,6 +1002,17 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_BPF_EVENT			= 18,
 
+	/*
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				ino;
+	 *	u64				path_len;
+	 *	char				path[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_CGROUP			= 19,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 51c37e53b3d8..ec639340bb65 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -445,6 +445,7 @@ static struct perf_diff pdiff = {
 		.fork	= perf_event__process_fork,
 		.lost	= perf_event__process_lost,
 		.namespaces = perf_event__process_namespaces,
+		.cgroup = perf_event__process_cgroup,
 		.ordered_events = true,
 		.ordering_requires_timestamps = true,
 	},
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 318b0b95c14c..c65a59fd2a94 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1033,6 +1033,7 @@ int cmd_report(int argc, const char **argv)
 			.mmap2		 = perf_event__process_mmap2,
 			.comm		 = perf_event__process_comm,
 			.namespaces	 = perf_event__process_namespaces,
+			.cgroup		 = perf_event__process_cgroup,
 			.exit		 = perf_event__process_exit,
 			.fork		 = perf_event__process_fork,
 			.lost		 = perf_event__process_lost,
diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 36ad3a4a79e6..ec112ad640a1 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -104,6 +104,13 @@ struct perf_record_bpf_event {
 	__u8			 tag[BPF_TAG_SIZE];  // prog tag
 };
 
+struct perf_record_cgroup {
+	struct perf_event_header header;
+	__u64			 ino;
+	__u64			 path_len;
+	char			 path[PATH_MAX];
+};
+
 struct perf_record_sample {
 	struct perf_event_header header;
 	__u64			 array[];
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 33616ea62a47..c19b00c1fc26 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -52,6 +52,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_NAMESPACES]		= "NAMESPACES",
 	[PERF_RECORD_KSYMBOL]			= "KSYMBOL",
 	[PERF_RECORD_BPF_EVENT]			= "BPF_EVENT",
+	[PERF_RECORD_CGROUP]			= "CGROUP",
 	[PERF_RECORD_HEADER_ATTR]		= "ATTR",
 	[PERF_RECORD_HEADER_EVENT_TYPE]		= "EVENT_TYPE",
 	[PERF_RECORD_HEADER_TRACING_DATA]	= "TRACING_DATA",
@@ -1279,6 +1280,12 @@ size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp)
 	return ret;
 }
 
+size_t perf_event__fprintf_cgroup(union perf_event *event, FILE *fp)
+{
+	return fprintf(fp, " cgroup: %" PRI_lu64 " %s\n",
+		       event->cgroup.ino, event->cgroup.path);
+}
+
 int perf_event__process_comm(struct perf_tool *tool __maybe_unused,
 			     union perf_event *event,
 			     struct perf_sample *sample,
@@ -1295,6 +1302,14 @@ int perf_event__process_namespaces(struct perf_tool *tool __maybe_unused,
 	return machine__process_namespaces_event(machine, event, sample);
 }
 
+int perf_event__process_cgroup(struct perf_tool *tool __maybe_unused,
+			       union perf_event *event,
+			       struct perf_sample *sample,
+			       struct machine *machine)
+{
+	return machine__process_cgroup_event(machine, event, sample);
+}
+
 int perf_event__process_lost(struct perf_tool *tool __maybe_unused,
 			     union perf_event *event,
 			     struct perf_sample *sample,
@@ -1516,6 +1531,9 @@ size_t perf_event__fprintf(union perf_event *event, FILE *fp)
 	case PERF_RECORD_NAMESPACES:
 		ret += perf_event__fprintf_namespaces(event, fp);
 		break;
+	case PERF_RECORD_CGROUP:
+		ret += perf_event__fprintf_cgroup(event, fp);
+		break;
 	case PERF_RECORD_MMAP2:
 		ret += perf_event__fprintf_mmap2(event, fp);
 		break;
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 429a3fe52d6c..0170435fd1e8 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -123,6 +123,7 @@ struct perf_sample {
 	u32 raw_size;
 	u64 data_src;
 	u64 phys_addr;
+	u64 cgroup;
 	u32 flags;
 	u16 insn_len;
 	u8  cpumode;
@@ -554,6 +555,7 @@ union perf_event {
 	struct perf_record_mmap2	mmap2;
 	struct perf_record_comm		comm;
 	struct perf_record_namespaces	namespaces;
+	struct perf_record_cgroup	cgroup;
 	struct perf_record_fork		fork;
 	struct perf_record_lost		lost;
 	struct perf_record_lost_samples	lost_samples;
@@ -663,6 +665,10 @@ int perf_event__process_namespaces(struct perf_tool *tool,
 				   union perf_event *event,
 				   struct perf_sample *sample,
 				   struct machine *machine);
+int perf_event__process_cgroup(struct perf_tool *tool,
+			       union perf_event *event,
+			       struct perf_sample *sample,
+			       struct machine *machine);
 int perf_event__process_mmap(struct perf_tool *tool,
 			     union perf_event *event,
 			     struct perf_sample *sample,
@@ -750,6 +756,7 @@ size_t perf_event__fprintf_switch(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_thread_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_cpu_map(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_namespaces(union perf_event *event, FILE *fp);
+size_t perf_event__fprintf_cgroup(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf_bpf(union perf_event *event, FILE *fp);
 size_t perf_event__fprintf(union perf_event *event, FILE *fp);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index fa676355559e..86a38679cad1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1593,6 +1593,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	PRINT_ATTRf(ksymbol, p_unsigned);
 	PRINT_ATTRf(bpf_event, p_unsigned);
 	PRINT_ATTRf(aux_output, p_unsigned);
+	PRINT_ATTRf(cgroup, p_unsigned);
 
 	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
 	PRINT_ATTRf(bp_type, p_unsigned);
@@ -2369,6 +2370,12 @@ int perf_evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 		array++;
 	}
 
+	data->cgroup = 0;
+	if (type & PERF_SAMPLE_CGROUP) {
+		data->cgroup = *array;
+		array++;
+	}
+
 	return 0;
 }
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 93483f1764d3..61c35eef616b 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -642,6 +642,16 @@ int machine__process_namespaces_event(struct machine *machine __maybe_unused,
 	return err;
 }
 
+int machine__process_cgroup_event(struct machine *machine __maybe_unused,
+				  union perf_event *event,
+				  struct perf_sample *sample __maybe_unused)
+{
+	if (dump_trace)
+		perf_event__fprintf_cgroup(event, stdout);
+
+	return 0;
+}
+
 int machine__process_lost_event(struct machine *machine __maybe_unused,
 				union perf_event *event, struct perf_sample *sample __maybe_unused)
 {
@@ -1902,6 +1912,8 @@ int machine__process_event(struct machine *machine, union perf_event *event,
 		ret = machine__process_mmap_event(machine, event, sample); break;
 	case PERF_RECORD_NAMESPACES:
 		ret = machine__process_namespaces_event(machine, event, sample); break;
+	case PERF_RECORD_CGROUP:
+		ret = machine__process_cgroup_event(machine, event, sample); break;
 	case PERF_RECORD_MMAP2:
 		ret = machine__process_mmap2_event(machine, event, sample); break;
 	case PERF_RECORD_FORK:
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 7d69119d0b5d..608813ced0cd 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -127,6 +127,9 @@ int machine__process_switch_event(struct machine *machine,
 int machine__process_namespaces_event(struct machine *machine,
 				      union perf_event *event,
 				      struct perf_sample *sample);
+int machine__process_cgroup_event(struct machine *machine,
+				  union perf_event *event,
+				  struct perf_sample *sample);
 int machine__process_mmap_event(struct machine *machine, union perf_event *event,
 				struct perf_sample *sample);
 int machine__process_mmap2_event(struct machine *machine, union perf_event *event,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5786e9c807c5..2cdce7ee228c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -457,6 +457,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 		tool->comm = process_event_stub;
 	if (tool->namespaces == NULL)
 		tool->namespaces = process_event_stub;
+	if (tool->cgroup == NULL)
+		tool->cgroup = process_event_stub;
 	if (tool->fork == NULL)
 		tool->fork = process_event_stub;
 	if (tool->exit == NULL)
@@ -1417,6 +1419,8 @@ static int machines__deliver_event(struct machines *machines,
 		return tool->comm(tool, event, sample, machine);
 	case PERF_RECORD_NAMESPACES:
 		return tool->namespaces(tool, event, sample, machine);
+	case PERF_RECORD_CGROUP:
+		return tool->cgroup(tool, event, sample, machine);
 	case PERF_RECORD_FORK:
 		return tool->fork(tool, event, sample, machine);
 	case PERF_RECORD_EXIT:
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 2abbf668b8de..472ef5eb4068 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -46,6 +46,7 @@ struct perf_tool {
 			mmap2,
 			comm,
 			namespaces,
+			cgroup,
 			fork,
 			exit,
 			lost,
-- 
2.23.0.187.g17f5b7556c-goog

