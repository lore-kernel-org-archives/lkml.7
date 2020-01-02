Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7875C3276E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2E421835
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004102;
	bh=mL1vVokoRK2OusLF3dXIGjDuok9LNKwcG8cxTvnCtDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hXBQ8ALEO/mPvmwfw/KLXOYBVQguV99DtPGD3NoQ7WARhidL/bEvVaqiP9rPrz8zx
	 m8nvVuKgAoywrx2bL8XoY1cV7jn1FoyB47hW5JVRJPIxsSvavr+cHAldzX8Sg7Nfar
	 CWK0iWFSBjGK6xZE64u3ohW/6V7Gbzv3DjhWSpxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgABW2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:28:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:57712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729881AbgABW2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:28:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40C9420866;
        Thu,  2 Jan 2020 22:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004093;
        bh=mL1vVokoRK2OusLF3dXIGjDuok9LNKwcG8cxTvnCtDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vybmR7kqf4fKoEgxdBa7QhjiQdXoFslDlPHyJAFvJXyVDs+TAIhI+1ukU5bWanv9C
         3lgTNiv7+Y2U1w9/mUpp67LYZYrFytopMmtIy6g4PMnBSZtJnw/aj9FeLN6U3IipyW
         kYAIqwHC7q0ssvIbRFpYrfIr5qVlHEC+pYwOYeew=
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
Subject: [PATCH 4.9 034/171] perf report: Add warning when libunwind not compiled in
Date:   Thu,  2 Jan 2020 23:06:05 +0100
Message-Id: <20200102220551.746426321@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
References: <20200102220546.960200039@linuxfoundation.org>
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
index 6e88460cd13d..33ff5c843346 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -292,6 +292,13 @@ static int report__setup_sample_type(struct report *rep)
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



