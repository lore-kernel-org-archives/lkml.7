Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E80C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67902183E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfCSKU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:20:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbfCSKU3 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:20:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA98330BC64F;
        Tue, 19 Mar 2019 10:20:28 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id DDD9F60FD9;
        Tue, 19 Mar 2019 10:20:25 +0000 (UTC)
Date:   Tue, 19 Mar 2019 11:20:25 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 0/4] perf: Support a new 'percore' event qualifier
Message-ID: <20190319102025.GA20602@krava>
References: <1552985816-20915-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552985816-20915-1-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 19 Mar 2019 10:20:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 04:56:52PM +0800, Jin Yao wrote:
> The 'percore' event qualifier which sums up the event counts for both
> hardware threads in a core. For example,
> 
> perf stat -e cpu/event=0,umask=0x3,percore=1/,cpu/event=0,umask=0x3/
> 
> In this example, we count the event 'ref-cycles' per-core and per-CPU in
> one perf stat command-line.
> 
> We can already support per-core counting with --per-core, but it's
> often useful to do this together with other metrics that are collected
> per CPU (per hardware thread). So this patch series supports this
> per-core counting on a event level.
> 
>  v3:
>  ---
>  Simplify the patch: "perf: Add a 'percore' event qualifier"
>  Other patches don't have changes.

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
>  v2:
>  ---
>  1. Change 'coresum' to 'percore'.
>  2. Move the aggregate counts printing to a seperate patch.
> 
> Jin Yao (4):
>   perf: Add a 'percore' event qualifier
>   perf stat: Factor out aggregate counts printing
>   perf stat: Support 'percore' event qualifier
>   perf test: Add a simple test for term 'percore'
> 
>  tools/perf/Documentation/perf-stat.txt |   4 ++
>  tools/perf/builtin-stat.c              |  21 +++++++
>  tools/perf/tests/parse-events.c        |  10 ++-
>  tools/perf/util/evsel.c                |   2 +
>  tools/perf/util/evsel.h                |   3 +
>  tools/perf/util/parse-events.c         |  27 +++++++++
>  tools/perf/util/parse-events.h         |   1 +
>  tools/perf/util/parse-events.l         |   1 +
>  tools/perf/util/stat-display.c         | 108 ++++++++++++++++++++++++---------
>  tools/perf/util/stat.c                 |   8 ++-
>  10 files changed, 151 insertions(+), 34 deletions(-)
> 
> -- 
> 2.7.4
> 
