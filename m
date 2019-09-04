Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E5DC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BAA23404
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rVpRcpMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfIDG0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 02:26:14 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:33045 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfIDG0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:26:13 -0400
Received: by mail-pg1-f202.google.com with SMTP id a21so12550433pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 23:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Tbk9iHA1BcIv4CnYIU8mmP8LfRBc9qlMqqjj2iAmjRM=;
        b=rVpRcpMywls/Rm6WnSUx4nLg8V3ztZoD8XZiwDNwzQ+pBlG3Dt8lGxRb+HXjSp4vB1
         e+huemO29QOZ84dq1PbhwJGO5BwlRo7cjeZFiwfKGraZF2g+nhjVLCugyeDn8ciR+8s5
         80YTsOla4s0Dqn9kPQtwgtzrUL8k5MtZxymPaB73lHHSqZyqTXMcF/kH3gxER/1qvomw
         ElWP4Iy7No2Ns/DHp2hOCqrg89DG5LISSyqjsuQac/1enLT8yusovFDWPJhFIpT+Ahax
         A2SmETEYGoJ0inQeSk6rC5HWu8mTf48Wcs0VImtA9WKvUFdViey0xBNoNzP8f8/gb1nX
         gLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Tbk9iHA1BcIv4CnYIU8mmP8LfRBc9qlMqqjj2iAmjRM=;
        b=a1OPfkFRqugds1gH70BtUL4wpDIvRmIknBhw8WYHohajLT2vsseTv6ymfpkD4yV8qF
         UUYlK9f6i73RFg1QWhrveWBPeRD0I0ox6N04TYPoAvLOdPyRgZjTlaMd/f0x7jRJdyID
         IV0ZoZ45z6KXwRlAMXMlQoMNUWz25Tq03GvWWPdLwo9SBwurSrikR/9gCni1Hz31J7IA
         zTvrQb7c1UzGKIQ7qLu+udU9pjA4TvRnaac0hYj1QYnV0wUVBFEN418fnJ+qiRyD/bqg
         bN6sbSVr1WVQslz5EmQb/VnOz9AXBgdI6jm1j6gyAap02X9fw5AJCIiOhDaDRp026RFS
         9Y/Q==
X-Gm-Message-State: APjAAAW9BJH+qgrHZ3PF9RMU6P00imYaJ5lVyifJlg9XEoo+up2sZSS+
        Kk1fWhJ8Tt1XbTGUU84J9Mu1ttc2hpea4maCEQWCyvEOdTwUC6dX9AzsIh0mNqIfXlrk4Sit+h7
        PU2TLurtX9wXcPuHlZjV5Ollsg5okP0xg4uaclqmnL31+IH/nyNZ84n5N5J+2Rlpzv9v8w2Fl
X-Google-Smtp-Source: APXvYqwREzUtZa4URF4lsqMSMCWWK3rzX0c/OfatcmGyCU1PoQuoCPxtSSeFbR9Ab6VGufHarx/lUd1xAmyx
X-Received: by 2002:a63:711c:: with SMTP id m28mr31760438pgc.396.1567578372659;
 Tue, 03 Sep 2019 23:26:12 -0700 (PDT)
Date:   Tue,  3 Sep 2019 23:26:03 -0700
Message-Id: <20190904062603.90165-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH] perf record: fix priv level with branch sampling for paranoid=2
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@elte.hu, acme@redhat.com,
        jolsa@redhat.com, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the default perf_events paranoid level is set to 2, a regular user
cannot monitor kernel level activity anymore. As such, with the following
cmdline:

$ perf record -e cycles date

The perf tool first tries cycles:uk but then falls back to cycles:u
as can be seen in the perf report --header-only output:

  cmdline : /export/hda3/tmp/perf.tip record -e cycles ls
  event : name = cycles:u, , id = { 436186, ... }

This is okay as long as there is way to learn the priv level was changed
internally by the tool.

But consider a similar example:

$ perf record -b -e cycles date
Error:
You may not have permission to collect stats.

Consider tweaking /proc/sys/kernel/perf_event_paranoid,
which controls use of the performance events system by
unprivileged users (without CAP_SYS_ADMIN).
...

Why is that treated differently given that the branch sampling inherits the
priv level of the first event in this case, i.e., cycles:u? It turns out
that the branch sampling code is more picky and also checks exclude_hv.

In the fallback path, perf record is setting exclude_kernel = 1, but it
does not change exclude_hv. This does not seem to match the restriction
imposed by paranoid = 2.

This patch fixes the problem by forcing exclude_hv = 1 in the fallback
for paranoid=2. With this in place:

$ perf record -b -e cycles date
  cmdline : /export/hda3/tmp/perf.tip record -b -e cycles ls
  event : name = cycles:u, , id = { 436847, ... }

And the command succeeds as expected.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/util/evsel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 85825384f9e8..3cbe06fdf7f7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2811,9 +2811,11 @@ bool perf_evsel__fallback(struct evsel *evsel, int err,
 		if (evsel->name)
 			free(evsel->name);
 		evsel->name = new_name;
-		scnprintf(msg, msgsize,
-"kernel.perf_event_paranoid=%d, trying to fall back to excluding kernel samples", paranoid);
+		scnprintf(msg, msgsize, "kernel.perf_event_paranoid=%d, trying "
+			  "to fall back to excluding kernel and hypervisor "
+			  " samples", paranoid);
 		evsel->core.attr.exclude_kernel = 1;
+		evsel->core.attr.exclude_hv     = 1;
 
 		return true;
 	}
-- 
2.23.0.187.g17f5b7556c-goog

