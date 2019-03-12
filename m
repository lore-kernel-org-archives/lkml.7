Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D26C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621E6214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552356242;
	bh=EiFQcj9TWQK9vlDg7309ztPatVuVWQbbUIzWCLP0klM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l5tuopFyQ0yHu1XKddh2FpvLBm9Osb2diCPqGaviff3ZdwvwqOa4DTk7P0k6F+0pp
	 0aOuOnubImmBQlrJV1EVxtyAJCePUR2IaWQQwQAUtw3UAdZkf+QE6K3TkzF46pIa42
	 dd1DSC9irwCjmiuFGRvGsOCbA2YMns2pMLFSCbV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbfCLCEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727214AbfCLCD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:03:56 -0400
Received: from quaco.meukeo.local (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 811FB214AE;
        Tue, 12 Mar 2019 02:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552356235;
        bh=EiFQcj9TWQK9vlDg7309ztPatVuVWQbbUIzWCLP0klM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L6YUVelU9+jeYiBisf1yi2+633iaVEcuVcSt1XEJ/62Uyx0tsCMZos82nyVDOOijG
         ZUUOtMQVbVln35v+6+/tJjfBWqcSnQXpP9DDsadYNaGXH2qDknJJU8pMf8aLds8nNt
         +tc1wFmGnsnm8AZXUGZgZ85aK+WDHzzpVTmU7bsc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 27/30] perf tools: Add some new tips describing the new options
Date:   Mon, 11 Mar 2019 23:02:01 -0300
Message-Id: <20190312020204.22092-28-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312020204.22092-1-acme@kernel.org>
References: <20190312020204.22092-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190311144502.15423-9-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/tips.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/Documentation/tips.txt b/tools/perf/Documentation/tips.txt
index 849599f39c5e..869965d629ce 100644
--- a/tools/perf/Documentation/tips.txt
+++ b/tools/perf/Documentation/tips.txt
@@ -15,6 +15,7 @@ To see callchains in a more compact form: perf report -g folded
 Show individual samples with: perf script
 Limit to show entries above 5% only: perf report --percent-limit 5
 Profiling branch (mis)predictions with: perf record -b / perf report
+To show assembler sample contexts use perf record -b / perf script -F +brstackinsn --xed
 Treat branches as callchains: perf report --branch-history
 To count events in every 1000 msec: perf stat -I 1000
 Print event counts in CSV format with: perf stat -x,
@@ -34,3 +35,9 @@ Show current config key-value pairs: perf config --list
 Show user configuration overrides: perf config --user --list
 To add Node.js USDT(User-Level Statically Defined Tracing): perf buildid-cache --add `which node`
 To report cacheline events from previous recording: perf c2c report
+To browse sample contexts use perf report --sample 10 and select in context menu
+To separate samples by time use perf report --sort time,overhead,sym
+To set sample time separation other than 100ms with --sort time use --time-quantum
+Add -I to perf report to sample register values visible in perf report context.
+To show IPC for sampling periods use perf record -e '{cycles,instructions}:S' and then browse context
+To show context switches in perf report sample context add --switch-events to perf record.
-- 
2.20.1

