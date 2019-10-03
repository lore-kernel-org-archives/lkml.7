Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED0DC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A1A2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbfJCVON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 17:14:13 -0400
Received: from excelsior.roeckx.be ([195.234.45.115]:35061 "EHLO
        excelsior.roeckx.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfJCVOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 17:14:12 -0400
Received: from intrepid.roeckx.be (localhost [127.0.0.1])
        by excelsior.roeckx.be (Postfix) with ESMTP id 48DDAA8A13A6;
        Thu,  3 Oct 2019 21:14:10 +0000 (UTC)
Received: by intrepid.roeckx.be (Postfix, from userid 1000)
        id 1A8661FE0C13; Thu,  3 Oct 2019 23:14:09 +0200 (CEST)
Date:   Thu, 3 Oct 2019 23:14:09 +0200
From:   Kurt Roeckx <kurt@roeckx.be>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Stop breaking the CSRNG
Message-ID: <20191003211409.GB18282@roeckx.be>
References: <20191002165533.GA18282@roeckx.be>
 <20191003033655.GA3226@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003033655.GA3226@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 11:36:55PM -0400, Theodore Y. Ts'o wrote:
> On Wed, Oct 02, 2019 at 06:55:33PM +0200, Kurt Roeckx wrote:
> > 
> > But it seems people are now thinking about breaking getrandom() too,
> > to let it return data when it's not initialized by default. Please
> > don't.
> 
> "It's complicated"
> 
> The problem is that whether a CRNG can be considered secure is a
> property of the entire system, including the hardware, and given the
> large number of hardware configurations which the kernel and OpenSSL
> can be used, in practice, we can't assure that getrandom(2) is
> "secure" without making certain assumptions.

I'm not saying it's easy. But getrandom() is documented as only
returning data after it has been initialized, which is an
important property of that interface and the main reason to switch
to it. And it seems that because someone's laptop hung during boot
because it doesn't find enough entrpoy is enough to break the
security of the rest. It seems that the only important thing is
that applications don't stop working, because it's clearly visible
that it's not working. Returning data before it's been initialized
doesn't have the effect of being visibly broken, but it's just as
broken, which is in my opinion worse.

> But if you assume that there is no hardware random number generator,
> and everything is driven from a single master oscillator, with no
> exernal input, and the CPU is utterly simple, with speculation or
> anything else that might be non-determinstic, AND if we assume that
> the idiots who make an IOT device use the same random seed across
> millions of devices all cloned off of the same master imagine, there
> is ***absoutely*** nothing the kernel can do to guarantee, with 100%
> certainty, that the CRNG will be initialzied.  (This is especially
> true if the idiots who design the IOT device call OpenSSL to generate
> their long-term private key the moment the device is first plugged in,
> before any networking device is brought on-line.)

And returning data before it's been initialized will only make
that situtation worse. We can only hope that by refusing to return
data the idiot will properly fix it.

If the hardware can't provide it, the kernel shouldn't just pretend
the hardware did provide it.

> There really are no good choices here.  The one thing which Linus has
> made very clear is that hanging at boot is Not Acceptable.

And I think it's not a kernel problem but a combination of
hardware, configuration and user space problem. The kernel can of
course be improved, and I'm sure it will.

I wonder if it's useful to extend getrandom() to provide an option
where the application can indicate it doesn't care about security
and just wants some number, like what /dev/urandom provides but
then as a system call. Other options could be that you're happy
with to get data after got an estimated 64 bit of entropy.

> And given that many users are just installing some kind of userspace
> jitter entropy to square this particular circle, even though I don't
> trust a jitter entropy scheme, even if it is insecure, we're also
> using RDRAND, and ultimately I'll trust RDRAND more than I trust a
> jitter entropy scheme.  And that's where we are right now.  Linus has
> introduced a simple in-kernel jitter entropy system

I don't trust it much either. And I think we should at least try
to estimate how much entropy it actually provides on various
systems, knowing that there will probably be systems where it
provides much less than what we think it does.

I'm willing to help analyze data if people can provide a list
of TSCs that are being added. The more samples the better. I think
you want to do this on an idle system.


Kurt

