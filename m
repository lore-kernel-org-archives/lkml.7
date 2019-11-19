Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00952C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9B2222A2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfKSQaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:30:16 -0500
Received: from muru.com ([72.249.23.125]:42916 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbfKSQaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:30:16 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 32D6D809B;
        Tue, 19 Nov 2019 16:30:53 +0000 (UTC)
Date:   Tue, 19 Nov 2019 08:30:13 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP: Use ARM SMC Calling Convention when OP-TEE is
 available
Message-ID: <20191119163013.GK35479@atomide.com>
References: <20191118165236.22136-1-afd@ti.com>
 <20191118215759.GD35479@atomide.com>
 <b86e1d66-1566-521c-a445-4f0ae2fd95d6@ti.com>
 <20191118223128.GE35479@atomide.com>
 <29db708e-119e-8a89-7d43-e38e2a10dc07@ti.com>
 <20191119162157.GJ35479@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119162157.GJ35479@atomide.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [191119 16:22]:
> * Andrew F. Davis <afd@ti.com> [191119 01:14]:
> > A generic smc() call would be nice, but arm_smccc_smc() is specifically
> > for SMCCC.
> 
> To me it seeems that HAVE_ARM_SMCCC is a generic feature though.
> It's not limited to OPTEE. We have select HAVE_ARM_SMCCC if CPU_V7
> in arch/arm/Kconfig, and OPTEE depends on HAVE_ARM_SMCCC.
> 
> From that point of view it seems that we could have HAVE_ARM_SMCCC
> enabled also for v6 and use it for all mach-omap2 with a wrapper.

In the omap_smc1 case it seems that we can just unconditionally
change the callers to use arm_smccc_smc() instead of omap_smc1
and get rid of it. It's only used by v7 SMP related stuff based
on grepping for it.

> So I'd like to have our smc callers eventually just call generic
> generic arm_smccc_smc(OMAP_SIP_SMC_STD_CALL_VAL(fn)...) rather
> than the custom calls. And we want to update to using the generic
> functions one case at a time as the features get tested :)

Sounds like the others can be then done one at a time as
needed :)

Regards,

Tony
