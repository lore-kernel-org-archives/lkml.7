Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30071C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1112E2173E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404623AbfITQWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:22:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52890 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405069AbfITQVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:21:24 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBLen-0004Bh-55; Fri, 20 Sep 2019 18:21:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CACAE1C0E38;
        Fri, 20 Sep 2019 18:21:01 +0200 (CEST)
Date:   Fri, 20 Sep 2019 16:21:01 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf jvmti: Link against tools/lib/string.o to
 have weak strlcpy()
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sergey Melnikov <melnikov.sergey.v@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-x8vg9sffgb2t1tzqmhkrulh7@git.kernel.org>
References: <tip-x8vg9sffgb2t1tzqmhkrulh7@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156899646175.24167.8702357606249062818.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     79743bc927f695e5a24f26c31cfe2d69f6ee00f7
Gitweb:        https://git.kernel.org/tip/79743bc927f695e5a24f26c31cfe2d69f6ee00f7
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 02 Sep 2019 15:37:21 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 09:18:45 -03:00

perf jvmti: Link against tools/lib/string.o to have weak strlcpy()

That is needed in systems such some S/390 distros.

  $ readelf -s /tmp/build/perf/jvmti/jvmti-in.o | grep strlcpy
	452: 0000000000002990   125 FUNC    WEAK   DEFAULT  119 strlcpy
  $

Thanks to Jiri Olsa for fixing up my initial stab at this, I forgot how
Makefiles are picky about spaces versus tabs.

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andreas Krebbel <krebbel@linux.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Sergey Melnikov <melnikov.sergey.v@gmail.com>
Link: https://lkml.kernel.org/n/tip-x8vg9sffgb2t1tzqmhkrulh7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/jvmti/Build |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/jvmti/Build b/tools/perf/jvmti/Build
index eaeb8cb..1e148bb 100644
--- a/tools/perf/jvmti/Build
+++ b/tools/perf/jvmti/Build
@@ -1,8 +1,17 @@
 jvmti-y += libjvmti.o
 jvmti-y += jvmti_agent.o
 
+# For strlcpy
+jvmti-y += libstring.o
+
 CFLAGS_jvmti         = -fPIC -DPIC -I$(JDIR)/include -I$(JDIR)/include/linux
 CFLAGS_REMOVE_jvmti  = -Wmissing-declarations
 CFLAGS_REMOVE_jvmti += -Wstrict-prototypes
 CFLAGS_REMOVE_jvmti += -Wextra
 CFLAGS_REMOVE_jvmti += -Wwrite-strings
+
+CFLAGS_libstring.o += -Wno-unused-parameter -DETC_PERFCONFIG="BUILD_STR($(ETC_PERFCONFIG_SQ))"
+
+$(OUTPUT)jvmti/libstring.o: ../lib/string.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
