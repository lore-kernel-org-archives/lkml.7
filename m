Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7570ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E562196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824406;
	bh=ytoNml8auwbuRE6mRe+eZqsXumghwcOu9b/vb1nAtuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S346BrbmRoqcVRCSwu3tuuUjE+722XJNVJkYqh5KW5nMvYs78vpaHhnywJgTTAN68
	 WeXK40A9lTya+r/avGSoUBo7p81yj4g9mTwfF1FqFHqGw5G9ijs30u2FoASMq8eODD
	 gtSkeiLdEotX3O828zmIlxmaFC2aJ+C29s6nBNtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfJKUGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:06:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729129AbfJKUGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:06:43 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E02AE222BE;
        Fri, 11 Oct 2019 20:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824403;
        bh=ytoNml8auwbuRE6mRe+eZqsXumghwcOu9b/vb1nAtuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gWfTIZSFV7dXQKvQEBitUt0DEeMycuONg7mkIa+v43E8Dn7r8xDtIpSbSJJ+5Zumi
         NIOsoNt9mVzb22fAQFdOIh7ItVziuqZPgrt6F+U2XjD+7LTretCFi+9UMm9p18z6lC
         bDbpjqQsgq70VbeRegru3ejIVb8mvKoowE2byKpQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 04/69] perf trace: Make evlist__set_evsel_handler() affect just entries without a handler
Date:   Fri, 11 Oct 2019 17:04:54 -0300
Message-Id: <20191011200559.7156-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Renaming it to evlist__set_default_evsel_handler(), to better reflect
what we want to do, which is to set a default handler for events we
still haven't set a custom handler, like the ones for "msr:write_msr",
etc that are coming soon.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-e1bit7upnpmtsayh8039kfuw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bb5130d02155..ee330f50b450 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3858,12 +3858,14 @@ static int parse_pagefaults(const struct option *opt, const char *str,
 	return 0;
 }
 
-static void evlist__set_evsel_handler(struct evlist *evlist, void *handler)
+static void evlist__set_default_evsel_handler(struct evlist *evlist, void *handler)
 {
 	struct evsel *evsel;
 
-	evlist__for_each_entry(evlist, evsel)
-		evsel->handler = handler;
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->handler == NULL)
+			evsel->handler = handler;
+	}
 }
 
 static int evlist__set_syscall_tp_fields(struct evlist *evlist)
@@ -4287,7 +4289,7 @@ int cmd_trace(int argc, const char **argv)
 	}
 
 	if (trace.evlist->core.nr_entries > 0) {
-		evlist__set_evsel_handler(trace.evlist, trace__event_handler);
+		evlist__set_default_evsel_handler(trace.evlist, trace__event_handler);
 		if (evlist__set_syscall_tp_fields(trace.evlist)) {
 			perror("failed to set syscalls:* tracepoint fields");
 			goto out;
-- 
2.21.0

