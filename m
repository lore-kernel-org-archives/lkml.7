Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E856CC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA94320880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3ez7IM/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfDOW5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:57:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54299 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfDOW5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 18:57:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id c1so22661459wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 15:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4m5cRpZV4vqK4PwyhZwTZq0EuEvBEKQazFbGo6vEKss=;
        b=J3ez7IM/meghOUXIEmxPBzwoG4ZKCiWYscdUrJWP5opt1t5LUwy/IecKxxS2wAa5kJ
         6eXN7AqA2w9WvH4YxInCP7q4+Gova8D5RGPMMk2cKucjnA4FaO1PsE8VIcXdCtw2aWBJ
         uBPwmeDFZ4eGhwGs5GXKpLEFIt1ss+CpPkm/gC3F2cbS2IvW1jvaNB3PTN93sGHH5thr
         E8X+zR9p3bGja6RRN5ZaXx9ow5ak4vqV6dP6hzX19e3alNNC+eA4kjCMIaKyC7HRhUrs
         rc6pnsj5eb4JGvlfkMtDDbzIhVIjgosyi5RrmoadMK7iIuTd0Qbnj7vI5UB7lSDOxInr
         1DCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4m5cRpZV4vqK4PwyhZwTZq0EuEvBEKQazFbGo6vEKss=;
        b=WK1qONkpKkpSIPVsC6yr2g5eOx+GSsKpzN/FiMWwrUH01QFq2pN42RBR5e3g+clycL
         Vp6yJlg2XzuipdNNzcP/BCxMwaATvnh6JEeFLgMt5+ZXllEjVHtY4gadS2XJ7yuToqgC
         30LZ/D20SgLPVOCArIyPndRN+1XvJ4D31UO+m2MzHYDJncDGgGaQRCWV0vH2lipwZJnE
         PbZ4TA6AbRIOyFYsKFmmpxQDz+qL3XYJHMhAXCbCE/5efZjHWlx7go+bYaNlg8gVbEMC
         bHbPeGRJ1gFrJMqw9WqcAYFKLPAN3Y419AekncS1ZpYy0G0uwQvPCXtqKiqXvIjDi9CM
         bzAg==
X-Gm-Message-State: APjAAAV5mpsT9pVPf7UJPvVl0+YZle13xCMTIJH+blC+EKBaZOhZyQq3
        giNe0sFp/kmOIX54vK0Rq4AO+Ew=
X-Google-Smtp-Source: APXvYqzApjixKuIgtajIkzWOdw0r8VyefOdSWZJHvs7OkAOIK5QQ2vjgDBEmaYxdkmB0jTb9SjiEQQ==
X-Received: by 2002:a05:600c:2293:: with SMTP id 19mr24102917wmf.77.1555369028638;
        Mon, 15 Apr 2019 15:57:08 -0700 (PDT)
Received: from localhost (186.red-83-33-157.dynamicip.rima-tde.net. [83.33.157.186])
        by smtp.gmail.com with ESMTPSA id u14sm45638049wrr.1.2019.04.15.15.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 15:57:07 -0700 (PDT)
Subject: Re: [PATCH] x86/mm: Prevent bogus warnings with "noexec=off"
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86 team <x86@kernel.org>
References: <c090ad3c-1f2f-c148-dd44-a58df0788588@gmail.com>
 <alpine.DEB.2.21.1904141158400.4917@nanos.tec.linutronix.de>
 <92ac69b8-7e29-50e1-f460-4e7ac8c6b7ac@gmail.com>
 <alpine.DEB.2.21.1904151037530.1729@nanos.tec.linutronix.de>
From:   Xose Vazquez Perez <xose.vazquez@gmail.com>
Message-ID: <20066a63-4d7e-c0e9-23fa-4653d1dae8df@gmail.com>
Date:   Tue, 16 Apr 2019 00:57:06 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904151037530.1729@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/19 10:46 AM, Thomas Gleixner wrote:

> Xose reported warnings when NX is disabled on the kernel command line.

Thank you for doing the dirty work.

> 
> __early_set_fixmap() triggers:
> 
>   attempted to set unsupported pgprot:    8000000000000163
>   	       	   	       bits:      8000000000000000
> 			       supported: 7fffffffffffffff
> 
>   WARNING: CPU: 0 PID: 0 at arch/x86/include/asm/pgtable.h:537
>   	   	       	    __early_set_fixmap+0xa2/0xff
> 
> because it uses __default_kernel_pte_mask to mask out unsupported bits.
> 
> Use __supported_pte_mask instead.
> 
> Disabling NX on the command line also triggers the NX warning in the page
> table mapping check:
> 
>   WARNING: CPU: 1 PID: 1 at arch/x86/mm/dump_pagetables.c:262 note_page+0x2ae/0x650
>   ....
> 
> Make the warning depend on NX set in __supported_pte_mask.
> 
> Reported-by: Xose Vazquez Perez <xose.vazquez@gmail.com>

And
Tested-by: Xose Vazquez Perez <xose.vazquez@gmail.com>

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/mm/dump_pagetables.c |    3 ++-
>  arch/x86/mm/ioremap.c         |    2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/mm/dump_pagetables.c
> +++ b/arch/x86/mm/dump_pagetables.c
> @@ -259,7 +259,8 @@ static void note_wx(struct pg_state *st)
>  #endif
>  	/* Account the WX pages */
>  	st->wx_pages += npages;
> -	WARN_ONCE(1, "x86/mm: Found insecure W+X mapping at address %pS\n",
> +	WARN_ONCE(__supported_pte_mask & _PAGE_NX,
> +		  "x86/mm: Found insecure W+X mapping at address %pS\n",
>  		  (void *)st->start_address);
>  }
>  
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -825,7 +825,7 @@ void __init __early_set_fixmap(enum fixe
>  	pte = early_ioremap_pte(addr);
>  
>  	/* Sanitize 'prot' against any unsupported bits: */
> -	pgprot_val(flags) &= __default_kernel_pte_mask;
> +	pgprot_val(flags) &= __supported_pte_mask;
>  
>  	if (pgprot_val(flags))
>  		set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, flags));
> 

