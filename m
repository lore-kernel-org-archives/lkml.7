Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D8EC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81FD20449
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225188;
	bh=oOs2LTbE87ss1DVJVJpKfey+sGJSCncsHNhxbxvTpXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n+//BlAYUYD7kSVK4+iYLvXOONKsMhqpI7H/3PPtyXHDGpRv7XsUblZnGFrlH3gDr
	 9uIr2ebvW1FdfHdVX9ZRr8Crk5889QsTt2/tG2MyV0D0qDZwF1BDQdAk17j6HQ6GB9
	 np0djF70WXbBKrtZ7E4Vtcb/X5ucFU08VaK1xDfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbfGOVNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:13:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730207AbfGOVNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:13:06 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18AB021721;
        Mon, 15 Jul 2019 21:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225185;
        bh=oOs2LTbE87ss1DVJVJpKfey+sGJSCncsHNhxbxvTpXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fHB3KIMyWCzbzULvWChuO1hlgA4e+1FL6K3Yijn+Nwhhlj/K9JpTT1scoiWA8TRv/
         1E72OIWbCxjSYAVww0/gfi8UcLBD5VmMwu6eT1ypVA2j+YoO0IkYCo7SNrhm1BnBLr
         D0oCjd9sz8YjOaF00/ytnbc/BUhh2SBmMekl0wWw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/28] perf db-export: Fix a white space issue in db_export__sample()
Date:   Mon, 15 Jul 2019 18:11:42 -0300
Message-Id: <20190715211200.10984-11-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190715211200.10984-1-acme@kernel.org>
References: <20190715211200.10984-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Fix a white space issue in db_export__sample()

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-8-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 78f62a733b9d..2c3a4ad68428 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -274,7 +274,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 		      struct perf_sample *sample, struct perf_evsel *evsel,
 		      struct addr_location *al)
 {
-	struct thread* thread = al->thread;
+	struct thread *thread = al->thread;
 	struct export_sample es = {
 		.event = event,
 		.sample = sample,
-- 
2.21.0

