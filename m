Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C03C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778532173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="J4pBFJTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404945AbfHHUXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:23:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47097 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404588AbfHHUXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:23:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78KNIVp3322002
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 13:23:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78KNIVp3322002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565295799;
        bh=vlmUvT48LKXae2dZomJin9M81+LvHmMIwvmFTd/bI8s=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=J4pBFJTtnnaxioFKfJ9bOjSdRQm2SOT2c0xgI4GXzQD+0lEeVXbrawvsUyse5GHHr
         d0RenWVZ6QdrWKeBaBPY750yazT0WtVthwWHsIs7sviIwu8HkKcZTBJBygXuljQhmv
         BvNVdecfTnbhga6/GyW543IVJ7ZST0w6IYUtys8uFOco6EsZVroGhA8nF3RPGu5P3q
         CcK/gzwsDPlMCaZR8g7W8b9VV3gsQbM8TIRIBJPzp1mHMsJy/n+Eu8C6E2EB3lMWrj
         zGFthD/tcZ2LWz5VHNaLv/wdfD1I1aUiCuZycY/W+T2OQ9dve9eQk43M73afa4r3uw
         0FvB5A9cU6o5A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78KNIkm3321999;
        Thu, 8 Aug 2019 13:23:18 -0700
Date:   Thu, 8 Aug 2019 13:23:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-8e6e5bea2e34c61291d00cb3f47560341aa84bc3@git.kernel.org>
Cc:     yao.jin@linux.intel.com, ak@linux.intel.com, peterz@infradead.org,
        kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        yao.jin@intel.com, acme@redhat.com, tglx@linutronix.de,
        jolsa@kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com, jolsa@kernel.org,
          tglx@linutronix.de, yao.jin@intel.com, acme@redhat.com,
          ak@linux.intel.com, yao.jin@linux.intel.com,
          kan.liang@linux.intel.com, peterz@infradead.org
In-Reply-To: <20190729072755.2166-1-yao.jin@linux.intel.com>
References: <20190729072755.2166-1-yao.jin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf pmu-events: Fix missing
 "cpu_clk_unhalted.core" event
Git-Commit-ID: 8e6e5bea2e34c61291d00cb3f47560341aa84bc3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8e6e5bea2e34c61291d00cb3f47560341aa84bc3
Gitweb:     https://git.kernel.org/tip/8e6e5bea2e34c61291d00cb3f47560341aa84bc3
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Mon, 29 Jul 2019 15:27:55 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 8 Aug 2019 15:41:37 -0300

perf pmu-events: Fix missing "cpu_clk_unhalted.core" event

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
