Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E850AC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A4C270DD
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 16:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mil+ru88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbfFCQaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 12:30:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54764 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbfFCQaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 12:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BEN7PA6qkbPjV6WloQExf8cn+SPRvOlp+pl0y2XsEy0=; b=Mil+ru88zrztphrCBQE0ba4ol
        YtZISOID2pKJXzzw8jJAsgFmN4LEwcGGCTf2A2wFSMDIV1EPgfjJVpSBjUPwwBU4nIjF02hqNgpzA
        HXTBRD8m1u7jhTm3QUXAfheTDJT+dpT3YndiPl33Gcivb3uejwf6R7Hw9/0E/N2e2rVamoybUVitl
        jAmJ70NHwgF+XK5QLe9ggCcgDRx7mNGHEaUeq9bX70VE5aHychuyQWEFuMXHKZD9hf9uL1DCdkiPm
        YP7iCwoCHrYfmbtRFu4EOYAqeWglch9cIwMmOhfnTRP4QCRUsBizxieBU9ObmCDBrT6JJJDUT+a7Y
        2HU6OrYnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hXprB-0004Yv-KK; Mon, 03 Jun 2019 16:30:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 623FD2010DE40; Mon,  3 Jun 2019 18:30:44 +0200 (CEST)
Date:   Mon, 3 Jun 2019 18:30:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, bp@alien8.de, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, qiuxu.zhuo@intel.com,
        tony.luck@intel.com, rui.zhang@intel.com
Subject: Re: [PATCH 2/3] perf/x86/intel: Add more Icelake CPUIDs
Message-ID: <20190603163044.GC3402@hirez.programming.kicks-ass.net>
References: <20190603134122.13853-1-kan.liang@linux.intel.com>
 <20190603134122.13853-2-kan.liang@linux.intel.com>
 <20190603154750.GA3402@hirez.programming.kicks-ass.net>
 <ae87acab-5dbe-25a8-93f8-1c8f8ecb547b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae87acab-5dbe-25a8-93f8-1c8f8ecb547b@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 12:14:49PM -0400, Liang, Kan wrote:
> 
> 
> On 6/3/2019 11:47 AM, Peter Zijlstra wrote:
> > On Mon, Jun 03, 2019 at 06:41:21AM -0700, kan.liang@linux.intel.com wrote:
> > > @@ -4962,7 +4965,9 @@ __init int intel_pmu_init(void)
> > >   		x86_pmu.cpu_events = get_icl_events_attrs();
> > >   		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xca, .umask=0x02);
> > >   		x86_pmu.lbr_pt_coexist = true;
> > > -		intel_pmu_pebs_data_source_skl(false);
> > > +		intel_pmu_pebs_data_source_skl(
> > > +			(boot_cpu_data.x86_model == INTEL_FAM6_ICELAKE_X) ||
> > > +			(boot_cpu_data.x86_model == INTEL_FAM6_ICELAKE_XEON_D));
> > 
> > That's pretty sad, a model switch inside a model switch :/
> > 
> > >   		pr_cont("Icelake events, ");
> > >   		name = "icelake";
> > >   		break;
> > 
> > Would something like so not be nicer?
> 
> Yes, it looks better. Thanks.
> 
> Should I combine your patch with mine, and send out V2?
> Or are you prefer to add your patch on top of this patch set?

I'll frob it. Thanks!
