Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8BCC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAB820B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbfFSJMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 05:12:25 -0400
Received: from foss.arm.com ([217.140.110.172]:57250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730996AbfFSJMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 05:12:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1292344;
        Wed, 19 Jun 2019 02:12:23 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 523053F738;
        Wed, 19 Jun 2019 02:12:21 -0700 (PDT)
Date:   Wed, 19 Jun 2019 10:12:19 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        aou@eecs.berkeley.edu, gary@garyguo.net, Atish.Patra@wdc.com,
        hch@infradead.org, paul.walmsley@sifive.com, rppt@linux.ibm.com,
        linux-riscv@lists.infradead.org, Anup Patel <anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>, suzuki.poulose@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com,
        julien.thierry@arm.com, christoffer.dall@arm.com,
        james.morse@arm.com
Subject: Re: [PATCH RFC 11/14] arm64: Move the ASID allocator code in a
 separate file
Message-ID: <20190619091219.GB7767@fuggles.cambridge.arm.com>
References: <20190321163623.20219-1-julien.grall@arm.com>
 <20190321163623.20219-12-julien.grall@arm.com>
 <0dfe120b-066a-2ac8-13bc-3f5a29e2caa3@arm.com>
 <CAJF2gTTXHHgDboaexdHA284y6kNZVSjLis5-Q2rDnXCxr4RSmA@mail.gmail.com>
 <c871a5ae-914f-a8bb-9474-1dcfec5d45bf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c871a5ae-914f-a8bb-9474-1dcfec5d45bf@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 09:54:21AM +0100, Julien Grall wrote:
> On 6/19/19 9:07 AM, Guo Ren wrote:
> > You forgot CCing C-SKY folks :P
> 
> I wasn't aware you could be interested :).
> 
> > Move arm asid allocator code in a generic one is a agood idea, I've
> > made a patchset for C-SKY and test is on processing, See:
> > https://lore.kernel.org/linux-csky/1560930553-26502-1-git-send-email-guoren@kernel.org/
> > 
> > If you plan to seperate it into generic one, I could co-work with you.
> 
> Was the ASID allocator work out of box on C-Sky? If so, I can easily move
> the code in a generic place (maybe lib/asid.c).

This is one place where I'd actually prefer not to go down the route of
making the code generic. Context-switching and low-level TLB management
is deeply architecture-specific and I worry that by trying to make this
code common, we run the real risk of introducing subtle bugs on some
architecture every time it is changed. Furthermore, the algorithm we use
on arm64 is designed to scale to large systems using DVM and may well be
too complex and/or sub-optimal for architectures with different system
topologies or TLB invalidation mechanisms.

It's not a lot of code, so I don't see that it's a big deal to keep it
under arch/arm64.

Will
