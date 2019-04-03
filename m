Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25626C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12A020830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfDCMod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:44:33 -0400
Received: from foss.arm.com ([217.140.101.70]:39484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCMod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:44:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADBBF15AD;
        Wed,  3 Apr 2019 05:44:32 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E8ED3F59C;
        Wed,  3 Apr 2019 05:44:31 -0700 (PDT)
Date:   Wed, 3 Apr 2019 13:44:29 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     wen.yang99@zte.com.cn
Cc:     linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: =?utf-8?B?562U5aSNOiBSZTogW1BBVENIIHYy?=
 =?utf-8?Q?_14=2F15=5D_arm64=3A_cpu=5Fops?= =?utf-8?Q?=3A?= fix a leaked
 reference byadding missing of_node_put
Message-ID: <20190403124429.GG16362@fuggles.cambridge.arm.com>
References: <20190401153722.GA6884@fuggles.cambridge.arm.com>
 <201904031356099956278@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201904031356099956278@zte.com.cn>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 01:56:09PM +0800, wen.yang99@zte.com.cn wrote:
> > > The call to of_get_next_child returns a node pointer with refcount
> > > incremented thus it must be explicitly decremented after the last
> > > usage.
> > >
> > > Detected by coccinelle with the following warnings:
> > > ./arch/arm64/kernel/cpu_ops.c:102:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 69, but without a corresponding object release within this function.
> > >
> > > Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> > > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > > v2->v1: add a missing space between "adding" and "missing"
> > >
> > >  arch/arm64/kernel/cpu_ops.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
> > > index ea00124..00f8b86 100644
> > > --- a/arch/arm64/kernel/cpu_ops.c
> > > +++ b/arch/arm64/kernel/cpu_ops.c
> > > @@ -85,6 +85,7 @@ static const char *__init cpu_read_enable_method(int cpu)
> > >                  pr_err("%pOF: missing enable-method property\n",
> > >                      dn);
> > >          }
> > > +        of_node_put(dn);
> > >      } else {
> > >          enable_method = acpi_get_enable_method(cpu);
> > >          if (!enable_method) {
> > 
> > Looks about right to me:
> > 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> > 
> > How do you plan to get this upstream? Can we just pick this one up via
> > arm64?
> 
> Ok, thank you.
> We are very happy to know that it is useful.

Ok, I picked it up.

Will
