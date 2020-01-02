Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ACEC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DDA21D7D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004554;
	bh=zeND0bhsXnQw2ggEGi50YY6UBDPcfM1Kq7O6wHhIgBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N75fzlG5u6KSQsi3kUblDwPzlA+kFyn4LCrnDLdBrRsIgcEvFgjFOj4PYzxkm5QBc
	 kijYgt1V544RP2UcZHgtdmXNrSZiDBgFpjUxtvUmTDlpAz44/CNB0wgMTba8nN010L
	 M64o5Wh9e1rwG+qFNAWHHT0wLaSW1XoGVV8K6YVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbgABWfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:35:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730855AbgABWfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:35:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1425E22314;
        Thu,  2 Jan 2020 22:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004547;
        bh=zeND0bhsXnQw2ggEGi50YY6UBDPcfM1Kq7O6wHhIgBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AUKlEfQ3FiMDcouqA7HlMLZUkeAq+UgAEZC4RhmLamUT57UEQuuxwC8BzxnYaR5K5
         gkCJrEkpgooERZyADJRsGtMpIe+EAXVs51iiWUgtfntOIdrPIYEI4kb7/Hv4wxqA0R
         MYgfttpgE8TYQrwZ5FlvcwejUwrldzHGf8miuLQw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 027/137] perf report: Add warning when libunwind not compiled in
Date:   Thu,  2 Jan 2020 23:06:40 +0100
Message-Id: <20200102220550.276428979@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.618583146@linuxfoundation.org>
References: <20200102220546.618583146@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

[ Upstream commit 800d3f561659b5436f8c57e7c26dd1f6928b5615 ]

We received a user report that call-graph DWARF mode was enabled in
'perf record' but 'perf report' didn't unwind the callstack correctly.
The reason was, libunwind was not compiled in.

We can use 'perf -vv' to check the compiled libraries but it would be
valuable to report a warning to user directly (especially valuable for
a perf newbie).

The warning is:

Warning:
Please install libunwind development packages during the perf build.

Both TUI and stdio are supported.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191011022122.26369-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-report.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index f256fac1e722..0f7ebac1846b 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -285,6 +285,13 @@ static int report__setup_sample_type(struct report *rep)
 				PERF_SAMPLE_BRANCH_ANY))
 		rep->nonany_branch_mode = true;
 
+#ifndef HAVE_LIBUNWIND_SUPPORT
+	if (dwarf_callchain_users) {
+		ui__warning("Please install libunwind development packages "
+			    "during the perf build.\n");
+	}
+#endif
+
 	return 0;
 }
 
-- 
2.20.1



