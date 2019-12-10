Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB558C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2FA20828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576014231;
	bh=wKOd01o8DcVuznw/5/vpnLO/6bw6KJmWtcssu6apU6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IuTUbTt2msD+jdfBaUJ2TO5Jpp16xefFrZ12INbHLxz2sABMcyWcozkDJu5LBx2OM
	 2vfpszJqVpc5cOH8tFzY8JNRgvsXNZwQkMAhG12ZGd9iyaFgWP9TSFTfsUceBx7PNG
	 g3h0igXO7CPfzHJ+wZZQpzulQ/0251urdAhW80mU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfLJVnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:43:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729743AbfLJVdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:33:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C53722467A;
        Tue, 10 Dec 2019 21:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013611;
        bh=wKOd01o8DcVuznw/5/vpnLO/6bw6KJmWtcssu6apU6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=efarRiWNES0qURihqQslwEGfxZKYU2fmTJWV7SfV3Bo9nTCKLUAuEjYpU8uODznaP
         9CvpUVVHzjU8bS4Hh2Dnwhad3eVQOAoRqbwgldbHLOHJycXHn2uPR9x4amPJY1idlO
         clKEYZ3Le/KyUtY1aR7o0VbJpUY2ZJ6rQ0zg9DKY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 057/177] perf report: Add warning when libunwind not compiled in
Date:   Tue, 10 Dec 2019 16:30:21 -0500
Message-Id: <20191210213221.11921-57-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210213221.11921-1-sashal@kernel.org>
References: <20191210213221.11921-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index b2188e623e229..2f94f7ad65bdc 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -383,6 +383,13 @@ static int report__setup_sample_type(struct report *rep)
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

