Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD22C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5059821783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573558616;
	bh=IBRZ0V+FizBPRXBE7AIelmGcF/rqx4zxpH+FTVnkzDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xg0x4hz+7ndx8tu2gqNPx2/BUtVe1nCBbFEjPPqw0ethqXokJn509E/sOwizLfnIQ
	 E1pVYGyMRuEJP/psdjCjdN+jr8HKY7S7s1ED7ZCaiZJGwCqFNy0JxYHNf66X1+NHBM
	 MvPwKVqFx6/fves7pdJDJKM1l2OOYT+93x6jFOZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfKLLgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:36:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfKLLgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:36:54 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61D6421925;
        Tue, 12 Nov 2019 11:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573558613;
        bh=IBRZ0V+FizBPRXBE7AIelmGcF/rqx4zxpH+FTVnkzDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vgR6vb6pygOrhYdh1tLbICYpzNyLiNW/NGEr6J8+nCx71yHQDyEQ3zjASKeUfsJrC
         tr9H+e8krqDcjj664LKgstygnZJcLRjtIzdyrNXpDLEotbjAeOGuGg3W0fRW/q0rLK
         wrAAh0Cey56Uy6sOjPmN8QeMewVkm+GLfLdNBr24=
Date:   Tue, 12 Nov 2019 11:36:47 +0000
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yunjae Lee <lyj7694@gmail.com>,
        SeongJae Park <sj38.park@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Joe Perches <joe@perches.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 01/13] compiler.h: Split {READ,WRITE}_ONCE definitions
 out into rwonce.h
Message-ID: <20191112113646.GC17835@willie-the-truck>
References: <20191108170120.22331-1-will@kernel.org>
 <20191108170120.22331-2-will@kernel.org>
 <CAK8P3a0f=WvSQSBQ4t0FmEkcFE_mC3oARxaeTviTSkSa-D2qhg@mail.gmail.com>
 <93f80017-d65e-7c3a-29b0-d9a568d08f58@de.ibm.com>
 <CAK8P3a21KdGKMDDPs3jc9XEg3=LbzFnGwVm+xDTB+EqGXiZorA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a21KdGKMDDPs3jc9XEg3=LbzFnGwVm+xDTB+EqGXiZorA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 10:32:46AM +0100, Arnd Bergmann wrote:
> On Mon, Nov 11, 2019 at 9:10 AM Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
> > On 08.11.19 20:57, Arnd Bergmann wrote:
> > > On Fri, Nov 8, 2019 at 6:01 PM Will Deacon <will@kernel.org> wrote:
> > >>
> > >> In preparation for allowing architectures to define their own
> > >> implementation of the 'READ_ONCE()' macro, move the generic
> > >> '{READ,WRITE}_ONCE()' definitions out of the unwieldy 'linux/compiler.h'
> > >> and into a new 'rwonce.h' header under 'asm-generic'.
> > >
> > > Adding Christian Bornträger to Cc, he originally added the
> > > READ_ONCE()/WRITE_ONCE()
> > > code.
> > >
> > > I wonder if it would be appropriate now to revert back to a much simpler version
> > > of these helpers for any modern compiler. As I understand, only gcc-4.6 and
> > > gcc4.7 actually need the song-and-dance version with the union and switch/case,
> > > while for others, we can might be able back to a macro doing a volatile access.
> >
> > As far as I know this particular issue with  volatile access on aggregate types
> > was fixed in gcc 4.8. On the other hand we know that the current construct will
> > work on all compilers. Not so sure about the orignal ACCESS_ONCE implementation.
> 
> I've seen problems with clang on the current version, leading to unnecessary
> temporaries being spilled to the stack in some cases, so I think it would still
> help to simplify it.
> 
> We probably don't want the exact ACCESS_ONCE() implementation back
> that existed before, but rather something that implements the stricter
> READ_ONCE() and WRITE_ONCE(). I'd probably also want to avoid the
> __builtin_memcpy() exception for odd-sized accesses and instead have
> a separate way to do those.

If you have a patch, I'm happy to carry it at the end of the series to
avoid conflicts. It's not completely clear to me what you're after, so if
you need me to adjust anything here then please shout!

Will
