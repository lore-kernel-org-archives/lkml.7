Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F12CC73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF4B20665
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562697110;
	bh=aVZ0iIxfrqicomtqFbAEDq8CdAhVe14Oy+wL/zknopw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rsLeLjdf9hA8DZi6rJ0K9XL9ypSZjSZD9NlFoEyBi6aA6OPSWETAl90EuL45ESXyQ
	 33hZjl+3OUDcaSXlEViDC5KHWBe304LOxs9UGwZN/4mN5XCuXu/yihlNcjMYVskNEu
	 ASGMcOKDkqu9L/z1abeywnlvjL2QdApc2yUj/uYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfGISbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:31:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbfGISbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:31:48 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A82CA214AF;
        Tue,  9 Jul 2019 18:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562697107;
        bh=aVZ0iIxfrqicomtqFbAEDq8CdAhVe14Oy+wL/zknopw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F2bTdox0H8xFhe/mRht+zvTN+TcE0KZL6eOYL7Iz06XZSNfhoYDeICfpNcc8HlFmh
         qffXnJhZjtN1ZwyWplr3H34bUl2VVKmNx01Fi5UBTmfdAgHzKSBsOg0I94n/LbQfqd
         jSkDNMv8Doc+kAOxjTV9cmEcolzf/VhAHmMpoSGY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Song Liu <songliubraving@fb.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/25] perf stat: Fix use-after-freed pointer detected by the smatch tool
Date:   Tue,  9 Jul 2019 15:31:03 -0300
Message-Id: <20190709183126.30257-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709183126.30257-1-acme@kernel.org>
References: <20190709183126.30257-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

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
-- 
2.21.0

