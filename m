Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7928C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43E02070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJlCdVAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbfCZRD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:03:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43413 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfCZRD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:03:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id d26so11415655ede.10;
        Tue, 26 Mar 2019 10:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Da+zC2BJbCPB/tjtf0Jk85c8HOJsfHJGaS+cHCHGf5M=;
        b=TJlCdVAC7CeSGb5rI9dBLm/OM61Boca7yb6nI7DSSwBxkq91irCW36x3fyzapLxWrB
         w/PEPjQk+mqFzVMV5wXl1t0CNi65e4fJ1uTvAWojJFrbbQW1EFmW1Z4sIsQcUeYO3xSv
         Wnl49QwXeDwqxIRfdzM+yvVRVEJv612laZQGnJZusLaREZjgR6/EfLZhSZVdccWlUxzj
         MZAJAqTR0cfzIi85zL0zWTDb7jj16vzjOMh0Fg3DzbwGMUfaL1nFE4+msepOnoGwj+Ku
         aRW9lIHYrNTFmEvxfwDyzVKdafPsN10mqIkU1/i3kfMYGyiDcsCEeVEwEhzjuMQSFB9c
         2CtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Da+zC2BJbCPB/tjtf0Jk85c8HOJsfHJGaS+cHCHGf5M=;
        b=pXeRez5Ih4qvgbSR3S3Ki4WUZUmDZLCPIEZw3OxtF6qLQXuWeb079YmSim4JifuDQY
         wJ8bqCkgKunBKbkqPXmKWEmfPN2/Br/aQvfNIysLvPz3koY77APmeQESSuDZvROuvsXT
         fqFGjbiCkqJ+pSfNgE/e6xC3DjOITMnLLo6Y0k8++5x1Y37OFbd0tlRJxIbsWh4GyTAH
         jSoD4LayxRXNFTRAL+wyrqDEaootAy++oCkQmk7cZaL432y96/ITOjY4usCiG5Su+rkk
         E3awT4pmli5E1FIEXhEp+mPIDwnzi1s5/7PLkiHvngVgpR6ix4VtjKxLKaYQwbGSUsKS
         9qkg==
X-Gm-Message-State: APjAAAXyUmQQQGkEnqDbknNWfOgx1eF3Ll4cWYAX3EjmexeLKYokuJXu
        yy+NF7PkW3qFj77P2ivq738=
X-Google-Smtp-Source: APXvYqzwEvDMTcXb1kP1nc7APCR6qbi6xrfTpcWDEuEiXZygcXrcD9KwvMoeX2/LXlxLga/WvMDP+Q==
X-Received: by 2002:a17:906:d503:: with SMTP id ge3mr14716041ejb.2.1553619834234;
        Tue, 26 Mar 2019 10:03:54 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id t52sm1631356edd.54.2019.03.26.10.03.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:03:53 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
        linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCH fixes] MIPS: perf: Fix build with CONFIG_CPU_BMIPS5000 enabled
Date:   Tue, 26 Mar 2019 10:03:34 -0700
Message-Id: <20190326170335.8031-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'event' variable may be unused in case only CONFIG_CPU_BMIPS5000
being enabled:

arch/mips/kernel/perf_event_mipsxx.c: In function 'mipsxx_pmu_enable_event':
arch/mips/kernel/perf_event_mipsxx.c:326:21: error: unused variable 'event' [-Werror=unused-variable]
  struct perf_event *event = container_of(evt, struct perf_event, hw);
                     ^~~~~

Fixes: 84002c88599d ("MIPS: perf: Fix perf with MT counting other threads")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/kernel/perf_event_mipsxx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 413863508f6f..739b7ff9fdab 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -323,7 +323,9 @@ static int mipsxx_pmu_alloc_counter(struct cpu_hw_events *cpuc,
 
 static void mipsxx_pmu_enable_event(struct hw_perf_event *evt, int idx)
 {
+#ifndef CONFIG_CPU_BMIPS5000
 	struct perf_event *event = container_of(evt, struct perf_event, hw);
+#endif
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 #ifdef CONFIG_MIPS_MT_SMP
 	unsigned int range = evt->event_base >> 24;
-- 
2.17.1

