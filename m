Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C34C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2B52067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbfLLOeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:34:50 -0500
Received: from mx2.freebsd.org ([96.47.72.81]:49814 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729761AbfLLOeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:34:50 -0500
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id 7D7066CE46;
        Thu, 12 Dec 2019 14:34:48 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: from freefall.freebsd.org (freefall.freebsd.org [96.47.72.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "freefall.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id 47Ybt01x3zz3Dgl;
        Thu, 12 Dec 2019 14:34:48 +0000 (UTC)
        (envelope-from emaste@freebsd.org)
Received: by freefall.freebsd.org (Postfix, from userid 1079)
        id 1D64BF3A0; Thu, 12 Dec 2019 14:34:48 +0000 (UTC)
From:   Ed Maste <emaste@freefall.freebsd.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>, emaste@freebsd.org,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf list: Fix s390 counter long description for DTLB1_GPAGE_WRITES
Date:   Thu, 12 Dec 2019 14:34:46 +0000
Message-Id: <20191212143446.88582-1-emaste@freefall.freebsd.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ed Maste <emaste@freebsd.org>

cf_z13 counter DTLB1_GPAGE_WRITES included a prefix 'Counter:132\tName:'.
This is incorrect; remove the prefix as with 7fcfa9a2d9 for cf_z14.

Signed-off-by: Ed Maste <emaste@freebsd.org>
---
 tools/perf/pmu-events/arch/s390/cf_z13/extended.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/extended.json b/tools/perf/pmu-events/arch/s390/cf_z13/extended.json
index 62e6bdf750dd..1a5e4f89c57e 100644
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
2.24.0

