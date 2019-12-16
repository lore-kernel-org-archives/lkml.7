Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DF6C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE5724650
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 20:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576529298;
	bh=jfxuM7EDEBwTryE1SB6k15JHMWELbwmkEP+82fa02Zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tihRGPthA98nQOzDNbBsLwVm9hKof6Nk3HvZsoSJQy3Z0PinD1s0IftAqxbCWl4tS
	 FXhYxxLMOPctgh2BWTPABaUkYiMxZVwEDZbueJ905EDqbxkb4iQIbirBnKo5l/Yi22
	 OhiIo0OVa8c5JJsV2+t8dWI7VF8wRtJ8EM4pTcOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfLPUsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 15:48:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbfLPUsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 15:48:15 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF389218AC;
        Mon, 16 Dec 2019 20:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576529294;
        bh=jfxuM7EDEBwTryE1SB6k15JHMWELbwmkEP+82fa02Zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lxg4PmH5TckN4DloCMTBPdLJhz1W0nof7YHTqZeSTVUb73SJd/vxvg7yalCzcRr9n
         mf1zAG7XNmdnoSm6W1EVBDQnWaVIqN0G26lRCzwsNMhhzGLVf6AlCr6+e3P+UT3V8X
         zS5SwmiAmDWUboNbOr8QnXiA+Tf08bpPz8t8d5ww=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ed Maste <emaste@freebsd.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greentime Hu <green.hu@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Hu <nickhu@andestech.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 8/9] perf vendor events s390: Fix counter long description for DTLB1_GPAGE_WRITES
Date:   Mon, 16 Dec 2019 17:47:37 -0300
Message-Id: <20191216204738.12107-9-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191216204738.12107-1-acme@kernel.org>
References: <20191216204738.12107-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed Maste <emaste@freebsd.org>

The cf_z13 counter DTLB1_GPAGE_WRITES included a prefix
'Counter:132\tName:'.

This is incorrect; remove the prefix as with 7fcfa9a2d9 for cf_z14.

Signed-off-by: Ed Maste <emaste@freebsd.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nick Hu <nickhu@andestech.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Link: http://lore.kernel.org/lkml/20191212143446.88582-1-emaste@freefall.freebsd.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/s390/cf_z13/extended.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/extended.json b/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
index 436ce33f1182..5da8296b667e 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
@@ -32,7 +32,7 @@
 		"EventCode": "132",
 		"EventName": "DTLB1_GPAGE_WRITES",
 		"BriefDescription": "DTLB1 Two-Gigabyte Page Writes",
-		"PublicDescription": "Counter:132	Name:DTLB1_GPAGE_WRITES A translation entry has been written to the Level-1 Data Translation Lookaside Buffer for a two-gigabyte page."
+		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer for a two-gigabyte page."
 	},
 	{
 		"Unit": "CPU-M-CF",
-- 
2.21.0

