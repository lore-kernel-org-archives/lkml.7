Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D2EC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B66218BB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559137002;
	bh=nDO/XqECbiXtktOst8juycy2+vQdGLrUs6S9KlbjNBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JIFx8wJC8sEpFDFw90o/4LYI4KUhAMYZXtWZJS44V9khvOWLPnhZ07lvAop4sMeLz
	 1r5M5y8WZGnK20laIn3ytJzb1AtSajafVg8OVDNZFPJDb2AdDUUuAKU+KeJQAmxohL
	 4D1qe9JFBFBk2YZk90CCDdfppWNmGzdbAcQUQ33U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfE2Ngm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:36:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbfE2Ngj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:36:39 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.211.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 435C6218D4;
        Wed, 29 May 2019 13:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559136998;
        bh=nDO/XqECbiXtktOst8juycy2+vQdGLrUs6S9KlbjNBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=It9dHlAIDe2kFnyLVPOYjJpMgH9ty8WDJ6O93UNSJxHBOAHM83N/JjlJox3ITaFkr
         c4Rto7yVad8yyKE79AlQDJ/mjJt5JvlOHeCbbYhkTIaQwKizCxpDXc02VcHnGt3yEk
         ZJ0x1sTz8QTTgfjcfqmNgUx659Q+wcBBTNzTxu14=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stanislav Fomichev <sdf@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/41] perf machine: Keep zero in pgoff BPF map
Date:   Wed, 29 May 2019 10:35:29 -0300
Message-Id: <20190529133605.21118-6-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

With pgoff set to zero, the map__map_ip function will return BPF
addresses based from 0, which is what we need when we read the data from
a BPF DSO.

Adding BPF symbols with mapped IP addresses as well.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190508132010.14512-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index dc7aafe45a2b..f5569f005cf3 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -704,12 +704,12 @@ static int machine__process_ksymbol_register(struct machine *machine,
 			return -ENOMEM;
 
 		map->start = event->ksymbol_event.addr;
-		map->pgoff = map->start;
 		map->end = map->start + event->ksymbol_event.len;
 		map_groups__insert(&machine->kmaps, map);
 	}
 
-	sym = symbol__new(event->ksymbol_event.addr, event->ksymbol_event.len,
+	sym = symbol__new(map->map_ip(map, map->start),
+			  event->ksymbol_event.len,
 			  0, 0, event->ksymbol_event.name);
 	if (!sym)
 		return -ENOMEM;
-- 
2.20.1

