Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072DCC48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D619721537
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561138754;
	bh=7eMeE7dt+M7EOEz6Yd2aF+eYztz13iKanKtWGcn0EWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vKbs1k1mP7iaxXjuC1Ksmg1ppZMY6eZ5t1rfxHDU0PPc6W8btjwDacu3qMM3E1Qlz
	 8bBHwN1QtsCy8mGuF+fQI5brS57UMJgt7J1b9fSagPBMPr2f0jgCk035oFdR4m8cAI
	 qHPxsEjJKANpjgDGUGm1V+speV7CaQJF4c0DgCNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfFURjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfFURjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:39:13 -0400
Received: from quaco.ghostprotocols.net (187-26-104-93.3g.claro.net.br [187.26.104.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34FB62083B;
        Fri, 21 Jun 2019 17:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561138752;
        bh=7eMeE7dt+M7EOEz6Yd2aF+eYztz13iKanKtWGcn0EWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mjgnbhni5LDpqy51b8kC3P2uXPtEqZma/r1C4+yUJ4kEeMU5m6xF89vRAIfjwxwND
         MuSPCDWOdndHPm39Dfzn7GWYnrLVt1tzGAAID467YjZyQBPQ6rV1CIBQurv9reJ37b
         sZyhZn//nwnJ+DpId1L1x1aT5C1sGU/dd3yZ7eq8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/25] perf tests arm64: Compile tests unconditionally
Date:   Fri, 21 Jun 2019 14:38:07 -0300
Message-Id: <20190621173831.13780-2-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

In order to subsequently add more tests for the arm64 architecture we
compile the tests target for arm64 systematically.

Further explanation provided by Mark Rutland:

Given prior questions regarding this commit, it's probably worth
spelling things out more explicitly, e.g.

  Currently we only build the arm64/tests directory if
  CONFIG_DWARF_UNWIND is selected, which is fine as the only test we
  have is arm64/tests/dwarf-unwind.o.

  So that we can add more tests to the test directory, let's
  unconditionally build the directory, but conditionally build
  dwarf-unwind.o depending on CONFIG_DWARF_UNWIND.

  There should be no functional change as a result of this patch.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190611125315.18736-2-raphael.gault@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/Build       | 2 +-
 tools/perf/arch/arm64/tests/Build | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm64/Build b/tools/perf/arch/arm64/Build
index 36222e64bbf7..a7dd46a5b678 100644
--- a/tools/perf/arch/arm64/Build
+++ b/tools/perf/arch/arm64/Build
@@ -1,2 +1,2 @@
 perf-y += util/
-perf-$(CONFIG_DWARF_UNWIND) += tests/
+perf-y += tests/
diff --git a/tools/perf/arch/arm64/tests/Build b/tools/perf/arch/arm64/tests/Build
index 41707fea74b3..a61c06bdb757 100644
--- a/tools/perf/arch/arm64/tests/Build
+++ b/tools/perf/arch/arm64/tests/Build
@@ -1,4 +1,4 @@
 perf-y += regs_load.o
-perf-y += dwarf-unwind.o
+perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
 perf-y += arch-tests.o
-- 
2.20.1

