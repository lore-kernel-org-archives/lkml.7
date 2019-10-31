Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8D4CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285A920862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qNmMGXtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfJaLDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:03:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35124 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbfJaLDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:03:10 -0400
Received: from nazgul.tnic (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 856641EC0CD3;
        Thu, 31 Oct 2019 12:03:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1572519785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=z39G9UOa5V+G2XaGK01K79kOY635cMjOB2YxE8Kx4mQ=;
        b=qNmMGXtVmSr3U2Q5XPPA1HDPHZfskzbUAw2Nb1PiMknM3AX86LxGI+avV6f2Q6h9TF8h+3
        IihVuHX0vp4R2u/x6Acv+yOxmIC6BxqQUKnwrkbnZowwTHPq8cG1JmPqOm2b9hXq5Eggmf
        l+DDBIWtqVJgU899u7Uvy3qUJNFI9VQ=
Date:   Thu, 31 Oct 2019 12:03:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/ioremap: Use WARN_ONCE instead of printk() +
 WARN_ON_ONCE()
Message-ID: <20191031110304.GE21133@nazgul.tnic>
References: <1572425838-39158-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1572425838-39158-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 04:57:18PM +0800, zhong jiang wrote:
> WARN_ONCE is more clear and simpler. Just replace it.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  arch/x86/mm/ioremap.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index a39dcdb..3b74599 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -172,9 +172,8 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
>  		return NULL;
>  
>  	if (!phys_addr_valid(phys_addr)) {
> -		printk(KERN_WARNING "ioremap: invalid physical address %llx\n",
> -		       (unsigned long long)phys_addr);
> -		WARN_ON_ONCE(1);
> +		WARN_ONCE(1, "ioremap: invalid physical address %llx\n",
> +			  (unsigned long long)phys_addr);

Does
	WARN_ONCE(!phys_addr_valid(phys_addr),
		  "ioremap: invalid physical address %llx\n",
		  (unsigned long long)phys_addr);

work too?

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
