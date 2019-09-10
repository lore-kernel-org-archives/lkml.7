Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80052C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E90321479
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388365AbfIJOjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:39:01 -0400
Received: from 6.mo177.mail-out.ovh.net ([46.105.51.249]:40014 "EHLO
        6.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfIJOjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:39:01 -0400
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Sep 2019 10:39:00 EDT
Received: from player750.ha.ovh.net (unknown [10.109.160.39])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id 536F210A056
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 15:59:45 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
        (Authenticated sender: clg@kaod.org)
        by player750.ha.ovh.net (Postfix) with ESMTPSA id 0B10D9BCF29D;
        Tue, 10 Sep 2019 13:59:37 +0000 (UTC)
Subject: Re: [PATCH] powerpc/xive: Fix bogus error code returned by OPAL
To:     Greg Kurz <groug@kaod.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <156812362556.1866243.7399893138425681517.stgit@bahia.tls.ibm.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b8c656c8-296c-2bc3-0758-ca513e76a19f@kaod.org>
Date:   Tue, 10 Sep 2019 15:59:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156812362556.1866243.7399893138425681517.stgit@bahia.tls.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12416705648356002583
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtddtgdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2019 15:53, Greg Kurz wrote:
> There's a bug in skiboot that causes the OPAL_XIVE_ALLOCATE_IRQ call
> to return the 32-bit value 0xffffffff when OPAL has run out of IRQs.
> Unfortunatelty, OPAL return values are signed 64-bit entities and
> errors are supposed to be negative. If that happens, the linux code
> confusingly treats 0xffffffff as a valid IRQ number and panics at some
> point.
> 
> A fix was recently merged in skiboot:
> 
> e97391ae2bb5 ("xive: fix return value of opal_xive_allocate_irq()")
> 
> but we need a workaround anyway to support older skiboots already
> on the field.
> 
> Internally convert 0xffffffff to OPAL_RESOURCE which is the usual error
> returned upon resource exhaustion.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>



Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  arch/powerpc/sysdev/xive/native.c |   13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
> index 37987c815913..c35583f84f9f 100644
> --- a/arch/powerpc/sysdev/xive/native.c
> +++ b/arch/powerpc/sysdev/xive/native.c
> @@ -231,6 +231,15 @@ static bool xive_native_match(struct device_node *node)
>  	return of_device_is_compatible(node, "ibm,opal-xive-vc");
>  }
>  
> +static int64_t opal_xive_allocate_irq_fixup(uint32_t chip_id)
> +{
> +	s64 irq = opal_xive_allocate_irq(chip_id);
> +
> +#define XIVE_ALLOC_NO_SPACE	0xffffffff /* No possible space */
> +	return
> +		irq == XIVE_ALLOC_NO_SPACE ? OPAL_RESOURCE : irq;
> +}
> +
>  #ifdef CONFIG_SMP
>  static int xive_native_get_ipi(unsigned int cpu, struct xive_cpu *xc)
>  {
> @@ -238,7 +247,7 @@ static int xive_native_get_ipi(unsigned int cpu, struct xive_cpu *xc)
>  
>  	/* Allocate an IPI and populate info about it */
>  	for (;;) {
> -		irq = opal_xive_allocate_irq(xc->chip_id);
> +		irq = opal_xive_allocate_irq_fixup(xc->chip_id);
>  		if (irq == OPAL_BUSY) {
>  			msleep(OPAL_BUSY_DELAY_MS);
>  			continue;
> @@ -259,7 +268,7 @@ u32 xive_native_alloc_irq(void)
>  	s64 rc;
>  
>  	for (;;) {
> -		rc = opal_xive_allocate_irq(OPAL_XIVE_ANY_CHIP);
> +		rc = opal_xive_allocate_irq_fixup(OPAL_XIVE_ANY_CHIP);
>  		if (rc != OPAL_BUSY)
>  			break;
>  		msleep(OPAL_BUSY_DELAY_MS);
> 

