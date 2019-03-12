Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C078C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D4C21852
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410843;
	bh=tXCnaYFjBA8ZShVoSSoH7xEEIQT5+nmNKeyjmcg/o6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EKJbSnUbEGYPAuUu83CEPiWEVb59bfnisYPDHQEYwzJ+PgxtFdlINh2y3PWm+3u5Z
	 jVv35pMaPlgGUWxNUoJtGu4RQ/U4KB2/GXKL134kpuWywtASOMGy3YHPpXmALD0xS2
	 gl3ZvR9YauLkFFoYI5S5aGlqC9Y5c7Gex+fhAUqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfCLROB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:14:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbfCLRNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:23 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A8192183F;
        Tue, 12 Mar 2019 17:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410802;
        bh=tXCnaYFjBA8ZShVoSSoH7xEEIQT5+nmNKeyjmcg/o6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KuMLwdd3RlWTo58vJ+BFmzreiZIBQVgpgL3rrY+kqHHOYe6whPoe1eScZT9/AfH9U
         BF4J2BWe9q6xcqnyE7n4yU0t+t8LTTIuAWrRHdzDreNDltQ2oPhdMEPv+ivbzuW+EL
         J7yVJuuccxD0N3odLT5XmOCfXUxeMpfFn2/ny8V0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Petlan <mpetlan@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 130/171] perf trace: Support multiple "vfs_getname" probes
Date:   Tue, 12 Mar 2019 10:08:30 -0700
Message-Id: <20190312170358.939660064@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6ab3bc240ade47a0f52bc16d97edd9accbe0024e ]

With a suitably defined "probe:vfs_getname" probe, 'perf trace' can
"beautify" its output, so syscalls like open() or openat() can print the
"filename" argument instead of just its hex address, like:

  $ perf trace -e open -- touch /dev/null
  [...]
       0.590 ( 0.014 ms): touch/18063 open(filename: /dev/null, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3
  [...]

The output without such beautifier looks like:

     0.529 ( 0.011 ms): touch/18075 open(filename: 0xc78cf288, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3

However, when the vfs_getname probe expands to multiple probes and it is
not the first one that is hit, the beautifier fails, as following:

     0.326 ( 0.010 ms): touch/18072 open(filename: , flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3

Fix it by hooking into all the expanded probes (inlines), now, for instance:

  [root@quaco ~]# perf probe -l
    probe:vfs_getname    (on getname_flags:73@fs/namei.c with pathname)
    probe:vfs_getname_1  (on getname_flags:73@fs/namei.c with pathname)
  [root@quaco ~]# perf trace -e open* sleep 1
       0.010 ( 0.005 ms): sleep/5588 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: RDONLY|CLOEXEC)   = 3
       0.029 ( 0.006 ms): sleep/5588 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: RDONLY|CLOEXEC)   = 3
       0.194 ( 0.008 ms): sleep/5588 openat(dfd: CWD, filename: /usr/lib/locale/locale-archive, flags: RDONLY|CLOEXEC) = 3
  [root@quaco ~]#

Works, further verified with:

  [root@quaco ~]# perf test vfs
  65: Use vfs_getname probe to get syscall args filenames   : Ok
  66: Add vfs_getname probe to get syscall args filenames   : Ok
  67: Check open filename arg using perf trace + vfs_getname: Ok
  [root@quaco ~]#

Reported-by: Michael Petlan <mpetlan@redhat.com>
Tested-by: Michael Petlan <mpetlan@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-mv8kolk17xla1smvmp3qabv1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-trace.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 835619476370..c108519ddd61 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2424,19 +2424,30 @@ static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp);
 
 static bool perf_evlist__add_vfs_getname(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evsel__newtp("probe", "vfs_getname");
+	bool found = false;
+	struct perf_evsel *evsel, *tmp;
+	struct parse_events_error err = { .idx = 0, };
+	int ret = parse_events(evlist, "probe:vfs_getname*", &err);
 
-	if (IS_ERR(evsel))
+	if (ret)
 		return false;
 
-	if (perf_evsel__field(evsel, "pathname") == NULL) {
+	evlist__for_each_entry_safe(evlist, evsel, tmp) {
+		if (!strstarts(perf_evsel__name(evsel), "probe:vfs_getname"))
+			continue;
+
+		if (perf_evsel__field(evsel, "pathname")) {
+			evsel->handler = trace__vfs_getname;
+			found = true;
+			continue;
+		}
+
+		list_del_init(&evsel->node);
+		evsel->evlist = NULL;
 		perf_evsel__delete(evsel);
-		return false;
 	}
 
-	evsel->handler = trace__vfs_getname;
-	perf_evlist__add(evlist, evsel);
-	return true;
+	return found;
 }
 
 static struct perf_evsel *perf_evsel__new_pgfault(u64 config)
-- 
2.19.1



