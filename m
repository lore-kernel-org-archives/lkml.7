Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE797C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D325F27DEF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfFCJFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:05:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46876 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbfFCJFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:05:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AB3B374;
        Mon,  3 Jun 2019 02:05:49 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C69F3F690;
        Mon,  3 Jun 2019 02:05:45 -0700 (PDT)
Date:   Mon, 3 Jun 2019 10:05:31 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Rob Herring <robh@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Otto Sabart <ottosabart@seberm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v6 2/7] dt-binding: cpu-topology: Move cpu-map to a
 common binding.
Message-ID: <20190603090531.GA26487@e107155-lin>
References: <20190529211340.17087-1-atish.patra@wdc.com>
 <20190529211340.17087-3-atish.patra@wdc.com>
 <0515d803-0da5-dcbe-3d3e-bb786b320d8b@arm.com>
 <28118149-193d-2a8a-995a-2f1829e95c1c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28118149-193d-2a8a-995a-2f1829e95c1c@wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 01:49:13AM -0700, Atish Patra wrote:
> On 5/30/19 1:55 PM, Jeremy Linton wrote:
> > Hi,
> >
> > On 5/29/19 4:13 PM, Atish Patra wrote:
> > > cpu-map binding can be used to described cpu topology for both
> > > RISC-V & ARM. It makes more sense to move the binding to document
> > > to a common place.
> > >
> > > The relevant discussion can be found here.
> > > https://lkml.org/lkml/2018/11/6/19
> > >
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > >    .../topology.txt => cpu/cpu-topology.txt}     | 82 +++++++++++++++----
> > >    1 file changed, 66 insertions(+), 16 deletions(-)
> > >    rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (86%)
> > >

[...]

> > <nit picking>
> >
> > While socket is optional, its probably a good idea to include the node
> > in the example even if the result is the same.
>
> Sure. I will update that.
>
> That is because at least
> > on arm64 the DT clusters=sockets decision had performance implications
> > for larger systems.
> >
> > Assuring the socket information is correct is helpful by itself to avoid
> > having to explain why a single socket machine is displaying some other
> > value in lscpu.
> >
> Just for my understanding, can you give a example?
>

That's simple. Today any ARM{32,64} DT based platform sets their cluster
id to physical package id, which is exposed to userspace. The userspace
can/must interpret that as multi-socket system. E.g. TC2/Juno which
2 clusters show up as 2 socket systems which is wrong and needs fixing.
We have fixed it for ARM64 ACPI based systems but for DT(mostly used in
mobile/embedded) we need to make sure we don't break anything else before
we fix it.

--
Regards,
Sudeep
