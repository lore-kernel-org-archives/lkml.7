Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA63CC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50D12189F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563509151;
	bh=L3bfEAAL0Ysgipi+GDxrm8gZDpiTXGOXWVgDY9UE48k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E0OROhj7uG2CBlbgkgvRXThLrJZIvvo5PDnTPuzg/MEnHdvONnDP38BR/3C/HdkwP
	 6z5zAwhANh6a01X/d1NK5SKYXQR9k853MbE8o9drvzRhyes8g6A8neASCnAh0lu7Uf
	 qdAJsZ5TAJOS6IaPdnJxTiWJjzIyXVbvymL7xxpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbfGSEFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731851AbfGSEFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:05:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C193218BA;
        Fri, 19 Jul 2019 04:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509146;
        bh=L3bfEAAL0Ysgipi+GDxrm8gZDpiTXGOXWVgDY9UE48k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B2uTbjfH0dtruYtPRP60D85ejVqqWmhd+z1+i7PoUwmSDvjW9rcUUijIuAhxszxBR
         X7CkdAC/rjk7Psa4T39hj1cGegHVsyxuThJNRJWQxLhdUkvwTPh6nE0bvDu+jGMnYV
         F35uhbMMSdXXNY6/n/PVFPzGbFXdN+9rGrYNWuDs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Numfor Mbiziwo-Tiapo <nums@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Drayton <mbd@fb.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 096/141] perf test mmap-thread-lookup: Initialize variable to suppress memory sanitizer warning
Date:   Fri, 19 Jul 2019 00:02:01 -0400
Message-Id: <20190719040246.15945-96-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Numfor Mbiziwo-Tiapo <nums@google.com>

[ Upstream commit 4e4cf62b37da5ff45c904a3acf242ab29ed5881d ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.20.1

