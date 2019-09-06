Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AEAC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD146208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=erdfelt.com header.i=@erdfelt.com header.b="duLhlNHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393150AbfIFQwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 12:52:11 -0400
Received: from out.bound.email ([141.193.244.10]:59770 "EHLO out.bound.email"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbfIFQwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:52:09 -0400
Received: from mail.sventech.com (localhost [127.0.0.1])
        by out.bound.email (Postfix) with ESMTP id A23208A30DF;
        Fri,  6 Sep 2019 09:52:07 -0700 (PDT)
Received: by mail.sventech.com (Postfix, from userid 1000)
        id 7C38F16001D9; Fri,  6 Sep 2019 09:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=erdfelt.com;
        s=default; t=1567788727;
        bh=ZLLoidsh84HFy8mGwmZDHdhenGuJ4dLEftpgpDtdmHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=duLhlNHnL42p90VPbBgmVENPyNZ+onEr5tYvonGU//n71EpJLVRDqMxAqUOUQEzTG
         28bUHL2dMTuYX27UBo0BoniLhWaaQtBaaCXOFskGU3Qzi0I/wjT9KCQoIVCWU1G5kU
         rXTkFZgib8RScPrdIUAyvjmfQ1m3+JsqIoybPLks=
Date:   Fri, 6 Sep 2019 09:52:07 -0700
From:   Johannes Erdfelt <johannes@erdfelt.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jon Grimm <Jon.Grimm@amd.com>, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: Add an option to reload microcode even if
 revision is unchanged
Message-ID: <20190906165207.GC29569@sventech.com>
References: <20190905002132.GA26568@otc-nc-03>
 <20190905072029.GB19246@zn.tnic>
 <20190905194044.GA3663@otc-nc-03>
 <alpine.DEB.2.21.1909052316130.1902@nanos.tec.linutronix.de>
 <20190905222706.GA4422@otc-nc-03>
 <alpine.DEB.2.21.1909061431330.1902@nanos.tec.linutronix.de>
 <20190906144039.GA29569@sventech.com>
 <20190906151617.GE19008@zn.tnic>
 <20190906154618.GB29569@sventech.com>
 <20190906161735.GH19008@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906161735.GH19008@zn.tnic>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019, Borislav Petkov <bp@alien8.de> wrote:
> On Fri, Sep 06, 2019 at 08:46:18AM -0700, Johannes Erdfelt wrote:
> > That said, we very much rely on late microcode loading and it has helped
> > us and our customers significantly.
> 
> You do realize that you rely on an update method which *won't* work in
> all possible cases and then you *will* have to reboot if the microcode
> patching *must* happen early, do you?

Yeah. I even explained some cases where it wouldn't work.

If we get a microcode update that isn't late loadable, then yes, we have
to do something different.

That doesn't mean that late loading isn't still useful. In practice, it
can be very valuable. It isn't bad or dangerous in vast majority of
cases. We haven't had a microcode update across all of the models of
Intel CPUs we have (going back a handful of generations) in the past
almost two years that wasn't safely late loadable.

Just as I can't know for sure that every future microcode update will be
safely late loadable, you can't know for sure that every future microcode
update won't be safely late loadable.

> > It's really easy to say "fix your infrastructure" when you're not
> > running that infrastructure.
> 
> I'm not saying you should fix your infrastructure now - I'm saying you
> should keep that in mind when thinking whether to rely more on late
> loading or not. Who knows, maybe newer generation machines in the fleet
> could do load balancing, live migration, whatever fancy new cloud stuff
> it is, to facilitate a proper reboot.

We are well aware of the downsides of late microcode loading and live
patching. However, like I said, it's currently the best tools available.

We are certainly looking at other options, but some aren't feasible for
mitigating security vulnerabilities where time to getting patched is
very much important.

> > The more reboots we can avoid, the better it is for us and our
> > customers.
> 
> So how do you update the kernels on those machines? Or you live-patch in
> the new functionality too?

Depends on what kind of patch is needed. Livepatching, while having it's
own set of problems, has been very valuable for us.

We do use other techniques as well particularly when it's not time
sensitive.

> > I understand that it could be unsafe to late load some rare microcode
> > updates (theoretical or not). However, that is certainly the exception.
> > We have done this multiple times on our fleet and we plan to continue
> > doing so in the future.
> 
> The fact that it has worked for you does not make it right. It won't
> magically become safe, as tglx said.

It very much makes it right because it's still a tool that can be used
safely in the right cases. Just because it can't be used 100% of the time
(even if it is close to that in practice) doesn't make it magically unsafe
either.

> Practically speaking, late loading probably won't disappear as it is
> being used apparently. Just don't expect that it will get "extended" if
> that extension brings with itself fallout and duct tape fixes left and
> right.

I don't have a particular use case for the patchset at hand and I'm
certainly not arguing for or against this patchset.

But I do get concerned when there is talk about removing a feature we
currently use extensively.

I'm happy to hear it will likely not be removed and I hope it was partly
because I spoke up to show that is actively being used and it's important
to us.

JE

