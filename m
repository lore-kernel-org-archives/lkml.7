Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A92EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551642089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="u2YafqDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387655AbfG3SAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:00:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34031 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbfG3SAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:00:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UI0Bkj3321863
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:00:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UI0Bkj3321863
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564509611;
        bh=yV22r3+GO4QQdOHpRWfXXA7gYTRQa8aKyIrtPLvcJR4=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=u2YafqDSx2GjlICLzGbfJdJtnCxq9oNT/TR3+L56GWrRuzWmBDDd9/IqoE0JY0++U
         mBZ5ubiYqtKnTlOusHZ7XnW2U3WWVi+qihRSkuDU+yeuPVkQznwn1+8UgZcCgSFVaq
         v9flXyXuW4GA4Uy2Ez0n7+iKn9ETRARM4CoRFsrKcR0HHqHKP3cHOCtFAS2OkN+q1B
         I8+i2fiKwzBAhHEwQxEMi1KgtoENccMBK5nKDLgZ3uOcCaRIC/+jGBbq4aBZYNp+fg
         GRbn1gbOqUSCiiFWgYjyihEOgwkBe5kCKZJx3OKqj9M1MLuGqTCAp0oNngHaiR9YkB
         nIWbPk83XczNA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UI08Ib3321859;
        Tue, 30 Jul 2019 11:00:08 -0700
Date:   Tue, 30 Jul 2019 11:00:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-b7t6h8sq9lebemvfy2zh3qq1@git.kernel.org>
Cc:     hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, lclaudio@redhat.com,
        adrian.hunter@intel.com, jolsa@kernel.org, namhyung@kernel.org
Reply-To: acme@redhat.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, namhyung@kernel.org,
          lclaudio@redhat.com, adrian.hunter@intel.com, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace beauty: Disable fd->pathname when
 close() not enabled
Git-Commit-ID: 79d725cdf24dec7bfe7ad27b107f5cb06cd3785a
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

Commit-ID:  79d725cdf24dec7bfe7ad27b107f5cb06cd3785a
Gitweb:     https://git.kernel.org/tip/79d725cdf24dec7bfe7ad27b107f5cb06cd3785a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 16 Jul 2019 16:56:49 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:41 -0300

perf trace beauty: Disable fd->pathname when close() not enabled

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
