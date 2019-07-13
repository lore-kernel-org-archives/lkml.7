Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234BBC742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9AB20848
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 11:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="uC5zEyNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfGMLK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 07:10:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60799 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbfGMLK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 07:10:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DB8jK73841284
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 04:08:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DB8jK73841284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563016126;
        bh=z78sEZTdWtdDJhzAlgXWC5a3IveziytmFKX+TQMy1Sw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=uC5zEyNeJP5FzV0WEyxL03z1Gf6fAGSXx9Xe09jwNa6LhCPypva+J7UGlBo1tpqsq
         GvCQxdHkmd4rQO7DvquoZRliZ6IDTAYG6QGJyCHAhuvTqZjK6PPvprlEMspQcfclmK
         /hTURvLq2DSAfAaS/MGlDEQUg1/TYmZAi5F9qVnzBwNVclGhvyWwJpDDufE3Pts/ig
         AMXAJvlopcc5YKnjytvsI2hjIc4ED6SCe99ARaIu8PyoD793TqzScMwUyUb0EMyZir
         JtxfrUu8UOvTseL7RwUD3KOr5zm/+tKusmI0F2rgN4Ykv/T6PcgAY9NATUbTsq7wvS
         86b+Zf9H3nfew==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DB8iYx3841280;
        Sat, 13 Jul 2019 04:08:44 -0700
Date:   Sat, 13 Jul 2019 04:08:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-1d481458816d9424c8a05833ce0ebe72194a350e@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, leo.yan@linaro.org, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        acme@redhat.com, suzuki.poulose@arm.com, hpa@zytor.com,
        adrian.hunter@intel.com
Reply-To: mingo@kernel.org, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, jolsa@redhat.com,
          namhyung@kernel.org, leo.yan@linaro.org,
          linux-kernel@vger.kernel.org, ak@linux.intel.com,
          acme@redhat.com, mathieu.poirier@linaro.org,
          adrian.hunter@intel.com, hpa@zytor.com, suzuki.poulose@arm.com
In-Reply-To: <20190708143937.7722-3-leo.yan@linaro.org>
References: <20190708143937.7722-3-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf intel-bts: Fix potential NULL pointer
 dereference found by the smatch tool
Git-Commit-ID: 1d481458816d9424c8a05833ce0ebe72194a350e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1d481458816d9424c8a05833ce0ebe72194a350e
Gitweb:     https://git.kernel.org/tip/1d481458816d9424c8a05833ce0ebe72194a350e
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Mon, 8 Jul 2019 22:39:35 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 10:13:28 -0300

perf intel-bts: Fix potential NULL pointer dereference found by the smatch tool

Based on the following report from Smatch, fix the potential NULL
pointer dereference check.

  tools/perf/util/intel-bts.c:898
  intel_bts_process_auxtrace_info() error: we previously assumed
  'session->itrace_synth_opts' could be null (see line 894)

  tools/perf/util/intel-bts.c:899
  intel_bts_process_auxtrace_info() warn: variable dereferenced before
  check 'session->itrace_synth_opts' (see line 898)

  tools/perf/util/intel-bts.c
  894         if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
  895                 bts->synth_opts = *session->itrace_synth_opts;
  896         } else {
  897                 itrace_synth_opts__set_default(&bts->synth_opts,
  898                                 session->itrace_synth_opts->default_no_sample);
                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^
  899                 if (session->itrace_synth_opts)
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^
  900                         bts->synth_opts.thread_stack =
  901                                 session->itrace_synth_opts->thread_stack;
  902         }

'session->itrace_synth_opts' is impossible to be a NULL pointer in
intel_bts_process_auxtrace_info(), thus this patch removes the NULL test
for 'session->itrace_synth_opts'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190708143937.7722-3-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-bts.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 5a21bcdb8ef7..5560e95afdda 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -891,13 +891,12 @@ int intel_bts_process_auxtrace_info(union perf_event *event,
 	if (dump_trace)
 		return 0;
 
-	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
+	if (session->itrace_synth_opts->set) {
 		bts->synth_opts = *session->itrace_synth_opts;
 	} else {
 		itrace_synth_opts__set_default(&bts->synth_opts,
 				session->itrace_synth_opts->default_no_sample);
-		if (session->itrace_synth_opts)
-			bts->synth_opts.thread_stack =
+		bts->synth_opts.thread_stack =
 				session->itrace_synth_opts->thread_stack;
 	}
 
