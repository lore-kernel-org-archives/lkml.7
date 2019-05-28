Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815C4C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBE920B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="04iorG8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfE1KCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:02:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48070 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfE1KCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LusDKMLS+m4sZJCVghZn+t8ht/w0Gel9LIuZv0e2CfE=; b=04iorG8B7OxjkIlDfmg0N623K
        H0TsySypnUjwPRESiBehwoKjnD1Cus2xp8T0m28bKV4uAd3/u/8XF8S/mk00S5tFvFPy2Nw+Sh+QK
        lXYYhf+ncCwtmUK1VdJ4E/9zJY4YnYnVTsSfA8AFpcLFjhchF/8bo8q5iYPtdpksQuL88M87PSXTI
        bd9PfxOFgqw/ILtCyCv6+0OhZPDQZbzHj3/jTVm5uWjcuyKuBzUxpF1Ip9ur1fbAIOFIoSKprOVte
        k4Err2llUFCEsd97Cu2xqd58dKJkcQerpbGU31KLl35l1LKIcyG4AHKbZUFVdIdpBGVWmzd0wbnBL
        0qj+2lcAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVYvW-0002XR-Pq; Tue, 28 May 2019 10:01:51 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB5552065C636; Tue, 28 May 2019 12:01:47 +0200 (CEST)
Date:   Tue, 28 May 2019 12:01:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/8] perf/x86: Rework msr probe interface
Message-ID: <20190528100147.GM2623@hirez.programming.kicks-ass.net>
References: <20190527215129.10000-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527215129.10000-1-jolsa@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 11:51:21PM +0200, Jiri Olsa wrote:
> hi,
> following up on [1], [2] and [3], this patchset adds update
> attribute groups to pmu, factors out the MSR probe code and
> use it in msr,cstate* and rapl PMUs.
> 
> The functionality stays the same with one exception:
> the event is not exported if the rdmsr return zero
> on event's msr.

That seems a wee bit dangerous, are we sure none of these counters are 0
by 'accident' when we probe them? I'm thinking esp. things like the Cn
residency stuff could be 0 simply because we've not been into that state
yet.

Other than that, this looks good. Kan?
