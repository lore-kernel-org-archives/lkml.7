Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64C4C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733AB2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZV58FB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfHNJWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 05:22:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37395 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfHNJWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:22:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id 129so6313535pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 02:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o5VgXZSr3CkOKGeSUVxEPdzuhdzMHUJ4B37bTJdSkiA=;
        b=pZV58FB92yTQ58cFWIY0ZrR9WepwOaEZQCnUq50sbyNa7k9L6MBWPEX92IZuybhEq3
         yI2BD/pDGWGYbOcUJUKBuRR23L845lxAbNW9j/cvj0I2bGcKq+iloz3i5e1P1EFfywR8
         xBUgJjQFOml6qUhkad76CFVHSJB3NQU4WOA1+3keR8hFivk29EexKY90XVd542j6K5HL
         vkbqW8Eeqqmr1Kz5RXNU286kuc6Sl2khJfj1YV4mqSf+QScckN4ZP+65ynr99CtRr02A
         dEjNAsbk2KmaNPBYC73azwiMUeJU7JOtUK1ihuN4r+8k7r0oiIcyoy3ddEulEZE+McMC
         3Dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o5VgXZSr3CkOKGeSUVxEPdzuhdzMHUJ4B37bTJdSkiA=;
        b=MklOMOcM/a315xwVx1LLkE80iZtvpJu+516RjSnQtxJOqg6NJ2M2HqDguJo0GyzYBk
         ueIjgmMYUqMp40Aw3CTMd6JJYRlDCkEkY2BIxakWAVRvbVbtTC+swEclgWzkqMbuSmka
         6CvYfj/cfiT5hzI3y1UvyXlxbXTVooJvQcAUwgQoUkm1H31XxpQHtjpGVC6AAVlTpytV
         2/5AvxUqemdCrxqpvRqJLGL9OMzV9YST4vdyVIjgG+j79WS00v1lRogxykZNysI3+dqu
         tQ9PXgwe56dMcCZirfCnUs8F/cTsCPK13RIqemaX0MSh5IScyh5aSNAgR2lTTKpvuizy
         kaog==
X-Gm-Message-State: APjAAAXg5Q2NuoyO1x0KvZnYmXPiLLh/8Y2JHgYduwvGFiEN50Fwow3B
        HFyLinu6bo+hYzjjYdYnFX0=
X-Google-Smtp-Source: APXvYqyiPptI/2rCkwsakVEWWwtICO6KfW5npJicVHWbTzex5WmfJr7zoLsHbjzFHyG4jJH65NIzwg==
X-Received: by 2002:a17:90a:3465:: with SMTP id o92mr6113026pjb.20.1565774527842;
        Wed, 14 Aug 2019 02:22:07 -0700 (PDT)
Received: from [192.168.68.119] (203-219-253-117.static.tpgi.com.au. [203.219.253.117])
        by smtp.gmail.com with ESMTPSA id m6sm113712457pfb.151.2019.08.14.02.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 02:22:07 -0700 (PDT)
Subject: Re: [PATCH v9 4/7] extable: Add function to search only kernel
 exception table
To:     Santosh Sivaraj <santosh@fossix.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
References: <20190812092236.16648-1-santosh@fossix.org>
 <20190812092236.16648-5-santosh@fossix.org>
From:   Balbir Singh <bsingharora@gmail.com>
Message-ID: <916d5741-a0bd-8860-4a38-7a5ef677214a@gmail.com>
Date:   Wed, 14 Aug 2019 19:22:00 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812092236.16648-5-santosh@fossix.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/19 7:22 pm, Santosh Sivaraj wrote:
> Certain architecture specific operating modes (e.g., in powerpc machine
> check handler that is unable to access vmalloc memory), the
> search_exception_tables cannot be called because it also searches the
> module exception tables if entry is not found in the kernel exception
> table.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  include/linux/extable.h |  2 ++
>  kernel/extable.c        | 11 +++++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/extable.h b/include/linux/extable.h
> index 41c5b3a25f67..81ecfaa83ad3 100644
> --- a/include/linux/extable.h
> +++ b/include/linux/extable.h
> @@ -19,6 +19,8 @@ void trim_init_extable(struct module *m);
>  
>  /* Given an address, look for it in the exception tables */
>  const struct exception_table_entry *search_exception_tables(unsigned long add);
> +const struct exception_table_entry *
> +search_kernel_exception_table(unsigned long addr);
> 

Can we find a better name search_kernel still sounds like all of the kernel.
Can we rename it to search_kernel_linear_map_extable?

 
>  #ifdef CONFIG_MODULES
>  /* For extable.c to search modules' exception tables. */
> diff --git a/kernel/extable.c b/kernel/extable.c
> index e23cce6e6092..f6c9406eec7d 100644
> --- a/kernel/extable.c
> +++ b/kernel/extable.c
> @@ -40,13 +40,20 @@ void __init sort_main_extable(void)
>  	}
>  }
>  
> +/* Given an address, look for it in the kernel exception table */
> +const
> +struct exception_table_entry *search_kernel_exception_table(unsigned long addr)
> +{
> +	return search_extable(__start___ex_table,
> +			      __stop___ex_table - __start___ex_table, addr);
> +}
> +
>  /* Given an address, look for it in the exception tables. */
>  const struct exception_table_entry *search_exception_tables(unsigned long addr)
>  {
>  	const struct exception_table_entry *e;
>  
> -	e = search_extable(__start___ex_table,
> -			   __stop___ex_table - __start___ex_table, addr);
> +	e = search_kernel_exception_table(addr);
>  	if (!e)
>  		e = search_module_extables(addr);
>  	return e;
> 
