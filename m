Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EADC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D2A20857
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vCuSZ21e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfDPJbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:31:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbfDPJbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q7Xr99zF4r6jYA93XnsTaf9Eg1/qnFu84nzVS5th2p8=; b=vCuSZ21eWSxfOySyD+iPsw857
        AMvJ+qUqBxnOm1QhnUfyHP0U74NqJasTl26fe3D0nqAk0CRrWHJUPHnYhSxFJNxXCGJ30b3YlICuP
        Kcn2Nwoksj5QF+MscgUGkoNAwUOX1TRjFrKmOXkGnMtEH5kKg3P6N01LMukal/4egTMti4O86pDj7
        Qvm+10NfXHLdFUuGenZ3p2dWKhsoH9iLWveL+U1iwnxtf0oqfMJ2AuCI7MaWs4dVqohuHoUztomoN
        kqsnkX1yLIdkbeZMAmLLi/lvHEs3mN8tr46xV6AwYVwZLwMg89aqV9wK+ArJvvMkevSqV54SToJ7l
        Sz9ZrrVoA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGKR3-0005vz-MZ; Tue, 16 Apr 2019 09:31:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B58629B49941; Tue, 16 Apr 2019 11:31:23 +0200 (CEST)
Date:   Tue, 16 Apr 2019 11:31:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "riel@surriel.com" <riel@surriel.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>, vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH] smp: Do not warn if smp_call_function_single() is doing
 a self call.
Message-ID: <20190416093123.GR11158@hirez.programming.kicks-ass.net>
References: <20190412235341.29379-1-decui@microsoft.com>
 <20190415122128.GO11158@hirez.programming.kicks-ass.net>
 <PU1P153MB01695FDC44C6A2C32C7FB887BF2B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB01695FDC44C6A2C32C7FB887BF2B0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 11:39:57PM +0000, Dexuan Cui wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > Sent: Monday, April 15, 2019 5:21 AM
> > To: Dexuan Cui <decui@microsoft.com>
> > 
> > On Fri, Apr 12, 2019 at 11:53:57PM +0000, Dexuan Cui wrote:
> > > If smp_call_function_single() is calling the function for itself, it's safe
> > > to run with irqs_disabled() == true.
> > >
> > > I hit the warning because I'm in the below path in the .suspend callback of
> > > a "syscore_ops" to support hibernation for a VM running on Hyper-V:
> > >
> > >   hv_synic_cleanup() ->
> > >     clockevents_unbind_device() ->
> > >       clockevents_unbind() ->
> > >         smp_call_function_single().
> > >
> > > When the .suspend callback runs, only CPU0 is online and irqs_disabled() is
> > > true.
> > 
> > Pray tell, how well do you think mutex_lock() works with interrupts
> > disabled?
> 
> Good point. I realized generally speaking this patch makes no sense, so let me
> try the solution proposed by Vitaly, i.e. fix clockevents_unbind() instead.

That's still not the problem. You're calling clockevents_unbind_device()
with IRQs disabled, that's not correct. It doesn't matter what
clockevents_unbind() does thereafter.

You simply cannot do any of this with IRQs disabled, end of story.
