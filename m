Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C3FC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F2422CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 11:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WIeV35zB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfHULVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 07:21:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34912 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfHULVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 07:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zn3ejhAASFSRg1tK+lTcY6WiRVoDmLTbMDhh5WUo4kM=; b=WIeV35zBNqv7yPM8SA3WzOWgm
        KyQ5IiHHuhQirkKsaIvQm/Y8yQ8vsoHh7OuEeD6xl2KQ12MPzYrEimbiLPzTXeuQHe+g3SY+7INJT
        Icz6HmwoWk0uWsRPaj0J+zWOJp2Ymk0R3WqQ1O5JacQbSLDjhHAk0oBmWul6X5of5iU3ttecLv6U0
        GcdxgmkYWl482jrmlDTD65sYgeFk2/+dKrS5HLrYFCVMWDGsps3whjkgRHU1tHdJ49jwR1/SMZXI4
        QgPQv3ptU0ausBAgtZ7ZXIXmIf5qflNCqVpxgit7eMp96E/tDL46yve9crbyWhe2frxcW5ZTkGRTv
        QgthHe+uw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i0Og0-0003Jk-OB; Wed, 21 Aug 2019 11:21:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A219307602;
        Wed, 21 Aug 2019 13:20:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F63020A21FC6; Wed, 21 Aug 2019 13:21:13 +0200 (CEST)
Date:   Wed, 21 Aug 2019 13:21:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>, kan.liang@intel.com,
        Rik van Riel <riel@surriel.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/9] sched/core: add is_kthread() helper
Message-ID: <20190821112113.GA2332@hirez.programming.kicks-ass.net>
References: <20190814104131.20190-1-mark.rutland@arm.com>
 <20190814104131.20190-2-mark.rutland@arm.com>
 <CAMuHMdV_hZ-uMmKdqEutLL5+XkhhcKdSaurMUS2N46AhZwDNKQ@mail.gmail.com>
 <20190814113232.GE17931@lakrids.cambridge.arm.com>
 <20190819085213.GA15409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819085213.GA15409@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 10:52:13AM +0200, Ingo Molnar wrote:
> * Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Aug 14, 2019 at 01:26:43PM +0200, Geert Uytterhoeven wrote:
> > > On Wed, Aug 14, 2019 at 12:43 PM Mark Rutland <mark.rutland@arm.com> wrote:

> > > > +static inline bool is_kthread(const struct task_struct *p)
> > > > +{
> > > > +       return !!(p->flags & PF_KTHREAD);
> > > 
> > > The !! is not really needed.
> > > Probably you followed is_idle_task() above (where it's also not needed).
> > 
> > Indeed! I'm aware of the implicit bool conversion, but kept that for
> > consistency.
> > 
> > Peter, Ingo, do you have a preference?
> 
> So the !! pattern is useful where the return value is an integer (i.e. 
> there's a risk of non-bool use) - but the return value is an explicit 
> bool here, so !! is IMO an entirely superfluous obfuscation.

Yeah, no real preference, for giggles, (_Bool) also seems to work.

