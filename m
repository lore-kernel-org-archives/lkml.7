Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AACAC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDCE2146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbfDEQag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:30:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52608 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730554AbfDEQaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:30:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AB27168F;
        Fri,  5 Apr 2019 09:30:35 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A84133F68F;
        Fri,  5 Apr 2019 09:30:31 -0700 (PDT)
Date:   Fri, 5 Apr 2019 17:30:27 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 00/21] Remove Mysterious Macro Intended to Obscure
 Weird Behaviours (mmiowb())
Message-ID: <20190405163027.GA19813@fuggles.cambridge.arm.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
 <CAHk-=wiarqZVH52VuKDiPk7Jqf1H-znf-NMoGkKnM7H08VN5fg@mail.gmail.com>
 <20190405160919.GA7857@fuggles.cambridge.arm.com>
 <CAHk-=wiBQwAL5hoLD9-EmCAf1N9CUmUkuj_jJhUCsboNLy-uLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiBQwAL5hoLD9-EmCAf1N9CUmUkuj_jJhUCsboNLy-uLw@mail.gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 06:15:12AM -1000, Linus Torvalds wrote:
> On Fri, Apr 5, 2019 at 6:09 AM Will Deacon <will.deacon@arm.com> wrote:
> > >
> > > Or did I miss something? I think the ia64() mb/rmb/wmb stuff only
> > > works on normal memory on ia64.
> >
> > I was worried about RISC-V, but actually their wmb() is "fence ow,ow"
> > which I think is stronger than their mmiowb() "fence o,w" implementation.
> 
> Also with smp_store_release -> smp_load_acquire kind of ordering?

Hmm, to be honest, I'm not convinced that smp_load_acquire() is ordered
wrt subsequent I/O on RISC-V anyway, so in the pattern of:

CPU 0:
writel(1, dev);
wmb();
smp_store_release(&x, 1);

CPU 1:
if (smp_load_acquire(&x) == 1)
	writel(2, dev)

then I think it's actually the control dependency in CPU 1 that provides
the expected ordering. That's probably quite fragile.

> Again, this is not at all a NAK - I think we should do this - just
> perhaps a request to add a note to the commit and make people aware of
> the issue.

Right, I'll do that.

Will
