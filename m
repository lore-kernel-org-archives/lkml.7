Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA656C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 10:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A446F206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 10:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbfHAK5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 06:57:22 -0400
Received: from 11.mo6.mail-out.ovh.net ([188.165.38.119]:54651 "EHLO
        11.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfHAK5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 06:57:21 -0400
X-Greylist: delayed 3599 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Aug 2019 06:57:21 EDT
Received: from player778.ha.ovh.net (unknown [10.108.35.95])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 0CCC21D1F9D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2019 11:41:43 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player778.ha.ovh.net (Postfix) with ESMTPSA id 5D8AE873BBDD;
        Thu,  1 Aug 2019 09:41:33 +0000 (UTC)
Date:   Thu, 1 Aug 2019 11:41:32 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        allison@lohutok.net, tglx@linutronix.de, clg@kaod.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc/xive: Add a check for memory allocation
 failure
Message-ID: <20190801114132.4c1db5be@bahia.lan>
In-Reply-To: <cc53462734dfeaf15b6bad0e626b483de18656b4.1564647619.git.christophe.jaillet@wanadoo.fr>
References: <cover.1564647619.git.christophe.jaillet@wanadoo.fr>
        <cc53462734dfeaf15b6bad0e626b483de18656b4.1564647619.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12958826454390118683
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrleejgddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Aug 2019 10:32:42 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> The result of this kzalloc is not checked. Add a check and corresponding
> error handling code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

> Note that 'xive_irq_bitmap_add()' failures are not handled in
> 'xive_spapr_init()'
> I guess that it is not really an issue. This function is _init, so if a
> memory allocation occures here, it is likely that the system will
> already be in bad shape.

Hmm not sure... The allocation could also fail if the "ibm,xive-lisn-ranges"
property contains an insanely big range, eg. count == 1 << 31. The system isn't
necessarily in bad shape in this case, but XIVE is definitely unusable and
we should let a chance to the kernel to switch to XICS in this case.

I guess it is worth adding proper error handling in xive_spapr_init() as well.

> Anyway, the check added here would at least keep the data linked in
> 'xive_irq_bitmaps' usable.
> ---
>  arch/powerpc/sysdev/xive/spapr.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
> index b4f5eb9e0f82..52198131c75e 100644
> --- a/arch/powerpc/sysdev/xive/spapr.c
> +++ b/arch/powerpc/sysdev/xive/spapr.c
> @@ -53,6 +53,10 @@ static int xive_irq_bitmap_add(int base, int count)
>  	xibm->base = base;
>  	xibm->count = count;
>  	xibm->bitmap = kzalloc(xibm->count, GFP_KERNEL);
> +	if (!xibm->bitmap) {
> +		kfree(xibm);
> +		return -ENOMEM;
> +	}
>  	list_add(&xibm->list, &xive_irq_bitmaps);
>  
>  	pr_info("Using IRQ range [%x-%x]", xibm->base,

