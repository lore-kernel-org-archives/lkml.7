Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695AFC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3E320693
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fhDJTyxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfG3ShY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:37:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45201 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfG3ShX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:37:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIbBA13331662
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:37:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIbBA13331662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564511832;
        bh=nUEPYsYLTbaDUICroNM4TNzVNKhodkOAGdNAkoTPlLo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=fhDJTyxKJ9O/wfe/13+gKLfdIXPXsAGGC2QeU4DobhUOxqItUY/yO4X4da1zD/VOP
         5tsJhUDDBYRi+uMk4HZmkaz7ALiY9NCBW89n6RNDTRukqzIwRkvPD3gWIgwI2dZN8b
         9goPDA0RxgdqsfKyk/n7Soi+ge647I1s1oMDBjAW9KEtcC3DSQe+76WGzb67x8/7TI
         gIhikGzbXFRGW7klJ6o0QjR0GTEjJvv5x6/UBu/NC3ia9l/0W+cW5XP6/aBzW12qR5
         Orkxi7phAcKG2eq4uGB1xCLIn/8jWgoO98F/kc/lKxXlLbemBrIgc1RUWbCbGcB7O8
         IUrlDz01ScVhw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIbBUf3331659;
        Tue, 30 Jul 2019 11:37:11 -0700
Date:   Tue, 30 Jul 2019 11:37:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-52e22fb8af779e1a26b1cbde1db2f82f78b3ae68@git.kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org, ak@linux.intel.com,
        namhyung@kernel.org, tglx@linutronix.de,
        alexey.budankov@linux.intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, mpetlan@redhat.com, hpa@zytor.com,
        acme@redhat.com, alexander.shishkin@linux.intel.com
Reply-To: alexey.budankov@linux.intel.com, namhyung@kernel.org,
          tglx@linutronix.de, ak@linux.intel.com, peterz@infradead.org,
          jolsa@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
          hpa@zytor.com, mpetlan@redhat.com,
          alexander.shishkin@linux.intel.com, acme@redhat.com
In-Reply-To: <20190721112506.12306-41-jolsa@kernel.org>
References: <20190721112506.12306-41-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Add perf_evlist__remove() function
Git-Commit-ID: 52e22fb8af779e1a26b1cbde1db2f82f78b3ae68
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

Commit-ID:  52e22fb8af779e1a26b1cbde1db2f82f78b3ae68
Gitweb:     https://git.kernel.org/tip/52e22fb8af779e1a26b1cbde1db2f82f78b3ae68
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:27 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:44 -0300

libperf: Add perf_evlist__remove() function

Adding perf_evlist__remove() function to remove a perf_evsel from
a perf_evlist struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-41-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c              | 6 ++++++
 tools/perf/lib/include/perf/evlist.h | 2 ++
 tools/perf/lib/libperf.map           | 1 +
 tools/perf/util/evlist.c             | 2 +-
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index e5f187fa4e57..023fe4b44131 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -14,3 +14,9 @@ void perf_evlist__add(struct perf_evlist *evlist,
 {
 	list_add_tail(&evsel->node, &evlist->entries);
 }
+
+void perf_evlist__remove(struct perf_evlist *evlist,
+			 struct perf_evsel *evsel)
+{
+	list_del_init(&evsel->node);
+}
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 6992568b14a0..e0c87995c6ff 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -10,5 +10,7 @@ struct perf_evsel;
 LIBPERF_API void perf_evlist__init(struct perf_evlist *evlist);
 LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
 				  struct perf_evsel *evsel);
+LIBPERF_API void perf_evlist__remove(struct perf_evlist *evlist,
+				     struct perf_evsel *evsel);
 
 #endif /* __LIBPERF_EVLIST_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 06ccf31eb24d..168339f89a2e 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -12,6 +12,7 @@ LIBPERF_0.0.1 {
 		perf_evsel__init;
 		perf_evlist__init;
 		perf_evlist__add;
+		perf_evlist__remove;
 	local:
 		*;
 };
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f2b86f49ab8d..9b0108c23010 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -194,7 +194,7 @@ void evlist__add(struct evlist *evlist, struct evsel *entry)
 void evlist__remove(struct evlist *evlist, struct evsel *evsel)
 {
 	evsel->evlist = NULL;
-	list_del_init(&evsel->core.node);
+	perf_evlist__remove(&evlist->core, &evsel->core);
 	evlist->nr_entries -= 1;
 }
 
