Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2474BC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D5B216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562697105;
	bh=H1lXyVSrJdlhwUe6Wi6nEcC6iJYeflbVrs5S8NzVf6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WoCsYCDnH3o/bCGd2NnkRfzqk6EtXDpgOCvit/JlXoeO6+AP9mEDStSVTMV1J8MhW
	 JKYV7m8N75G/8Z15gPNgtvLcLZxfLSA57Oq0BBvbKGXzqZ6Ldbrch73dVwXiwb0JYG
	 juFJaMzXV9FBB8OsNz7HKne2SuS/wmz9Pg1EL51c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbfGISbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:31:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728991AbfGISbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:31:42 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76D9621537;
        Tue,  9 Jul 2019 18:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562697101;
        bh=H1lXyVSrJdlhwUe6Wi6nEcC6iJYeflbVrs5S8NzVf6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IYHeEhDVFRs2Nc1Mjt1rT8J/gRuLTqT+ug6vDRKCjWPyDqtTEaWlo/jyQc6h/076N
         Rgfxd1DgkKR9FD2XmzO4Qs64TEB6EErESzBbHb5KXeUXllCyDu2i5irh4Yk4k7tPXk
         N52GX2j2ubk5bNkna30/8PZiyQCalOwvFAnCImJc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Numfor Mbiziwo-Tiapo <nums@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Drayton <mbd@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/25] perf test mmap-thread-lookup: Initialize variable to suppress memory sanitizer warning
Date:   Tue,  9 Jul 2019 15:31:02 -0300
Message-Id: <20190709183126.30257-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709183126.30257-1-acme@kernel.org>
References: <20190709183126.30257-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Numfor Mbiziwo-Tiapo <nums@google.com>

Running the 'perf test' command after building perf with a memory
sanitizer causes a warning that says:

  WARNING: MemorySanitizer: use-of-uninitialized-value... in mmap-thread-lookup.c

Initializing the go variable to 0 silences this harmless warning.

Committer warning:

This was harmless, just a simple test writing whatever was at that
sizeof(int) memory area just to signal another thread blocked reading
that file created with pipe(). Initialize it tho so that we don't get
this warning.

Signed-off-by: Numfor Mbiziwo-Tiapo <nums@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Drayton <mbd@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190702173716.181223-1-nums@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/mmap-thread-lookup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index ba87e6e8d18c..0a4301a5155c 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -53,7 +53,7 @@ static void *thread_fn(void *arg)
 {
 	struct thread_data *td = arg;
 	ssize_t ret;
-	int go;
+	int go = 0;
 
 	if (thread_init(td))
 		return NULL;
-- 
2.21.0

