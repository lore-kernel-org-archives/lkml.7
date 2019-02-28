Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F968C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C99520C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551367033;
	bh=PoYs+UzqTHPO3CTwlHmc/6lVTpaMKr8p45fLsP7jvU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0QFbeZiGphsOmSfRZjMJ8QhvJDz/z0uHJG+WpFt9E30bIBASAw4edebUtuy/928vn
	 dgp+YJlmeo+ddWfzYXrxDXAZhvHI8Tq6kMnJDbAS5Bd55WbwTsyFUOew6j8JnbOMjS
	 YCE9h5lnu34q81ZfVjppBLsTlNL0uvNEiynRJfxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388800AbfB1PRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:17:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:52736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389026AbfB1PQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:16:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3765F218D9;
        Thu, 28 Feb 2019 15:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551366983;
        bh=PoYs+UzqTHPO3CTwlHmc/6lVTpaMKr8p45fLsP7jvU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w/ZSNBUF2PYhxQV/dlaku7jD8EtiSTsPKkkXeRqusuaysouW9aeld1fN7RNPzItIP
         qdVwPnqVZvPvsSls3Mo1OkJ5/W2BzAqopu5+svDmTDN9xv3f4DE2IhDW/ZyPxwcrPv
         gyp8u33WszhWj/u5EKmbZ7Q6Q+IC2Q5/8pW+OsKI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 7/8] perf trace: Support multiple "vfs_getname" probes
Date:   Thu, 28 Feb 2019 10:16:11 -0500
Message-Id: <20190228151614.13022-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190228151614.13022-1-sashal@kernel.org>
References: <20190228151614.13022-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index da8afc1211182..039517c61c75a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2403,19 +2403,30 @@ static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp);
 
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
 
 static int perf_evlist__add_pgfault(struct perf_evlist *evlist,
-- 
2.19.1

