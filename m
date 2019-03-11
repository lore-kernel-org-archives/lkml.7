Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF4DC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38501214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfCKUYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:24:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:37486 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728254AbfCKUYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:24:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 13:24:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="306300713"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga005.jf.intel.com with ESMTP; 11 Mar 2019 13:24:48 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id CDC6B301E31; Mon, 11 Mar 2019 13:24:48 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 07/10] perf, tools, report: Indicate JITed code better in report
Date:   Mon, 11 Mar 2019 13:24:43 -0700
Message-Id: <20190311202446.10210-8-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311202446.10210-1-andi@firstfloor.org>
References: <20190311202446.10210-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Print [TID] tid %d instead of the crypted /tmp/perf-%d.map default.

% cat >loop.java
public class loop {
        public static void main(String[] args)
        {
                for (;;);
        }
}
^D
% javac loop.java
% perf record java loop
^C

Before:

% perf report --stdio
...
    56.09%  java     perf-34724.map      [.] 0x00007fd5bd021896
    19.12%  java     perf-34724.map      [.] 0x00007fd5bd021887
     9.79%  java     perf-34724.map      [.] 0x00007fd5bd021783
     8.97%  java     perf-34724.map      [.] 0x00007fd5bd02175b

After:

% perf report --stdio
...
    56.09%  java     [JIT] tid 34724     [.] 0x00007fd5bd021896
    19.12%  java     [JIT] tid 34724     [.] 0x00007fd5bd021887
     9.79%  java     [JIT] tid 34724     [.] 0x00007fd5bd021783
     8.97%  java     [JIT] tid 34724     [.] 0x00007fd5bd02175b

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/dso.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index ba58ba603b69..ab8a455d2283 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1141,28 +1141,34 @@ void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated)
 
 static void dso__set_basename(struct dso *dso)
 {
-       /*
-        * basename() may modify path buffer, so we must pass
-        * a copy.
-        */
-       char *base, *lname = strdup(dso->long_name);
+	char *base, *lname;
+	int tid;
 
-       if (!lname)
-               return;
-
-       /*
-        * basename() may return a pointer to internal
-        * storage which is reused in subsequent calls
-        * so copy the result.
-        */
-       base = strdup(basename(lname));
+	if (sscanf(dso->long_name, "/tmp/perf-%d.map", &tid) == 1) {
+		if (asprintf(&base, "[JIT] tid %d", tid) < 0)
+			return;
+	} else {
+	      /*
+	       * basename() may modify path buffer, so we must pass
+               * a copy.
+               */
+		lname = strdup(dso->long_name);
+		if (!lname)
+			return;
 
-       free(lname);
+		/*
+		 * basename() may return a pointer to internal
+		 * storage which is reused in subsequent calls
+		 * so copy the result.
+		 */
+		base = strdup(basename(lname));
 
-       if (!base)
-               return;
+		free(lname);
 
-       dso__set_short_name(dso, base, true);
+		if (!base)
+			return;
+	}
+	dso__set_short_name(dso, base, true);
 }
 
 int dso__name_len(const struct dso *dso)
-- 
2.20.1

