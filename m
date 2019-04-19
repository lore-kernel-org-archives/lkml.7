Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAECC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776AF20821
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="vGeojem1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfDSTGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:06:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42949 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729097AbfDSTDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:03:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3JHJONv359277
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 19 Apr 2019 10:19:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3JHJONv359277
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555694365;
        bh=9aMUz3v12otTjvjuVLZXNSBqxpeJu+jJcyYftk2YjPU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=vGeojem1GVQIvH0KdgnMNwf94aqiY0uJh1f3pn0N2z0QE9CDfqirSNBrwzROR9iRG
         jwjc/zWzdjygeuu7fT+VzDwjPifACzOEHDO93O6SnDZC6Xuj7ZA/zOjlbUuB4z1ThU
         qZvWYVWtxW/4/5s2TNgQeqcq6WSEJanlyzlTdz2mdKD7bdhFSgPtfTBIwSaS+fgx63
         NR/EO0tDyAj/lmvb7Ln0MGVzRbe7+3HmyMJhFU3KIV/EyEFrROdZxmfzIMV4DARwS7
         f8TiIiFUgxGPvAvna70ar1CTFmulfKYu947Vd8yOpO6Q7nhOijYdFBdBbQMC5T5Lp7
         hNEX67AErsHPA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3JHJN3s359274;
        Fri, 19 Apr 2019 10:19:23 -0700
Date:   Fri, 19 Apr 2019 10:19:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-adc6257c4a6f23ff97dca8314fcd33828e2d8db5@git.kernel.org>
Cc:     acme@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        daniel@iogearbox.net, ast@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        songliubraving@fb.com, hpa@zytor.com, mingo@kernel.org,
        adrian.hunter@intel.com, tglx@linutronix.de, ak@linux.intel.com,
        linux-kernel@vger.kernel.org
Reply-To: adrian.hunter@intel.com, mingo@kernel.org, ak@linux.intel.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, acme@redhat.com, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, ast@kernel.org,
          jolsa@kernel.org, daniel@iogearbox.net, hpa@zytor.com,
          songliubraving@fb.com
In-Reply-To: <20190416160127.30203-9-jolsa@kernel.org>
References: <20190416160127.30203-9-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf evlist: Fix side band thread draining
Git-Commit-ID: adc6257c4a6f23ff97dca8314fcd33828e2d8db5
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

Commit-ID:  adc6257c4a6f23ff97dca8314fcd33828e2d8db5
Gitweb:     https://git.kernel.org/tip/adc6257c4a6f23ff97dca8314fcd33828e2d8db5
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 16 Apr 2019 18:01:23 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 17 Apr 2019 14:30:11 -0300

perf evlist: Fix side band thread draining

Current perf_evlist__poll_thread() code could finish without draining
the data. Adding the logic that makes sure we won't finish before the
drain.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Fixes: 657ee5531903 ("perf evlist: Introduce side band thread")
Link: http://lkml.kernel.org/r/20190416160127.30203-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6689378ee577..51ead577533f 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1868,12 +1868,12 @@ static void *perf_evlist__poll_thread(void *arg)
 {
 	struct perf_evlist *evlist = arg;
 	bool draining = false;
-	int i;
+	int i, done = 0;
+
+	while (!done) {
+		bool got_data = false;
 
-	while (draining || !(evlist->thread.done)) {
-		if (draining)
-			draining = false;
-		else if (evlist->thread.done)
+		if (evlist->thread.done)
 			draining = true;
 
 		if (!draining)
@@ -1894,9 +1894,13 @@ static void *perf_evlist__poll_thread(void *arg)
 					pr_warning("cannot locate proper evsel for the side band event\n");
 
 				perf_mmap__consume(map);
+				got_data = true;
 			}
 			perf_mmap__read_done(map);
 		}
+
+		if (draining && !got_data)
+			break;
 	}
 	return NULL;
 }
