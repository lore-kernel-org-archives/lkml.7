Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654BFC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FC02251D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 12:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574253065;
	bh=igZU/uxtW8Tj+TBJdEFIPYOI/ZlPHauslaJCQ6/sNqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qUiuHUKVB0VQ4lpjyJqbf+GsMkL6nW+LQPy2iXxH7K5eSyZaJrtsSF/WEqGD2OyuN
	 IrzA+INqFnwtR9A28SMyPcmS+2uCCoymzEJdwQNqC00KeXqUy5rKstxk7J40Jb3qIx
	 mYmctN0aHfmACYRa2+/OTqanJmOepVwUr0kQZ3wo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbfKTMbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 07:31:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39030 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfKTMbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 07:31:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id l7so27932620wrp.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 04:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oF272YdvOBPcMekRUMKZ+4luBT6maFPugIEMdZDUVZw=;
        b=kMbThVja6AiYnx24nyEpF3d3/wgr8WOeg9d+ED2tcr+5fk5m+88n2vcDw0//q4zf0p
         oeVd6AeRmZtJ8xJ3WkHkS36R2h1NnXNfv+f0sdKVX1IPol8IQ+HjwLhc/9lwUxd9u8yq
         xBHp9+L07x47qcs7koYofX1iTuLZNQta5vckRhmUqSl0v6aydygcHhkyLen4yOU/qLBX
         gGyKoOjMsG7wBkwwAzGE2n0arYeQZAPBy14HDMgk5C1e387we2Zobetz2T7GLKXW+Fn1
         tceJ1xjhJYiPyENtLLRTZ77KEg+MvSl+vSE7rzgd/lJJCtC0t0fQgg9lTXep3HJNfgc1
         akbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oF272YdvOBPcMekRUMKZ+4luBT6maFPugIEMdZDUVZw=;
        b=JwPQT1YnojnUrgYkSVgFNBIO4yXUkANH/3oNRQYfuM4vlWI5SlZTaX6u26Sw8+zw3c
         I3obXzYUysPYpwkDGPAMShK9UoiFCMBIqU+TKSw/qCX0YBmDjzNZUuaCXF8LvKv/zt9x
         zgpuooUF0wlVtAw48NMaBI5gdAgIpvkbHiYZ73kfHO3K68bKbVvoKTtMUPdnN1JJeOaw
         6d7cxfnoQuqwlGbpZtKyPeacSug78ZcJ3qH72DGsntTWTDmOuNbJ2JESqvIi7Kp0ubpQ
         /exki0kYZz/GD21m2877gh3R/xWdeIcvh6B58dfuX0AAy3DRgDpEwdoT46Np6Ntl5OSf
         l/zA==
X-Gm-Message-State: APjAAAXWvhbf4Wamogc1N1CmojhGK1PZMbI6R6lpGw5PhvZUdTMqTu/X
        Ib21EAB3nT4V3bbqJLO70eCFXI6U
X-Google-Smtp-Source: APXvYqz/Zwe5fWDvGG+YGtv7pOayqZk+Dh1xQrrocmXxJNcNWe52hMM0UthWdUYJYvd9pvWReF5RsQ==
X-Received: by 2002:a5d:4c8c:: with SMTP id z12mr2966064wrs.347.1574253061550;
        Wed, 20 Nov 2019 04:31:01 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id w12sm6421851wmi.17.2019.11.20.04.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 04:31:00 -0800 (PST)
Date:   Wed, 20 Nov 2019 13:30:58 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 2/4] x86/traps: Print non-canonical address on #GP
Message-ID: <20191120123058.GA17296@gmail.com>
References: <20191120103613.63563-1-jannh@google.com>
 <20191120103613.63563-2-jannh@google.com>
 <20191120111859.GA115930@gmail.com>
 <CAG48ez0Frp4-+xHZ=UhbHh0hC_h-1VtJfwHw=kDo6NahyMv1ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0Frp4-+xHZ=UhbHh0hC_h-1VtJfwHw=kDo6NahyMv1ig@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jann Horn <jannh@google.com> wrote:

> You mean something like this?
> 
> ========================
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 9b23c4bda243..16a6bdaccb51 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -516,32 +516,36 @@ dotraplinkage void do_bounds(struct pt_regs
> *regs, long error_code)
>   * On 64-bit, if an uncaught #GP occurs while dereferencing a non-canonical
>   * address, return that address.
>   */
> -static unsigned long get_kernel_gp_address(struct pt_regs *regs)
> +static bool get_kernel_gp_address(struct pt_regs *regs, unsigned long *addr,
> +                                          bool *non_canonical)

Yeah, that's pretty much the perfect end result!

> I guess that could potentially be useful if a #GP is triggered by
> something like an SSE alignment error? I'll add it in unless someone
> else complains.

Yeah - also it's correct information about the context of the fault, so 
it probably cannot *hurt*, and will allow us to debug/validate everything 
in this area faster.

> > > +#define GPFSTR "general protection fault"
> > >  dotraplinkage void
> >
> > Please separate macro and function definitions by an additional newline.
> 
> Will change it.

Thanks!

	Ingo
