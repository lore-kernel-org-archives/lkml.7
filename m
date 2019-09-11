Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF02C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7D3206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfIKP60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 11:58:26 -0400
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:47529 "EHLO
        9.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbfIKP60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 11:58:26 -0400
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Sep 2019 11:58:25 EDT
Received: from player688.ha.ovh.net (unknown [10.109.143.249])
        by mo68.mail-out.ovh.net (Postfix) with ESMTP id BB5F4142F53
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 16:40:52 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player688.ha.ovh.net (Postfix) with ESMTPSA id 4ED3C99ECC49;
        Wed, 11 Sep 2019 14:40:44 +0000 (UTC)
Date:   Wed, 11 Sep 2019 16:40:43 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/xive: Fix bogus error code returned by OPAL
Message-ID: <20190911164043.5548afa1@bahia.lan>
In-Reply-To: <87k1aezz78.fsf@mpe.ellerman.id.au>
References: <156812362556.1866243.7399893138425681517.stgit@bahia.tls.ibm.com>
        <87k1aezz78.fsf@mpe.ellerman.id.au>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 537054258809641393
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtdefgdehfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2019 00:26:19 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Hi Greg,
> 

Bom dia ! :)

> Couple of comments ...
> 
> Greg Kurz <groug@kaod.org> writes:
> > There's a bug in skiboot that causes the OPAL_XIVE_ALLOCATE_IRQ call
> > to return the 32-bit value 0xffffffff when OPAL has run out of IRQs.
> > Unfortunatelty, OPAL return values are signed 64-bit entities and
> > errors are supposed to be negative. If that happens, the linux code
> > confusingly treats 0xffffffff as a valid IRQ number and panics at some
> > point.
> >
> > A fix was recently merged in skiboot:
> >
> > e97391ae2bb5 ("xive: fix return value of opal_xive_allocate_irq()")
> >
> > but we need a workaround anyway to support older skiboots already
> > on the field.
>   ^
>   in
>  
> >
> > Internally convert 0xffffffff to OPAL_RESOURCE which is the usual error
> > returned upon resource exhaustion.
> 
> This should go to stable, any idea what versions it should go back to?
> Probably whenever the xive code was introduced?
> 

Yes I guess so. This would mean v4.12. I'll add the appropriate stable
tag before re-posting, and address all the other remarks of course.

> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  arch/powerpc/sysdev/xive/native.c |   13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
> > index 37987c815913..c35583f84f9f 100644
> > --- a/arch/powerpc/sysdev/xive/native.c
> > +++ b/arch/powerpc/sysdev/xive/native.c
> > @@ -231,6 +231,15 @@ static bool xive_native_match(struct device_node *node)
> >  	return of_device_is_compatible(node, "ibm,opal-xive-vc");
> >  }
> >  
> > +static int64_t opal_xive_allocate_irq_fixup(uint32_t chip_id)
>           ^                                    ^
>           Can you use s64 here and u32 here ....
> 
> Instead of calling this opal_xive_allocate_irq_fixup() and relying on
> all callers to call the fixup, can we rename the opal wrapper and leave
> this function's name unchanged, eg:
> 
> -OPAL_CALL(opal_xive_allocate_irq,              OPAL_XIVE_ALLOCATE_IRQ);
> +OPAL_CALL(opal_xive_allocate_irq_raw,          OPAL_XIVE_ALLOCATE_IRQ);
> 
> 
> > +{
> > +	s64 irq = opal_xive_allocate_irq(chip_id);
> > +
> > +#define XIVE_ALLOC_NO_SPACE	0xffffffff /* No possible space */
> > +	return
> > +		irq == XIVE_ALLOC_NO_SPACE ? OPAL_RESOURCE : irq;
> > +}
> 
> I don't really like the #define and the weird indenting and so on, can
> we instead do it like:
> 
> 	/*
>          * Old versions of skiboot can incorrectly return 0xffffffff to
>          * indicate no space, fix it up here.
>          */
> 	return irq == 0xffffffff ? OPAL_RESOURCE : irq;
> 
> cheers
