Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDEEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6760220863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cLbfV4zC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfCSQLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:11:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58932 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfCSQLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r87si/t8wAIZCXUDn+L/bEW/tAsq4aFA4dpoOY8KMoI=; b=cLbfV4zCIT8SWAi/eIcQoeQPL
        mPOBKnGbfnd1+LD8943kmmIRKTkjLth/USRxuImctowfWfqQvt3itw3nY9ZlMZy0dx3Z2lCSyuO4G
        IeFkEQbaWNcxlpqzfE+sYuBGutakDu4aBMHwDOhnCi8HNrKxAnikTlDdm7YUZ19gU5SYD90UZoF45
        a1BF94cS+NZ4pUF87Uuu7LkhholwQKGD0jBLQHT8+Be1kW+lGfMnBU2kldmb8CozeIEM9JkEiveDq
        s9fzUcd/ghNWHD/mtlNKC1IUbBTjIYclE0GUbbwN8wJV8zfgmGt/FTyU88NA47k0qUnlAVOS6iOFu
        YJfsDPHLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6HKv-000869-1Y; Tue, 19 Mar 2019 16:11:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C7AF23CB6531; Tue, 19 Mar 2019 17:11:31 +0100 (CET)
Date:   Tue, 19 Mar 2019 17:11:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kan.liang@linux.intel.com, acme@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        eranian@google.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH 03/22] perf/x86/intel: Support adaptive PEBSv4
Message-ID: <20190319161131.GM5996@hirez.programming.kicks-ass.net>
References: <20190318214144.4639-1-kan.liang@linux.intel.com>
 <20190318214144.4639-4-kan.liang@linux.intel.com>
 <20190319144748.GH5996@hirez.programming.kicks-ass.net>
 <20190319160337.GW24002@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319160337.GW24002@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 09:03:37AM -0700, Andi Kleen wrote:
> On Tue, Mar 19, 2019 at 03:47:48PM +0100, Peter Zijlstra wrote:
> > On Mon, Mar 18, 2019 at 02:41:25PM -0700, kan.liang@linux.intel.com wrote:
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > > 
> > > Adaptive PEBS is a new way to report PEBS sampling information. Instead
> > > of a fixed size record for all PEBS events it allows to configure the
> > > PEBS record to only include the information needed. Events can then opt
> > > in to use such an extended record, or stay with a basic record which
> > > only contains the IP.
> > > 
> > > The major new feature is to support LBRs in PEBS record.
> > > This allows (much faster) large PEBS, while still supporting callstacks
> > > through callstack LBR. 
> > 
> > Does it also allow normal LBR usage? Or does it have to be callstacks?
> 
> It allows normal LBR too. But I would expect callstack to be the most
> common one.  As long as you set a period you can get multi-record
> PEBS with -g, which has a lot lower lower overhead than using
> PMIs.
> 
> Eventually I hope we can even make multi-record PEBS
> work in frequency mode by averaging the frequency over multiple
> records.

Should be doable..

> > >  	hwc->config |= ARCH_PERFMON_EVENTSEL_INT;
> > > +	hwc->config &= ~ICL_EVENTSEL_ADAPTIVE;
> > 
> > Just curious; the way I read the SDM, we could leave this set, is that
> > correct?
> 
> It needs to be cleared to get the basic record (which should be
> a common case)

But you unconditionally set the bit when you enable PEBS for the event.
So why clear it?
