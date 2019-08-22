Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3218C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78822341A
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566507777;
	bh=toz37KZfzCs5b6EHIMiOqqqWz5fe7EkJy/dz+T/LHUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GkyaO19nCeCpswr7qvOnSh74tsc+zigQdFf0fgef91TqSEAvo6U0iCOFJLhV1jml2
	 x2Q6zoAxP67XWnvf7OWpeu+8nm+tTIh0AnFto2dieUZoCIDadiJhZrSsdb20Suas/5
	 2bsoNuiyb1xHGP6JT6HHR8TOZudjZIDDbz3pcxAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393547AbfHVVC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393538AbfHVVCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:02:52 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.141.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D7A623401;
        Thu, 22 Aug 2019 21:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566507771;
        bh=toz37KZfzCs5b6EHIMiOqqqWz5fe7EkJy/dz+T/LHUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t0hQsEdVjIcTtQVH7YtZwQI6pAg4CtlXSw6wjDeyQKf3DO3jZfmWbySwiaIOeAuHR
         foU8X/tCrpu/+M7zEE2zaKf7C7diYUNVTOS3o+QOF5OLQKPJz22TnfSlnYMEO0JnmB
         Vqzyxfc7nGRnQX3jXctJOoj9YyT2eTL8ErzOzjiI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Nageswara R Sastry <nasastry@in.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 24/25] perf c2c: Fix report with offline cpus
Date:   Thu, 22 Aug 2019 18:00:59 -0300
Message-Id: <20190822210100.3461-25-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822210100.3461-1-acme@kernel.org>
References: <20190822210100.3461-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

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
index 01629f5b6d1f..211143720078 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2027,7 +2027,7 @@ static int setup_nodes(struct perf_session *session)
 		c2c.node_info = 2;
 
 	c2c.nodes_cnt = session->header.env.nr_numa_nodes;
-	c2c.cpus_cnt  = session->header.env.nr_cpus_online;
+	c2c.cpus_cnt  = session->header.env.nr_cpus_avail;
 
 	n = session->header.env.numa_nodes;
 	if (!n)
-- 
2.21.0

