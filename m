Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43314CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191BE2166E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665278;
	bh=CpSOuczRpfLZMlTVrUjM3wVbKg2PUbjfBDwSMSBeGag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=slZc66Oewpf85f+P35NjDEPEgpCvg68M1O/6JLEGu1SDaBeWotJP9fh/RCxX1FAo4
	 FCm18kuFuWoMF8l0CsLl6gStp2Xgk/HCngAcoVVG5Pq9yMa9WdQn9k3fi9G0hp3Xtr
	 CJ/CQHeV/1/07tPC8qVDFs4n2Fnl4JLjlujVM3/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbfJUNlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:41:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729069AbfJUNlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:41:13 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B07B2173B;
        Mon, 21 Oct 2019 13:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665273;
        bh=CpSOuczRpfLZMlTVrUjM3wVbKg2PUbjfBDwSMSBeGag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NZGKhPoi+p0PTYLDsETqTUHLY49aMCYWzmi65hsu6Isho+1lj2eLjYVtjNbqUoFLm
         W5ZFBWYEIa0WukUu5Xkvc1jWYl+0IIm9vXkVxlaeZO9z+cw5QGx14HS8Nb03jVKdwZ
         oirX+0a9sy7xAgQGcMv5rd7mpDl4ejYC7FsyEfGA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 46/57] libperf: Link static tests with libapi.a
Date:   Mon, 21 Oct 2019 10:38:23 -0300
Message-Id: <20191021133834.25998-47-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Both static and dynamic tests needs to link with libapi.a, because it's
using its functions. Also include path for libapi includes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20191017105918.20873-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Makefile       | 1 +
 tools/perf/lib/tests/Makefile | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
index 0889c9c3ec19..0f233638ef1f 100644
--- a/tools/perf/lib/Makefile
+++ b/tools/perf/lib/Makefile
@@ -107,6 +107,7 @@ else
 endif
 
 LIBAPI = $(API_PATH)libapi.a
+export LIBAPI
 
 $(LIBAPI): FORCE
 	$(Q)$(MAKE) -C $(LIB_DIR) O=$(OUTPUT) $(OUTPUT)libapi.a
diff --git a/tools/perf/lib/tests/Makefile b/tools/perf/lib/tests/Makefile
index 1ee4e9ba848b..a43cd08c5c03 100644
--- a/tools/perf/lib/tests/Makefile
+++ b/tools/perf/lib/tests/Makefile
@@ -16,13 +16,13 @@ all:
 
 include $(srctree)/tools/scripts/Makefile.include
 
-INCLUDE = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include
+INCLUDE = -I$(srctree)/tools/perf/lib/include -I$(srctree)/tools/include -I$(srctree)/tools/lib
 
 $(TESTS_A): FORCE
-	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -o $@ $(subst -a,.c,$@) ../libperf.a
+	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -o $@ $(subst -a,.c,$@) ../libperf.a $(LIBAPI)
 
 $(TESTS_SO): FORCE
-	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -L.. -o $@ $(subst -so,.c,$@) -lperf
+	$(QUIET_LINK)$(CC) $(INCLUDE) $(CFLAGS) -L.. -o $@ $(subst -so,.c,$@) $(LIBAPI) -lperf
 
 all: $(TESTS_A) $(TESTS_SO)
 
-- 
2.21.0

