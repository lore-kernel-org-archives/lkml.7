Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A75FC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B6A2253C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559137122;
	bh=r+vEbdNJKs3mSy6G5eVzNm4Ll2YSveQDwNrfCgP0WnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1bibZOO36NjdBFA64KAvjqFN3sgFTcnx6F/kIfPN9lXFY3T1LEnimzG4FldO0e0dX
	 33hEoOT2E8p/tA7/U98x8liT73ny4Yak2vsW7KOME4DSQYtiInNuTq+TWcoW4cuKmV
	 PBk+f6B3lQNPISNpHtGHR5DsOlewrlKyRzfcUp7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfE2Nil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbfE2Nik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:38:40 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C43E12238C;
        Wed, 29 May 2019 13:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559137119;
        bh=r+vEbdNJKs3mSy6G5eVzNm4Ll2YSveQDwNrfCgP0WnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JjH+PdVQ6QWx4jXmyUrBZnlTLWkQ+7HZQ1t/3YT2NX/ra85TAldcW5WQQtRMhSSHZ
         5DuW0ysb7rs5K7FChc3FG+3SEuKGfhY0VzUtuTtWPwFQgmwUIY2rxlDQqrJyCOtzYh
         3Rcxe0JYjgDGYd0WfrjzpjJgmTUDstq94QYtgb3g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH 29/41] perf script: Remove superfluous BPF event titles
Date:   Wed, 29 May 2019 10:35:53 -0300
Message-Id: <20190529133605.21118-30-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no need to display "ksymbol event with" text for the
PERF_RECORD_KSYMBOL event and "bpf event with" test for the
PERF_RECORD_BPF_EVENT event.

Remove it so it also goes along with other side-band events display.

Before:

  # perf script --show-bpf-events
  ...
  swapper     0 [000]     0.000000: PERF_RECORD_KSYMBOL ksymbol event with addr ffffffffc0ef971d len 229 type 1 flags 0x0 name bpf_prog_2a142ef67aaad174
  swapper     0 [000]     0.000000: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 36

After:

  # perf script --show-bpf-events
  ...
  swapper     0 [000]     0.000000: PERF_RECORD_KSYMBOL addr ffffffffc0ef971d len 229 type 1 flags 0x0 name bpf_prog_2a142ef67aaad174
  swapper     0 [000]     0.000000: PERF_RECORD_BPF_EVENT type 1, flags 0, id 36

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190508132010.14512-12-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index d1ad6c419724..c9c6857360e4 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -1486,7 +1486,7 @@ static size_t perf_event__fprintf_lost(union perf_event *event, FILE *fp)
 
 size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp)
 {
-	return fprintf(fp, " ksymbol event with addr %" PRIx64 " len %u type %u flags 0x%x name %s\n",
+	return fprintf(fp, " addr %" PRIx64 " len %u type %u flags 0x%x name %s\n",
 		       event->ksymbol_event.addr, event->ksymbol_event.len,
 		       event->ksymbol_event.ksym_type,
 		       event->ksymbol_event.flags, event->ksymbol_event.name);
@@ -1494,7 +1494,7 @@ size_t perf_event__fprintf_ksymbol(union perf_event *event, FILE *fp)
 
 size_t perf_event__fprintf_bpf_event(union perf_event *event, FILE *fp)
 {
-	return fprintf(fp, " bpf event with type %u, flags %u, id %u\n",
+	return fprintf(fp, " type %u, flags %u, id %u\n",
 		       event->bpf_event.type, event->bpf_event.flags,
 		       event->bpf_event.id);
 }
-- 
2.20.1

