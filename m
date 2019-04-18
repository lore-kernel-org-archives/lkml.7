Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332D3C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038532083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555596287;
	bh=rXg9MbYv65BGD10TSLe+qpV5NkwF6YeCRYTlHvjXgx0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rlN7dbpp5zw2IaCdsRFbMYz1OPTzSi8U+FDm7WhQcuSKiweU81J4SKdtBLoo1hL8c
	 IA63x3qiytoCu6pF1TjzYj8i8YbaEeEAAqLBkr+dJT5EfkGm7wWOcUspsN3RUiNeeF
	 Giy2QAKuSu7MP2/+++8WSEc3Rlnv+isOuibt64jE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389180AbfDROEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:04:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388685AbfDROEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:04:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8F80307DA35;
        Thu, 18 Apr 2019 14:04:39 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 348E81001DC0;
        Thu, 18 Apr 2019 14:04:38 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH] perf trace: Fix events draining
Date:   Thu, 18 Apr 2019 16:04:37 +0200
Message-Id: <20190418140437.16986-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 18 Apr 2019 14:04:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event handler has currently events->disable check,
that prevents processing in case we disable the event.

It was used to bypass event display when we reach the
configured maximum via --max-events or 'nr' term. But
it collides with draining, which disables events and
processes whatever left in the buffer.

  # cat ex.c
  int main(void)
  {
          return 0;
  }

  # perf probe -x  ./ex main
  Added new event:
    probe_ex:main        (on main in /home/jolsa/kernel/linux-perf/tools/perf/ex)

  You can now use it in all perf tools, such as:

          perf record -e probe_ex:main -aR sleep 1

Before:
  # perf trace -e probe_ex:main ./ex
  #

After:
  # perf trace -e probe_ex:main ./ex
     0.000 ex/16341 probe_ex:main:(401106)
  #

Checking on nr_events_printed value instead.

Fixes: a9c5e6c1e9bf ("perf trace: Introduce per-event maximum number of events property")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f5b3a1e9c1dd..729d3b82558b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2251,7 +2251,7 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 	 * from the ring buffer that we should discard, since the max events
 	 * have already been considered/printed.
 	 */
-	if (evsel->disabled)
+	if (evsel->nr_events_printed == evsel->max_events)
 		return 0;
 
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
-- 
2.20.1

