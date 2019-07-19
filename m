Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F89C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3128121849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510513;
	bh=zyptBL22BQzfu1k4kBA3ufXKiq2YIYNyjbNz7wVX55g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mzaT/fPVeVqHBlzqyEXhPR79mIe78HxyVZ4VQ3p4woHiHSb0ucJv/GCKIJ6o0NjG/
	 kCnEeC/DKz+SATu/h33aTSpV8koJyHPuQ0XfDOLrQ/9bKJUHvP5fJeQ0MQv5nLv2wZ
	 lZJLg/1RY72bIQxJNsAgmnk7NMJ8huxHSvTAxaXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbfGSEG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732051AbfGSEGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:06:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5904218A3;
        Fri, 19 Jul 2019 04:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509174;
        bh=zyptBL22BQzfu1k4kBA3ufXKiq2YIYNyjbNz7wVX55g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JvHS+c8iazP0/arI3kpdCZogEN+Rp8MJtanrQ8vJlHrSFq7CS2temewFUq7V5EI7w
         scj6BcRGTNXs7E59woUxUHqSL/6s03VDysGjOeF8Nhd3QYbWluqkfFpYrOnLzY4KSN
         IQw4e29iMjg3fLFaQoac+yQHpzyNJLWQZDlppyNU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 106/141] perf intel-bts: Fix potential NULL pointer dereference found by the smatch tool
Date:   Fri, 19 Jul 2019 00:02:11 -0400
Message-Id: <20190719040246.15945-106-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

[ Upstream commit 1d481458816d9424c8a05833ce0ebe72194a350e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/intel-bts.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 47025bc727e1..7afcc462f9e7 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -900,13 +900,12 @@ int intel_bts_process_auxtrace_info(union perf_event *event,
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
 
-- 
2.20.1

