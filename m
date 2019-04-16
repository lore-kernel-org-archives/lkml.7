Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF6BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB32218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555430528;
	bh=5TSR9iKQa5Ts/nLO3H2dJmp00vXqZ4S46QJXaVEl0ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oa1tUEsl2VR+mykbvqdkn+SSawKh1v/3DmY2wv7ISWep6+fMBFDTd4bS01QBrUXkt
	 3SnCv3zNpmlYkvdBdoKGGL4feE7UzX7MoQgl0Ubxz1ranBy/PtIVU4rW60pLNGBkTb
	 AzNai8ufMLOgd1Y4aa5tu2GCBUrhKrxVNHsyijzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbfDPQCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:02:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730046AbfDPQCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:02:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C1FB78667B;
        Tue, 16 Apr 2019 16:02:05 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74FBC5D71B;
        Tue, 16 Apr 2019 16:02:03 +0000 (UTC)
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
Subject: [PATCH 10/12] perf tools: Keep zero in pgoff bpf map
Date:   Tue, 16 Apr 2019 18:01:25 +0200
Message-Id: <20190416160127.30203-11-jolsa@kernel.org>
In-Reply-To: <20190416160127.30203-1-jolsa@kernel.org>
References: <20190416160127.30203-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 16 Apr 2019 16:02:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With pgoff set to zero, the map__map_ip function
will return bpf address based from 0, which is
what we need when we read the data from bpf dso.

Adding bpf symbols with mapped ip addresses as well.

Link: http://lkml.kernel.org/n/tip-nqgyzbqgekvxqc5tjmsb3da2@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/machine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index ad0205fbb506..d4aa44489011 100644
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
2.17.2

