Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6371C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71E52171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565986666;
	bh=1Gh0TmgB3FYxFTKVROv7Cg2Zn3w4aNYiq8s0ujqnA7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OobA9yG3ljRbuwkH5k9HMp5xTf289HGY5s0AD8ELjoLvBwBi2eA7QuNVv79HLNjC4
	 pPfp88vxHodm8r/Ld9fEyY5smdX7f+UWafBtR3DsGYLkpO6spfsWgHfvFgdNetbNY0
	 zOoQ5wol513NxDvVrjwyVsgssuI4oHu5T2/P6GRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfHPURp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:17:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbfHPURm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:17:42 -0400
Received: from quaco.ghostprotocols.net (unknown [179.182.221.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D27721721;
        Fri, 16 Aug 2019 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565986661;
        bh=1Gh0TmgB3FYxFTKVROv7Cg2Zn3w4aNYiq8s0ujqnA7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RXUNvdZyLVxChq0kCIwckOJZw42VxX92Fin0hFw9B80oK648RqIUWMFHXSN9IrjlU
         eKSqEgWrMM42qjtHoTX7PzsTZ+VIyUlSRK/2YQXP1+QEf7RSHEhsJDxPlsz7hTYH6r
         F/3I6X5ctPhMmmxlurnWNAzhLaYI7T6aDGr3j6SA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        William Cohen <wcohen@redhat.com>
Subject: [PATCH 08/17] perf evswitch: Introduce OPTS_EVSWITCH() for cmd line processing
Date:   Fri, 16 Aug 2019 17:16:44 -0300
Message-Id: <20190816201653.19332-9-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816201653.19332-1-acme@kernel.org>
References: <20190816201653.19332-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.21.0

