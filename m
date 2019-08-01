Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110FEC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FE9214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbfHAJgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 05:36:47 -0400
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:43745 "EHLO
        9.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHAJgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:36:47 -0400
X-Greylist: delayed 1201 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Aug 2019 05:36:46 EDT
Received: from player791.ha.ovh.net (unknown [10.109.160.39])
        by mo68.mail-out.ovh.net (Postfix) with ESMTP id 43E5913E980
        for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2019 10:58:57 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
        (Authenticated sender: clg@kaod.org)
        by player791.ha.ovh.net (Postfix) with ESMTPSA id EAA2686678C9;
        Thu,  1 Aug 2019 08:58:45 +0000 (UTC)
Subject: Re: [PATCH 1/2] powerpc/xive: Use GFP_KERNEL instead of GFP_ATOMIC in
 'xive_irq_bitmap_add()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        allison@lohutok.net, tglx@linutronix.de, groug@kaod.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <cover.1564647619.git.christophe.jaillet@wanadoo.fr>
 <85d5d247ce753befd6aa63c473f7823de6520ccd.1564647619.git.christophe.jaillet@wanadoo.fr>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <669a1566-4048-1d81-f719-45e4ac05758b@kaod.org>
Date:   Thu, 1 Aug 2019 10:58:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <85d5d247ce753befd6aa63c473f7823de6520ccd.1564647619.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12236561665022528369
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrleejgddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2019 10:32, Christophe JAILLET wrote:
> There is no need to use GFP_ATOMIC here. GFP_KERNEL should be enough.
> GFP_KERNEL is also already used for another allocation just a few lines
> below.

This is correct.
 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  arch/powerpc/sysdev/xive/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
> index 8ef9cf4ebb1c..b4f5eb9e0f82 100644
> --- a/arch/powerpc/sysdev/xive/spapr.c
> +++ b/arch/powerpc/sysdev/xive/spapr.c
> @@ -45,7 +45,7 @@ static int xive_irq_bitmap_add(int base, int count)
>  {
>  	struct xive_irq_bitmap *xibm;
>  
> -	xibm = kzalloc(sizeof(*xibm), GFP_ATOMIC);
> +	xibm = kzalloc(sizeof(*xibm), GFP_KERNEL);
>  	if (!xibm)
>  		return -ENOMEM;
>  
> 

