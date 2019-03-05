Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF40EC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E722084F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfCEMe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:34:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfCEMe1 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:34:27 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2FCD302451C;
        Tue,  5 Mar 2019 12:34:26 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 92A671001DF0;
        Tue,  5 Mar 2019 12:34:24 +0000 (UTC)
Date:   Tue, 5 Mar 2019 13:34:23 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 0/3] perf diff: Add new filter options
Message-ID: <20190305123423.GA4533@krava>
References: <1551791143-10334-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551791143-10334-1-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 05 Mar 2019 12:34:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 09:05:40PM +0800, Jin Yao wrote:
> This patch series creates following new filter options for perf diff.
> 
> --time:
>     It supports time percent with multipe time ranges. Time string is
>     'a%/n,b%/m,...' or 'a%-b%,c%-%d,...'.
> 
>     For example:
> 
>     Select the second 10% time slice to diff:
>     perf diff --time 10%/2
> 
>     Select from 0% to 10% time slice to diff:
>     perf diff --time 0%-10%
> 
>     Select the first and the second 10% time slices to diff:
>     perf diff --time 10%/1,10%/2
> 
>     Select from 0% to 10% and 30% to 40% slices to diff:
>     perf diff --time 0%-10%,30%-40%
> 
>     It also supports to analyze samples within given time window as:
>     <start>,<stop>. Times have the format seconds.microseconds. If start
>     is not given (i.e., time string is ',x.y') then analysis starts at
>     the beginning of the file. If stop time is not given (i.e, time
>     string is 'x.y,') then analysis goes to end of file. Time string is
>     'a1.b1,c1.d1:a2.b2,c2.d2'. Use ':' to separate timestamps for different
>     perf.data files.
> 
>     For example, we get the timestamp information from perf script.
> 
>     perf script -i perf.data.old
>       mgen 13940 [000]  3946.361400: ...
> 
>     perf script -i perf.data
>       mgen 13940 [000]  3971.150589 ...
> 
>     perf diff --time 3946.361400,:3971.150589,
> 
>     It analyzes the perf.data.old from the timestamp 3946.361400 to
>     the end of perf.data.old and analyzes the perf.data from the
>     timestamp 3971.150589 to the end of perf.data.
> 
> --cpu:
>     Only diff samples for the list of CPUs provided. Multiple CPUs can
>     be provided as a comma-separated list with no space: 0,1. Ranges of
>     CPUs are specified with -: 0-2. Default is to report samples on all
>     CPUs.
> 
>     For example:
>     perf diff --cpu 0,1
> 
>     It only diff the samples for CPU0 and CPU1.
> 
> --pid:
>     Only diff samples for given process ID (comma separated list).
> 
> --tid:
>     Only diff samples for given thread ID (comma separated list).
> 
>     For example,
>     perf diff --tid 13965
> 
>     It only diff the samples for thread 13965.
> 
>  v4:
>  ---
>  Update abstime_str_dup(), let it return error if strdup
>  is failed, and update __cmd_diff() accordingly.
> 
>  Only the patch "perf diff: Support --time filter option" is impacted
>  Others are no logical changes.
> 
> Jin Yao (3):
>   perf diff: Support --time filter option
>   perf diff: Support --cpu filter option
>   perf diff: Support --pid/--tid filter options

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
