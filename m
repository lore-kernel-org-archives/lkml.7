Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7F3C28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001512070B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfFFLXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 07:23:18 -0400
Received: from foss.arm.com ([217.140.101.70]:45720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfFFLXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 07:23:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 999DDA78;
        Thu,  6 Jun 2019 04:23:17 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 424D03F246;
        Thu,  6 Jun 2019 04:23:16 -0700 (PDT)
Date:   Thu, 6 Jun 2019 12:23:13 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH V2 3/4] arm64/mm: Consolidate page fault information
 capture
Message-ID: <20190606112313.GA56860@arrakis.emea.arm.com>
References: <1559544085-7502-1-git-send-email-anshuman.khandual@arm.com>
 <1559544085-7502-4-git-send-email-anshuman.khandual@arm.com>
 <20190604144209.GJ6610@arrakis.emea.arm.com>
 <20190606093811.GA37430@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606093811.GA37430@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 10:38:11AM +0100, Mark Rutland wrote:
> On Tue, Jun 04, 2019 at 03:42:09PM +0100, Catalin Marinas wrote:
> > On Mon, Jun 03, 2019 at 12:11:24PM +0530, Anshuman Khandual wrote:
> > > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > > index da02678..4bb65f3 100644
> > > --- a/arch/arm64/mm/fault.c
> > > +++ b/arch/arm64/mm/fault.c
> > > @@ -435,6 +435,14 @@ static bool is_el0_instruction_abort(unsigned int esr)
> > >  	return ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_LOW;
> > >  }
> > >  
> > > +/*
> > > + * This is applicable only for EL0 write aborts.
> > > + */
> > > +static bool is_el0_write_abort(unsigned int esr)
> > > +{
> > > +	return (esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM);
> > > +}
> > 
> > What makes this EL0 only?
> 
> It returns false for EL1 faults caused by DC IVAC, where write
> permission is required. EL0 can only issue maintenance that requires
> read permission.
> 
> For whatever reason, the architecture says that WnR is always 1b1, even
> if read permission was sufficient.
> 
> How about:
> 
> /*
>  * Note: not valid for EL1 DC IVAC, but we never use that such that it
>  * should fault.
>  */

For completeness, I'd add "... should fault. EL0 cannot issue DC IVAC
(undef)." or something like that.

Looks fine otherwise.

-- 
Catalin
