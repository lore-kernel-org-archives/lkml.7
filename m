Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BB4C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 00:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961A721881
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 00:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FMp6D3PY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbfIEAAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 20:00:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47043 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730196AbfIEAAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 20:00:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so445969pfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 17:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0NxsKgRGI2+KacBh6H56eCk9/oGHU02yt6ZfudyZ/ts=;
        b=FMp6D3PYAa0+RBlQo6LHWUOI4fXTGDJIb5gG3z2Fb5W/5VzsQrv1mIsdmiH1sFEbBe
         m22uqgy7btZyc7Cm460jDTDO8UDAkcW+VR6Ragqi4P0lGFD9Fq7W/QXU6cwXHafgiXzu
         sLFV9HhFHwJMqzrhypXfrRMhgEmZMeeV89sW5jFkkmrLlhdvqHLeiWCG3xN9qFE69GFz
         S3HZX2ML1iMnMhSwo9GIqlOX8Kn9Dp5MuYb3BftNl3RepcvPiBNPPmR7ntSEIMvnrn1h
         dGp8yMIQ2BMbeC02rHaFrrMUBVq7LR3IDBrhdd7GoHqMDDEvTyub/NdUH5kTzrQ47iK9
         fWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0NxsKgRGI2+KacBh6H56eCk9/oGHU02yt6ZfudyZ/ts=;
        b=UH2V1nP6QUecViWbtQ5Q6FbuWDQ65/otAi+hs/kR2S94BbiSdhG4z8DjDIV2lvU2TS
         utiKPK3t5WjnyP9X7+x6Iyrur2SoL/5z2FPsRVvxPvaQHt3Y8DbFwliYVFtPDNR8opOv
         nqwxzvwg4tnUaHWX8jrlyXURu4yI37BJg/Fs0gvLkBZHKYM0eC5e+K+Z5Zh9bC3NA0zP
         +Vej7yq0s5BZkV8H4iLbGoDm0+LV0Sn1hNDL0C94wNxw3JqGTpu74HTP8IWFHAI/A2kO
         GBFUQAQLrAh21AApkAjOJJjkK20i4t0gsVMdPFGqYM1DLfDf2sgJ0pFiN6BSJPP+G15g
         PioQ==
X-Gm-Message-State: APjAAAW3NLIcRfwWD9QXLyJtDcQnNqyW4LFQf9Lcvh++1S1V5VRdj6Nu
        RAzhCxPSvlVoo6/dcg3qJHs0WWP2j4FO469JaiyD6w==
X-Google-Smtp-Source: APXvYqx0zWTuKmb8e/CAU475Ycn//YTBcC4TiriwCKRWYganMEWhcIP8vqeo33Q3SKepMoa63GsAWWfd/6rhWWCfDPg=
X-Received: by 2002:a63:6193:: with SMTP id v141mr619229pgb.263.1567641604961;
 Wed, 04 Sep 2019 17:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-1-linux@rasmusvillemoes.dk> <20190830231527.22304-3-linux@rasmusvillemoes.dk>
In-Reply-To: <20190830231527.22304-3-linux@rasmusvillemoes.dk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 4 Sep 2019 16:59:53 -0700
Message-ID: <CAKwvOdnZE7pCTykwjX_DDh0wKcUAVKA8eSYXSUFWG2e3swFEJQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] lib/zstd/mem.h: replace __inline by inline
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 4:15 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> Currently, compiler_types.h #defines __inline as inline (and further
> #defines inline to automatically attach some attributes), so this does
> not change functionality. It serves as preparation for removing the
> #define of __inline.
>
> (Note that if ZSTD_STATIC is expanded somewhere where compiler_types.h
> has not yet been processed, both __inline and inline both refer to the
> compiler keyword, so again this does not change anything.)
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  lib/zstd/mem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/zstd/mem.h b/lib/zstd/mem.h
> index 3a0f34c8706c..739837a59ad6 100644
> --- a/lib/zstd/mem.h
> +++ b/lib/zstd/mem.h
> @@ -27,7 +27,7 @@
>  /*-****************************************
>  *  Compiler specifics
>  ******************************************/
> -#define ZSTD_STATIC static __inline __attribute__((unused))
> +#define ZSTD_STATIC static inline __attribute__((unused))

While you're here, would you mind replacing `__attribute__((unused))`
with `__unused`?  I would consider "naked attributes" (haven't been
feature tested in include/linux/compiler_attributes.h and are verbose)
to be an antipattern.

>
>  /*-**************************************************************
>  *  Basic Types
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers
