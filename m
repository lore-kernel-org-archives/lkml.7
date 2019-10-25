Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AFACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DB521D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504700AbfJYNBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:01:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:41239 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504684AbfJYNB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:01:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 06:01:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="201802389"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.55])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2019 06:01:23 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 5/6] perf auxtrace: Add auxtrace_cache__remove()
Date:   Fri, 25 Oct 2019 15:59:59 +0300
Message-Id: <20191025130000.13032-6-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025130000.13032-1-adrian.hunter@intel.com>
References: <20191025130000.13032-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add auxtrace_cache__remove(). Intel PT uses an auxtrace_cache to store the
results of code-walking, so that the same block of instructions does not
have to be decoded repeatedly. However, when there are text poke events,
the associated cache entries need to be removed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 28 ++++++++++++++++++++++++++++
 tools/perf/util/auxtrace.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 8470dfe9fe97..c555c3ccd79d 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1457,6 +1457,34 @@ int auxtrace_cache__add(struct auxtrace_cache *c, u32 key,
 	return 0;
 }
 
+static struct auxtrace_cache_entry *auxtrace_cache__rm(struct auxtrace_cache *c,
+						       u32 key)
+{
+	struct auxtrace_cache_entry *entry;
+	struct hlist_head *hlist;
+	struct hlist_node *n;
+
+	if (!c)
+		return NULL;
+
+	hlist = &c->hashtable[hash_32(key, c->bits)];
+	hlist_for_each_entry_safe(entry, n, hlist, hash) {
+		if (entry->key == key) {
+			hlist_del(&entry->hash);
+			return entry;
+		}
+	}
+
+	return NULL;
+}
+
+void auxtrace_cache__remove(struct auxtrace_cache *c, u32 key)
+{
+	struct auxtrace_cache_entry *entry = auxtrace_cache__rm(c, key);
+
+	auxtrace_cache__free_entry(c, entry);
+}
+
 void *auxtrace_cache__lookup(struct auxtrace_cache *c, u32 key)
 {
 	struct auxtrace_cache_entry *entry;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index f201f36bc35f..3f4aa5427d76 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -489,6 +489,7 @@ void *auxtrace_cache__alloc_entry(struct auxtrace_cache *c);
 void auxtrace_cache__free_entry(struct auxtrace_cache *c, void *entry);
 int auxtrace_cache__add(struct auxtrace_cache *c, u32 key,
 			struct auxtrace_cache_entry *entry);
+void auxtrace_cache__remove(struct auxtrace_cache *c, u32 key);
 void *auxtrace_cache__lookup(struct auxtrace_cache *c, u32 key);
 
 struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
-- 
2.17.1

