Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73833C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DD9218F0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TKn1rR+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392240AbfGWVwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 17:52:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60111 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbfGWVwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:52:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6NLqHlX253894
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 23 Jul 2019 14:52:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6NLqHlX253894
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563918738;
        bh=5bytH8d/oNFtpCRm+TZ+u9cBajMIZ+++wdQGf2uJ0j8=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=TKn1rR+PrZ7+I6Yrr18eIYWEX32tHnT9XqONqGrTMyM1difCKu2PeYjvzMCt63Xxh
         1ZOdT9GKruLgdvSBFdiRILntHFpt3K0cgmh/fFQkWScNVN49mA0qNqxvJc3pLjzKZD
         W1f5iNw0a/M25Ure2H6wx350gSkD7KBaow25B+zM4EpzBzVPQqnT7+FRgirS26C2R3
         DP6ieypqBua7j1rl8Rcpq0VWjsFLObzVV3Z6Tk8UfiSO3PnOMlV3j5KycDRWHCjQrT
         ypw0JEjV32GmPqVf7f2uCgzjODR3/HoPbbnk0+awW9NyDl/NVklMEyH73yDytC7mZV
         9FhtOZWjT//HA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6NLqFFi253891;
        Tue, 23 Jul 2019 14:52:15 -0700
Date:   Tue, 23 Jul 2019 14:52:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-x8qgma4g813z96dvtw9w219q@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, mingo@kernel.org, acme@redhat.com,
        jolsa@kernel.org, mhiramat@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, acme@redhat.com, mingo@kernel.org,
          jolsa@kernel.org, mhiramat@kernel.org, tglx@linutronix.de,
          namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf probe: Avoid calling freeing routine
 multiple times for same pointer
Git-Commit-ID: d95daf5accf4a72005daa13fbb1d1bd8709f2861
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

Commit-ID:  d95daf5accf4a72005daa13fbb1d1bd8709f2861
Gitweb:     https://git.kernel.org/tip/d95daf5accf4a72005daa13fbb1d1bd8709f2861
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 18 Jul 2019 11:28:37 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 23 Jul 2019 09:04:41 -0300

perf probe: Avoid calling freeing routine multiple times for same pointer

When perf_add_probe_events() we call cleanup_perf_probe_events() for the
pev pointer it receives, then, as part of handling this failure the main
'perf probe' goes on and calls cleanup_params() and that will again call
cleanup_perf_probe_events()for the same pointer, so just set nevents to
zero when handling the failure of perf_add_probe_events() to avoid the
double free.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-x8qgma4g813z96dvtw9w219q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-probe.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 6418782951a4..3d0ffd41fb55 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -698,6 +698,16 @@ __cmd_probe(int argc, const char **argv)
 
 		ret = perf_add_probe_events(params.events, params.nevents);
 		if (ret < 0) {
+
+			/*
+			 * When perf_add_probe_events() fails it calls
+			 * cleanup_perf_probe_events(pevs, npevs), i.e.
+			 * cleanup_perf_probe_events(params.events, params.nevents), which
+			 * will call clear_perf_probe_event(), so set nevents to zero
+			 * to avoid cleanup_params() to call clear_perf_probe_event() again
+			 * on the same pevs.
+			 */
+			params.nevents = 0;
 			pr_err_with_code("  Error: Failed to add events.", ret);
 			return ret;
 		}
