Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3325C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75793222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458209;
	bh=7PLqFsDT07CG0T9iE6hVR1CkVTScb3CoN9v52bS+0Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ac6GOOyBHld3carFSiGfz4rfLfiW+0yPLjIjNbpKAnlxnuUQHlj3V+no646LqgGbA
	 4nbGjW6bZp3um+AfZ1rJXkQzSPoBeRuDORNllyvZd25tJgKNnUOBgM8PV6chSJRJwM
	 tZ2nZFqgD6c9LI9ABrubj2CLAGTR16Bi2OmkaY8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390872AbfIZAgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:36:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390684AbfIZAgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:36:45 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0E4121D7B;
        Thu, 26 Sep 2019 00:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458205;
        bh=7PLqFsDT07CG0T9iE6hVR1CkVTScb3CoN9v52bS+0Ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sLNAMkfJG3XjfgCjlc/tzzHgSWHKLOg6xlF80uOOekfK9O/QApo56S80Xuf1XspRF
         Ncn3mvRtyrClBRkdQOvwCx5DMeu/qcJgasJLJ+BIa+sBODLanNaCre/Ta9ITI5M8/q
         iL3I7q+ubniujk+9veFWPIrbKEoOB0pSSLaPxaPw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 63/66] perf vendor events: Remove P8 HW events which are not supported
Date:   Wed, 25 Sep 2019 21:32:41 -0300
Message-Id: <20190926003244.13962-64-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>

This patch is to remove following hardware events
from JSON file which are not supported on POWER8.

pm_l3_p0_grp_pump
pm_l3_p0_lco_data
pm_l3_p0_lco_no_data
pm_l3_p0_lco_rty

  Note: Unfortunately power8 event list is not publicly available.

Fixes: c3b4d5c4afb0 ("perf vendor events: Remove P8 HW events which are not supported")
Signed-off-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190909065624.11956.3992.stgit@localhost.localdomain
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../pmu-events/arch/powerpc/power8/other.json | 24 -------------------
 1 file changed, 24 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power8/other.json b/tools/perf/pmu-events/arch/powerpc/power8/other.json
index 9dc2f6b70354..b2a3df07fbc4 100644
--- a/tools/perf/pmu-events/arch/powerpc/power8/other.json
+++ b/tools/perf/pmu-events/arch/powerpc/power8/other.json
@@ -1775,30 +1775,6 @@
     "BriefDescription": "L3 Load Prefetches",
     "PublicDescription": ""
   },
-  {,
-    "EventCode": "0xa29084",
-    "EventName": "PM_L3_P0_GRP_PUMP",
-    "BriefDescription": "L3 pf sent with grp scope port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x528084",
-    "EventName": "PM_L3_P0_LCO_DATA",
-    "BriefDescription": "lco sent with data port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0x518080",
-    "EventName": "PM_L3_P0_LCO_NO_DATA",
-    "BriefDescription": "dataless l3 lco sent port 0",
-    "PublicDescription": ""
-  },
-  {,
-    "EventCode": "0xa4908c",
-    "EventName": "PM_L3_P0_LCO_RTY",
-    "BriefDescription": "L3 LCO received retry port 0",
-    "PublicDescription": ""
-  },
   {,
     "EventCode": "0x84908d",
     "EventName": "PM_L3_PF0_ALLOC",
-- 
2.21.0

