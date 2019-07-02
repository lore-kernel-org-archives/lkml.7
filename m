Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911BBC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 11:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3EE20836
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 11:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfGBLH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 07:07:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfGBLH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 07:07:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D63E88313;
        Tue,  2 Jul 2019 11:07:53 +0000 (UTC)
Received: from krava (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 345422D351;
        Tue,  2 Jul 2019 11:07:44 +0000 (UTC)
Date:   Tue, 2 Jul 2019 13:07:43 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 00/11] perf: Fix errors detected by Smatch
Message-ID: <20190702110743.GA12694@krava>
References: <20190702103420.27540-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702103420.27540-1-leo.yan@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 02 Jul 2019 11:07:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 06:34:09PM +0800, Leo Yan wrote:
> When I used static checker Smatch for perf building, the main target is
> to check if there have any potential issues in Arm cs-etm code.  So
> finally I get many reporting for errors/warnings.
> 
> I used below command for using static checker with perf building:
> 
>   # make VF=1 CORESIGHT=1 -C tools/perf/ \
>     CHECK="/root/Work/smatch/smatch --full-path" \
>     CC=/root/Work/smatch/cgcc | tee smatch_reports.txt
> 
> I reviewed the errors one by one, if I understood some of these errors
> so changed the code as I can, this patch set is the working result; but
> still leave some errors due to I don't know what's the best way to fix
> it.  There also have many inconsistent indenting warnings.  So I firstly
> send out this patch set and let's see what's the feedback from public
> reviewing.
> 
> Leo Yan (11):
>   perf report: Smatch: Fix potential NULL pointer dereference
>   perf stat: Smatch: Fix use-after-freed pointer
>   perf top: Smatch: Fix potential NULL pointer dereference
>   perf annotate: Smatch: Fix dereferencing freed memory
>   perf trace: Smatch: Fix potential NULL pointer dereference
>   perf hists: Smatch: Fix potential NULL pointer dereference
>   perf map: Smatch: Fix potential NULL pointer dereference
>   perf session: Smatch: Fix potential NULL pointer dereference
>   perf intel-bts: Smatch: Fix potential NULL pointer dereference
>   perf intel-pt: Smatch: Fix potential NULL pointer dereference
>   perf cs-etm: Smatch: Fix potential NULL pointer dereference

from quick look it all looks good to me, nice tool ;-)

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
>  tools/perf/builtin-report.c    |  4 ++--
>  tools/perf/builtin-stat.c      |  2 +-
>  tools/perf/builtin-top.c       |  8 ++++++--
>  tools/perf/builtin-trace.c     |  5 +++--
>  tools/perf/ui/browsers/hists.c | 13 +++++++++----
>  tools/perf/util/annotate.c     |  6 ++----
>  tools/perf/util/cs-etm.c       |  2 +-
>  tools/perf/util/intel-bts.c    |  5 ++---
>  tools/perf/util/intel-pt.c     |  5 ++---
>  tools/perf/util/map.c          |  7 +++++--
>  tools/perf/util/session.c      |  3 +++
>  11 files changed, 36 insertions(+), 24 deletions(-)
> 
> -- 
> 2.17.1
> 
