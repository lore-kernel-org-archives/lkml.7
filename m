Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5963C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD5621D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153441;
	bh=n8p5BwmZaXj3FJOrHQksZvZp1lbsz+SvdNDzREnH6TM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tc84fzuqQIFwPuX3/a9RuSfHYuIihDOmbd978JldKbLkalJiXfWnkTJ8A38AvPwsE
	 mNR8W8ynAyxNTgtKK1gV6YDL2PXV8vu7SpthaBWUPVVjHZetT1yRQ0EFAe8dlU8RVj
	 qNpyfjNw/avKmkmXaFNVmtTcpOY2hiu67hikIG+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfKGTEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:04:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:42934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfKGTEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:04:00 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FD9F21882;
        Thu,  7 Nov 2019 19:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153439;
        bh=n8p5BwmZaXj3FJOrHQksZvZp1lbsz+SvdNDzREnH6TM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WoZUDD4PpbmyUwvecOluISfhz/lAA/oHR5GCL3L55BqBePi9nz89CYAI1zmjkPrQv
         V5y2od3eQK3OvmM61jvFhNv4I8BRotG0x3kBkKcwzG69Be1j+gpSf/Hyhr4LQV1BiV
         2R5QKP3QowbbKJBDf5B3JPgXQG1nMo1UgcFmHlNc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 25/63] perf auxtrace: Add auxtrace_cache__remove()
Date:   Thu,  7 Nov 2019 15:59:33 -0300
Message-Id: <20191107190011.23924-26-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

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
2.21.0

