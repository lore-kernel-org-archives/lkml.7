Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDFFC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EB82171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565986699;
	bh=X+v0IzboznOsWtVeOljDjZZS7BTG2W3JVT6DCyi3Z5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PuIJ1QxZILJTy6xzQUFf/WfS/R2XGhEm7/oXflSaoXN28UuddmT9KKn/X0gABhBMK
	 rGMzqCH3MBYIPdbC+T5kYHUBvE975gXe1quB7iiclo/0Vs7g1opiao3ieyfmE5g+Dt
	 PTcrmZd52075XjeWhZ8MawTWwrJwv3zgX/6K33cs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfHPUSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:18:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727885AbfHPUSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:18:14 -0400
Received: from quaco.ghostprotocols.net (unknown [179.182.221.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 729E721721;
        Fri, 16 Aug 2019 20:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565986693;
        bh=X+v0IzboznOsWtVeOljDjZZS7BTG2W3JVT6DCyi3Z5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2tUCRzd+E4+0bBwuPUuWBO3UX1E13X4t8+cCv2eYg2IprWjo7beWWJA0ff9qKxQZL
         //WrPBYeFH9ETPLiM3ALeMIOP2zjIpWe3bWFwZGoZjlDRW4dwk70ejwL2npkSxOsSH
         xfXBdeOTM58RTeCIwXEGfMRrHQbs/kre09fSasTU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Keeping <john@metanate.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/17] perf map: Use zalloc for map_groups
Date:   Fri, 16 Aug 2019 17:16:51 -0300
Message-Id: <20190816201653.19332-16-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816201653.19332-1-acme@kernel.org>
References: <20190816201653.19332-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Keeping <john@metanate.com>

In the next commit we will add new fields to map_groups and we need
these to be null if no value is assigned.  The simplest way to achieve
this is to request zeroed memory from the allocator.

Signed-off-by: John Keeping <john@metanate.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: john keeping <john@metanate.com>
Link: http://lkml.kernel.org/r/20190815100146.28842-1-john@metanate.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 668410b1d426..44b556812e4b 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -636,7 +636,7 @@ bool map_groups__empty(struct map_groups *mg)
 
 struct map_groups *map_groups__new(struct machine *machine)
 {
-	struct map_groups *mg = malloc(sizeof(*mg));
+	struct map_groups *mg = zalloc(sizeof(*mg));
 
 	if (mg != NULL)
 		map_groups__init(mg, machine);
-- 
2.21.0

