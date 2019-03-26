Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620D7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB222070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="cg5TkqZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbfCZQP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:15:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44104 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730458AbfCZQP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:15:28 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 45F551EC014B;
        Tue, 26 Mar 2019 17:15:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553616926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=b/gCcZgzVAA1WNoDlPofXTpn+e8ViF+hTKidsSCP7rE=;
        b=cg5TkqZBl/c06Am7mg1KAb5+KTYFv2BtgJqBXMPVTXUWQh7hhLpWoSEqWiFqa+6sa9uXw+
        G2xhAJzaijOA7HZ0Em0JogPizQHbOrNjmCC68L40Gn9g83Qm/VXI7UmaPp0XjgeeJbjuDy
        CI6iPPHgHeOGKAh/9bz9dBhGRLxmUZk=
Date:   Tue, 26 Mar 2019 17:15:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/realmode: don't leak kernel addresses
Message-ID: <20190326161457.GN1867@zn.tnic>
References: <20190324190504.29906-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190324190504.29906-1-mcroce@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 08:05:04PM +0100, Matteo Croce wrote:
> Since commit ad67b74d2469d9b8 ("printk: hash addresses printed with %p"),
> at boot "____ptrval____" is printed instead of the trampoline addresses:
> 
>     Base memory trampoline at [(____ptrval____)] 99000 size 24576
> 
> Remove the address from the print as we don't want to leak kernel
> addresses.
> 
> Fixes: ad67b74d2469d9b8 ("printk: hash addresses printed with %p")
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---
>  arch/x86/realmode/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index d10105825d57..d76a1380ec37 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -20,8 +20,8 @@ void __init set_real_mode_mem(phys_addr_t mem, size_t size)
>  	void *base = __va(mem);
>  
>  	real_mode_header = (struct real_mode_header *) base;
> -	printk(KERN_DEBUG "Base memory trampoline at [%p] %llx size %zu\n",
> -	       base, (unsigned long long)mem, size);
> +	printk(KERN_DEBUG "Base memory trampoline at %llx size %zu\n",
> +	       (unsigned long long)mem, size);

In case this wasn't clear, please remove the whole printk. And don't
forget to CC lkml on your submissions. CCed now.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
