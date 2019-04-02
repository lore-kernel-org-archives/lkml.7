Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA81C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5802084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221187;
	bh=bZ3XjJnhUXtFHzjGPyabRantiP1Sr5/P3x5pJEjs4jI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GwaL59+oVj8ozKfgqOd6Di00nXJe/j12VU5jN9OgLzg/9aIUMFGHsIZi+TdrvFM8K
	 LAuzyu8Rj6DyZjpmsJ2+9dvyLlfAauWwwubZi4M5RMBZGEmlisk7C8yiKGgRytF/b8
	 f0kEcE8Oq4UKApo0Au5PfPzWd5Ht/hGRr0bvjI28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbfDBQGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729813AbfDBQGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:06:23 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 929B820856;
        Tue,  2 Apr 2019 16:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221182;
        bh=bZ3XjJnhUXtFHzjGPyabRantiP1Sr5/P3x5pJEjs4jI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eDmDh/W4w4zEtvxzE7gXPbDAVV2uoB8QNiJ+eL9+SdkA/awIwQV6i65ePFxo0Vhs9
         ExQjZI49CmMC/mqQzqi6+/g3KmW0R55nOIU2d9hprWAOMWSYyMj0Zj45PkPOJhPacS
         vnAZ6GwftLGJZCUkWC6lXx4QYMNeYHHqW5hQxf+Y=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/44] perf list: Fix s390 counter long description for L1D_RO_EXCL_WRITES
Date:   Tue,  2 Apr 2019 13:05:11 -0300
Message-Id: <20190402160549.13544-7-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

Command

  # perf list --long-desc pmu

lists the long description of the available counters. For counter
named L1D_RO_EXCL_WRITES on machine types 3906 and 3907 the long
description contains the counter number 'Counter:128 Name:'
prefix. This is wrong.

The fix changes the description text and removes this prefix.

Output before:

  [root@m35lp76 perf]# ./perf list --long-desc pmu
   ...
   L1D_ONDRAWER_L4_SOURCED_WRITES
    [A directory write to the Level-1 Data cache directory where the
     returned cache line was sourced from On-Drawer Level-4 cache]

   L1D_RO_EXCL_WRITES
    [Counter:128 Name:L1D_RO_EXCL_WRITES A directory write to the Level-1
     Data cache where the line was originally in a Read-Only state in the
     cache but has been updated to be in the Exclusive state that allows
     stores to the cache line]

   ...

Output after:

  [root@m35lp76 perf]# ./perf list --long-desc pmu
   ...
   L1D_ONDRAWER_L4_SOURCED_WRITES
    [A directory write to the Level-1 Data cache directory where the
     returned cache line was sourced from On-Drawer Level-4 cache]

   L1D_RO_EXCL_WRITES
    [L1D_RO_EXCL_WRITES A directory write to the Level-1
     Data cache where the line was originally in a Read-Only state in the
     cache but has been updated to be in the Exclusive state that allows
     stores to the cache line]

   ...

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Fixes: 109d59b900e7 ("perf vendor events s390: Add JSON files for IBM z14")
Link: http://lkml.kernel.org/r/20190329133337.60255-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/s390/cf_z14/extended.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
index e7a3524b748f..68618152ea2c 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z14/extended.json
@@ -4,7 +4,7 @@
 		"EventCode": "128",
 		"EventName": "L1D_RO_EXCL_WRITES",
 		"BriefDescription": "L1D Read-only Exclusive Writes",
-		"PublicDescription": "Counter:128	Name:L1D_RO_EXCL_WRITES A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
+		"PublicDescription": "L1D_RO_EXCL_WRITES A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
 	},
 	{
 		"Unit": "CPU-M-CF",
-- 
2.20.1

