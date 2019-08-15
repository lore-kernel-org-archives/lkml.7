Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8886C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957362084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 12:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbfHOMvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 08:51:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41376 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731645AbfHOMvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 08:51:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4213C057F2E;
        Thu, 15 Aug 2019 12:51:12 +0000 (UTC)
Received: from krava (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id EA9E75C1D8;
        Thu, 15 Aug 2019 12:51:09 +0000 (UTC)
Date:   Thu, 15 Aug 2019 14:51:09 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, jeremie.galarneau@efficios.com,
        shawn@git.icu, tstoyanov@vmware.com, tglx@linutronix.de,
        alexey.budankov@linux.intel.com, adrian.hunter@intel.com,
        songliubraving@fb.com, ravi.bangoria@linux.ibm.com
Subject: Re: [PATCH]Perf: Return error code for perf_session__new function on
 failure
Message-ID: <20190815125109.GF30356@krava>
References: <20190814092654.7781.81601.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814092654.7781.81601.stgit@localhost.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 15 Aug 2019 12:51:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 03:02:18PM +0530, Mamatha Inamdar wrote:
> This Patch is to return error code of perf_new_session function
> on failure instead of NULL
> ----------------------------------------------
> Test Results:
> 
> Before Fix:
> 
> $ perf c2c report -input
> failed to open nput: No such file or directory
> 
> $ echo $?
> 0
> ------------------------------------------
> After Fix:
> 
> $ ./perf c2c report -input
> failed to open nput: No such file or directory
> 
> $ echo $?
> 254
> 
> Signed-off-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
> Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Reported-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
> Tested-by: Nageswara R Sastry <rnsastry@linux.vnet.ibm.com>
> ---
>  tools/perf/builtin-annotate.c      |    5 +++--
>  tools/perf/builtin-buildid-cache.c |    5 +++--
>  tools/perf/builtin-buildid-list.c  |    5 +++--
>  tools/perf/builtin-c2c.c           |    6 ++++--
>  tools/perf/builtin-diff.c          |    9 +++++----
>  tools/perf/builtin-evlist.c        |    5 +++--
>  tools/perf/builtin-inject.c        |    5 +++--
>  tools/perf/builtin-kmem.c          |    5 +++--
>  tools/perf/builtin-kvm.c           |    9 +++++----
>  tools/perf/builtin-lock.c          |    5 +++--
>  tools/perf/builtin-mem.c           |    5 +++--
>  tools/perf/builtin-record.c        |    5 +++--
>  tools/perf/builtin-report.c        |    4 ++--
>  tools/perf/builtin-sched.c         |   11 ++++++-----
>  tools/perf/builtin-script.c        |    9 +++++----
>  tools/perf/builtin-stat.c          |   11 ++++++-----
>  tools/perf/builtin-timechart.c     |    5 +++--
>  tools/perf/builtin-top.c           |    5 +++--
>  tools/perf/builtin-trace.c         |    4 ++--
>  tools/perf/util/data-convert-bt.c  |    4 +++-
>  tools/perf/util/session.c          |   13 +++++++++----
>  21 files changed, 80 insertions(+), 55 deletions(-)

I'm getting few conflicts, please rebase to latest Arnaldo's perf/core

patching file builtin-annotate.c
patching file builtin-buildid-cache.c
patching file builtin-buildid-list.c
patching file builtin-c2c.c
patching file builtin-diff.c
patching file builtin-evlist.c
patching file builtin-inject.c
patching file builtin-kmem.c
patching file builtin-kvm.c
patching file builtin-lock.c
patching file builtin-mem.c
patching file builtin-record.c
Hunk #2 succeeded at 1361 (offset 23 lines).
patching file builtin-report.c
patching file builtin-sched.c
patching file builtin-script.c
Hunk #1 FAILED at 48.
Hunk #2 succeeded at 3073 (offset 1 line).
Hunk #3 succeeded at 3743 (offset 1 line).
1 out of 3 hunks FAILED -- saving rejects to file builtin-script.c.rej
patching file builtin-stat.c
Hunk #1 succeeded at 81 with fuzz 1.
Hunk #2 succeeded at 1447 (offset 1 line).
Hunk #3 succeeded at 1646 (offset 1 line).
patching file builtin-timechart.c
patching file builtin-top.c
Hunk #1 succeeded at 74 (offset -1 lines).
Hunk #2 succeeded at 1668 (offset 25 lines).
patching file builtin-trace.c
Hunk #1 succeeded at 3573 (offset 320 lines).
patching file util/data-convert-bt.c
patching file util/session.c
Hunk #1 succeeded at 30 (offset 2 lines).
Hunk #2 succeeded at 184 (offset 2 lines).
Hunk #3 succeeded at 199 (offset 2 lines).
Hunk #4 succeeded at 222 (offset 2 lines).
Hunk #5 succeeded at 257 (offset 2 lines).

thanks,
jirka
