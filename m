Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AB5C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19751206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BIzGLCaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbfG3SEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:04:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55883 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387837AbfG3SEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:04:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UI4gtT3324164
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:04:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UI4gtT3324164
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564509883;
        bh=Q93UdOxBPaMehLIASygquktSIG3eYCvGYY8quCJsUZo=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=BIzGLCaRp8nKbCKtzDnB/sRbqyIxwrxj2AbBf2970GLpI9bx/swa7VDdRyvLHlyVX
         V2NOKSA58c6WWqRCv3toYS+8VgA/RAOCo8b1lc3RC1lObVt6ib82UhXJhc02qs7wfh
         Nv+v3TZf01k3VJ5+XIj1ciCq5n3OzEmhX6K8MPu6GlcwA5xVO4+uzjI6m12xGLB1X5
         JOX5I4aOQhQX4dXhgUBE7dc0YipkTUQXYENhXljUoSqXtheHvv4PXbahoUCcD5NJtB
         0SYLSQfqHOkmLlhcb06bE+GQ86l8QMiEuiNOezN5FaNZRd2W50bWtcd9Q46RJGlDB4
         ZF/FFpwebku6w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UI4g013324161;
        Tue, 30 Jul 2019 11:04:42 -0700
Date:   Tue, 30 Jul 2019 11:04:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-cku9mpcrcsqaiq0jepu86r68@git.kernel.org>
Cc:     acme@redhat.com, mingo@kernel.org, hpa@zytor.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, lclaudio@redhat.com
Reply-To: lclaudio@redhat.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, tglx@linutronix.de, hpa@zytor.com,
          namhyung@kernel.org, jolsa@kernel.org, acme@redhat.com,
          mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Mark syscall ids that are not allocated
 to avoid unnecessary error messages
Git-Commit-ID: b8b1033fcaa091d82289698d7179e84e28cbd92a
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

Commit-ID:  b8b1033fcaa091d82289698d7179e84e28cbd92a
Gitweb:     https://git.kernel.org/tip/b8b1033fcaa091d82289698d7179e84e28cbd92a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 17 Jul 2019 20:21:37 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:42 -0300

perf trace: Mark syscall ids that are not allocated to avoid unnecessary error messages

There are holes in syscall tables with IDs not associated with any
syscall, mark those when trying to read information for syscalls, which
could happen when iterating thru all syscalls from 0 to the highest
numbered syscall id.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-cku9mpcrcsqaiq0jepu86r68@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 5dae7b172291..765b998755ce 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -976,6 +976,7 @@ static struct syscall_fmt *syscall_fmt__find_by_alias(const char *alias)
  * is_exit: is this "exit" or "exit_group"?
  * is_open: is this "open" or "openat"? To associate the fd returned in sys_exit with the pathname in sys_enter.
  * args_size: sum of the sizes of the syscall arguments, anything after that is augmented stuff: pathname for openat, etc.
+ * nonexistent: Just a hole in the syscall table, syscall id not allocated
  */
 struct syscall {
 	struct tep_event    *tp_format;
@@ -987,6 +988,7 @@ struct syscall {
 	}		    bpf_prog;
 	bool		    is_exit;
 	bool		    is_open;
+	bool		    nonexistent;
 	struct tep_format_field *args;
 	const char	    *name;
 	struct syscall_fmt  *fmt;
@@ -1491,9 +1493,6 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	struct syscall *sc;
 	const char *name = syscalltbl__name(trace->sctbl, id);
 
-	if (name == NULL)
-		return -EINVAL;
-
 	if (id > trace->syscalls.max) {
 		struct syscall *nsyscalls = realloc(trace->syscalls.table, (id + 1) * sizeof(*sc));
 
@@ -1512,8 +1511,15 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	}
 
 	sc = trace->syscalls.table + id;
-	sc->name = name;
+	if (sc->nonexistent)
+		return 0;
 
+	if (name == NULL) {
+		sc->nonexistent = true;
+		return 0;
+	}
+
+	sc->name = name;
 	sc->fmt  = syscall_fmt__find(sc->name);
 
 	snprintf(tp_name, sizeof(tp_name), "sys_enter_%s", sc->name);
@@ -1811,14 +1817,21 @@ static struct syscall *trace__syscall_info(struct trace *trace,
 		return NULL;
 	}
 
+	err = -EINVAL;
+
 	if ((id > trace->syscalls.max || trace->syscalls.table[id].name == NULL) &&
 	    (err = trace__read_syscall_info(trace, id)) != 0)
 		goto out_cant_read;
 
-	err = -EINVAL;
-	if ((id > trace->syscalls.max || trace->syscalls.table[id].name == NULL))
+	if (id > trace->syscalls.max)
 		goto out_cant_read;
 
+	if (trace->syscalls.table[id].name == NULL) {
+		if (trace->syscalls.table[id].nonexistent)
+			return NULL;
+		goto out_cant_read;
+	}
+
 	return &trace->syscalls.table[id];
 
 out_cant_read:
