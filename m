Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EC1C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C752246F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfKLLU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:20:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33902 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfKLLS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBd-0000YZ-4S; Tue, 12 Nov 2019 12:18:17 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2ED841C03AB;
        Tue, 12 Nov 2019 12:18:08 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:18:07 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf auxtrace: Add auxtrace_cache__remove()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20191025130000.13032-6-adrian.hunter@intel.com>
References: <20191025130000.13032-6-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157355748769.29376.9336907434787303711.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     fd62c1097a0700484fc2cbc9a182f341f30890cd
Gitweb:        https://git.kernel.org/tip/fd62c1097a0700484fc2cbc9a182f341f30890cd
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Fri, 25 Oct 2019 15:59:59 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:43:06 -03:00

perf auxtrace: Add auxtrace_cache__remove()

Add auxtrace_cache__remove(). Intel PT uses an auxtrace_cache to store
the results of code-walking, so that the same block of instructions does
not have to be decoded repeatedly. However, when there are text poke
events, the associated cache entries need to be removed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
Link: http://lore.kernel.org/lkml/20191025130000.13032-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 28 ++++++++++++++++++++++++++++
 tools/perf/util/auxtrace.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 8470dfe..c555c3c 100644
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
index f201f36..3f4aa54 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -489,6 +489,7 @@ void *auxtrace_cache__alloc_entry(struct auxtrace_cache *c);
 void auxtrace_cache__free_entry(struct auxtrace_cache *c, void *entry);
 int auxtrace_cache__add(struct auxtrace_cache *c, u32 key,
 			struct auxtrace_cache_entry *entry);
+void auxtrace_cache__remove(struct auxtrace_cache *c, u32 key);
 void *auxtrace_cache__lookup(struct auxtrace_cache *c, u32 key);
 
 struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
