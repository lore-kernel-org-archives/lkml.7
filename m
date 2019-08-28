Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428DBC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F732173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uBN6WOyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfH1Joh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 05:44:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46098 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfH1Jog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iMElaPHo9zrK/w4FeEoSdgqVnRRksQQkwN7eaOl29aM=; b=uBN6WOySY87QGJwkICPVfucD0
        n0ThbK+dhXQgvnJWZP+1OEFmA326ZGLBNRuJLzDGW9a7V8y6pcnEZ9tE3NVUvCmYiL/lik41095hO
        beu9s4fDhtlsD80ymXnRXbr/5SiK5QXK8u6xNG4EgYXYp7DyxuGrWjcJVbLvgHwzN5bu91YNt9lLo
        yxs3DFeSBG8cnZnTgG79dj8f83MbGIaRhxdBkr+IpVdsn4D4sN8HUK3Ev7WU/mzkazUNYNGJnz/13
        63YW32lQMoX05DNCuadMwVBXFownuDfTaJPWxQeRLC9/jDawzLngBnMEni/wRtYXHSllpaBfIzeqP
        kZp9kwBaw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2uV3-0008Uq-Ku; Wed, 28 Aug 2019 09:44:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 461783074C6;
        Wed, 28 Aug 2019 11:43:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E4FD420B33561; Wed, 28 Aug 2019 11:44:18 +0200 (CEST)
Date:   Wed, 28 Aug 2019 11:44:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/9] perf/core: Add PERF_RECORD_CGROUP event
Message-ID: <20190828094418.GF2369@hirez.programming.kicks-ass.net>
References: <20190828073130.83800-1-namhyung@kernel.org>
 <20190828073130.83800-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828073130.83800-2-namhyung@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 04:31:22PM +0900, Namhyung Kim wrote:
> To support cgroup tracking, add CGROUP event to save a link between
> cgroup path and inode number.  The attr.cgroup bit was also added to
> enable cgroup tracking from userspace.
> 
> This event will be generated when a new cgroup becomes active.
> Userspace might need to synthesize those events for existing cgroups.
> 
> As aux_output change is also going on, I just added the bit here as
> well to remove possible conflicts later.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  include/uapi/linux/perf_event.h |  15 ++++-
>  kernel/events/core.c            | 112 ++++++++++++++++++++++++++++++++
>  2 files changed, 126 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 7198ddd0c6b1..cb07c24b715f 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -374,7 +374,9 @@ struct perf_event_attr {
>  				namespaces     :  1, /* include namespaces data */
>  				ksymbol        :  1, /* include ksymbol events */
>  				bpf_event      :  1, /* include bpf events */
> -				__reserved_1   : 33;
> +				aux_output     :  1, /* generate AUX records instead of events */
> +				cgroup         :  1, /* include cgroup events */
> +				__reserved_1   : 31;

That looks like a rebase fail, aux_output is not from these patches.
