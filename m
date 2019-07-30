Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B6AC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA1620578
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455847;
	bh=MDNSvMDSKWeF6aQiQVcOuTHdoGP+VEqV8myc8KGxdOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w3yKHcfZjdPL0wMpn3NS/bc4YOyHR0OoH88Oan+UHiVmoaYeZe7G1t06BWQBfd3CU
	 itWl+ULznLRzFJ56umFdR8ZUYwsM8Kr4LJvREoiB6mTJmcMrqswGHOent+rb4rirym
	 IvKAC+vhn+/HANcJWMyPMvbFUHpvHlelgVRbseMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbfG3C5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:57:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731459AbfG3C5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:57:14 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D95AC21726;
        Tue, 30 Jul 2019 02:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455433;
        bh=MDNSvMDSKWeF6aQiQVcOuTHdoGP+VEqV8myc8KGxdOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rPviL+zyx98EY983I1ACRZv1bRQ7XkUpheQ+DOKo2Dbwo2wvV+dBcJWxtU7XDJFAE
         m7uigQTfxPG6oecoSALIyddQfWm22neXpH8gjVQ0mEItwlWrZeiGPfuVRcaHjOxjHW
         y7c0FF93bpieZwweeTk9GlbI1BOmeON3iIR+xr4g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 018/107] perf trace beauty: Disable fd->pathname when close() not enabled
Date:   Mon, 29 Jul 2019 23:54:41 -0300
Message-Id: <20190730025610.22603-19-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As we invalidate the fd->pathname table in the SCA_CLOSE_FD beautifier,
if we don't have it we may end up keeping an fd->pathname association
that then gets misprinted.

The previous behaviour continues when the close() syscall is enabled,
which may still be a a problem if we lose records (i.e. we may lose a
'close' record and then get that fd reused by socket()) but then the
tool will notify that records are being lost and the user will be warned
that some of the heuristics will fall apart.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-b7t6h8sq9lebemvfy2zh3qq1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 123d7efc12e8..94c33bb573c1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -127,6 +127,7 @@ struct trace {
 	unsigned int		min_stack;
 	int			raw_augmented_syscalls_args_size;
 	bool			raw_augmented_syscalls;
+	bool			fd_path_disabled;
 	bool			sort_events;
 	bool			not_ev_qualifier;
 	bool			live;
@@ -1178,7 +1179,7 @@ static const char *thread__fd_path(struct thread *thread, int fd,
 {
 	struct thread_trace *ttrace = thread__priv(thread);
 
-	if (ttrace == NULL)
+	if (ttrace == NULL || trace->fd_path_disabled)
 		return NULL;
 
 	if (fd < 0)
@@ -2097,7 +2098,7 @@ static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
 
 	ret = perf_evsel__sc_tp_uint(evsel, ret, sample);
 
-	if (sc->is_open && ret >= 0 && ttrace->filename.pending_open) {
+	if (!trace->fd_path_disabled && sc->is_open && ret >= 0 && ttrace->filename.pending_open) {
 		trace__set_fd_pathname(thread, ret, ttrace->filename.name);
 		ttrace->filename.pending_open = false;
 		++trace->stats.vfs_getname;
@@ -3206,7 +3207,6 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (trace->syscalls.prog_array.sys_enter)
 		trace__init_syscalls_bpf_prog_array_maps(trace);
 
-
 	if (trace->ev_qualifier_ids.nr > 0) {
 		err = trace__set_ev_qualifier_filter(trace);
 		if (err < 0)
@@ -3218,6 +3218,19 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		}
 	}
 
+	/*
+	 * If the "close" syscall is not traced, then we will not have the
+	 * opportunity to, in syscall_arg__scnprintf_close_fd() invalidate the
+	 * fd->pathname table and were ending up showing the last value set by
+	 * syscalls opening a pathname and associating it with a descriptor or
+	 * reading it from /proc/pid/fd/ in cases where that doesn't make
+	 * sense.
+	 *
+	 *  So just disable this beautifier (SCA_FD, SCA_FDAT) when 'close' is
+	 *  not in use.
+	 */
+	trace->fd_path_disabled = !trace__syscall_enabled(trace, syscalltbl__id(trace->sctbl, "close"));
+
 	err = perf_evlist__apply_filters(evlist, &evsel);
 	if (err < 0)
 		goto out_error_apply_filters;
-- 
2.21.0

