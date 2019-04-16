Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7765C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A7120821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555430531;
	bh=xqFeVLPep/prm1ef2ZefxpxuoXIoqbCObwVLTxqEu4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wIRqsUfNd4hAca2yigw9YGWzuyye7VSqWCWiIR8tPLhLm0MeJd7Ez/tBM4p5ozABZ
	 BzatH+m0jCARmOBBwhjrCQJPnIYhjiaHapCvp45w8M6yPEaGbBJUNPsjHxDdvWj0xm
	 opJIxJq8zhRBZbIDhsffM64MsskTcGFq7l5lv6Bg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbfDPQCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:02:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbfDPQCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:02:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 67843C04FFF9;
        Tue, 16 Apr 2019 16:02:08 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 195295D71E;
        Tue, 16 Apr 2019 16:02:05 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 11/12] perf tools: Reuse shared eBPF dso objects
Date:   Tue, 16 Apr 2019 18:01:26 +0200
Message-Id: <20190416160127.30203-12-jolsa@kernel.org>
In-Reply-To: <20190416160127.30203-1-jolsa@kernel.org>
References: <20190416160127.30203-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 16 Apr 2019 16:02:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eBPF program can be loaded multiple times
with the same name (tag). We can share dso
objects for those programs.

Link: http://lkml.kernel.org/n/tip-3damf8vq1dryhtpbk5b06jpt@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/machine.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index d4aa44489011..a60653827891 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -23,6 +23,7 @@
 #include "linux/hash.h"
 #include "asm/bug.h"
 #include "bpf-event.h"
+#include "dso.h"
 
 #include "sane_ctype.h"
 #include <symbol/kallsyms.h>
@@ -699,11 +700,18 @@ static int machine__process_ksymbol_register(struct machine *machine,
 
 	map = map_groups__find(&machine->kmaps, event->ksymbol_event.addr);
 	if (!map) {
-		map = dso__new_map(event->ksymbol_event.name);
-		if (!map)
+		struct dso *dso;
+
+		dso = dsos__findnew(&machine->dsos, event->ksymbol_event.name);
+		if (!dso)
 			return -ENOMEM;
 
-		map->start = event->ksymbol_event.addr;
+		map = map__new2(event->ksymbol_event.addr, dso);
+		if (!map) {
+			dso__put(dso);
+			return -ENOMEM;
+		}
+
 		map->end = map->start + event->ksymbol_event.len;
 		map_groups__insert(&machine->kmaps, map);
 	}
-- 
2.17.2

