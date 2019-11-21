Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66174C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 22:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358A0206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 22:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P11PcsYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfKUWpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:45:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34009 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfKUWp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 17:45:29 -0500
Received: by mail-pl1-f196.google.com with SMTP id h13so2266361plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 14:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NLz8kBduJ9FRPrkOWrULO0u5MGm5tgSgst04YXoyCPU=;
        b=P11PcsYdx77RuFgGyC06CQKzVX3DdP56J5tlxf5wdv/z+QSa459zis/2f+GGQHGH1x
         IPGvcZrqGPYLTpz3rfeaHfVWa+NmRjJ6QW2ejIDIzFBxNblRFQ0F1x0Qb+FWw98haQCb
         fPhMWZuOulCfCaWchT4nNn3P+yDhGa/cfqmKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NLz8kBduJ9FRPrkOWrULO0u5MGm5tgSgst04YXoyCPU=;
        b=GdhbirpIcgJq+PPj5Bfld+ZE9YpICpztIhJlqv3eC6kJCYRKkdhNehTJ1M+1dw6Lrm
         zSH7w0LyvTYVSRqJ+7yEcPjeYWO/ky7X84xKEl9nqVpqNmmRapr+UhGQ96ONsbfOdKaJ
         37rniFGrLoDI18WWxYgwgptmhROtkASP1k1oxJSDjMNJGcrc9dgrtuMD3PWYD0NESmJ4
         df+25orykGEWitzfULLf5EoMTzkSxXXtun3BuGAnVcWUTheyrPY2XynzWlWjj/PiNDt1
         RTl0QYgNv5hoEHkv02o8inMxqHTq7uen/jlu4fU/E5/N45hPFYTybgwrQjza1+cpCERn
         6K/g==
X-Gm-Message-State: APjAAAVLJL7hZjgI8/fBTHdd6KvcScZCInoII64xCOPIIy466dBW+Spq
        78QQ33V5rxKxjrHymNUR6f1Hzg==
X-Google-Smtp-Source: APXvYqwqJs9lM/zsQjIHM1WnY03LC1E54t3cRzzuRCm7DgdRYqBOI/BlaHjhl3bUoQBbqAUojSgk1g==
X-Received: by 2002:a17:90a:ba89:: with SMTP id t9mr14885631pjr.29.1574376329072;
        Thu, 21 Nov 2019 14:45:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k32sm545501pje.10.2019.11.21.14.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 14:45:27 -0800 (PST)
Date:   Thu, 21 Nov 2019 14:45:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        =?iso-8859-1?Q?Jo=E3o?= Moreira <joao.moreira@intel.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Stephan Mueller <smueller@chronox.de>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v5 2/8] crypto: x86/serpent: Remove glue function macros
 usage
Message-ID: <201911211444.01B61BEB7@keescook>
References: <20191113182516.13545-1-keescook@chromium.org>
 <20191113182516.13545-3-keescook@chromium.org>
 <20191113193428.GB221701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113193428.GB221701@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 11:34:29AM -0800, Eric Biggers wrote:
> On Wed, Nov 13, 2019 at 10:25:10AM -0800, Kees Cook wrote:
> > diff --git a/arch/x86/include/asm/crypto/serpent-sse2.h b/arch/x86/include/asm/crypto/serpent-sse2.h
> > index 1a345e8a7496..491a5a7d4e15 100644
> > --- a/arch/x86/include/asm/crypto/serpent-sse2.h
> > +++ b/arch/x86/include/asm/crypto/serpent-sse2.h
> > @@ -41,8 +41,7 @@ asmlinkage void __serpent_enc_blk_8way(struct serpent_ctx *ctx, u8 *dst,
> >  asmlinkage void serpent_dec_blk_8way(struct serpent_ctx *ctx, u8 *dst,
> >  				     const u8 *src);
> >  
> > -static inline void serpent_enc_blk_xway(struct serpent_ctx *ctx, u8 *dst,
> > -				   const u8 *src)
> > +static inline void serpent_enc_blk_xway(void *ctx, u8 *dst, const u8 *src)
> >  {
> >  	__serpent_enc_blk_8way(ctx, dst, src, false);
> >  }
> > @@ -53,8 +52,7 @@ static inline void serpent_enc_blk_xway_xor(struct serpent_ctx *ctx, u8 *dst,
> >  	__serpent_enc_blk_8way(ctx, dst, src, true);
> >  }
> >  
> > -static inline void serpent_dec_blk_xway(struct serpent_ctx *ctx, u8 *dst,
> > -				   const u8 *src)
> > +static inline void serpent_dec_blk_xway(void *ctx, u8 *dst, const u8 *src)
> >  {
> >  	serpent_dec_blk_8way(ctx, dst, src);
> >  }
> 
> Please read this whole file --- these functions are also defined under an #ifdef
> CONFIG_X86_32 block, so that part needs to be updated too.

Whoops, yes, thank you! I'll add a 32-bit build to my allmodconfig test.
:)

-- 
Kees Cook
