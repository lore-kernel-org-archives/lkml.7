Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB4CC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64622171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="NqlfBxy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfHPUyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:54:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33059 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbfHPUyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:54:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7GKsOZm2959815
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 16 Aug 2019 13:54:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7GKsOZm2959815
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565988865;
        bh=MBqXsTPCZMlFpnORqEQDRdJ4ZEafbCuGWq816AhMHJE=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=NqlfBxy/uI3XBTqLLVR6klLmknzUj4Zh90e/Y89ZW6hl3/DCh96CLbW7QX7bgIjuP
         2JivpOP7YgQQ4rif2l6Nv4OKSE40HGWKvOb213bomw86unIuYWAR1WqSEnSv3hLg5D
         NO9PHbpNppiKvk44zMSXHe44Bc12TDdarO9VctLdHYM2WsUqjbc/J+5NgmHZSIjcSU
         YYlZiQUo+kiBbwHghuZfaYGHMwjEVwtOQ9clAbmeh6QSPw7RRPF4/XJK8nk6jE1UcL
         T7L56BqAZ5gSa0xQ9sqegy2/w2m+Pd1AywgYD6njV+dHLCHDBfy920F2aIK4vWG5V6
         iPZLKr5u2yJNQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7GKsO7K2959812;
        Fri, 16 Aug 2019 13:54:24 -0700
Date:   Fri, 16 Aug 2019 13:54:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-v16pe3sbf3wjmn152u18f649@git.kernel.org>
Cc:     fweimer@redhat.com, linux-kernel@vger.kernel.org,
        wcohen@redhat.com, tglx@linutronix.de, namhyung@kernel.org,
        mingo@kernel.org, adrian.hunter@intel.com, acme@redhat.com,
        jolsa@kernel.org, hpa@zytor.com
Reply-To: hpa@zytor.com, acme@redhat.com, jolsa@kernel.org,
          mingo@kernel.org, adrian.hunter@intel.com, namhyung@kernel.org,
          tglx@linutronix.de, wcohen@redhat.com, fweimer@redhat.com,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evswitch: Introduce OPTS_EVSWITCH() for cmd
 line processing
Git-Commit-ID: add3a719c95f0443d563889b4af255b78ba54521
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

Commit-ID:  add3a719c95f0443d563889b4af255b78ba54521
Gitweb:     https://git.kernel.org/tip/add3a719c95f0443d563889b4af255b78ba54521
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Aug 2019 11:21:21 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Aug 2019 12:25:47 -0300

perf evswitch: Introduce OPTS_EVSWITCH() for cmd line processing

All tools will want those, so provide a convenient way to get them.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-v16pe3sbf3wjmn152u18f649@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 7 +------
 tools/perf/util/evswitch.h  | 8 ++++++++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 177e4e91b199..2a5b8af80e6b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3543,12 +3543,7 @@ int cmd_script(int argc, const char **argv)
 		   "file", "file saving guest os /proc/kallsyms"),
 	OPT_STRING(0, "guestmodules", &symbol_conf.default_guest_modules,
 		   "file", "file saving guest os /proc/modules"),
-	OPT_STRING(0, "switch-on", &script.evswitch.on_name,
-		   "event", "Consider events after the ocurrence of this event"),
-	OPT_STRING(0, "switch-off", &script.evswitch.off_name,
-		   "event", "Stop considering events after the ocurrence of this event"),
-	OPT_BOOLEAN(0, "show-on-off-events", &script.evswitch.show_on_off_events,
-		    "Show the on/off switch events, used with --switch-on"),
+	OPTS_EVSWITCH(&script.evswitch),
 	OPT_END()
 	};
 	const char * const script_subcommands[] = { "record", "report", NULL };
diff --git a/tools/perf/util/evswitch.h b/tools/perf/util/evswitch.h
index 891164504080..94220d1bb479 100644
--- a/tools/perf/util/evswitch.h
+++ b/tools/perf/util/evswitch.h
@@ -16,4 +16,12 @@ struct evswitch {
 
 bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel);
 
+#define OPTS_EVSWITCH(evswitch)								  \
+	OPT_STRING(0, "switch-on", &(evswitch)->on_name,				  \
+		   "event", "Consider events after the ocurrence of this event"),	  \
+	OPT_STRING(0, "switch-off", &(evswitch)->off_name,				  \
+		   "event", "Stop considering events after the ocurrence of this event"), \
+	OPT_BOOLEAN(0, "show-on-off-events", &(evswitch)->show_on_off_events,		  \
+		    "Show the on/off switch events, used with --switch-on and --switch-off")
+
 #endif /* __PERF_EVSWITCH_H */
