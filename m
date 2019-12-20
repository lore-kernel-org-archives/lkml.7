Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D92C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427072146E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 09:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yTdS75r0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfLTJeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 04:34:00 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55114 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbfLTJeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 04:34:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/9YQTDX1rQMnRpGjo8v0aRdduxI1RsOgNUg+1Xxv8xU=; b=yTdS75r0aWwucLsKyw+wk+PmF
        cLq1DvfA0ELGQR7NF5nSilho2SzKSDeeijmcyQ8lJtMnGsK+vrThJuuWDTCSC5GyyMCC6+JHGEqBV
        VHyFwPSkAc4icj6zV1qntdkcikuitH0zi42r3f0Al+6ueWUmmEYhR9/A46Ttu+BLWzWKDDH0RYqwj
        sTN8Mt+G4PfF4j3CB5XauNjGYDKvd5nbwuL1+HR1eTuT64HWiltuLfOZuLfiWREfvEV/ABtSr0uz+
        doxTOZHgQlWX9NdPZggqUeTBqnNq/DiT0V2mFDoKLusxUTSE/bJaI4t8RTbA5c2SoGHYmfy9VdyAa
        4sV3LxQeA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iiEfC-0000FS-15; Fri, 20 Dec 2019 09:33:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C8C8F30073C;
        Fri, 20 Dec 2019 10:32:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 935062B46862F; Fri, 20 Dec 2019 10:33:35 +0100 (CET)
Date:   Fri, 20 Dec 2019 10:33:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/9] perf/core: Add PERF_RECORD_CGROUP event
Message-ID: <20191220093335.GC2844@hirez.programming.kicks-ass.net>
References: <20191220043253.3278951-1-namhyung@kernel.org>
 <20191220043253.3278951-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220043253.3278951-2-namhyung@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 01:32:45PM +0900, Namhyung Kim wrote:
> To support cgroup tracking, add CGROUP event to save a link between
> cgroup path and inode number.  The attr.cgroup bit was also added to
> enable cgroup tracking from userspace.
> 
> This event will be generated when a new cgroup becomes active.
> Userspace might need to synthesize those events for existing cgroups.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

TJ, is this the right thing to do? ISTR you had concerns on this topic
on the past.

> ---
>  include/uapi/linux/perf_event.h |  14 +++-
>  kernel/events/core.c            | 112 ++++++++++++++++++++++++++++++++
>  2 files changed, 125 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 377d794d3105..7bae2d3380a6 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -377,7 +377,8 @@ struct perf_event_attr {
>  				ksymbol        :  1, /* include ksymbol events */
>  				bpf_event      :  1, /* include bpf events */
>  				aux_output     :  1, /* generate AUX records instead of events */
> -				__reserved_1   : 32;
> +				cgroup         :  1, /* include cgroup events */
> +				__reserved_1   : 31;
>  
>  	union {
>  		__u32		wakeup_events;	  /* wakeup every n events */
> @@ -1006,6 +1007,17 @@ enum perf_event_type {
>  	 */
>  	PERF_RECORD_BPF_EVENT			= 18,
>  
> +	/*
> +	 * struct {
> +	 *	struct perf_event_header	header;
> +	 *	u64				id;
> +	 *	u64				path_len;

You can leave out path_len (also u64 for a length field is silly).

> +	 *	char				path[];
> +	 *	struct sample_id		sample_id;
> +	 * };
> +	 */
> +	PERF_RECORD_CGROUP			= 19,
