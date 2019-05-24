Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B959C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58262175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390060AbfEXI5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:57:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37198 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389677AbfEXI5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:57:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0AF1A78;
        Fri, 24 May 2019 01:57:50 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC0413F5AF;
        Fri, 24 May 2019 01:57:46 -0700 (PDT)
Date:   Fri, 24 May 2019 09:57:40 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFT PATCH v5 3/5] cpu-topology: Move cpu topology code to
 common code.
Message-ID: <20190524085720.GA13121@e107155-lin>
References: <20190524000653.13005-1-atish.patra@wdc.com>
 <20190524000653.13005-4-atish.patra@wdc.com>
 <20190524081333.GA15566@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524081333.GA15566@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 10:13:33AM +0200, Greg Kroah-Hartman wrote:
> On Thu, May 23, 2019 at 05:06:50PM -0700, Atish Patra wrote:
> > Both RISC-V & ARM64 are using cpu-map device tree to describe
> > their cpu topology. It's better to move the relevant code to
> > a common place instead of duplicate code.
> > 
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Tested-by: Jeffrey Hugo <jhugo@codeaurora.org>
> > ---
> >  arch/arm64/include/asm/topology.h |  23 ---
> >  arch/arm64/kernel/topology.c      | 303 +-----------------------------
> >  drivers/base/arch_topology.c      | 296 +++++++++++++++++++++++++++++
> >  include/linux/arch_topology.h     |  28 +++
> >  include/linux/topology.h          |   1 +
> >  5 files changed, 329 insertions(+), 322 deletions(-)
>
> What, now _I_ have to maintain drivers/base/arch_topology.c?  That's
> nice for everyone else, but not me :(
>
> Ugh.
>
> Anyway, what are you wanting to happen to this series?  I think we need
> some ARM people to sign off on it before I can take the whole thing,
> right?
>

Greg, I am ready to take ownership. Juri the original author of this file
agreed and I have been reviewing this file since Juri first wrote it.
I am happy to submit a patch assuming maintainership for this file, was
just waiting to hear from you when I asked explicitly you and Juri in
last version of the patch when Will wanted someone from ARM to be reviewer
of this file at-least. I am happy to take over as reviewer or maintainer
which ever you prefer.

Sorry if I was not so clear in my earlier mail.

--
Regards,
Sudeep
