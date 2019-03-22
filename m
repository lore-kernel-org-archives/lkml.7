Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F90C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C672054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DjBgkn7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390637AbfCVMaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:30:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389779AbfCVMad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tbqj9yH3c6i2fdwjk5RqNfWptdmwcaU7Mv4hDOSCRGw=; b=DjBgkn7wR87i9b6rv3PofseYV
        AyEcNApeJV+JS/HKPcDEVS4iKFLtt16IoqS1F3AwMZIUpp07uCNtS3yYt47KyQ+K8OU4mTCkeC3jp
        UsL/iFYwIaFzjTnhJ+2eTDdMAUeKviGGnf5G+jFt9R97fqxxp2GZEi2+z/MNDh7DQLQBgGcshG+qz
        0KfX6zt1snGzrml0rGkEVelpBaPa8drpiu1WPfMJYyZEtNU1uol87qFpIR2iZg7aGBw5LthQmkdRJ
        /yYFQ83iNnzwZ7/O/NKcoeltTC/mu373wGYgvNemo5Vwc6r6VAxW/pr83zilqU78Z8pCQuTUEZMHY
        0mCqfaWHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h7JJc-0000VB-8X; Fri, 22 Mar 2019 12:30:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A4CE203C06F3; Fri, 22 Mar 2019 13:30:25 +0100 (CET)
Date:   Fri, 22 Mar 2019 13:30:25 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V2 04/23] perf/x86/intel: Support adaptive PEBSv4
Message-ID: <20190322123025.GS6058@hirez.programming.kicks-ass.net>
References: <20190321205703.4256-1-kan.liang@linux.intel.com>
 <20190321205703.4256-5-kan.liang@linux.intel.com>
 <20190321212059.GD7905@worktop.programming.kicks-ass.net>
 <701a0cb7-d2ae-2d55-b5ef-57f4094c994f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <701a0cb7-d2ae-2d55-b5ef-57f4094c994f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 08:40:03PM -0400, Liang, Kan wrote:
> 
> 
> On 3/21/2019 5:20 PM, Peter Zijlstra wrote:
> > On Thu, Mar 21, 2019 at 01:56:44PM -0700, kan.liang@linux.intel.com wrote:
> > > @@ -933,6 +1001,34 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc, struct pmu *pmu)
> > >   		update = true;
> > >   	}
> > > +	/*
> > > +	 * The PEBS record doesn't shrink on the del. Because to get
> > > +	 * an accurate config needs to go through all the existing pebs events.
> > > +	 * It's not necessary.
> > > +	 * There is no harmful for a bigger PEBS record, except little
> > > +	 * performance impacts.
> > > +	 * Also, for most cases, the same pebs config is applied for all
> > > +	 * pebs events.
> > > +	 */
> > > +	if (x86_pmu.intel_cap.pebs_baseline && add) {
> > > +		u64 pebs_data_cfg;
> > > +
> > > +		/* Clear pebs_data_cfg and pebs_record_size for first PEBS. */
> > > +		if (cpuc->n_pebs == 1) {
> > > +			cpuc->pebs_data_cfg = 0;
> > > +			cpuc->pebs_record_size = sizeof(struct pebs_basic);
> > > +		}
> > 
> > Argh, no. This is daft. The previous site was fine, it was just the
> > pebs_record_size assignment I'm confused about.
> > 
> > Note how by setting ->pebs_data_cfs to 0, you force the below branch to
> > true and call adaptive_pebs_record_size_update() ? So _why_ do you have
> > to set pebs_record_size()?
> > 
> 
> I think we have to reset both cpuc->pebs_data_cfg and
> cpuc->pebs_record_size. Because pebs_update_adaptive_cfg() can return 0.
> If so, adaptive_pebs_record_size_update() will not be called. The
> cpuc->pebs_record_size still use the stale data, which may be wrong.

Oh, bugger.. I see.

> > > +
> > > +		pebs_data_cfg = pebs_update_adaptive_cfg(event);
> > > +
> > > +		/* Update pebs_record_size if new event requires more data. */
> > > +		if (pebs_data_cfg & ~cpuc->pebs_data_cfg) {
> > > +			cpuc->pebs_data_cfg |= pebs_data_cfg;
> > > +			adaptive_pebs_record_size_update();
> > > +			update = true;
> > > +		}
> > > +	}
> > > +
> > >   	if (update)
> > >   		pebs_update_threshold(cpuc);
> > >   }
