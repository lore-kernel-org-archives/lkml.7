Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B83C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BD321835
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfK2GDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 01:03:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48082 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfK2GDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 01:03:07 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iaZMh-0008Hp-78; Fri, 29 Nov 2019 07:02:51 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DA17F1C20BF;
        Fri, 29 Nov 2019 07:02:50 +0100 (CET)
Date:   Fri, 29 Nov 2019 06:02:50 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf diff: Use llabs() with 64-bit values
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-pn7szy5uw384ntjgk6zckh6a@git.kernel.org>
References: <tip-pn7szy5uw384ntjgk6zckh6a@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157500737077.21853.7118791348763065608.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     2b1ac6403f8800babed0f16ab1d29ee3300be122
Gitweb:        https://git.kernel.org/tip/2b1ac6403f8800babed0f16ab1d29ee3300be122
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 27 Nov 2019 09:58:22 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 28 Nov 2019 08:08:38 -03:00

perf diff: Use llabs() with 64-bit values

To fix this build error on a debian mipsel cross build environment:

  builtin-diff.c: In function 'compute_cycles_diff':
  builtin-diff.c:649:10: error: absolute value function 'labs' given an argument of type 's64' {aka 'long long int'} but has parameter of type 'long int' which may cause truncation of value [-Werror=absolute-value]
    649 |    val = labs(pair->block_info->cycles_spark[i] -
        |          ^~~~

Fixes: cebf7d51a6c3 ("perf diff: Report noisy for cycles diff")
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-pn7szy5uw384ntjgk6zckh6a@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index eae8793..f8b6ae5 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -646,7 +646,7 @@ static void compute_cycles_diff(struct hist_entry *he,
 			if (i >= he->block_info->num || i >= NUM_SPARKS)
 				break;
 
-			val = labs(pair->block_info->cycles_spark[i] -
+			val = llabs(pair->block_info->cycles_spark[i] -
 				     he->block_info->cycles_spark[i]);
 
 			update_spark_value(pair->diff.svals, NUM_SPARKS,
