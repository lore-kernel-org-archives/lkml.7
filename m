Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED04C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E0820645
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4psVpVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfEIRWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:22:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44711 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfEIRWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:22:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id z16so1533649pgv.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 10:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Cxfb19YUVUexW3ozjAQeyWjYm/lrrA+iXsHy8xXEAM=;
        b=F4psVpVZrrjQ/nPIPztYU0hyT6id0Qk586KPULiCzJvTlqTJOIL1Ez2aAf5GaW+9ZE
         PKQqKT5d5Eoc4gH5iN/Cygu21nybDN9za39dq+AxcTkAaOaWX5h/ieoTxPp3wj8sTTB9
         Cfd4SZHGClzzK2xO1kkRv0Yl4dScXscT6V3Qr9AIEfs+COVt7hysZRq5n10Q/CjFKmqr
         M8pxWPJtM6xHxShEHCTKdOxj4evFeQT+B6HoCOEOLNZFnd6/KTo7zQbm0U1BLWYIvIaf
         VuP3LHV9Nmn5HB8YY9sVGKwC4YFBwSXaL9v32GG08jYwVBzpe6pj+2TyGAAVqsBDFFFn
         cnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Cxfb19YUVUexW3ozjAQeyWjYm/lrrA+iXsHy8xXEAM=;
        b=UJPMkyEkSLhCppnwqK9mFW38kJSrxRq4E+9Sk/OxYCPWxr6CcBt70LZ4NqQ8hLzHZo
         dwQRKA711YYocrNqgd+HVqO02hIvIHQwXpXGvlawULYGS6JswWBT2Fz3i2LUfvpUhnkz
         ifGwRsVp0jZztlhj1h3b0IM9/mJ8/BotVuXKh0TJVFlQRHdyovaHfsbQLwZ8MG3kYiTK
         THT/XEQD+vUJi5aJDTVN3EyF++ImdwEmUzmAOcCG3lHE+iRh6VSLQGHvX2e0F6q1JYMi
         iQS34JfmM3hV99Avmuqh8JKrQzUV7STjtLDMrmSRkwRg0ahPTVV2vrXIaPW5mKqInuxl
         Jvmg==
X-Gm-Message-State: APjAAAVZ8u+HrrXQrovRCnfg8r+8rqP8kp7O6IiSrZNMciYlT6lu/QMV
        armWZLY0Twl9iGbtwjP/MQs=
X-Google-Smtp-Source: APXvYqwB7N5aie/qryInfA7ZAOafE4fDcxS+GE2len23QrUiVGrCSintwNWb1RazqCXzE1q8YU4bjQ==
X-Received: by 2002:a62:2703:: with SMTP id n3mr6918605pfn.199.1557422566388;
        Thu, 09 May 2019 10:22:46 -0700 (PDT)
Received: from localhost ([2601:640:c:43ea:19d3:11c4:475e:3daa])
        by smtp.gmail.com with ESMTPSA id j10sm3690822pfa.37.2019.05.09.10.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 10:22:45 -0700 (PDT)
Date:   Thu, 9 May 2019 10:22:44 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Yury Norov <ynorov@marvell.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Clean up the __[PHYSICAL/VIRTUAL]_MASK_SHIFT
 definitions a bit
Message-ID: <20190509172244.GA11274@yury-thinkpad>
References: <20190508204411.13452-1-ynorov@marvell.com>
 <20190509090131.GA130570@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509090131.GA130570@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 11:01:31AM +0200, Ingo Molnar wrote:
> 
> * Yury Norov <yury.norov@gmail.com> wrote:
> 
> > __VIRTUAL_MASK_SHIFT is defined twice to the same valie in
> > arch/x86/include/asm/page_32_types.h. Fix it.
> > 
> > Signed-off-by: Yury Norov <ynorov@marvell.com>
> > ---
> >  arch/x86/include/asm/page_32_types.h | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/page_32_types.h b/arch/x86/include/asm/page_32_types.h
> > index 0d5c739eebd7..9bfac5c80d89 100644
> > --- a/arch/x86/include/asm/page_32_types.h
> > +++ b/arch/x86/include/asm/page_32_types.h
> > @@ -28,6 +28,8 @@
> >  #define MCE_STACK 0
> >  #define N_EXCEPTION_STACKS 1
> >  
> > +#define __VIRTUAL_MASK_SHIFT	32
> > +
> >  #ifdef CONFIG_X86_PAE
> >  /*
> >   * This is beyond the 44 bit limit imposed by the 32bit long pfns,
> > @@ -36,11 +38,8 @@
> >   * The real limit is still 44 bits.
> >   */
> >  #define __PHYSICAL_MASK_SHIFT	52
> > -#define __VIRTUAL_MASK_SHIFT	32
> > -
> >  #else  /* !CONFIG_X86_PAE */
> >  #define __PHYSICAL_MASK_SHIFT	32
> > -#define __VIRTUAL_MASK_SHIFT	32
> >  #endif	/* CONFIG_X86_PAE */
> 
> I think it's clearer to see them defined where the physical mask shift is 
> defined.
> 
> How about the patch below? It does away with the weird formatting and 
> cleans up both the comments and the style of the definition:
> 
> /*
>  * 52 bits on PAE is beyond the 44-bit limit imposed by the
>  * 32-bit long PFNs, but we need the full mask to make sure
>  * inverted PROT_NONE entries have all the host bits set
>  * in a guest. The real limit is still 44 bits.
>  */
> #ifdef CONFIG_X86_PAE
> # define __PHYSICAL_MASK_SHIFT	52
> # define __VIRTUAL_MASK_SHIFT	32
> #else
> # define __PHYSICAL_MASK_SHIFT	32
> # define __VIRTUAL_MASK_SHIFT	32
> #endif
> 
> ?

My main concern was about double definition. It pretty looks like a
bug. But if it's intentional, I'm OK. In the patch below, could you
please add some note to the comment that __VIRTUAL_MASK_SHIFT defined
twice intentionally?

Thanks,
Yury
 
> Thanks,
> 
> 	Ingo
> 
> ===============>
> From: Ingo Molnar <mingo@kernel.org>
> Date: Thu, 9 May 2019 10:59:44 +0200
> Subject: [PATCH] x86/mm: Clean up the __[PHYSICAL/VIRTUAL]_MASK_SHIFT definitions a bit
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/include/asm/page_32_types.h | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/include/asm/page_32_types.h b/arch/x86/include/asm/page_32_types.h
> index 565ad755c785..009e96d4b6d4 100644
> --- a/arch/x86/include/asm/page_32_types.h
> +++ b/arch/x86/include/asm/page_32_types.h
> @@ -26,20 +26,19 @@
>  
>  #define N_EXCEPTION_STACKS	1
>  
> -#ifdef CONFIG_X86_PAE
>  /*
> - * This is beyond the 44 bit limit imposed by the 32bit long pfns,
> - * but we need the full mask to make sure inverted PROT_NONE
> - * entries have all the host bits set in a guest.
> - * The real limit is still 44 bits.
> + * 52 bits on PAE is beyond the 44-bit limit imposed by the
> + * 32-bit long PFNs, but we need the full mask to make sure
> + * inverted PROT_NONE entries have all the host bits set
> + * in a guest. The real limit is still 44 bits.
>   */
> -#define __PHYSICAL_MASK_SHIFT	52
> -#define __VIRTUAL_MASK_SHIFT	32
> -
> -#else  /* !CONFIG_X86_PAE */
> -#define __PHYSICAL_MASK_SHIFT	32
> -#define __VIRTUAL_MASK_SHIFT	32
> -#endif	/* CONFIG_X86_PAE */
> +#ifdef CONFIG_X86_PAE
> +# define __PHYSICAL_MASK_SHIFT	52
> +# define __VIRTUAL_MASK_SHIFT	32
> +#else
> +# define __PHYSICAL_MASK_SHIFT	32
> +# define __VIRTUAL_MASK_SHIFT	32
> +#endif
>  
>  /*
>   * Kernel image size is limited to 512 MB (see in arch/x86/kernel/head_32.S)
