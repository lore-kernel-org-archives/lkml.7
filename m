Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277D3C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77BE2089E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556808855;
	bh=rb0t0m1rrl7nLIEwqnlZ5+rxJJb0Zo/EaTIOLKSeCuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OINh6Iih5Q3jsQftOhpKhW7r38MWnvd2yLIlYyp4vdtFQxrXLMdHWJAA5o2quwwkS
	 eHwYYVBgRo57tNSfjBvJgeGBhpnh010pAPyzqUD5uLpeD/pGJ3Zbj8RmKRw3LfqO6q
	 Z6PZpM8/jklN+u7x0rst7bMzndVhWADxPYudSkyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfEBOyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 10:54:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfEBOyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 10:54:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D5B020652;
        Thu,  2 May 2019 14:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556808852;
        bh=rb0t0m1rrl7nLIEwqnlZ5+rxJJb0Zo/EaTIOLKSeCuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s5FWeGwp9+62+dghztib6O6yr5SedSPXyALbAv7WDIRM3LaDLPuatxyFCIqFjxxX6
         3xLPRK6wEi3UwvkIThRc4rkoE+jw8QouxHE9yvbtHeNL5fgGwtIvRU9XNNeYhyiTkr
         HIChZTyNJVPr70ubAFFCD/nd6cSB1qE9nWacRooI=
Date:   Thu, 2 May 2019 16:54:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        20181129150210.2k4mawt37ow6c2vq@linutronix.de,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Nicolai Stange <nstange@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        stable-commits@vger.kernel.org
Subject: Re: Patch "x86/fpu: Don't export __kernel_fpu_{begin,end}()" has
 been added to the 4.19-stable tree
Message-ID: <20190502145410.GA13656@kroah.com>
References: <1556544977149154@kroah.com>
 <CALCETrVjhVXYA4B6zFzbH14wBXZcNMAeM8YxdRh3RLHxVVde_g@mail.gmail.com>
 <20190502080204.GA2832@kroah.com>
 <CALCETrXx_24vOLosXvOMZ81LKcAnud1A7axZ057wK0KFeBCT3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXx_24vOLosXvOMZ81LKcAnud1A7axZ057wK0KFeBCT3A@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 07:42:21AM -0700, Andy Lutomirski wrote:
> On Thu, May 2, 2019 at 1:02 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, May 01, 2019 at 10:47:07AM -0700, Andy Lutomirski wrote:
> > > On Mon, Apr 29, 2019 at 6:36 AM <gregkh@linuxfoundation.org> wrote:
> > > >
> > > >
> > > > This is a note to let you know that I've just added the patch titled
> > > >
> > > >     x86/fpu: Don't export __kernel_fpu_{begin,end}()
> > > >
> > > > to the 4.19-stable tree which can be found at:
> > > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > >
> > > Why?  ISTM the only possible effect is to break out-of-tree modules.
> > > I have no objection to breaking such modules if we need to, but, in
> > > this case, I don't see the benefit.
> >
> > The "benefit" is that people keep complaining that newer kernels do not
> > have this api for some reason and that it is a "regression", which
> > completely does not understand how the kernel handles internal apis.
> 
> I suppose that's a reasonable point.  But maybe we should actually
> give these modules a credible alternative first?  I just send a patch.

That's your call, it's your code :)

thanks,

greg k-h
