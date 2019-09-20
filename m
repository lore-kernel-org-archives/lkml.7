Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA56C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B7C207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989781;
	bh=g/uEh/2zZmM3i0kN5I9jxRL0l/wRQEFgOClyigDz634=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sySje7pA3XSrzJVDtp9t3ax5C2nMfuyjSMgydVjhL8NP22Qb0cEK2NIPCiknuQb1T
	 VEBmVBGiKQFhjSYJLT/D4iP3+X/rqqIbH7fYC6Kt6YmwJ0TGK9h7B4zm/rRZvuMb2w
	 ioHFAlNkk5Tk+Y3m+Xkm5o7LzGyAc82Er6LYJGrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390481AbfITO3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:29:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfITO0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:26:07 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62D662086A;
        Fri, 20 Sep 2019 14:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989567;
        bh=g/uEh/2zZmM3i0kN5I9jxRL0l/wRQEFgOClyigDz634=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPRzLS93JgI409tfZhO3bPJ3A1uZo9mzb9ucXn9ZlnCB8cz6blLAmJlr1fW8ngMhd
         Y+jYso+f2r5xlRel4olefHYRdioUyg1NobhRxT1SIerKk+TXZLNeZk+18QXooG8AZg
         jcodSa+4LmEmgzS5TeKv/KsnVz753V0UJ2iSwGdQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>,
        Sergey Melnikov <melnikov.sergey.v@gmail.com>
Subject: [PATCH 05/31] perf jvmti: Link against tools/lib/string.o to have weak strlcpy()
Date:   Fri, 20 Sep 2019 11:25:16 -0300
Message-Id: <20190920142542.12047-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 tools/perf/jvmti/Build | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/jvmti/Build b/tools/perf/jvmti/Build
index eaeb8cb5379b..1e148bbdf820 100644
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
-- 
2.21.0

