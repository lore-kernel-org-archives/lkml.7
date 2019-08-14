Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE7DC32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EE320578
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFuFnRB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfHNJlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 05:41:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39885 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfHNJlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:41:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id f17so49260087pfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 02:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LfFkLwjqyQIH9T75mSQkj/WAlvM62io+hnQFkWZp6Pc=;
        b=jFuFnRB0/8csf+W8FViKPIDaEmS37F+row4a3iyvUZTk3+UEYYsc/umedWVPXZUEPN
         LDdtmXgjxyfggY0JP9gzuxWNLkt9w7hpjz8XuE2kCmm80gh3Ki9JQxk9tWm1EBPlfH/K
         DP12ymtzlN9IHXiSHs19xPERgy/Qb624g0yuWHYl2dH4tQJSIcz8tQn7dX+ptc4xCSJz
         B5+5z3lM3tK0y5tdfekEiXiAa3s+bulCjpDfShlgK+v7H75t366TqhsaV7NYrIMciMC/
         qdUcENrR41a7h870LEPPVNzFj8aZQuAJJprtvNeh4/Pv5rXpcBKXNaVjOrJr6lJaZqWu
         frmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LfFkLwjqyQIH9T75mSQkj/WAlvM62io+hnQFkWZp6Pc=;
        b=Aj9qcNqyQvqljSwKM5tuXeVILdC7qsBgSYICNuq5EcoU+zvasZ9rUIHzR5zoBRyO06
         3mD62vp+ZKbDRq9JlFooQW4NO84v0BFkv8AmQHUGWSUh6uQqCOihMLG2gLtXWrsR+/QI
         KQw9hGcRE83d/ZOFAEKP6rh+FBQ51Sdxwih2wsf4wSBBLBwJDvtGt7lafsVJ4lQ+z0/j
         1bUfED4rCWjciDZFJHQRCrdXSuENB683ClsfnTFKVeZOagMLlYpXEGz39RBFmTXNczJy
         fNGYLc52tQ+QmyIieVzRwlDaQ7Id3w5NSuy+UgDBaPBgqmeFSO3wuUNgz4yUPD6J7ikC
         Kc8Q==
X-Gm-Message-State: APjAAAXHRpsLnc3hrCLLIAB8poMZTBYXYYykm50VHFWqYS+bVYMKXfkT
        ouPlFVDKYfun5F4nbiXjS4U02IM6JyLObg==
X-Google-Smtp-Source: APXvYqyRTX2xe/RXO2a1R4wAMFoGUHd/8F69mYx1bwHIiLNCMYtDwXDbG78SgJR7jpu9zRPE3C/+Kg==
X-Received: by 2002:a62:7a0f:: with SMTP id v15mr26284997pfc.35.1565775664294;
        Wed, 14 Aug 2019 02:41:04 -0700 (PDT)
Received: from [192.168.68.119] (203-219-253-117.static.tpgi.com.au. [203.219.253.117])
        by smtp.gmail.com with ESMTPSA id i11sm17425385pfk.34.2019.08.14.02.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 02:41:03 -0700 (PDT)
Subject: Re: [PATCH v9 7/7] powerpc: add machine check safe copy_to_user
To:     Santosh Sivaraj <santosh@fossix.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>
References: <20190812092236.16648-1-santosh@fossix.org>
 <20190812092236.16648-8-santosh@fossix.org>
From:   Balbir Singh <bsingharora@gmail.com>
Message-ID: <74d12529-d068-0210-e229-5cea68bcf9da@gmail.com>
Date:   Wed, 14 Aug 2019 19:40:58 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812092236.16648-8-santosh@fossix.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/19 7:22 pm, Santosh Sivaraj wrote:
> Use  memcpy_mcsafe() implementation to define copy_to_user_mcsafe()
> 
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  arch/powerpc/Kconfig               |  1 +
>  arch/powerpc/include/asm/uaccess.h | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 77f6ebf97113..4316e36095a2 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -137,6 +137,7 @@ config PPC
>  	select ARCH_HAS_STRICT_KERNEL_RWX	if ((PPC_BOOK3S_64 || PPC32) && !RELOCATABLE && !HIBERNATION)
>  	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_HAS_UACCESS_FLUSHCACHE	if PPC64
> +	select ARCH_HAS_UACCESS_MCSAFE		if PPC64
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>  	select ARCH_KEEP_MEMBLOCK
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index 8b03eb44e876..15002b51ff18 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -387,6 +387,20 @@ static inline unsigned long raw_copy_to_user(void __user *to,
>  	return ret;
>  }
>  
> +static __always_inline unsigned long __must_check
> +copy_to_user_mcsafe(void __user *to, const void *from, unsigned long n)
> +{
> +	if (likely(check_copy_size(from, n, true))) {
> +		if (access_ok(to, n)) {
> +			allow_write_to_user(to, n);
> +			n = memcpy_mcsafe((void *)to, from, n);
> +			prevent_write_to_user(to, n);
> +		}
> +	}
> +
> +	return n;

Do we always return n independent of the check_copy_size return value and access_ok return values?

Balbir Singh.

> +}
> +
>  extern unsigned long __clear_user(void __user *addr, unsigned long size);
>  
>  static inline unsigned long clear_user(void __user *addr, unsigned long size)
> 
