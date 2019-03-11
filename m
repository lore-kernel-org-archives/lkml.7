Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301F7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B352084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfCKOpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:45:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:64519 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727480AbfCKOpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:45:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 07:45:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="133337811"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga007.fm.intel.com with ESMTP; 11 Mar 2019 07:45:10 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 019F7301618; Mon, 11 Mar 2019 07:45:09 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Support sample context in perf report
Date:   Mon, 11 Mar 2019 07:44:51 -0700
Message-Id: <20190311144502.15423-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Changes: 
v6:
Rebase.
Drop already merged patches.
Address review comments: free samples and refactor perf script checking 
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
git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-misc.git perf/streams-6


