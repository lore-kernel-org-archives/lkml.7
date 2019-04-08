Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6018C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E8620879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OcFJSgKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfDHQ3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:29:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfDHQ3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jXXglnA1BjEEmfi0CEuMn1wgAY5NZd60rH8B74W3Mm8=; b=OcFJSgKTA4g9VNOLE1Ua6aNE52
        VXx82q5hFOFdUY70tO4J2ersZjTVqizr8zovT3LS1qCoopvA2x6QGL3Ydw6YMdUBJ0LvmAZNPoF3d
        EHT7h5MS/Xy3HsEbseWxtyrSpjgDAu87auSOrT/KFie8I1vxXuiA88piIzo4aiV2lyhWXhhJM3trF
        jptUeLRwEyfLNN2RFec8aq2yDxRlQ1VvKpXsedysWAKlCizNK2WAhrGWU8VYW4QmA0yBAj655ISGe
        IofLccxt+3yLZOeHPZgQGS7/M98Lj4nSWG3We+g4WilQHtRrpSqL4p0v3i8wP4Znc29TkTW+HwPlg
        DQaGPfCA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hDX8j-0000Fj-U7; Mon, 08 Apr 2019 16:28:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 718F42030C798; Mon,  8 Apr 2019 18:28:55 +0200 (CEST)
Date:   Mon, 8 Apr 2019 18:28:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V5 00/12] perf: Add Icelake support (kernel only, except
 Topdown)
Message-ID: <20190408162855.GM4038@hirez.programming.kicks-ass.net>
References: <20190402194509.2832-1-kan.liang@linux.intel.com>
 <20190408154112.GW12232@hirez.programming.kicks-ass.net>
 <ec9e3a07-4b29-b698-83d7-5b8bbcd48dc4@linux.intel.com>
 <c22d3a18-3a49-dc27-5abe-b284021578c0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c22d3a18-3a49-dc27-5abe-b284021578c0@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 12:25:17PM -0400, Liang, Kan wrote:
> 
> > > @@ -963,40 +963,42 @@ static u64 pebs_update_adaptive_cfg(stru
> > >       u64 pebs_data_cfg = 0;
> > >       bool gprs, tsx_weight;
> > > -    if ((sample_type & ~(PERF_SAMPLE_IP|PERF_SAMPLE_TIME)) ||
> > > -        attr->precise_ip < 2) {
> > > +    if (!(sample_type & ~(PERF_SAMPLE_IP|PERF_SAMPLE_TIME)) &&
> > > +        attr->precise_ip > 1)
> > > +        return pebs_data_cfs;
> 
> Sorry, there are two typos. I didn't find in the previous email.
> Should be pebs_data_cfg.
> 
> > > -        if (sample_type & PERF_PEBS_MEMINFO_TYPE)
> > > -            pebs_data_cfg |= PEBS_DATACFG_MEMINFO;
> > > +    if (sample_type & PERF_PEBS_MEMINFO_TYPE)
> > > +        pebs_data_cfg |= PEBS_DATACFG_MEMINFO;
> > > +    /*
> > > +     * We need GPRs when:
> > > +     * + user requested them
> > > +     * + precise_ip < 2 for the non event IP
> > > +     * + For RTM TSX weight we need GPRs for the abort code.
> > > +     */
> > > +    gprs = (sample_type & PERF_SAMPLE_REGS_INTR) &&
> > > +           (attr->sample_regs_intr & PEBS_GPRS_REGS);
> > > +
> > > +    tsx_weight = (sample_type & PERF_SAMPLE_WEIGHT) &&
> > > +             ((attr->config & INTEL_ARCH_EVENT_MASK) ==
> > > +              x86_pmu.rtm_abort_event);
> > > +
> > > +    if (gprs || (attr->precise_ip < 2) || tsx_weight)
> > > +        pebs_data_cfg |= PEBS_DATACFG_GPRS;
> > > +
> > > +    if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
> > > +        (attr->sample_regs_intr & PERF_XMM_REGS))
> 
> Should be PEBS_XMM_REGS.
> 

Ha!, clearly I compile-tested it... oh wait :-)
