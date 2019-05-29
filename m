Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622B9C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE6423E7F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 16:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B6922hLc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfE2Q6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 12:58:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37930 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfE2Q6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 12:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rXrAP+Iga6tJQXISDarBkMhgvbgqdtXIqdRXFbJlkWA=; b=B6922hLcB0oohhBRVWjTiL+o9
        N0MaAGDDi+9EOp9r0yySf+n7xAs47uxLR1Z+X40pj2kf4o2m+TohopTubZAmJgIEd4a0ML8/tG0AS
        PtCcU0pudTtT+YdSnE9dP68eH49SbaHnxlbMVsnHmnkP7U1gWiMmOq7aA5HyR3ZxcnEot9aGJUa1F
        26YsuJoYiNEWznbP7+NTNVu1iWY7L62sPTDrZwlbQqUPmO8CuQN+UeeyKhFP/Qi/d05R25hsHfvty
        oF9iQPUp1luwWXwhl7s2pdKsJPh5S/ghup86TbtzCLvTx7ogslehlxRe8VQ2KYwMKQe6o6p0jMFlP
        jPiigmHzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW1u3-00085d-J1; Wed, 29 May 2019 16:58:15 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68562201B8CFD; Wed, 29 May 2019 18:58:13 +0200 (CEST)
Date:   Wed, 29 May 2019 18:58:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 4/9] perf/x86/intel: Support hardware TopDown metrics
Message-ID: <20190529165813.GC2623@hirez.programming.kicks-ass.net>
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-5-kan.liang@linux.intel.com>
 <20190528134354.GP2623@hirez.programming.kicks-ass.net>
 <561ec469-2e0b-4749-c184-d07e4f4eaf40@linux.intel.com>
 <20190529075426.GA2623@hirez.programming.kicks-ass.net>
 <110d6e3e-9f50-ad47-5a12-1ccf0b756602@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <110d6e3e-9f50-ad47-5a12-1ccf0b756602@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 10:42:10AM -0400, Liang, Kan wrote:
> On 5/29/2019 3:54 AM, Peter Zijlstra wrote:

> > cd09c0c40a97 ("perf events: Enable raw event support for Intel unhalted_reference_cycles event")
> > 
> > We used the fake event=0x00, umask=0x03 for CPU_CLK_UNHALTED.REF_TSC,
> > because that was not available as a generic event, *until now* it seems.
> > I see ICL actually has it as a generic event, which means we need to fix
> > up the constraint mask for that differently.
> > 
> 
> There is no change for REF_TSC on ICL.

Well, if I look at the SDM for May'19 (latest afaict), Volume 3, Chapter
19.3 'Performance Monitoring Events for Future Intel (C) Core(tm)
Processors' the table lists:

 Event Num.	Umask Value	Event Mask Mnemonic

 00H		03H		CPU_CLK_UNHALTED.REF_TSC

as a generic event, without constraints, unlike any of the preceding
uarchs, where that event was not available except through FIXED2.

That is most certainly a change.

> > But note that for all previous uarchs this event did not in fact exist.
> > 
> > It appears the TOPDOWN.SLOTS thing, which is available in in FIXED3 is
> > event=0x00, umask=0x04, is indeed a generic event too.
> 
> The SLOTS do have a generic event, TOPDOWN.SLOTS_P, event=0xA4, umask=0x1.
> 
> I think we need a fix as below for ICL, so the SLOT event can be extended to
> generic event.
> -	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
> +	FIXED_EVENT_CONSTRAINT(0x01a4, 3),	/* TOPDOWN.SLOTS */

Then WTH is that 00H, 04H event listed in the table? Note the distinct
lack of 'Fixed Counter' or any other contraints in the 'Comments'
column.
