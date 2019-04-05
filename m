Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B32C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C309E217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="heErWUCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbfDEIY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:24:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37996 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfDEIY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:24:56 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DF7E1EC0A6C;
        Fri,  5 Apr 2019 10:24:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554452694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vxMltuRWQ2c/2Wp7yTv8Di56B8om9ePsax7Ud9l7tzA=;
        b=heErWUCv2djwFtSBDYib03xVxX00bt1gIBFbUKIGOXSbeFvYFnswJagqrNonmu80kgkzWK
        YPJyup7W6NuG34jO8tththTWtSKoB0Z2ny0AFAnWEzSSiQy8tFlfUdrPq74fg7aFXOBcvZ
        5CyuG/8U/1/C1zKMQdCJl6YcqlIZzWw=
Date:   Fri, 5 Apr 2019 10:24:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] overflow.h: Rename __ab_c_size() to __calc_size()
Message-ID: <20190405082447.GD23348@zn.tnic>
References: <20190405045711.30339-1-bp@alien8.de>
 <d2e7ee85-50a7-7026-82f9-2169656bd4f9@rasmusvillemoes.dk>
 <20190405075251.GC23348@zn.tnic>
 <3fefb03d-3ea0-5a08-f00c-09a47b17f2a8@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3fefb03d-3ea0-5a08-f00c-09a47b17f2a8@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 10:09:31AM +0200, Rasmus Villemoes wrote:
> On 05/04/2019 09.52, Borislav Petkov wrote:
> > On Fri, Apr 05, 2019 at 08:26:45AM +0200, Rasmus Villemoes wrote:
> 
> >> It computes a*b+c with overflow checking at each step. calc_size
> >> is way too generic and doesn't say anything at all about how the
> >> calc(ulation) is done.
> > 
> > Ok, whatever.
> > 
> > Then it would need at least a comment above it to state what it does. I
> > don't want to go and parse the macros each time.
> 
> It's an internal helper, and struct_size is fully kernel-doc'ed. But
> yeah, a comment wouldn't hurt, and let's rename the parameters so they
> match the abc naming.
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index 40b48e2133cb..6534a727cadb 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -278,11 +278,15 @@ static inline __must_check size_t
> array3_size(size_t a, size_t b, size_t c)
>         return bytes;
>  }
> 
> -static inline __must_check size_t __ab_c_size(size_t n, size_t size,
> size_t c)
> +/*
> + * Compute a*b+c, returning SIZE_MAX on overflow. Internal helper for
> + * struct_size() below.
> + */
> +static inline __must_check size_t __ab_c_size(size_t a, size_t b, size_t c)
>  {
>         size_t bytes;
> 
> -       if (check_mul_overflow(n, size, &bytes))
> +       if (check_mul_overflow(a, b, &bytes))
>                 return SIZE_MAX;
>         if (check_add_overflow(bytes, c, &bytes))
>                 return SIZE_MAX;
> 
>

Reported-by: Borislav Petkov <bp@suse.de>
Acked-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
