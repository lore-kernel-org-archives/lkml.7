Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDF5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC132173B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665233;
	bh=WYwzIakmuWo0+t/g5LtHL3sK58VgM7KPWY9apQ5mMI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aKwA5gEaWQsY/wrgcxfRnyqa/tIUGlBDs15Zj66xf2eZG/ULopCc3wHZ7ucp5/Ntz
	 kCWuaRrftzxTlG4qydclclKj3pou1nJKNBF4CKVxGG284c7H6uEpnKqrlp4Ba7hNUi
	 2qFez4ojGZ1OFq47goMcFdUoj7Kr6HvYBOCNQwpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbfJUNkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbfJUNk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:40:28 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAC3520679;
        Mon, 21 Oct 2019 13:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665227;
        bh=WYwzIakmuWo0+t/g5LtHL3sK58VgM7KPWY9apQ5mMI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vtp+z5BDT9QlBclJiduSKN63Sz35dbBD/rx7hHo0rtKLZWQkYtKgZvAhoB82Te7b+
         EToKEi6t/3OZ0LHWFzt/9aMhrukhOzoWSfrFWCAiaAdkqzl+JMgSrbYjH2rwL/J9+A
         C2J2QvNBE0vQkAxK78wYoVlydyAuAVJp8CFkeQOY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 33/57] perf trace: Initialize evsel_trace->fmt for syscalls:sys_enter_* tracepoints
Date:   Mon, 21 Oct 2019 10:38:10 -0300
Message-Id: <20191021133834.25998-34-acme@kernel.org>
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

From the syscall_fmts->arg entries for formatting strace-like syscalls.

This is when resolving the string "whence" on a filter expression for
the syscalls:sys_enter_lseek:

  Breakpoint 3, perf_evsel__syscall_arg_fmt (evsel=0xc91ed0, arg=0x7fffffff7cd0 "whence") at builtin-trace.c:3626
  3626	{
  (gdb) n
  3628		struct syscall_arg_fmt *fmt = __evsel__syscall_arg_fmt(evsel);
  (gdb) n
  3630		if (evsel->tp_format == NULL || fmt == NULL)
  (gdb) n
  3633		for (field = evsel->tp_format->format.fields; field; field = field->next, ++fmt)
  (gdb) n
  3634			if (strcmp(field->name, arg) == 0)
  (gdb) p field->name
  $3 = 0xc945e0 "__syscall_nr"
  (gdb) n
  3633		for (field = evsel->tp_format->format.fields; field; field = field->next, ++fmt)
  (gdb) p *fmt
  $4 = {scnprintf = 0x0, strtoul = 0x0, mask_val = 0x0, parm = 0x0, name = 0x0, nr_entries = 0, show_zero = false}
  (gdb) n
  3634			if (strcmp(field->name, arg) == 0)
  (gdb) p field->name
  $5 = 0xc94690 "fd"
  (gdb) n
  3633		for (field = evsel->tp_format->format.fields; field; field = field->next, ++fmt)
  (gdb) n
  3634			if (strcmp(field->name, arg) == 0)
  (gdb) n
  3633		for (field = evsel->tp_format->format.fields; field; field = field->next, ++fmt)
  (gdb) n
  3634			if (strcmp(field->name, arg) == 0)
  (gdb) p *fmt
  $9 = {scnprintf = 0x489be2 <syscall_arg__scnprintf_strarray>, strtoul = 0x0, mask_val = 0x0, parm = 0xa2da80 <strarray.whences>, name = 0x0,
    nr_entries = 0, show_zero = false}
  (gdb) p field->name
  $10 = 0xc947b0 "whence"
  (gdb) p fmt->parm
  $11 = (void *) 0xa2da80 <strarray.whences>
  (gdb) p *(struct strarray *)fmt->parm
  $12 = {offset = 0, nr_entries = 5, prefix = 0x724d37 "SEEK_", entries = 0xa2da40 <whences>}
  (gdb) p (struct strarray *)fmt->parm)->entries
  Junk after end of expression.
  (gdb) p ((struct strarray *)fmt->parm)->entries
  $13 = (const char **) 0xa2da40 <whences>
  (gdb) p ((struct strarray *)fmt->parm)->entries[0]
  $14 = 0x724d21 "SET"
  (gdb) p ((struct strarray *)fmt->parm)->entries[1]
  $15 = 0x724d25 "CUR"
  (gdb) p ((struct strarray *)fmt->parm)->entries[2]
  $16 = 0x724d29 "END"
  (gdb) p ((struct strarray *)fmt->parm)->entries[2]
  $17 = 0x724d29 "END"
  (gdb) p ((struct strarray *)fmt->parm)->entries[3]
  $18 = 0x724d2d "DATA"
  (gdb) p ((struct strarray *)fmt->parm)->entries[4]
  $19 = 0x724d32 "HOLE"
  (gdb)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-lc8h9jgvbnboe0g7ic8tra1y@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 5792278065f6..3502417dc7f2 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4366,6 +4366,25 @@ static void evlist__set_default_evsel_handler(struct evlist *evlist, void *handl
 	}
 }
 
+static void evsel__set_syscall_arg_fmt(struct evsel *evsel, const char *name)
+{
+	struct syscall_arg_fmt *fmt = evsel__syscall_arg_fmt(evsel);
+
+	if (fmt) {
+		struct syscall_fmt *scfmt = syscall_fmt__find(name);
+
+		if (scfmt) {
+			int skip = 0;
+
+			if (strcmp(evsel->tp_format->format.fields->name, "__syscall_nr") == 0 ||
+			    strcmp(evsel->tp_format->format.fields->name, "nr") == 0)
+				++skip;
+
+			memcpy(fmt + skip, scfmt->arg, (evsel->tp_format->format.nr_fields - skip) * sizeof(*fmt));
+		}
+	}
+}
+
 static int evlist__set_syscall_tp_fields(struct evlist *evlist)
 {
 	struct evsel *evsel;
@@ -4387,11 +4406,15 @@ static int evlist__set_syscall_tp_fields(struct evlist *evlist)
 
 			if (__tp_field__init_ptr(&sc->args, sc->id.offset + sizeof(u64)))
 				return -1;
+
+			evsel__set_syscall_arg_fmt(evsel, evsel->tp_format->name + sizeof("sys_enter_") - 1);
 		} else if (!strncmp(evsel->tp_format->name, "sys_exit_", 9)) {
 			struct syscall_tp *sc = __evsel__syscall_tp(evsel);
 
 			if (__tp_field__init_uint(&sc->ret, sizeof(u64), sc->id.offset + sizeof(u64), evsel->needs_swap))
 				return -1;
+
+			evsel__set_syscall_arg_fmt(evsel, evsel->tp_format->name + sizeof("sys_exit_") - 1);
 		}
 	}
 
-- 
2.21.0

