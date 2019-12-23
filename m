Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3D3C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 21:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2124920882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 21:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLWVfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 16:35:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38395 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfLWVfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 16:35:23 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ijVMB-0007BG-TF; Mon, 23 Dec 2019 22:35:16 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 871741C2BAA;
        Mon, 23 Dec 2019 22:35:14 +0100 (CET)
Date:   Mon, 23 Dec 2019 21:35:14 -0000
From:   "tip-bot2 for Yuya Fujita" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf hists: Fix variable name's inconsistency in
 hists__for_each() macro
Cc:     Yuya Fujita <fujita.yuya@fujitsu.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3COSAPR01MB1588E1C47AC22043175DE1B2E8520=40OSAPR01MB?=
 =?utf-8?q?1588=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom=3E?=
References: =?utf-8?q?=3COSAPR01MB1588E1C47AC22043175DE1B2E8520=40OSAPR01M?=
 =?utf-8?q?B1588=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <157713691440.30329.16673529531445455880.tip-bot2@tip-bot2>
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

Commit-ID:     55347ec340af401437680fd0e88df6739a967f9f
Gitweb:        https://git.kernel.org/tip/55347ec340af401437680fd0e88df6739a967f9f
Author:        Yuya Fujita <fujita.yuya@fujitsu.com>
AuthorDate:    Thu, 19 Dec 2019 08:08:32 
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Dec 2019 18:58:13 -03:00

perf hists: Fix variable name's inconsistency in hists__for_each() macro

Variable names are inconsistent in hists__for_each macro().

Due to this inconsistency, the macro replaces its second argument with
"fmt" regardless of its original name.

So far it works because only "fmt" is passed to the second argument.
However, this behavior is not expected and should be fixed.

Fixes: f0786af536bb ("perf hists: Introduce hists__for_each_format macro")
Fixes: aa6f50af822a ("perf hists: Introduce hists__for_each_sort_list macro")
Signed-off-by: Yuya Fujita <fujita.yuya@fujitsu.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/OSAPR01MB1588E1C47AC22043175DE1B2E8520@OSAPR01MB1588.jpnprd01.prod.outlook.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 4528690..0aa63ae 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -339,10 +339,10 @@ static inline void perf_hpp__prepend_sort_field(struct perf_hpp_fmt *format)
 	list_for_each_entry_safe(format, tmp, &(_list)->sorts, sort_list)
 
 #define hists__for_each_format(hists, format) \
-	perf_hpp_list__for_each_format((hists)->hpp_list, fmt)
+	perf_hpp_list__for_each_format((hists)->hpp_list, format)
 
 #define hists__for_each_sort_list(hists, format) \
-	perf_hpp_list__for_each_sort_list((hists)->hpp_list, fmt)
+	perf_hpp_list__for_each_sort_list((hists)->hpp_list, format)
 
 extern struct perf_hpp_fmt perf_hpp__format[];
 
