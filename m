Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B54BC10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C785C2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554203407;
	bh=BHXtPR4mo60+shL/pZju0ayNTt4irIcG6kH9W4xZ8kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pasLhdPJKNTfCmT98FcE18GmpD7QPDDd7HI2fanP+5r4iRHnVtXjslWj7HkvclkxB
	 N+eKwK7xvQHMHRj5sBptHzJHM8tbKLdSlDTSJozDMbReK/UndkTvOG7kwo+6s0pYw4
	 WEH0GTtBcRwIVco240nNXY2ofqEEeN9U0afhOlIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbfDBLKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfDBLKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:10:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 260AC20857;
        Tue,  2 Apr 2019 11:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554203405;
        bh=BHXtPR4mo60+shL/pZju0ayNTt4irIcG6kH9W4xZ8kg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2N4ohzshikzqkyPVJaN7FFSGSbZbNQ8rooWhhIliBnB2OpFKtqEJIYifWOwv9VTbc
         vp9WHz0GoRQvliN9TF7LkAmhdJzRCZyKLDYUB+dh7P4nQflPwV/Pw6aRJUImTqvf4A
         kEYoW1srHt4/b1VQUfFLl81hel2lZvIbHkTAuPkk=
Date:   Tue, 2 Apr 2019 13:10:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Anshul Garg <aksgarg1989@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        David Miller <davem@davemloft.net>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Davidson <md@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4.4 034/131] lib/int_sqrt: optimize small argument
Message-ID: <20190402111003.GB18896@kroah.com>
References: <20190401170051.645954551@linuxfoundation.org>
 <20190401170055.035782875@linuxfoundation.org>
 <d153fa8079c3e49e1ad35a54c400298ba51184e3.camel@perches.com>
 <20190402065958.GA21380@kroah.com>
 <a3d975a7a8e378c5a831d7ae6a98da1af9557c05.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3d975a7a8e378c5a831d7ae6a98da1af9557c05.camel@perches.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 02:00:06AM -0700, Joe Perches wrote:
> On Tue, 2019-04-02 at 08:59 +0200, Greg Kroah-Hartman wrote:
> > On Mon, Apr 01, 2019 at 10:42:52AM -0700, Joe Perches wrote:
> > > On Mon, 2019-04-01 at 19:01 +0200, Greg Kroah-Hartman wrote:
> > > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > If this is to be ported just for an optimization
> > > (which I think is dubious as it's not a bug fix),
> > 
> > Yes, it was requested to be backported because of that.
> > 
> > > why not port the __fls optimization too?
> > > 
> > > __fls has a bigger effect on performance.
> > 
> > What commit are you referring to?
> 
> f8ae107eef209bff29a5816bc1aad40d5cd69a80

Thanks for the commit id, I'll look into adding that to a later round of
kernel releases.

greg k-h
