Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F99C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5037217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfH0I0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:26:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42801 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729852AbfH0I0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:26:30 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2Wo2-0007qQ-Tg; Tue, 27 Aug 2019 10:26:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 95D471C07DC;
        Tue, 27 Aug 2019 10:26:17 +0200 (CEST)
Date:   Tue, 27 Aug 2019 08:26:17 -0000
From:   tip-bot2 for Andi Kleen <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf report: Fix --ns time sort key output
Cc:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20190823210338.12360-2-andi@firstfloor.org>
References: <20190823210338.12360-2-andi@firstfloor.org>
MIME-Version: 1.0
Message-ID: <156689437747.24515.12882688378485685652.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3dab6ac080dcd7f71cb9ceb84ad7dafecd6f7c07
Gitweb:        https://git.kernel.org/tip/3dab6ac080dcd7f71cb9ceb84ad7dafecd6f7c07
Author:        Andi Kleen <ak@linux.intel.com>
AuthorDate:    Fri, 23 Aug 2019 14:03:38 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 26 Aug 2019 11:58:29 -03:00

perf report: Fix --ns time sort key output

If the user specified --ns, the column to print the sort time stamp
wasn't wide enough to actually print the full nanoseconds.

Widen the time key column width when --ns is specified.

Before:

  % perf record -a sleep 1
  % perf report --sort time,overhead,symbol --stdio --ns
  ...
       2.39%  187851.10000  [k] smp_call_function_single   -      -
       1.53%  187851.10000  [k] intel_idle                 -      -
       0.59%  187851.10000  [.] __wcscmp_ifunc             -      -
       0.33%  187851.10000  [.] 0000000000000000           -      -
       0.28%  187851.10000  [k] cpuidle_enter_state        -      -

After:

  % perf report --sort time,overhead,symbol --stdio --ns
  ...
       2.39%  187851.100000000  [k] smp_call_function_single   -      -
       1.53%  187851.100000000  [k] intel_idle                 -      -
       0.59%  187851.100000000  [.] __wcscmp_ifunc             -      -
       0.33%  187851.100000000  [.] 0000000000000000           -      -
       0.28%  187851.100000000  [k] cpuidle_enter_state        -      -

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190823210338.12360-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 8efbf58..3370267 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -193,7 +193,10 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	hists__new_col_len(hists, HISTC_MEM_LVL, 21 + 3);
 	hists__new_col_len(hists, HISTC_LOCAL_WEIGHT, 12);
 	hists__new_col_len(hists, HISTC_GLOBAL_WEIGHT, 12);
-	hists__new_col_len(hists, HISTC_TIME, 12);
+	if (symbol_conf.nanosecs)
+		hists__new_col_len(hists, HISTC_TIME, 16);
+	else
+		hists__new_col_len(hists, HISTC_TIME, 12);
 
 	if (h->srcline) {
 		len = MAX(strlen(h->srcline), strlen(sort_srcline.se_header));
