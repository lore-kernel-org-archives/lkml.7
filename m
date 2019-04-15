Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF074C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE13D2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfDOIvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:51:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfDOIvv (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:51:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8A7A81DEB;
        Mon, 15 Apr 2019 08:51:50 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id B872E6013A;
        Mon, 15 Apr 2019 08:51:48 +0000 (UTC)
Date:   Mon, 15 Apr 2019 10:51:48 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 0/4] perf: Support a new 'percore' event qualifier
Message-ID: <20190415085148.GC13124@krava>
References: <1555077590-27664-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555077590-27664-1-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 15 Apr 2019 08:51:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 09:59:46PM +0800, Jin Yao wrote:
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
>  v4:
>  ---
>  Add percore qualifier to documantation.
>  Rebase to latest perf/core branch

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
>  v3:
>  ---
>  Simplify the patch: "perf: Add a 'percore' event qualifier"
>  Other patches don't have changes.
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
>  tools/perf/Documentation/perf-list.txt |  12 ++++
>  tools/perf/Documentation/perf-stat.txt |   4 ++
>  tools/perf/builtin-stat.c              |  21 +++++++
>  tools/perf/tests/parse-events.c        |  10 ++-
>  tools/perf/util/evsel.c                |   2 +
>  tools/perf/util/evsel.h                |   3 +
>  tools/perf/util/parse-events.c         |  27 +++++++++
>  tools/perf/util/parse-events.h         |   1 +
>  tools/perf/util/parse-events.l         |   1 +
>  tools/perf/util/stat-display.c         | 107 ++++++++++++++++++++++++---------
>  tools/perf/util/stat.c                 |   8 ++-
>  11 files changed, 163 insertions(+), 33 deletions(-)
> 
> -- 
> 2.7.4
> 
