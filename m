Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5325CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2A62053B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665342;
	bh=N81njtrv9vAbYCRQABHAUsdmEqQeMv4SFtJQ1/BU6NQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=THYTf/rB1bisbeCYnC18Us1mPVPHqCt2iaLpdGyyNRHAAkuvcjI4tnwf6kSd6WpuO
	 7UkazwQ+f3PlCMz8XV0pV34x9RupiFUFuYz09qQSdmGTxX0vZoTbQdN4lWBJ8gABhH
	 W0MmbpwKDnDneOmIWseKfDRzXzL8pkzdIO8/qCQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfJUNkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728945AbfJUNkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:40:40 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06C3B20679;
        Mon, 21 Oct 2019 13:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665239;
        bh=N81njtrv9vAbYCRQABHAUsdmEqQeMv4SFtJQ1/BU6NQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ddhPbiCbxrIvOm3r2FNUsI8cDRxkGFfidt6LG0OqlC8Mc5JpFuP63Tly8L0Ys1744
         VzRFE4CfF2dUkGLv+AbIPjQioSIZMtXEMn7udZ9cdFZBgckpJtvWfdhkHpsb1PauVW
         +NkB+p+CSYwIpKjzAV1votyJHqPlYKtv2kGizVfo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 37/57] perf trace: Honour --max-events in processing syscalls:sys_enter_*
Date:   Mon, 21 Oct 2019 10:38:14 -0300
Message-Id: <20191021133834.25998-38-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We were doing this only at the sys_exit syscall tracepoint, as for
strace-like we count the pair of sys_enter and sys_exit as one event,
but when asking specifically for a the syscalls:sys_enter_NAME
tracepoint we need to count each of those as an event.

I.e. things like:

  # perf trace --max-events=4 -e syscalls:sys_enter_lseek
     0.000 pool/2242 syscalls:sys_enter_lseek(fd: 14<anon_inode:[timerfd]>, offset: 0, whence: CUR)
     0.034 pool/2242 syscalls:sys_enter_lseek(fd: 15<anon_inode:[timerfd]>, offset: 0, whence: CUR)
     0.051 pool/2242 syscalls:sys_enter_lseek(fd: 16<anon_inode:[timerfd]>, offset: 0, whence: CUR)
  2307.900 sshd/30800 syscalls:sys_enter_lseek(fd: 3</usr/lib64/libsystemd.so.0.25.0>, offset: 9032, whence: SET)
  #

Were going on forever, since we only had sys_enter events.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-0ob1dky1a9ijlfrfhxyl40wr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0294b17ed510..1aaf7b28eec4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2727,12 +2727,6 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 			} else {
 				trace__fprintf_tp_fields(trace, evsel, sample, thread, NULL, 0);
 			}
-			++trace->nr_events_printed;
-
-			if (evsel->max_events != ULONG_MAX && ++evsel->nr_events_printed == evsel->max_events) {
-				evsel__disable(evsel);
-				evsel__close(evsel);
-			}
 		}
 	}
 
@@ -2743,6 +2737,13 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 		trace__fprintf_callchain(trace, sample);
 	else if (callchain_ret < 0)
 		pr_err("Problem processing %s callchain, skipping...\n", perf_evsel__name(evsel));
+
+	++trace->nr_events_printed;
+
+	if (evsel->max_events != ULONG_MAX && ++evsel->nr_events_printed == evsel->max_events) {
+		evsel__disable(evsel);
+		evsel__close(evsel);
+	}
 out:
 	thread__put(thread);
 	return 0;
-- 
2.21.0

