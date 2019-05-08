Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410AEC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129F9214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557321638;
	bh=zRDefgn6LXQeLrfX5ieKwQMp2vMOBZMRVV5dKRfXks0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gJtabgK+JB0x4pUUm7bTUSEjgrDSvO57I2wMyIH5rZdKqxN+V0oo7eS/FvTDjlH8V
	 EmRpwOhs1MWHJ7cx4L6itPt5x2/AyHnBpMM5It0GtskuURKwXOUs4DTEUXuJ+8WFMV
	 Uzffiytq1C91WALgwMRQZa1RboAsF0WSHMKrQuy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfEHNUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:20:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbfEHNUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:20:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29457306641B;
        Wed,  8 May 2019 13:20:35 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-49.brq.redhat.com [10.40.204.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A14BA10027D5;
        Wed,  8 May 2019 13:20:32 +0000 (UTC)
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
Date:   Wed,  8 May 2019 15:20:04 +0200
Message-Id: <20190508132010.14512-7-jolsa@kernel.org>
In-Reply-To: <20190508132010.14512-1-jolsa@kernel.org>
References: <20190508132010.14512-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 08 May 2019 13:20:35 +0000 (UTC)
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

