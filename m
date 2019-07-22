Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF09C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5838C21903
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817374;
	bh=BY5qLLhXbHaOpnN4vy7dPRKfNlb0SY89m8uSlsUQNac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CSxRxtkzET96vJZlCTu0NsCRzEOKq/qmKLArmWAWUOVvdFMsiY9Vug2HMVR99ZMd/
	 261ZKqfGKPB/4CxEAeKKeVQcD4cV2IMl7Iag7aajEf4TJkPDGEwcDJEWcBqMcS1iz+
	 um9glw2A66A8Avcy5Qo1V4ECqAjYt5jaAmqzzPD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbfGVRmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:42:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfGVRmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:42:50 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F9B021955;
        Mon, 22 Jul 2019 17:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817370;
        bh=BY5qLLhXbHaOpnN4vy7dPRKfNlb0SY89m8uSlsUQNac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=idP/J+jO8WAjqD0wf1MnGtDdVzPzKZwQxrlENO42QFHiPl0HaPV3qdaGDup3ceLBY
         Xj2aOl1mz1InMQoodhozzY0Yfu42vKbnle7NrO+nXfZ4zV55ybdOj4eBjTffF5LYtB
         VeoCCuHAS11LgrVF3dGLs4WVs0wqeFYj+LLltR74=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 35/37] perf probe: Set pev->nargs to zero after freeing pev->args entries
Date:   Mon, 22 Jul 2019 14:38:37 -0300
Message-Id: <20190722173839.22898-36-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that, when perf_add_probe_events() fails, like in:

  # perf probe icmp_rcv:64 "type=icmph->type"
  Failed to find 'icmph' in this function.
    Error: Failed to add events.
  Segmentation fault (core dumped)
  #

We don't segfault.

clear_perf_probe_event() was zeroing the whole pev, and since the switch
to zfree() for the members in the pev, that memset() was removed, which
left nargs with its original value, in the above case 1.

With the memset the same pev could be passed to clear_perf_probe_event()
multiple times, since all it would have would be zeroes, and free()
accepts zero, the loop would not happen and we would just memset it
again to zeroes.

Without it we got that segfault, so zero nargs to keep it like it was,
next cset will avoid calling clear_perf_probe_event() for the same pevs
in case of failure.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: d8f9da240495 ("perf tools: Use zfree() where applicable")
Link: https://lkml.kernel.org/n/tip-802f2jypnwqsvyavvivs8464@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 0c3b55d0617d..4acd3457d39d 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2219,6 +2219,7 @@ void clear_perf_probe_event(struct perf_probe_event *pev)
 			field = next;
 		}
 	}
+	pev->nargs = 0;
 	zfree(&pev->args);
 }
 
-- 
2.21.0

