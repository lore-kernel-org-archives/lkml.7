Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6525CC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363742184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565290533;
	bh=gFPZR4HyW7vKEOKaDrcoCZSjLa4YIa7BGo9nbJMsxQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MZp1BP5IMX0iDjSZou/nPahB8Gi1eFLcRe+JTLfK9hybCBDKF9K9lRFKRj9mFHj7m
	 e1EyBSa6m7xnjCAgxJ9f0m1zJ3j3hdL74abf1wG2TLCIThIqu+xTWgyxhdHY0o0LpX
	 fboi22A2etcSEje+lDRC4gHbEn0O7/zF+Blvl8no=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404190AbfHHSzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:55:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404110AbfHHSzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:55:31 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.210.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ADDF2089E;
        Thu,  8 Aug 2019 18:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565290531;
        bh=gFPZR4HyW7vKEOKaDrcoCZSjLa4YIa7BGo9nbJMsxQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/sjogn4NzVNESo1ZnQ/loDQEBLGDtM7rfmM1UOqB8Fig9i3zhByaxoo2FIlHabFI
         8zIrOcCloiq5LnKdZLyFcLliYy/Ds4too8GCD6TU/51X7SnofCfInrK7wCGqaoZcO3
         EfZ0SnaF2sQvlwnnCmdGAvmlg/3VD91cbK5FYChw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/10] perf pmu-events: Fix missing "cpu_clk_unhalted.core" event
Date:   Thu,  8 Aug 2019 15:53:58 -0300
Message-Id: <20190808185358.20125-11-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190808185358.20125-1-acme@kernel.org>
References: <20190808185358.20125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

The events defined in pmu-events JSON are parsed and added into perf
tool. For fixed counters, we handle the encodings between JSON and perf
by using a static array fixed[].

But the fixed[] has missed an important event "cpu_clk_unhalted.core".

For example, on the Tremont platform,

  [root@localhost ~]# perf stat -e cpu_clk_unhalted.core -a
  event syntax error: 'cpu_clk_unhalted.core'
                       \___ parser error

With this patch, the event cpu_clk_unhalted.core can be parsed.

  [root@localhost perf]# ./perf stat -e cpu_clk_unhalted.core -a -vvv
  ------------------------------------------------------------
  perf_event_attr:
    type                             4
    size                             112
    config                           0x3c
    sample_type                      IDENTIFIER
    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
    disabled                         1
    inherit                          1
    exclude_guest                    1
  ------------------------------------------------------------
...

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190729072755.2166-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/jevents.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 1a91a197cafb..d413761621b0 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -453,6 +453,7 @@ static struct fixed {
 	{ "inst_retired.any_p", "event=0xc0" },
 	{ "cpu_clk_unhalted.ref", "event=0x0,umask=0x03" },
 	{ "cpu_clk_unhalted.thread", "event=0x3c" },
+	{ "cpu_clk_unhalted.core", "event=0x3c" },
 	{ "cpu_clk_unhalted.thread_any", "event=0x3c,any=1" },
 	{ NULL, NULL},
 };
-- 
2.21.0

