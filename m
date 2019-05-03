Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C73C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FEE2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556871549;
	bh=zRDefgn6LXQeLrfX5ieKwQMp2vMOBZMRVV5dKRfXks0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zqxW7Coed/cCVivAN2vSjLXcjJH4uufadjX0eeqbfsn3Ejn2Fu0W2q77a7AxvQU1V
	 5wVxRX3BvFa0bPdX6YCX/BD1aPk2FQz4pLid6S5gn5afbTrjTyc7zZqdL6BZQQQNJF
	 kpLpGWri1u6OYdxWThHVosU5y6VMp08DRulvScTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfECITH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:19:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbfECITD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:19:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6DEB985528;
        Fri,  3 May 2019 08:19:03 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CE8126352;
        Fri,  3 May 2019 08:19:01 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 06/12] perf tools: Keep zero in pgoff bpf map
Date:   Fri,  3 May 2019 10:18:35 +0200
Message-Id: <20190503081841.1908-7-jolsa@kernel.org>
In-Reply-To: <20190503081841.1908-1-jolsa@kernel.org>
References: <20190503081841.1908-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 03 May 2019 08:19:03 +0000 (UTC)
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
2.20.1

