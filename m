Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EE3C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C97E229EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563912377;
	bh=JKP2JhzEnsc9bYpk6Y10mwB1u8TREd4TKCmiXyAbUAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WAUR98TYzsRHfKloHgN13NeEsooa/JJ9KHicXDB2t6FDEr6eIke0KYe2R7JuTfTsS
	 7qsNTwZJsHpRvDfK1vIRYHFonwE4i39z8i18TVqZbimi2oEo5wXOccTqlWoJwLDtDx
	 WtyPy9uG+a+ztzFfou+6kf7XlzhFyAnURwIwvv+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388736AbfGWUGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfGWUGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:06:14 -0400
Received: from quaco.ghostprotocols.net (unknown [179.182.218.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6114229EB;
        Tue, 23 Jul 2019 20:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563912373;
        bh=JKP2JhzEnsc9bYpk6Y10mwB1u8TREd4TKCmiXyAbUAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NqdfPPfs9jHgF0peju3EBcoGwUZ7L/OLndFSMM0cN0U+WzliQeJqTHxl+9/iHQHXQ
         +4sSFKJIV2uHfpk1QQFp7oQLZMnbAUy7AuazSxnnaur0wQTvtTyvNgtWQljwQWcQk5
         wD42H+CXIr7j2PUbQl1F/3sh4j+Ewt+c8Ce+5SOc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/10] perf stat: Always separate stalled cycles per insn
Date:   Tue, 23 Jul 2019 17:05:26 -0300
Message-Id: <20190723200530.14090-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190723200530.14090-1-acme@kernel.org>
References: <20190723200530.14090-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

The "stalled cycles per insn" is appended to "instructions" when the CPU
has this hardware counter directly. We should always make it a separate
line, which also aligns to the output when we hit the "if (total &&
avg)" branch.

Before:

  $ sudo perf stat --all-cpus --field-separator , --log-fd 1 -einstructions,cycles -- sleep 1
  4565048704,,instructions,64114578096,100.00,1.34,insn per cycle,,
  3396325133,,cycles,64146628546,100.00,,

After:

  $ sudo ./tools/perf/perf stat --all-cpus --field-separator , --log-fd 1 -einstructions,cycles -- sleep 1
  6721924,,instructions,24026790339,100.00,0.22,insn per cycle
  ,,,,,0.00,stalled cycles per insn
  30939953,,cycles,24025512526,100.00,,

Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Link: http://lkml.kernel.org/r/20190517221039.8975-1-xiyou.wangcong@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 656065af4971..accb1bf1cfd8 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -819,7 +819,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 					"stalled cycles per insn",
 					ratio);
 		} else if (have_frontend_stalled) {
-			print_metric(config, ctxp, NULL, NULL,
+			out->new_line(config, ctxp);
+			print_metric(config, ctxp, NULL, "%7.2f ",
 				     "stalled cycles per insn", 0);
 		}
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES)) {
-- 
2.21.0

