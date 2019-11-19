Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0B5C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E34E223B0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfKSScv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 13:32:51 -0500
Received: from muru.com ([72.249.23.125]:42946 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfKSScv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 13:32:51 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 582A8809B;
        Tue, 19 Nov 2019 18:33:27 +0000 (UTC)
Date:   Tue, 19 Nov 2019 10:32:47 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP: Use ARM SMC Calling Convention when OP-TEE is
 available
Message-ID: <20191119183247.GN35479@atomide.com>
References: <20191118165236.22136-1-afd@ti.com>
 <20191118215759.GD35479@atomide.com>
 <b86e1d66-1566-521c-a445-4f0ae2fd95d6@ti.com>
 <20191118223128.GE35479@atomide.com>
 <29db708e-119e-8a89-7d43-e38e2a10dc07@ti.com>
 <20191119162157.GJ35479@atomide.com>
 <6e009ae3-6aa2-409b-749f-4947303940d8@ti.com>
 <20191119164227.GL35479@atomide.com>
 <20191119180546.GM35479@atomide.com>
 <9e15c170-c9fa-778c-d998-bd1111a6390d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e15c170-c9fa-778c-d998-bd1111a6390d@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew F. Davis <afd@ti.com> [191119 18:21]:
> On 11/19/19 1:05 PM, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [191119 16:43]:
> >> What I'd like to have though is to make arm_smccc_smc()
> >> work for optee and non-optee case for mach-omap2 as it
> >> already has the features necessary to do the runtime
> >> patching of the code for the quirks.
> > 
> > In any case sounds like we only need the r12 quirk when
> > optee is _not_ enabled.
> > 
> > So a modified version of your earlier smccc-call.S patch
> > modified to only enable the r12 quirk when no optee is
> > loaded just might be all we need :)
> 
> Doesn't change the reason the earlier patch was NAKd, we would still be
> modifying the core SMCCC call to be non-compliant.

Well let's see what Mark says about r12 quirk version
that is only needed when optee is not active.

> And doing it only when OP-TEE is not installed doesn't gain us anything,
> we already have our own SMC calls for when OP-TEE is not available, this
> patch is specifically so the OMAP2+ boot still works even when OP-TEE is
> installed.

It would allow us to completely change over to using
arm_smccc_smc() and forget the custom calls.

> If you can get Mark to take my old patch then we can think about moving
> more legacy SMC callers to the SMCCC, otherwise this patch is what we
> need to get OP-TEE enabled OMAP2+ platforms to boot and we will just
> stick to the custom SMC functions we already have for everything else.

To me it sounds like your old patch won't work as is though,
we just want the code modified dynamically if optee is not
present to enable the r12 quirk.

Of course if both the optee version without the r12 quirk,
and a non-optee version with the r12 of the arm_smccc_smc()
are needed the same time on a booted system, then they should
be kept separate.

Regards,

Tony
