Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E1BCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EA1218BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572877621;
	bh=0IjKRPtlsAuGGSBfyycUTHeq+OKoAcUZR2xfdqbrOgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q1DxCjvG9VegG6clq099ARHtXukBoXcDsBYTo1LbmvTkfXxpKYagZP8+S7Wh0Lquw
	 ZRco5zg+wAnSXc48aqtSsORAEZ8PNYbR0gX7AaHGpcDZYcq/uirFt03ZJU5WDZS/qn
	 WXVltqXiPPWahUAsi5TPi/o0XSjGixDBq4Fia4kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfKDO1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:27:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:43120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728174AbfKDO1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:27:00 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01E0A217F4;
        Mon,  4 Nov 2019 14:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572877619;
        bh=0IjKRPtlsAuGGSBfyycUTHeq+OKoAcUZR2xfdqbrOgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EcwNhrNW699SAWToP/HTLcjb/0Z5KD9Ws4UgUPP7G8FaI4CkH1achz2b6G8yRHmPX
         KUp8mUaFn23KKjjV7S2q8vXsnnkEzHKzEAr4SIsa4FWir9RubmKdDuAKKQDOi7z3UW
         gtlvHv2zF/WuZLLl1N2CUhO2A3M06mGFLMG2ZfgA=
Date:   Mon, 4 Nov 2019 14:26:54 +0000
From:   Will Deacon <will@kernel.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, liuqi115@hisilicon.com,
        huangdaode@hisilicon.com, john.garry@huawei.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC] About perf-mem command support on arm64 platform
Message-ID: <20191104142654.GA24609@willie-the-truck>
References: <74f8ddb5-13cc-5dce-82a6-ca8bd02f8175@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74f8ddb5-13cc-5dce-82a6-ca8bd02f8175@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 05:18:00PM +0800, Shaokun Zhang wrote:
> perf-mem is used to profile memory access which has been implemented on x86
> platform. It needs mem-stores events and mem-loads/load-latency.
> For mem-stores events, it is MEM_INST_RETIRED_ALL_STORES whose raw number
> is r82d0, and mem-loads/load-latency is from PEBS if I follow its code.
> 
> Now, for some arm64 cores, like HiSilicon's tsv110 and ARM's Neoverse N1,
> has supported the SPE(Statistical Profiling Extensions), so is it a
> possibility that perf-mem is supported on arm64?
> https://developer.arm.com/ip-products/processors/neoverse/neoverse-n1

I don't understand the relationship you're trying to draw between mem-stores
and SPE. How does perf-mem work and what does it actually require from the
CPU?

One thing that may be worth noting is that SPE isn't generally able to
capture information about all instructions being executed by the CPU:
instead, it instructions (most likely micro-ops) are sampled based on
some user-specified period. The CPU advertises a minimum recommended
period which we expose under /sys and enforce when programming events.

> For arm64 PMU, it has 'st_retired' event that the event number is 0x0007
> which is equal to mem-stores on x86, if we want support perf-mem, it seems
> that 'st_retired' shall be replaced by 'mem-stores'
> in arch/arm64/kernel/perf_event.c file. Of course, the cpu core should
> support st_retired event. I'm not sure Will/Mark are happy on this.;-)
> 
> For mem-loads/load-latency, we can derive them from SPE sampled data which
> supports by load_filter and min_latency in SPE driver. and we may do some
> work on tools/perf/builtin-mem.c.

I don't see how you could reconcile the sampling nature of SPE with a
CPU PMU counter, particularly as filtering in SPE happens /after/ sampling.

> From the above conditions, it seems that we may have the opportunity to
> support the perf-mem command on arm64.
> I'm not very sure about it, so I send this RFC and any comments are welcome.

I don't think there's enough information here to comment meaningfully more
than SPE != PEBS.

Will
