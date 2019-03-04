Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED74C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1474420663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfCDOtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:49:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfCDOs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:48:58 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 69CDB368A5;
        Mon,  4 Mar 2019 14:48:57 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0E4045D96F;
        Mon,  4 Mar 2019 14:48:55 +0000 (UTC)
Date:   Mon, 4 Mar 2019 15:48:55 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 10/11] perf tools report: Implement browsing of
 individual samples
Message-ID: <20190304144855.GL30476@krava>
References: <20190228183550.14126-1-andi@firstfloor.org>
 <20190228183550.14126-11-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228183550.14126-11-andi@firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 04 Mar 2019 14:48:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:35:49AM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Now report can show whole time periods with perf script,
> but the user still has to find individual samples of interest
> manually.
> 
> It would be expensive and complicated to search for the
> right samples in the whole perf file. Typically users
> only need to look at a small number of samples for useful
> analysis.
> 
> Also the full scripts tend to show samples of all CPUs and all
> threads mixed up, which can be very confusing on larger systems.
> 
> Add a new --samples option to save a small random number of samples
> per hist entry
> 
> Use a reservoir sample technique to select a representatve
> number of samples.
> 
> Then allow browsing the samples using perf script
> as part of the hist entry context menu. This automatically
> adds the right filters, so only the thread or cpu of the sample
> is displayed. Then we use less' search functionality
> to directly jump the to the time stamp of the selected
> sample.
> 
> It uses different menus for assembler and source display.
> Assembler needs xed installed and source needs debuginfo.
> 
> Currently it only supports as many samples as fit on
> the screen due to some limitations in the slang ui code.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> ---
> v2:
> Free names on error path
> Pass --inline and --show-*-event to child perf as needed.
> ---
>  tools/perf/Documentation/perf-report.txt |  4 ++
>  tools/perf/builtin-report.c              |  2 +
>  tools/perf/ui/browsers/Build             |  1 +
>  tools/perf/ui/browsers/hists.c           | 47 ++++++++++++++
>  tools/perf/ui/browsers/res_sample.c      | 80 ++++++++++++++++++++++++
>  tools/perf/ui/browsers/scripts.c         |  2 +-
>  tools/perf/util/hist.c                   | 36 +++++++++++
>  tools/perf/util/hist.h                   | 19 ++++++
>  tools/perf/util/sort.h                   |  8 +++
>  tools/perf/util/symbol.c                 |  1 +
>  tools/perf/util/symbol_conf.h            |  1 +
>  11 files changed, 200 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/ui/browsers/res_sample.c
> 
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index 546d87221ad8..f441baa794ce 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -461,6 +461,10 @@ include::itrace.txt[]
>  --socket-filter::
>  	Only report the samples on the processor socket that match with this filter
>  
> +--samples=N::
> +	Save N individual samples for each histogram entry to show context in perf
> +	report tui browser.

maybe we could set some default value (50?)

jirka
