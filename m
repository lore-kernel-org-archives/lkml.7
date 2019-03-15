Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DABC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A68820854
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfCONet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:34:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbfCONet (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:34:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 49DFA3002DC6;
        Fri, 15 Mar 2019 13:34:49 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id E749A61369;
        Fri, 15 Mar 2019 13:34:44 +0000 (UTC)
Date:   Fri, 15 Mar 2019 14:34:43 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 0/3] perf: Support a new coresum event qualifier
Message-ID: <20190315133443.GA5200@krava>
References: <1552665856-27741-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552665856-27741-1-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 15 Mar 2019 13:34:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 12:04:13AM +0800, Jin Yao wrote:
> The coresum event qualifier which sums up the event counts for both
> hardware threads in a core. For example,
> 
> perf stat -e cpu/event=0,umask=0x3,coresum=1/,cpu/event=0,umask=0x3/
> 
> In this example, we count the event 'ref-cycles' per-core and per-CPU in
> one perf stat command-line.
> 
> We can already support per-core counting with --per-core, but it's
> often useful to do this together with other metrics that are collected
> per CPU (per hardware thread). So this patch series supports this
> per-core counting on a event level.

seems useful, but perhaps we should follow the --per-core option
we already have and call it 'per-core' instead of coresum

jirka

> 
> Jin Yao (3):
>   perf: Add a coresum event qualifier
>   perf stat: Support coresum event qualifier
>   perf test: Add a simple test for term coresum
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
