Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AE1C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D75620863
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CWLk+EqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfFQTTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:19:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34377 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFQTTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:19:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJHPAD3559731
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:17:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJHPAD3559731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560799046;
        bh=eKNWTzr+B8NGSSEjmd7ILzozmpOYeQsaHsAv0hvvn4I=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=CWLk+EqF0yl0cimkOYk4lOO2M/XaZIwC5PCPGFFIP8tQIbOkfRZBWcrFdt3N698as
         diCwCd3d6Y49kW7lvXF65Fk8vM++TWVDD0s4Pi4DGcEXagh42ASUF3zJ2zSX62j7mp
         BLhNLurTx7aBSrLA3v+lCl4y8RTfhy4/ThfsVrYWgEkgyjeej6IKRYNCIG5L82LuU+
         g37SuCG0+dFdU1GNFBcQwQ35yk+yIUxBtZjqeN3+5OYIWH77XJRMXY/pINEtQ13Hqi
         Uq8db/Pj6AucuZl0yRoPFtLWTDvJa90FANBnGoFQUp5k0xNIKlxHgQkLr9YcNkZR5U
         Ssq4Wm0a1+jNw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJHPrP3559728;
        Mon, 17 Jun 2019 12:17:25 -0700
Date:   Mon, 17 Jun 2019 12:17:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-x4i63f5kscykfok0hqim3zma@git.kernel.org>
Cc:     acme@redhat.com, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, songliubraving@fb.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mathieu.poirier@linaro.org, leo.yan@linaro.org, yhs@fb.com,
        daniel@iogearbox.net, suzuki.poulose@arm.com,
        mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, ast@kernel.org, jolsa@redhat.com,
        kafai@fb.com
Reply-To: daniel@iogearbox.net, suzuki.poulose@arm.com, leo.yan@linaro.org,
          yhs@fb.com, mathieu.poirier@linaro.org, namhyung@kernel.org,
          kafai@fb.com, adrian.hunter@intel.com, jolsa@redhat.com,
          ast@kernel.org, alexander.shishkin@linux.intel.com,
          mike.leach@linaro.org, mingo@kernel.org, acme@redhat.com,
          songliubraving@fb.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Exit when failing to build eBPF program
Git-Commit-ID: 012749caf9419f22636891259b664c6dd383e897
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

Commit-ID:  012749caf9419f22636891259b664c6dd383e897
Gitweb:     https://git.kernel.org/tip/012749caf9419f22636891259b664c6dd383e897
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Thu, 6 Jun 2019 10:38:59 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 15:49:43 -0300

perf trace: Exit when failing to build eBPF program

On my Juno board with ARM64 CPUs, perf trace command reports the eBPF
program building failure but the command will not exit and continue to
run.  If we define an eBPF event in config file, the event will be
parsed with below flow:

  perf_config()
    `> trace__config()
         `> parse_events_option()
              `> parse_events__scanner()
                   `-> parse_events_parse()
                         `> parse_events_load_bpf()
                              `> llvm__compile_bpf()

Though the low level functions return back error values when detect eBPF
building failure, but parse_events_option() returns 1 for this case and
trace__config() passes 1 to perf_config(); perf_config() doesn't treat
the returned value 1 as failure and it continues to parse other
configurations.  Thus the perf command continues to run even without
enabling eBPF event successfully.

This patch changes error handling in trace__config(), when it detects
failure it will return -1 rather than directly pass error value (1);
finally, perf_config() will directly bail out and perf will exit for
this case.

Committer notes:

Simplified the patch to just check directly the return of
parse_events_option() and it it is non-zero, change err from its initial
zero value to -1.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: Yonghong Song <yhs@fb.com>
Fixes: ac96287cae08 ("perf trace: Allow specifying a set of events to add in perfconfig")
Link: https://lkml.kernel.org/n/tip-x4i63f5kscykfok0hqim3zma@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f7e4e50bddbd..1a2a605cf068 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3703,7 +3703,12 @@ static int trace__config(const char *var, const char *value, void *arg)
 		struct option o = OPT_CALLBACK('e', "event", &trace->evlist, "event",
 					       "event selector. use 'perf list' to list available events",
 					       parse_events_option);
-		err = parse_events_option(&o, value, 0);
+		/*
+		 * We can't propagate parse_event_option() return, as it is 1
+		 * for failure while perf_config() expects -1.
+		 */
+		if (parse_events_option(&o, value, 0))
+			err = -1;
 	} else if (!strcmp(var, "trace.show_timestamp")) {
 		trace->show_tstamp = perf_config_bool(var, value);
 	} else if (!strcmp(var, "trace.show_duration")) {
