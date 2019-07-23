Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5178C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FC222387
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cGGzu4ph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392228AbfGWVvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 17:51:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56733 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbfGWVvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:51:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6NLpV9F253820
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 23 Jul 2019 14:51:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6NLpV9F253820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563918692;
        bh=1CgbBfzWEoK3oJI9gH8Yh7qkJkmMu8inz+QHn0Ty6HY=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=cGGzu4phIkk8LVMcnZXOPqIq33+iN0vnr7/8EKu0c/UrwR9oTc+HIdAFZOHA5XKEz
         50xxdWUJdOpMPPCVD2Ak0kk8b30kkWRPV9tNcr6blL6dF1nkaI1z40/DCmf+bv2opZ
         /+Yu60eQScPr8XpdpwJcDqRxAndQVREdgSbKNqZ+R/IBst8vpSWbSEUHqZxIXlztvq
         XsFL5sQolMLTQyKaMAZ6DrHzMZXmJEYm97uEv0Jbt9GlDGG13xtGPCL+hPKWNWVfe2
         IA+AH6FIwmY4InbHy/wYnSMNn67wPNyIvlHY49cDUQW+Leb74N00OtuAzaWHXJ25nD
         WzKBB7/9/6tUw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6NLpVpD253817;
        Tue, 23 Jul 2019 14:51:31 -0700
Date:   Tue, 23 Jul 2019 14:51:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-802f2jypnwqsvyavvivs8464@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        tglx@linutronix.de, acme@redhat.com, adrian.hunter@intel.com,
        hpa@zytor.com, namhyung@kernel.org, jolsa@kernel.org,
        mingo@kernel.org
Reply-To: hpa@zytor.com, adrian.hunter@intel.com, jolsa@kernel.org,
          mingo@kernel.org, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, mhiramat@kernel.org,
          acme@redhat.com, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf probe: Set pev->nargs to zero after freeing
 pev->args entries
Git-Commit-ID: df8350ed56a26f502a9636f37faf699a12ee906e
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

Commit-ID:  df8350ed56a26f502a9636f37faf699a12ee906e
Gitweb:     https://git.kernel.org/tip/df8350ed56a26f502a9636f37faf699a12ee906e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 18 Jul 2019 11:22:58 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 23 Jul 2019 09:04:25 -0300

perf probe: Set pev->nargs to zero after freeing pev->args entries

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
 
