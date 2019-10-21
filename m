Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B34DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31032173B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665186;
	bh=Rwj/0TzeTdBBfSeXoLYRN52d0cGcmDv2pCCuwnyyM+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1X1dON+hITAnmFmTBxDM0c2/+KbLrXZaP69j+J0SOeA9jwZtBZLAogzUqqtkm4IyE
	 8Fg0UHjs75asc0LqIqMcNQKJNFANUg+e3BdpoksABHqtRSY03UILaWgXEGL0Mlkqhs
	 oVMmcDvkC/vDg6bGOE6YkASPLk05iwlNZECI99ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfJUNjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:39:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729312AbfJUNjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:39:42 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56D6D21929;
        Mon, 21 Oct 2019 13:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665180;
        bh=Rwj/0TzeTdBBfSeXoLYRN52d0cGcmDv2pCCuwnyyM+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s2OQGTV/swRWJ8OOyeJUcC/VjsWOlFdarifeCBQoKkcR9b4ryeCTtoXWAOSmnNY10
         HbIT4qD5RvbH88m6i551OSoxvwj/V9qFFOR7ou6ubL3G/PptOQTkK2OMdd2LdEu6es
         cnkah6NXNXy7d/MsN8IFlUz7IMvTRqJ1IkrWdQdM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 18/57] perf trace: Support tracepoint dynamic char arrays
Date:   Mon, 21 Oct 2019 10:37:55 -0300
Message-Id: <20191021133834.25998-19-acme@kernel.org>
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

Things like:

  # grep __data_loc /sys/kernel/debug/tracing/events/sched/sched_process_exec/format
	field:__data_loc char[] filename;	offset:8;	size:4;	signed:1;
  #

That, at that offset (8) and with that size(8) have an integer that
contains the real length and offset for the contents of that array.

Now this works:

  # perf trace --max-events 1 -e sched:*exec -a
     0.000 sed/19441 sched:sched_process_exec(filename: "/usr/bin/sync", pid: 19441 (sync), old_pid: 19441 (sync))
  #

As when using the libtraceevent based beautifier:

  # perf trace --libtraceevent --max-events 1 -e sched:*exec -a
     0.000 sync/19463 sched:sched_process_exec(filename=/usr/bin/sync pid=19463 old_pid=19463)
  #

I.e. that 'filename' is implemented as a dynamic char array.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-950p0m842fe6n7sxsdwqj5i2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 19 ++++++++++++++-----
 tools/perf/trace/beauty/beauty.h |  2 ++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index cdee22dac2b3..907eaf316f5b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -563,7 +563,7 @@ static size_t syscall_arg__scnprintf_char_array(char *bf, size_t size, struct sy
 	// XXX Hey, maybe for sched:sched_switch prev/next comm fields we can
 	//     fill missing comms using thread__set_comm()...
 	//     here or in a special syscall_arg__scnprintf_pid_sched_tp...
-	return scnprintf(bf, size, "\"%-.*s\"", arg->fmt->nr_entries, arg->val);
+	return scnprintf(bf, size, "\"%-.*s\"", arg->fmt->nr_entries ?: arg->len, arg->val);
 }
 
 #define SCA_CHAR_ARRAY syscall_arg__scnprintf_char_array
@@ -1559,7 +1559,7 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			arg->scnprintf = SCA_PID;
 		else if (strcmp(field->type, "umode_t") == 0)
 			arg->scnprintf = SCA_MODE_T;
-		else if ((field->flags & TEP_FIELD_IS_ARRAY) && strstarts(field->type, "char")) {
+		else if ((field->flags & TEP_FIELD_IS_ARRAY) && strstr(field->type, "char")) {
 			arg->scnprintf = SCA_CHAR_ARRAY;
 			arg->nr_entries = field->arraylen;
 		} else if ((strcmp(field->type, "int") == 0 ||
@@ -2523,10 +2523,19 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		if (syscall_arg.mask & bit)
 			continue;
 
+		syscall_arg.len = 0;
 		syscall_arg.fmt = arg;
-		if (field->flags & TEP_FIELD_IS_ARRAY)
-			val = (uintptr_t)(sample->raw_data + field->offset);
-		else
+		if (field->flags & TEP_FIELD_IS_ARRAY) {
+			int offset = field->offset;
+
+			if (field->flags & TEP_FIELD_IS_DYNAMIC) {
+				offset = format_field__intval(field, sample, evsel->needs_swap);
+				syscall_arg.len = offset >> 16;
+				offset &= 0xffff;
+			}
+
+			val = (uintptr_t)(sample->raw_data + offset);
+		} else
 			val = format_field__intval(field, sample, evsel->needs_swap);
 		/*
 		 * Some syscall args need some mask, most don't and
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 77ad80a399fd..0dee0cf4fda8 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -87,6 +87,7 @@ struct syscall_arg_fmt;
 
 /**
  * @val: value of syscall argument being formatted
+ * @len: for tracepoint dynamic arrays, if fmt->nr_entries == 0, then its not a fixed array, look at arg->len
  * @args: All the args, use syscall_args__val(arg, nth) to access one
  * @augmented_args: Extra data that can be collected, for instance, with eBPF for expanding the pathname for open, etc
  * @augmented_args_size: augmented_args total payload size
@@ -109,6 +110,7 @@ struct syscall_arg {
 	struct thread *thread;
 	struct trace  *trace;
 	void	      *parm;
+	u16	      len;
 	u8	      idx;
 	u8	      mask;
 	bool	      show_string_prefix;
-- 
2.21.0

