Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A76C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA842186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbfDELh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:37:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38589 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbfDELh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:37:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35Bbnmc2734394
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 04:37:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35BbmxU2734391;
        Fri, 5 Apr 2019 04:37:48 -0700
Date:   Fri, 5 Apr 2019 04:37:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-7fcfa9a2d9a7c1b428d61992c2deaa9e37a437b0@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, acme@redhat.com,
        linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com,
        schwidefsky@de.ibm.com, tmricht@linux.ibm.com, hpa@zytor.com,
        brueckner@linux.vnet.ibm.com
Reply-To: schwidefsky@de.ibm.com, tmricht@linux.ibm.com, hpa@zytor.com,
          brueckner@linux.vnet.ibm.com, mingo@kernel.org,
          tglx@linutronix.de, acme@redhat.com,
          linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
In-Reply-To: <20190329133337.60255-1-tmricht@linux.ibm.com>
References: <20190329133337.60255-1-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf list: Fix s390 counter long description for
 L1D_RO_EXCL_WRITES
Git-Commit-ID: 7fcfa9a2d9a7c1b428d61992c2deaa9e37a437b0
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

Commit-ID:  7fcfa9a2d9a7c1b428d61992c2deaa9e37a437b0
Gitweb:     https://git.kernel.org/tip/7fcfa9a2d9a7c1b428d61992c2deaa9e37a437b0
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Fri, 29 Mar 2019 14:33:37 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Apr 2019 14:49:24 -0300

perf list: Fix s390 counter long description for L1D_RO_EXCL_WRITES

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
