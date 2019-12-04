Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB3FC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA47320661
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575498522;
	bh=3MxToSPN7HGtRQHEnjUrwJVLpVkfGu+CjJW4hwRBq1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tz/RSWnF0+vatZxx/gRVBLrXZ950GpBIz0b+M6jZkDU0xQ+7Ff+Wzwnh3pkeIpjrh
	 y/AqUYJI4sU4s6GUKVDsPjmlzf6sWDG6ELUOZh5CVUpaGaBUg7QaSPs7JY0MykuyrR
	 2VSJJiTiQKTdAt7vbgAn3NOJUMyReaZqFEQuNudg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfLDW2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:28:40 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32939 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfLDW2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 17:28:40 -0500
Received: by mail-qt1-f194.google.com with SMTP id d5so1499410qto.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 14:28:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HEYQS05MAbHQwQXy7WM1nS2KzK94OdilVdY0KXKLqkE=;
        b=nBBqCbSsH0vcRIuqTjqwqF/EPv2RAANnvUThDsrRZBrruFYliF8PrDiOf6Scgm0RY2
         DJPg2KOtzdwA/U2nGZskH7q7Z7mhcfHO2GFWW11I3RSBKgYud2CT6Nt7+XA3Lgtdl/Ch
         UKw9GK4ulIcQUY+toc/6lnj69rW84l7LM30IwsJhLWCeDAfU5uJ3sTwyvRz/67d/7vPX
         nkGWFWdwJOYYmXs81hND0MONdW0epBMFL7PT9n3QLBqAoSJhrf2OEmOWbyc+sDhjbYZ/
         pffBWpsN+rlsMM9ozBiZ+tPF0JgTM9aWm0x+3x8KYqDZpJaQb7u9bbvZSWCVgyw456GV
         3ZbQ==
X-Gm-Message-State: APjAAAXARjCs8N2cz2aeAhx9hahbzrgWYxGHIagbm88VFtgPm5O14zpo
        XFyLvf8Fsf2nzpQZUmONexg=
X-Google-Smtp-Source: APXvYqw144SltBipb0Heq13NL02ySiBx3f1aMaIVU+2+KzH6pACZiCQCdgFg7UHDk/vby/lCKgODwA==
X-Received: by 2002:ac8:259c:: with SMTP id e28mr4999167qte.323.1575498519587;
        Wed, 04 Dec 2019 14:28:39 -0800 (PST)
Received: from dennisz-mbp ([2620:10d:c091:500::f69c])
        by smtp.gmail.com with ESMTPSA id d6sm4345036qkb.103.2019.12.04.14.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 14:28:38 -0800 (PST)
Date:   Wed, 4 Dec 2019 17:28:37 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH v2] fix __percpu annotation in asm-generic
Message-ID: <20191204222837.GA51250@dennisz-mbp>
References: <20191204010623.65384-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204010623.65384-1-luc.vanoostenryck@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 02:06:23AM +0100, Luc Van Oostenryck wrote:
> The generic implementation of raw_cpu_generic_add_return() is:
> 
>         #define raw_cpu_generic_add_return(pcp, val)            \
>         ({                                                      \
>                 typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));       \
>                                                                 \
>                 *__p += val;                                    \
>                 *__p;                                           \
>         })
> 
> where the 'pcp' argument is a __percpu lvalue.
> There, the variable '__p' is declared as a __percpu pointer
> the type of the address of 'pcp') but:
> 1) the value assigned to it, the return value of raw_cpu_ptr(), is
>    a plain (__kernel) pointer, not a __percpu one.
> 2) this variable is dereferenced just after while a __percpu
>    pointer is implicitly __noderef.
> 
> So, fix the declaration of the 'pcp' variable to its correct type:
> the plain (non-percpu) pointer corresponding to pcp's address,
> using the fact that typeof() ignores the address space and the
> 'noderef' attribute of its agument.
> 
> Same for raw_cpu_generic_xchg(), raw_cpu_generic_cmpxchg() &
> raw_cpu_generic_cmpxchg_double().
> 
> This removes 209 warnings on ARM, 525 on ARM64, 220 on x86 &
> more than 2600 on ppc64 (all of them with the default config).
> 
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Reported-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
> 
> Change since v1:
> * use the fact that typeof() ignore the address space of its argument.
> 
>  include/asm-generic/percpu.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
> index c2de013b2cf4..35e4a53b83e6 100644
> --- a/include/asm-generic/percpu.h
> +++ b/include/asm-generic/percpu.h
> @@ -74,7 +74,7 @@ do {									\
>  
>  #define raw_cpu_generic_add_return(pcp, val)				\
>  ({									\
> -	typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));			\
> +	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
>  									\
>  	*__p += val;							\
>  	*__p;								\
> @@ -82,7 +82,7 @@ do {									\
>  
>  #define raw_cpu_generic_xchg(pcp, nval)					\
>  ({									\
> -	typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));			\
> +	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
>  	typeof(pcp) __ret;						\
>  	__ret = *__p;							\
>  	*__p = nval;							\
> @@ -91,7 +91,7 @@ do {									\
>  
>  #define raw_cpu_generic_cmpxchg(pcp, oval, nval)			\
>  ({									\
> -	typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));			\
> +	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
>  	typeof(pcp) __ret;						\
>  	__ret = *__p;							\
>  	if (__ret == (oval))						\
> @@ -101,8 +101,8 @@ do {									\
>  
>  #define raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2) \
>  ({									\
> -	typeof(&(pcp1)) __p1 = raw_cpu_ptr(&(pcp1));			\
> -	typeof(&(pcp2)) __p2 = raw_cpu_ptr(&(pcp2));			\
> +	typeof(pcp1) *__p1 = raw_cpu_ptr(&(pcp1));			\
> +	typeof(pcp2) *__p2 = raw_cpu_ptr(&(pcp2));			\
>  	int __ret = 0;							\
>  	if (*__p1 == (oval1) && *__p2  == (oval2)) {			\
>  		*__p1 = nval1;						\
> -- 
> 2.24.0
> 

I've applied this for-5.6.

Thanks,
Dennis
