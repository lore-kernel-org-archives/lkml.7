Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3FEC742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 10:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56642083B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 10:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ZaI8aAPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfGMKxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 06:53:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56603 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfGMKxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 06:53:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DArADE3837497
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 03:53:10 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DArADE3837497
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563015192;
        bh=hDq1tiBBkrgtrsyHkCKYXRUoo8rYajHBrpyquSiZ28A=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ZaI8aAPNv7WQclgYjdxXUGk08ktJ6dm8ixZreO7ghR+6cpWUchC/qwfLkY41l6fwQ
         03TEZHuT8eh7cBDt03XZCMeSF9Gy0gofDfmZHRJi5Dz7UG2UEoXZhK0liBIYP5tYLo
         iI/1oX7ZcQpheRhJZYiyMzn83G5axid4AWU2xO57kEcUREFNAoc7BAWO4YIOBLjCZJ
         GBLcPq7YwnCArWW+bDzpbomp7QDn52EiPy624MT5dg1fvRhGNyWyopcSOeZCL7cqSZ
         Ro0viOGkf1OOI4RbkUvm11K1AWJCmKDrHEMZxD9z5KWOf9cSuk9trMxm4XT2p2ofe/
         /p1/BuwS76uJA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DAr6xB3837479;
        Sat, 13 Jul 2019 03:53:06 -0700
Date:   Sat, 13 Jul 2019 03:53:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-c74b05030edb3b52f4208d8415b8c933bc509a29@git.kernel.org>
Cc:     adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, leo.yan@linaro.org, dave@stgolabs.net,
        suzuki.poulose@arm.com, tmricht@linux.ibm.com, jolsa@kernel.org,
        changbin.du@intel.com, tglx@linutronix.de, acme@redhat.com,
        mingo@kernel.org, yao.jin@linux.intel.com, davem@davemloft.net,
        alexios.zavras@intel.com, peterz@infradead.org,
        songliubraving@fb.com, eric.saint.etienne@oracle.com,
        mathieu.poirier@linaro.org, alexey.budankov@linux.intel.com,
        hpa@zytor.com, khlebnikov@yandex-team.ru, ak@linux.intel.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, khlebnikov@yandex-team.ru, ak@linux.intel.com,
          linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
          peterz@infradead.org, songliubraving@fb.com,
          eric.saint.etienne@oracle.com, mathieu.poirier@linaro.org,
          alexey.budankov@linux.intel.com, jolsa@kernel.org,
          changbin.du@intel.com, tglx@linutronix.de, acme@redhat.com,
          yao.jin@linux.intel.com, mingo@kernel.org, davem@davemloft.net,
          alexios.zavras@intel.com, adrian.hunter@intel.com,
          alexander.shishkin@linux.intel.com, namhyung@kernel.org,
          dave@stgolabs.net, leo.yan@linaro.org, suzuki.poulose@arm.com,
          tmricht@linux.ibm.com
In-Reply-To: <20190702103420.27540-3-leo.yan@linaro.org>
References: <20190702103420.27540-3-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf stat: Fix use-after-freed pointer detected
 by the smatch tool
Git-Commit-ID: c74b05030edb3b52f4208d8415b8c933bc509a29
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

Commit-ID:  c74b05030edb3b52f4208d8415b8c933bc509a29
Gitweb:     https://git.kernel.org/tip/c74b05030edb3b52f4208d8415b8c933bc509a29
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Tue, 2 Jul 2019 18:34:11 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 09:33:54 -0300

perf stat: Fix use-after-freed pointer detected by the smatch tool

Based on the following report from Smatch, fix the use-after-freed
pointer.

  tools/perf/builtin-stat.c:1353
  add_default_attributes() warn: passing freed memory 'str'.

The pointer 'str' has been freed but later it is still passed into the
function parse_events_print_error().  This patch fixes this
use-after-freed issue.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Alexios Zavras <alexios.zavras@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Changbin Du <changbin.du@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Song Liu <songliubraving@fb.com>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: http://lkml.kernel.org/r/20190702103420.27540-3-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e5e19b461061..b81f7b197d24 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1349,8 +1349,8 @@ static int add_default_attributes(void)
 				fprintf(stderr,
 					"Cannot set up top down events %s: %d\n",
 					str, err);
-				free(str);
 				parse_events_print_error(&errinfo, str);
+				free(str);
 				return -1;
 			}
 		} else {
