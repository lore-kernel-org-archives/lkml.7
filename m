Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E421C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33B421897
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394754AbfHWM3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:29:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35348 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730804AbfHWM33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:29:29 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i18h2-00024L-DU; Fri, 23 Aug 2019 14:29:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 098231C089A;
        Fri, 23 Aug 2019 14:29:24 +0200 (CEST)
Date:   Fri, 23 Aug 2019 12:29:23 -0000
From:   tip-bot2 for Ravi Bangoria <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf c2c: Fix report with offline cpus
Cc:     Nageswara R Sastry <nasastry@in.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20190822085045.25108-1-ravi.bangoria@linux.ibm.com>
References: <20190822085045.25108-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <156656336391.32670.13819000137400710283.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1ea770f6c1971bc101b3741f4d88b0b4ea5c4181
Gitweb:        https://git.kernel.org/tip/1ea770f6c1971bc101b3741f4d88b0b4ea5c4181
Author:        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
AuthorDate:    Thu, 22 Aug 2019 14:20:45 +05:30
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 22 Aug 2019 17:16:57 -03:00

perf c2c: Fix report with offline cpus

If c2c is recorded on a machine where any cpus are offline, 'perf c2c
report' throws an error "node/cpu topology bugFailed setup nodes".

It fails because while preparing node-cpu mapping we don't consider
offline cpus.

Reported-by: Nageswara R Sastry <nasastry@in.ibm.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Fixes: 1e181b92a2da ("perf c2c report: Add 'node' sort key")
Link: http://lkml.kernel.org/r/20190822085045.25108-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 01629f5..2111437 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2027,7 +2027,7 @@ static int setup_nodes(struct perf_session *session)
 		c2c.node_info = 2;
 
 	c2c.nodes_cnt = session->header.env.nr_numa_nodes;
-	c2c.cpus_cnt  = session->header.env.nr_cpus_online;
+	c2c.cpus_cnt  = session->header.env.nr_cpus_avail;
 
 	n = session->header.env.numa_nodes;
 	if (!n)
