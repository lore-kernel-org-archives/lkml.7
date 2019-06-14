Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9750C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C81F20850
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EpsswAWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfFNMey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:34:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38374 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfFNMex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8zcrmpxMTcFzomBktwD/Lbw3zoalWjEgM0thr5hfWlc=; b=EpsswAWp0F1OGy8+g+3HlkkvV
        PEEF/0Ryd+wBb81VkRJhMpJBV2T1YpKPTmdooRQt3i1rDEQsM5KRBOsUjxx/LcWrpIORm/H709q+L
        plNo/BT3PCfcGvIrVUvErYQAwEy3lejpzVkXP7rsE4pTup0+J4jAoZVAmg21RuesHiPDogfHvzBxo
        AtmIEEfPhTWLfD3iBeOuparYVUWy8UmDrDwwPLPHW5JL4ujl1p+Ch9+Op504B6k76SRphjMkvGf8d
        35jVdse6nQLxa0Vr4PGK6X0lPNdxWO+k0IDOOLdcIko2+Tn+PBgy7jsVyUR24DHaiZq3ZWgnOvF6e
        uaiT3UQ+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hblPg-0007iR-Vy; Fri, 14 Jun 2019 12:34:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BAE8520259523; Fri, 14 Jun 2019 14:34:35 +0200 (CEST)
Date:   Fri, 14 Jun 2019 14:34:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] perf/x86/intel: Use is_visible callback for default group
Message-ID: <20190614123435.GM3436@hirez.programming.kicks-ass.net>
References: <20190512155518.21468-1-jolsa@kernel.org>
 <20190512155518.21468-10-jolsa@kernel.org>
 <20190513093545.GM2623@hirez.programming.kicks-ass.net>
 <20190524132152.GB26617@krava>
 <20190614102017.GA4325@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614102017.GA4325@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 12:20:17PM +0200, Jiri Olsa wrote:
> On Fri, May 24, 2019 at 03:21:52PM +0200, Jiri Olsa wrote:
> 
> SNIP
> 
> ping

Well, it looks about right; but last time you asked if someone could
test, and I've no idea. I don't think I have any testboxes that are
affected by this stuff.

I can just merge it I suppose, we'll see if anybody complains :-)

> > ---
> > It's preffered to use group's is_visible callback, so
> > we do not need to use condition attribute assignment.
> > 
> > Cc: Stephane Eranian <eranian@google.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/events/intel/core.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> > index 85afe7e98c7d..cfd61b71136d 100644
> > --- a/arch/x86/events/intel/core.c
> > +++ b/arch/x86/events/intel/core.c
> > @@ -4386,7 +4386,7 @@ static DEVICE_ATTR(allow_tsx_force_abort, 0644,
> >  
> >  static struct attribute *intel_pmu_attrs[] = {
> >  	&dev_attr_freeze_on_smi.attr,
> > -	NULL, /* &dev_attr_allow_tsx_force_abort.attr.attr */
> > +	&dev_attr_allow_tsx_force_abort.attr,
> >  	NULL,
> >  };
> >  
> > @@ -4414,6 +4414,15 @@ exra_is_visible(struct kobject *kobj, struct attribute *attr, int i)
> >  	return x86_pmu.version >= 2 ? attr->mode : 0;
> >  }
> >  
> > +static umode_t
> > +default_is_visible(struct kobject *kobj, struct attribute *attr, int i)
> > +{
> > +	if (attr == &dev_attr_allow_tsx_force_abort.attr)
> > +		return x86_pmu.flags & PMU_FL_TFA ? attr->mode : 0;
> > +
> > +	return attr->mode;
> > +}
> > +
> >  static struct attribute_group group_events_td  = {
> >  	.name = "events",
> >  };
> > @@ -4450,7 +4459,8 @@ static struct attribute_group group_format_extra_skl = {
> >  };
> >  
> >  static struct attribute_group group_default = {
> > -	.attrs = intel_pmu_attrs,
> > +	.attrs      = intel_pmu_attrs,
> > +	.is_visible = default_is_visible,
> >  };
> >  
> >  static const struct attribute_group *attr_update[] = {
> > @@ -4973,7 +4983,6 @@ __init int intel_pmu_init(void)
> >  			x86_pmu.get_event_constraints = tfa_get_event_constraints;
> >  			x86_pmu.enable_all = intel_tfa_pmu_enable_all;
> >  			x86_pmu.commit_scheduling = intel_tfa_commit_scheduling;
> > -			intel_pmu_attrs[1] = &dev_attr_allow_tsx_force_abort.attr;
> >  		}
> >  
> >  		pr_cont("Skylake events, ");
> > -- 
> > 2.20.1
> > 
