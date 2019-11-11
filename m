Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4B6C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F88321655
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfKKRQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 12:16:45 -0500
Received: from foss.arm.com ([217.140.110.172]:48234 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfKKRQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 12:16:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2D0731B;
        Mon, 11 Nov 2019 09:16:44 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8ED4D3F534;
        Mon, 11 Nov 2019 09:16:43 -0800 (PST)
Date:   Mon, 11 Nov 2019 17:16:35 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: Rename WORKAROUND_1165522 to SPECULATIVE_AT
Message-ID: <20191111171621.GA30274@lakrids.cambridge.arm.com>
References: <20191111141157.55062-1-steven.price@arm.com>
 <20191111141157.55062-2-steven.price@arm.com>
 <160a852027f4481cc63aed72c4f4a409@www.loen.fr>
 <013eec05-b558-d97a-bf95-248a62f25dc5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <013eec05-b558-d97a-bf95-248a62f25dc5@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 04:07:39PM +0000, Steven Price wrote:
> On 11/11/2019 15:42, Marc Zyngier wrote:
> >> +config ARM64_WORKAROUND_SPECULATIVE_AT
> >> +    bool
> >> +
> >>  config ARM64_ERRATUM_1165522
> >>      bool "Cortex-A76: Speculative AT instruction using out-of-context
> >> translation regime could cause subsequent request to generate an
> >> incorrect translation"
> >>      default y
> >> +    select ARM64_WORKAROUND_SPECULATIVE_AT
> > 
> > I'd object that ARM64_ERRATUM_1319367 (and its big brother 1319537)
> > are also related to speculative AT execution, and yet are not covered
> > by this configuration symbol.
> 
> Good point.
> 
> > I can see three solutions to this:
> > 
> > - Either you call it SPECULATIVE_AT_VHE and introduce SPECULATIVE_AT_NVHE
> >   for symmetry
> 
> Tempting...

FWIW, this sounds fine to me.

> > - Or you make SPECULATIVE_AT cover all the speculative AT errata, which
> >   may or may not work...
> 
> This actually sounds the neatest, but I'm not sure whether there's going
> to be any conflicts between VHE/NVHE. I'll prototype this and see how
> ugly it is.
> 
> > - Or even better, you just ammend the documentation to say that 1165522
> >   also covers the newly found A55 one (just like we have for A57/A72)
> 
> Well Mark Rutland disliked my initial thoughts about just including both
> errata in one option like that - hence the refactoring in this patch.
> Although of course that's exactly what's happened with 1319367/1319537...

My view on this is that using one erratum config symbol to cover the
workaround for another is more confusing than having a level of
indirection, and I would've preferred the indirection for that case too.
 
> > What do you think?
> 
> I'll have a go at SPECULATIVE_AT covering both VHE/NVHE - from an
> initial look it seems like it should work and it would be neat if it
> does. In particular it should avoid the necessity to require VHE when
> the erratum is present.
> 
> Otherwise I guess SPECULATIVE_AT_{,N}VHE is probably second best.

Both sound good to me.

Thanks for dealing with this!

Mark.
