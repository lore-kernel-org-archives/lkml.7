Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CCCCA9EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 16:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E839E21D80
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 16:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfJTQOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 12:14:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:11522 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbfJTQN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 12:13:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 09:13:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,320,1566889200"; 
   d="scan'208";a="200213405"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2019 09:13:58 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 2C74B30038C; Sun, 20 Oct 2019 09:13:58 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, eranian@google.com, kan.liang@linux.intel.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 2/9] perf evsel: Avoid close(-1)
Date:   Sun, 20 Oct 2019 09:13:39 -0700
Message-Id: <20191020161346.18938-3-andi@firstfloor.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191020161346.18938-1-andi@firstfloor.org>
References: <20191020161346.18938-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

In some weak fallback cases close can be called a lot with -1. Check
for this case and avoid calling close then.

This is mainly to shut up valgrind which complains about this case.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/lib/evsel.c  | 3 ++-
 tools/perf/util/evsel.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index 24abc80dd767..106522305ed0 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -120,7 +120,8 @@ void perf_evsel__close_fd(struct perf_evsel *evsel)
 
 	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++)
 		for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
-			close(FD(evsel, cpu, thread));
+			if (FD(evsel, cpu, thread) >= 0)
+				close(FD(evsel, cpu, thread));
 			FD(evsel, cpu, thread) = -1;
 		}
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a646975a20f3..bc57ac5d51a0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1981,7 +1981,8 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	old_errno = errno;
 	do {
 		while (--thread >= 0) {
-			close(FD(evsel, cpu, thread));
+			if (FD(evsel, cpu, thread) >= 0)
+				close(FD(evsel, cpu, thread));
 			FD(evsel, cpu, thread) = -1;
 		}
 		thread = nthreads;
-- 
2.21.0

