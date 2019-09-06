Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76FFC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3952082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393390AbfIFNom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:44:42 -0400
Received: from foss.arm.com ([217.140.110.172]:56358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393347AbfIFNom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:44:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0D5028;
        Fri,  6 Sep 2019 06:44:41 -0700 (PDT)
Received: from localhost (e113682-lin.copenhagen.arm.com [10.32.144.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54DB43F718;
        Fri,  6 Sep 2019 06:44:41 -0700 (PDT)
Date:   Fri, 6 Sep 2019 15:44:40 +0200
From:   Christoffer Dall <christoffer.dall@arm.com>
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     Alexander Graf <graf@amazon.com>,
        Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        kvmarm@lists.cs.columbia.edu,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/1] KVM: inject data abort if instruction cannot be
 decoded
Message-ID: <20190906134440.GH4320@e113682-lin.lund.arm.com>
References: <86r24vrwyh.wl-maz@kernel.org>
 <CAFEAcA-mc6cLmRGdGNOBR0PC1f_VBjvTdAL6xYtKjApx3NoPgQ@mail.gmail.com>
 <86mufjrup7.wl-maz@kernel.org>
 <CAFEAcA9qkqkOTqSVrhTpt-NkZSNXomSBNiWo_D6Kr=QKYRRf=w@mail.gmail.com>
 <20190905092223.GC4320@e113682-lin.lund.arm.com>
 <4b6662bd-56e4-3c10-3b65-7c90828a22f9@kernel.org>
 <20190906080033.GF4320@e113682-lin.lund.arm.com>
 <a58c5f76-641a-8381-2cf3-e52d139c4236@amazon.com>
 <20190906131252.GG4320@e113682-lin.lund.arm.com>
 <CAFEAcA9vwyhAN8uO8=PpaBkBXb0Of4G0jEij7nMrYcnJjSRVjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9vwyhAN8uO8=PpaBkBXb0Of4G0jEij7nMrYcnJjSRVjg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 02:31:42PM +0100, Peter Maydell wrote:
> On Fri, 6 Sep 2019 at 14:13, Christoffer Dall <christoffer.dall@arm.com> wrote:
> > I'd prefer leaving it to userspace to worry about, but I thought Peter
> > said that had been problematic historically, which I took at face value,
> > but I could have misunderstood.
> >
> > If QEMU, kvmtool, and whatever the crazy^H cool kids are using in
> > userspace these days are happy emulating the exception, then that's a
> > viable approach.  The main concern I have with that is whether they'll
> > all get it right, and since we already have the code in the kernel to do
> > this, it might make sense to re-use the kernel logic for it.
> 
> Well, for QEMU we've had code that in theory might do this but
> in practice it's never been tested. Essentially the problem is
> that nobody ever wants to inject an exception from userspace
> except in incredibly rare cases like "trying to use h/w breakpoints
> simultaneously inside the VM and also to debug the VM from outside"
> or "we're running on RAS hardware that just told us that the VM's
> RAM was faulty". There's no even vaguely commonly-used usecase
> for it today; and this ABI suggestion adds another "this is in
> practice almost never going to happen" case to the pile. The
> codepath is unreliable in QEMU because (a) it requires getting
> syncing of sysreg values to and from the kernel right -- this is
> about the only situation where userspace wants to modify sysregs
> during execution of the VM, as opposed to just reading them -- and
> (b) we try to reuse the code we already have that does TCG exception
> injection, which might or might not be a design mistake, and
> (c) as noted above it's a never-actually-used untested codepath...
> 
> So I think if I were you I wouldn't commit to the kernel ABI until
> somebody had at least written some RFC-quality patches for QEMU and
> tested that they work and the ABI is OK in that sense. (For the
> avoidance of doubt, I'm not volunteering to do that myself.)
> I don't object to the idea in principle, though.
> 
> PS: the other "injecting exceptions to the guest" oddity is that
> if the kernel *does* find the ISV information and returns to userspace
> for it to handle the MMIO, there's no way for userspace to say
> "actually that address is supposed to generate a data abort".
> 

That's a good point.  A synchronous interface with a separate mechanism
to ask the kernel to inject an exception might be a good solution, if
there's an elegant way to do the latter.  I'll have a look at that.

Thanks,

    Christoffer
