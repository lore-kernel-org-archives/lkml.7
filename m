Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C3AC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694C92087C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 14:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfCEOtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 09:49:22 -0500
Received: from mga07.intel.com ([134.134.136.100]:28781 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728141AbfCEOsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 09:48:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2019 06:48:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,444,1544515200"; 
   d="scan'208";a="121150030"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga006.jf.intel.com with ESMTP; 05 Mar 2019 06:48:14 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 460E6301BC6; Tue,  5 Mar 2019 06:48:14 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Support sample context in perf report
Date:   Tue,  5 Mar 2019 06:47:43 -0800
Message-Id: <20190305144758.12397-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Changes: 
v4:
Address review comments. 
Fix --cpu filtering.
Fix a sampling bug.
Add support for configuring custom script menu entries in perfconfig.
Fix display of more samples than fit on screen.
Fix some buffer overruns in legacy code.
Add more tips
]

We currently have two ways to look at sample data in perf:
either use perf report to aggregate everything, or use
perf script to look at all individual samples.

Both ways are useful. Of course aggregation is useful
to quickly find the most expensive part of the code.

But sometimes a single sample is not good enough to
determine the problem and we need to look at context, either
through branch contexts, or other previous samples (e.g. for
correlating different micro architecture events or computing
metrics)

This can be done through perf script today, but it can
be rather cumbersome to find the right samples to look
at.

Another problem with perf report is that it aggregates
the whole measurement period. But many real workloads
have phases where they behave quite differently, and it is
often not useful to combine them into a single histogram.

While this can be worked around with the --time option
to report, it can be quite cumbersome.

This patch kit attempts to address some of these
problems in perf report by making it time aware.

- It adds a new time sort key that allows perf report
to separate samples from different regions. The time
regions can be defined with a new --time-quantum option.

- Then it extends the perf script support in the
tui record browser to allow browsing samples for 
different time regions from within a perf report
session.

- Extends the report browser script display
to automatically select sensible defaults
based on what was recorded. For example it will
automatically show branch contexts with -b.

- Support browsing the context of individual samples.
perf report can save a limited number of random samples
per histogram entry with the new --samples option.
Then the browser allows directly jumping to any
of the saved samples and browsing the context on the current
thread or CPU.

There could be probably be done more to make
perf report even better for such use cases (e.g. a real
time line display), but this basic support is good
enough for many useful usages.

Also available in
git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git perf/streams-4


