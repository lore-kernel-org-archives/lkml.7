Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2389C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C363E21881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="UuZn+C/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731174AbfIBJfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:35:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34194 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729882AbfIBJfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:35:42 -0400
Received: from zn.tnic (p200300EC2F064300457D028AAFF6D0C1.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:4300:457d:28a:aff6:d0c1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 20FF91EC058B;
        Mon,  2 Sep 2019 11:35:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567416941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gMacCHoIDtGw6CoJzRJ0mgFybJ/RZle830//LlHX1RI=;
        b=UuZn+C/wmlVWfwlzTgUPC1VslVT7CYKOYvrReYJvPE4uR/qv7nhvg1RVjlmvAVec22LhCV
        umx1XiiQ8kh2XXiz4AEYAufzh1skba6oRoAQQ6FrjSLGAvnvTzBmX8kD9AZ/AM8H5XXhdq
        6lvG+KhkBDtHquVygYd5SRomMwuIRxc=
Date:   Mon, 2 Sep 2019 11:35:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86-ml <x86@kernel.org>
Subject: Re: [PATCH] x86/boot/compressed/64: Fix 'may be used uninitialized'
 issue
Message-ID: <20190902093534.GB9605@zn.tnic>
References: <1567416624-26727-1-git-send-email-zhenzhong.duan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1567416624-26727-1-git-send-email-zhenzhong.duan@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2019 at 05:30:24PM +0800, Zhenzhong Duan wrote:
> Builds kernel with "make bzImage EXTRA_CFLAGS=-Wall", gcc complains:
> 
> arch/x86/boot/compressed/pgtable_64.c: In function 'paging_prepare':
> arch/x86/boot/compressed/pgtable_64.c:92:7: warning: 'new' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    new = round_down(new, PAGE_SIZE);
> 
> In theory a random value of variable new may pass all the check and be
> assigned to bios_start, fixing it by assigning it an initial value.
> 
> Fixes: 0a46fff2f910 ("x86/boot/compressed/64: Fix boot on machines with broken E820 table")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86-ml <x86@kernel.org>
> ---
>  arch/x86/boot/compressed/pgtable_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> index 2faddeb..c886269 100644
> --- a/arch/x86/boot/compressed/pgtable_64.c
> +++ b/arch/x86/boot/compressed/pgtable_64.c
> @@ -72,7 +72,7 @@ static unsigned long find_trampoline_placement(void)
>  
>  	/* Find the first usable memory region under bios_start. */
>  	for (i = boot_params->e820_entries - 1; i >= 0; i--) {
> -		unsigned long new;
> +		unsigned long new = bios_start;
>  
>  		entry = &boot_params->e820_table[i];
>  
> -- 

https://git.kernel.org/tip/c96e8483cb2da6695c8b8d0896fe7ae272a07b54

In the future, use tip/master when preparing fixes because it has the
latest state of the x86 tree and you won't have to duplicate effort,
like in this case.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
