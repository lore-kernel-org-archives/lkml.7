Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC909C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA62222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573642193;
	bh=lShpq6wKKwja1j0m890wmOSQ8hsSDtUNvq+rYaZInxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vDtDZasQsEz9c9W3bQo2zMo+wrEI5o/UdxfoQLYIzUO8Nc8zXHwV8dVguRLepxiEN
	 55983DHoCHkmaZbwa8Fm8yEVilocL6qGpkRHWdSllG4om5DO48FGvwtFN7AEfXNMZf
	 TJTE7HsCETQn6FRZTW7AE67B4K27GvP4jvoFKBks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfKMKtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:49:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:43602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfKMKtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:49:52 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67506222BD;
        Wed, 13 Nov 2019 10:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573642191;
        bh=lShpq6wKKwja1j0m890wmOSQ8hsSDtUNvq+rYaZInxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wPnE1zAHiIFwyXcEZWslE5NZbjOYK8Mtp2UVLPfJUV5A8zLtZN16gymcbXt4T9E0w
         vr9D8BGgaUKkY0L67IWMDDa/606Iz++ZY/5WwHZkuwLhltaTO6FWHD47LU7w1r/Wl1
         3tXFT9hUNqDfATuVVvF75t+8Gq7/7NBQjvglskH0=
Date:   Wed, 13 Nov 2019 10:49:45 +0000
From:   Will Deacon <will@kernel.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Vincent Whitchurch <rabinv@axis.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>
Subject: Re: [PATCH v2] buffer: Fix I/O error due to ARM read-after-read
 hazard
Message-ID: <20191113104945.GC25900@willie-the-truck>
References: <20191112130244.16630-1-vincent.whitchurch@axis.com>
 <20191112160855.GA22025@arrakis.emea.arm.com>
 <20191112180034.GB19889@willie-the-truck>
 <20191112182249.GB22025@arrakis.emea.arm.com>
 <CAHk-=wg4vi27mnMVgZ-rzcEdDAjTXrY1Jyz3+=5STcY0bw4-jQ@mail.gmail.com>
 <20191113102357.GA25875@willie-the-truck>
 <20191113103150.GL25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113103150.GL25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Wed, Nov 13, 2019 at 10:31:51AM +0000, Russell King - ARM Linux admin wrote:
> On Wed, Nov 13, 2019 at 10:23:58AM +0000, Will Deacon wrote:
> > On Tue, Nov 12, 2019 at 10:39:01AM -0800, Linus Torvalds wrote:
> > > On Tue, Nov 12, 2019 at 10:22 AM Catalin Marinas
> > > <catalin.marinas@arm.com> wrote:
> > > >
> > > > OK, so this includes changing test_bit() to perform a READ_ONCE.
> > > 
> > > That's not going to happen.
> > 
> > Ok, I'll stick my neck out here, but if test_bit() is being used to read
> > a bitmap that is being concurrently modified (e.g. by set_bit() which boils
> > down to atomic_long_or()), then why isn't READ_ONCE() required? Right now,
> > test_bit takes a 'const volatile unsigned long *addr' argument, so I don't
> > see that you'll get a change in codegen except on alpha and, with this
> > erratum, arm32.
> 
> I'm not entirely clear what you're suggesting, so I'll just pick the
> scenario that I think you're talking about - but I'm not sure it's the
> one you're intending.
> 
> Using test_bit() in one thread and set_bit() on the same bit in another
> thread without locking is going to be racy by definition.  It's entirely
> possible for:
> 
> 	Thread 1			Thread 2
> 	bit = test_bit(...);
> 					set_bit(...);
> 	/* use bit */
> 
> and here, bit == 0 but the bit has been set by thread 2.  Use of the
> result from test_bit() is inherently a non-atomic operation.

I think it's atomic in the same way that atomic_read() is atomic (which is
typically defined using READ_ONCE()).

> This is why we have test_and_set_bit() and friends that atomically test
> that a bit is clear before setting it.  Where this is especially
> important is for some filesystems, as they use test_and_xxx_bit() to
> manage their allocation bitmaps.

Agreed, but what we don't want is something like:

	Thread 1			Thread 2
					set_bit(...); // bit is now 1
	test_bit(...); // returns 1
	test_bit(...); // returns 0

which is what can happen due to this erratum. It's generally good practice
to use READ_ONCE() when reading something which can be updated concurrently
because:

	* It ensures that the value is (re-)loaded from memory

	* It prevents the compiler from performing harmful optimisations,
	  such as merging or tearing (although in this case I suspect
	  these are ok because we're dealing with a single bit)

	* On Alpha, it gives you a barrier so that dependency ordering
	  can be relied upon from the load

	* It keeps KCSAN happy

I think the current definition of test_bit() gives you the first two by
casting to volatile explicitly, but not the second two.

So I'm mainly curious as to the disconnect between my thinking and Linus's
"That's not going to happen" comment, given that it shouldn't have an
impact on architectures that don't need magic here.

Will
