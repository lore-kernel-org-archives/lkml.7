Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BE2C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05EFB20684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="FkGFioHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfCHMHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:07:49 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:47518 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfCHMHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:07:48 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 995E325BEE4;
        Fri,  8 Mar 2019 23:07:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1552046865; bh=do/NZoA+2yVYjcKfNWQJCtxHXOG03DljP4xUfjCII/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FkGFioHexwEdup88xYIeCzYwsbOEcsrMm9vi35HG9cVMuk1l8V+T7TmKiomlTyXyt
         PjxOwCdTmjws4P/oVp5k1VdkGMTIlRp5RbVkF/uMPHMbem2qG/1S18JjbYA1KPEzsK
         Vtv+02nmwb5EimknsMKt1NI+jxm8RLtbTy30qnsk=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 0A298940270; Fri,  8 Mar 2019 13:07:43 +0100 (CET)
Date:   Fri, 8 Mar 2019 13:07:43 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 08/15] ARM: shmobile: fix a leaked reference by adding
 missing of_node_put
Message-ID: <20190308120743.bsqma3pp6h52bd53@verge.net.au>
References: <1551785646-46173-1-git-send-email-wen.yang99@zte.com.cn>
 <1551785646-46173-8-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551785646-46173-8-git-send-email-wen.yang99@zte.com.cn>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 07:33:59PM +0800, Wen Yang wrote:
> The call to of_get_next_child returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> ./arch/arm/mach-shmobile/pm-rcar-gen2.c:77:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 66, but without a corresponding object release within this function.
> ./arch/arm/mach-shmobile/pm-rcar-gen2.c:85:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 66, but without a corresponding object release within this function.
> ./arch/arm/mach-shmobile/pm-rcar-gen2.c:90:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 66, but without a corresponding object release within this function.
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
> v2->v1: add a missing space between "adding" and "missing"

Thanks, I have this applied for inclusion in v5.2.

>  arch/arm/mach-shmobile/pm-rcar-gen2.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
> index 8c2a205..e84599d 100644
> --- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
> +++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
> @@ -72,6 +72,7 @@ void __init rcar_gen2_pm_init(void)
>  	}
>  
>  	error = of_address_to_resource(np, 0, &res);
> +	of_node_put(np);
>  	if (error) {
>  		pr_err("Failed to get smp-sram address: %d\n", error);
>  		return;
> -- 
> 2.9.5
> 
