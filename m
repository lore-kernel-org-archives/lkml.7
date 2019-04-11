Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B550C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66635217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DIpOrJdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfDKNds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:33:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfDKNds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1kxNf4so3ccyKHWrjAX9qpZgk4c+O7LB1yiNbKc9Z20=; b=DIpOrJdbt2rUKMANhEAr990cN
        XruNqbh3/mLI4AOSr4eaptuFGs8mKLMVJETL0iW01DnkSV+QakAnFgw1/MGXXkQ+fPFJHF7V2ImRX
        RPe4rIlyMzDUMNHHMNuTSgkWDKxFqyv+L0MZWDE7iQjPJ1EFqWnZXC0IIaEHIeb2LtbkUFe6J1wto
        BWGv0BIylfDfkZX8c1CBkUKPJMGimC05kisiY3+5GssfPLzjufgOK/KxX1neqUa/7U8LGCuwCluHW
        wvyoAhS4WuPe7y51XsbWOt10Ft7JmVhEld152CLnLbgOk7aHcMxU7jrfD0JKdT+xtJd+X8hAh4bFg
        Jybi1SbBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hEZpd-0001Q9-Jb; Thu, 11 Apr 2019 13:33:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF97129AB518B; Thu, 11 Apr 2019 15:33:31 +0200 (CEST)
Date:   Thu, 11 Apr 2019 15:33:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        acme@kernel.org, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V2 2/2] perf/x86/intel: Add Tremont core PMU support
Message-ID: <20190411133331.GE11158@hirez.programming.kicks-ass.net>
References: <1554922629-126287-1-git-send-email-kan.liang@linux.intel.com>
 <1554922629-126287-3-git-send-email-kan.liang@linux.intel.com>
 <20190411090658.GD4038@hirez.programming.kicks-ass.net>
 <9ef797ad-bce6-2883-8245-20bdf0b79142@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ef797ad-bce6-2883-8245-20bdf0b79142@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 09:30:10AM -0400, Liang, Kan wrote:

> > I changed that like so:
> > 
> > --- a/arch/x86/events/intel/core.c
> > +++ b/arch/x86/events/intel/core.c
> > @@ -3508,7 +3508,7 @@ tnt_get_event_constraints(struct cpu_hw_
> >   	 */
> >   	if (event->attr.precise_ip == 3) {
> >   		/* Force instruction:ppp on PMC0 and Fixed counter 0 */
> > -		if (EVENT_CONFIG(event->hw.config) == X86_CONFIG(.event=0xc0))
> > +		if (constraint_match(&fixed_counter0_constraint, event->hw.config))
> 
> Should be
> 	if (constraint_match(&fixed0_counter0_constraint, event->hw.config))

No, because fixed0_counter0_constraint doesn't set an event.

The logic as I proposed checks if it fits the fixed0 constraint, and if
so, allows f0-c0, otherwise only c0.

> >   			return &fixed0_counter0_constraint;
> >   		return &counter0_constraint;
> > 
