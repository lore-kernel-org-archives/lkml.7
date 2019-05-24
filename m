Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673A1C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEB22168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 11:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558698048;
	bh=fQZ79S4453oANj/QYuLmNFpEoEAa4OcOEjjIQRyx0kM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AumuMl5YVqWHShzBkVdq1IkF+WJ4b53KX2Bu4TM0+XaxylTFHkpfYZ1V14iMrJQsn
	 zxqnFKL3MkDSwJDsXb1GdZK9oGmT7AWtohJiFhGmRK8dd5yer4tS9ucABGMbfXlbfC
	 yepxm10UNDwljDu9bhM8MH/HfzaIqiTb3aFnh/Lg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391194AbfEXLkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 07:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:37958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390743AbfEXLkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 07:40:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FECC2184B;
        Fri, 24 May 2019 11:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558698045;
        bh=fQZ79S4453oANj/QYuLmNFpEoEAa4OcOEjjIQRyx0kM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y766CFz20w56iQEiVbk+UYz2yopXFT5Ke8aJsWAKWhonFidfFmUARU6ydEoAYAjBv
         vKlG9a8R8B+HjXagnuhj/xgJS+damsWJFYAbmKC7brOAZmbR5zKS8kky5bqzAGOGsW
         9iyEUl2/9bA2it5N1HD2zYyUlsDCf1HKLE2DPQjI=
Date:   Fri, 24 May 2019 13:40:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jorgen Hansen <jhansen@vmware.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH 1/2] vmw_vmci: Clean up uses of atomic*_set()
Message-ID: <20190524114042.GA360@kroah.com>
References: <1558694136-19226-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1558694136-19226-2-git-send-email-andrea.parri@amarulasolutions.com>
 <20190524103934.GO2606@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524103934.GO2606@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 12:39:34PM +0200, Peter Zijlstra wrote:
> On Fri, May 24, 2019 at 12:35:35PM +0200, Andrea Parri wrote:
> > The primitive vmci_q_set_pointer() relies on atomic*_set() being of
> > type 'void', but this is a non-portable implementation detail.
> > 
> > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jorgen Hansen <jhansen@vmware.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> > ---
> >  include/linux/vmw_vmci_defs.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
> > index 0c06178e4985b..eb593868e2e9e 100644
> > --- a/include/linux/vmw_vmci_defs.h
> > +++ b/include/linux/vmw_vmci_defs.h
> > @@ -759,9 +759,9 @@ static inline void vmci_q_set_pointer(atomic64_t *var,
> >  				      u64 new_val)
> >  {
> >  #if defined(CONFIG_X86_32)
> > -	return atomic_set((atomic_t *)var, (u32)new_val);
> > +	atomic_set((atomic_t *)var, (u32)new_val);
> >  #else
> > -	return atomic64_set(var, new_val);
> > +	atomic64_set(var, new_val);
> >  #endif
> >  }
> 
> All that should just die a horrible death. That code is crap.
> 
> See:
> 
>   lkml.kernel.org/r/20190524103731.GN2606@hirez.programming.kicks-ass.net

I agree, Peter's patch should be the thing that is applied, not this
one.

thanks,

greg k-h
