Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EC4C4CECD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0D62184C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989615;
	bh=qqjkylDNCgNRjPDZ7Fc9Nk1ZIMOoJrCjVhb+noxnrQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oppfPpBI/V2A+UV0Ejjnb1mvMwWsECcvM5R67XfgYmfbXSG1L5CFF8kPvaiePLwre
	 e4vvvJdlgD38sSpL26VsCodVUsZ2a25On5zARhOO5S89FcO+C27RBDJp0D2uijVjBo
	 kFcxGECDBEdf84T7tA6U91B3RhDuhGzTXUWCI3SI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389406AbfITO0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:26:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388814AbfITOZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:25:55 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3225A2086A;
        Fri, 20 Sep 2019 14:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989554;
        bh=qqjkylDNCgNRjPDZ7Fc9Nk1ZIMOoJrCjVhb+noxnrQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0LA9v0vaAQ6ypW1zpbAvU3XIUp680N4obngagLytMV87j5r9DH8OiU5/Qk77/R0IB
         Rhzodu8VXQFKhn8c6P+oRrIWO85iPxg3t5e1wvvdsE6X8O+viuokyUFa0LfbGEOPeH
         C979sxnhf3Nw9nP300SOgRrLOwOHlSAW64jMPR2E=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 01/31] perf python: Add missing python/perf.so dependency for libperf
Date:   Fri, 20 Sep 2019 11:25:12 -0300
Message-Id: <20190920142542.12047-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The python/perf.so compilation needs libperf ready, otherwise it fails:

  $ make python/perf.so JOBS=1
    BUILD:   Doing 'make -j1' parallel build
    GEN      python/perf.so
  gcc: error: /home/jolsa/kernel/linux-perf/tools/perf/lib/libperf.a: No such file or directory

Fixing this with by adding libperf dependency.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190901124822.10132-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f9807d8c005b..2ccc12f3730b 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -567,7 +567,7 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 # Create python binding output directory if not already present
 _dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
 
-$(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBTRACEEVENT_DYNAMIC_LIST)
+$(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBTRACEEVENT_DYNAMIC_LIST) $(LIBPERF)
 	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
         CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS) $(LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS)' \
 	  $(PYTHON_WORD) util/setup.py \
-- 
2.21.0

