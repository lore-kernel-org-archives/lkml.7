Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C111C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3523020820
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MxQkl5wb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfIDLdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:33:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33158 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfIDLdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7ZxpYw80TnM8pUdDxCkEZ9lIF/h0K47tY7bLiAqa7C0=; b=MxQkl5wbWOtRJmDF7L+kjiwqn
        FjgAucHm3TGh5oMv5bhgcalqzyhVhqHQULpzIIAU25pplwNxZTzrxRqTcfV4sFl5B7EzUxncC9SMk
        8nEoRHxAhiNHW+MBjvHLgNIUAQYCb+Po7rqtBfOD/NzisZcf6AAhCj1PjwUkkUX0Ks5x4fB7DMEyP
        3nOehKy+ctGoGZzwb1IoE7Ta5u05vQ1rTI3qDbflhflHcmBZkT+Qd9EpEnSoRhRGZaCscH+U5rgds
        RyZu76jnQgPE6rdo4HEkktnXZYzBEqEln7jUMGa6a3UT9zVxajOee5RRUJ4fJy5KFm9pR8lnDySvP
        yvchMp4hQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5TWq-0004RY-JD; Wed, 04 Sep 2019 11:32:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AD86D306024;
        Wed,  4 Sep 2019 13:32:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C4E429D9E73B; Wed,  4 Sep 2019 13:32:47 +0200 (CEST)
Date:   Wed, 4 Sep 2019 13:32:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Alessio Balsini <balsini@android.com>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        luca.abeni@santannapisa.it, bristot@redhat.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 00/13] SCHED_DEADLINE server infrastructure
Message-ID: <20190904113247.GF2349@hirez.programming.kicks-ass.net>
References: <20190726145409.947503076@infradead.org>
 <20190903142732.GA35593@google.com>
 <20190904105037.GE5158@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904105037.GE5158@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 12:50:37PM +0200, Juri Lelli wrote:
> Hi Alessio,
> 
> On 03/09/19 15:27, Alessio Balsini wrote:
> > Hi Peter,
> > 
> > While testing your series (peterz/sched/wip-deadline 7a9e91d3fe951), I ended up
> > in a panic at boot on a x86_64 kvm guest, would you please have a look?  Here
> > attached the backtrace.
> > Happy to test any suggestion that fixes the issue.
> 
> Are you running with latest fix by Peter?
> 
> https://lore.kernel.org/lkml/20190830112437.GD2369@hirez.programming.kicks-ass.net/
> 
> It seems that his wip tree now has d3138279c7f3 on top (and the fix
> above has been merged).
> 
> Not sure it fixes also what you are seeing, though.

He likely is; but it is also very likely I messed it up somehow; I
didn't even boot that branch :/ I'll try and have a look, but I'm
running out of time before LPC.
