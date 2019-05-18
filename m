Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26788C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA4720872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BqTzCnVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbfERJ3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:29:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34107 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJ3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:29:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9THIS1741746
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:29:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9THIS1741746
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558171759;
        bh=7ZF4OCPHNoRrniJ1Jk5lG5efPOZ9p+rfnoklSE0VTuI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=BqTzCnVY8PM17vQ6YsBP7WmM8s5J7CHA7A1PlfONMjhCFu9nBlAbmB+zqGTdSwZSt
         M8C/aCkxAvqUWjwWn9a5Bd5TO5K6IYd6525Kqjp5ntiYcvSG9dp2YZXenq4a0LfwDz
         MumEnONRJXtialTUnxtpOI3OqWejR9CsQIik6kj8QNhURzL/zrEQKGpAjOSmKT8/uh
         Y2QcmXgp7lgOYWXGLeqVljd77zMCe/uZvq8BzXoLymxFf7qvLF8L+9Z48a7U+GpxA7
         59c0UxP0PtmInDuagXLJePtsL0As+trb+qzDZGNxgH4e0AlW2/+pDEUTaZiEo1xdhk
         AMQK3lBx696nA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9THD51741743;
        Sat, 18 May 2019 02:29:17 -0700
Date:   Sat, 18 May 2019 02:29:17 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Florian Fainelli <tipbot@zytor.com>
Message-ID: <tip-93fe8f1e11042e6cdf6f36f4e8ac111c7b818fc7@git.kernel.org>
Cc:     seanvk.dev@oregontracks.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        f.fainelli@gmail.com, will.deacon@arm.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        ganapatrao.kulkarni@cavium.com, mark.rutland@arm.com,
        john.garry@huawei.com, jolsa@redhat.com, acme@redhat.com,
        catalin.marinas@arm.com, peterz@infradead.org
Reply-To: tglx@linutronix.de, ganapatrao.kulkarni@cavium.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          seanvk.dev@oregontracks.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, namhyung@kernel.org,
          f.fainelli@gmail.com, will.deacon@arm.com, jolsa@redhat.com,
          acme@redhat.com, catalin.marinas@arm.com, peterz@infradead.org,
          mark.rutland@arm.com, john.garry@huawei.com
In-Reply-To: <20190513202522.9050-3-f.fainelli@gmail.com>
References: <20190513202522.9050-3-f.fainelli@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events arm64: Map Brahma-B53 CPUID to
 cortex-a53 events
Git-Commit-ID: 93fe8f1e11042e6cdf6f36f4e8ac111c7b818fc7
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

Commit-ID:  93fe8f1e11042e6cdf6f36f4e8ac111c7b818fc7
Gitweb:     https://git.kernel.org/tip/93fe8f1e11042e6cdf6f36f4e8ac111c7b818fc7
Author:     Florian Fainelli <f.fainelli@gmail.com>
AuthorDate: Mon, 13 May 2019 13:25:21 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:49 -0300

perf vendor events arm64: Map Brahma-B53 CPUID to cortex-a53 events

Broadcom's Brahma-B53 CPUs support the same type of events that the
Cortex-A53 supports, recognize its CPUID and map it to the cortex-a53
events.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sean V Kelley <seanvk.dev@oregontracks.org>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org (moderated list
Link: http://lkml.kernel.org/r/20190513202522.9050-3-f.fainelli@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/arm64/mapfile.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index da5ff2204bf6..013155f1eb58 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -13,6 +13,7 @@
 #
 #Family-model,Version,Filename,EventType
 0x00000000410fd030,v1,arm/cortex-a53,core
+0x00000000420f1000,v1,arm/cortex-a53,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000480fd010,v1,hisilicon/hip08,core
