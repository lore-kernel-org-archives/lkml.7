Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F7FC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D152067B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QYSGWD2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfIKJkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:40:43 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:56468 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfIKJkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bC+7AkqQohlcqRdZPZWKgGspys87RR8TikThWXhbXNk=; b=QYSGWD2EiaQUzRlWTWlgn9t1p
        W/ppZ+fmwlYPNZ79bENQJ1r4n36DdMI8pp6DZpgdOVraWQJ7vWsnADH5UQapBj9/KOnyXzj8U2YoL
        nFwyucdxReA1aVGBzEr6ZxmYqFwDDjDA727zWFagxlR1qHzAng0UE6GvVsdulucPKsvvnZULSj4bS
        NNEZE8qtmZcWFLAkMToYafM4hXwJtsT0t44EN00B3wtZRuLN+UZTD17K7k3F4Jl7mT0XWjbVjauvo
        v1cm6v8uunJ77/ah/rrA/FJOiv0MH4aMFvjA1XasiwEKj/hs5SYPBqgVN8yA5B02we607O6mKW4/9
        ogS1saweA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:38166)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i7z75-0005Vv-7r; Wed, 11 Sep 2019 10:40:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i7z72-0003qa-4e; Wed, 11 Sep 2019 10:40:32 +0100
Date:   Wed, 11 Sep 2019 10:40:32 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     allison@lohutok.net, info@metux.net,
        matthias.schiffer@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: module: Drop 'rel->r_offset < 0' always false
 statement
Message-ID: <20190911094031.GU13294@shell.armlinux.org.uk>
References: <20190911045408.GA62424@LGEARND20B15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911045408.GA62424@LGEARND20B15>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 01:54:08PM +0900, Austin Kim wrote:
> Since rel->r_offset is declared as Elf32_Addr,
> this value is always non-negative.
> typedef struct elf32_rel {
> 	  Elf32_Addr	r_offset;
> 	    Elf32_Word	r_info;
> } Elf32_Rel;
> 
> typedef __u32	Elf32_Addr;
> typedef unsigned int __u32;
> 
> Drop 'rel->r_offset < 0' statement which is always false.
> 
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> ---
>  arch/arm/kernel/module.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
> index deef17f..0921ce7 100644
> --- a/arch/arm/kernel/module.c
> +++ b/arch/arm/kernel/module.c
> @@ -92,7 +92,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
>  		sym = ((Elf32_Sym *)symsec->sh_addr) + offset;
>  		symname = strtab + sym->st_name;
>  
> -		if (rel->r_offset < 0 || rel->r_offset > dstsec->sh_size - sizeof(u32)) {
> +		if (rel->r_offset > dstsec->sh_size - sizeof(u32)) {
>  			pr_err("%s: section %u reloc %u sym '%s': out of bounds relocation, offset %d size %u\n",

Also change %d to %u here.

>  			       module->name, relindex, i, symname,
>  			       rel->r_offset, dstsec->sh_size);
> -- 
> 2.6.2
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
