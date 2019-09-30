Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C87C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 23:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9CC20842
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 23:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SPRbd6oU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbfI3XRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 19:17:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41381 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfI3XRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 19:17:12 -0400
Received: by mail-pl1-f195.google.com with SMTP id t10so4499056plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 16:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s+E8d+wIpq1H61PFBF05uvTO/+0fPX2dJKuEBGo4+g8=;
        b=SPRbd6oUbYxVJorJSUePGkeFypIbfmsj0kT6hGC2CdojS3znzWsO+zLVnk89yw18bz
         s4yrtzvrd5NA6wvhv0xtW47/61CeCJvUH5YxLa427g9fjSlyLapp4eobTICnQNQXvFch
         QM+EdYldHGmpjSQ2lNVc5Mk1HFwHi2wAivBcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s+E8d+wIpq1H61PFBF05uvTO/+0fPX2dJKuEBGo4+g8=;
        b=q/AEuXz+xv2uR0b/rCUzI1R67Vf8JpmgncoP8FdHEC9j70aC1he+kGEgKvQrmLl2hS
         Ahm7dpvde38dd6tOE2QnGzsRy0O19geOSHXfhEq1IcWYHR6A3RkcwdjXw4PQlqvwZwe/
         kYLVq8Cc3DnqXOQ2BqqO1f4Id94jXlu6vKm/VV3jTlVG7m5OWXpbYk/r0c2e8WQpuKdc
         jpxGjwieoaRxKZkHoXolV4zLD8mupE+pbJvoqIgoJLRL1dcIEWZignVICDZHX+Nfo5c3
         HUab2YAce9vgw/CKOKpDsCC65U0Ba+Hu3M86rFKro1zsXdYopsSt5Z54zyzTrqjnC/Bd
         bPqw==
X-Gm-Message-State: APjAAAXiQxqOGsP1bnT4miFcj9x7KJHvYGtHfhy9wVjjysHP3xlGZIww
        xiTcQuRgc073oAiTPDejzP2HHg==
X-Google-Smtp-Source: APXvYqyQWN8nd8F5m/N78RKk7aA10//x0k553EMaqLL1W2gvfaw6tX36DJxbpsfGMcFzyz3Pnrq7Yw==
X-Received: by 2002:a17:902:a98a:: with SMTP id bh10mr22769666plb.343.1569885431796;
        Mon, 30 Sep 2019 16:17:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j126sm15668439pfb.186.2019.09.30.16.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:17:09 -0700 (PDT)
Date:   Mon, 30 Sep 2019 16:17:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] uaccess: Add missing __must_check attributes
Message-ID: <201909301611.1363980D7@keescook>
References: <201908251609.ADAD5CAAC1@keescook>
 <CAK8P3a3_sarrMKij5=sp-o16dXERfWkHhUr0fE49Xv8BvXDfaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3_sarrMKij5=sp-o16dXERfWkHhUr0fE49Xv8BvXDfaw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 12:33:19PM +0200, Arnd Bergmann wrote:
> On Wed, Aug 28, 2019 at 7:38 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > The usercopy implementation comments describe that callers of the
> > copy_*_user() family of functions must always have their return values
> > checked. This can be enforced at compile time with __must_check, so add
> > it where needed.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> I can't find any other reports, so I'd point out here that this found what
> looks like a bug in the x86 math-emu code:

Oh interesting!

> arch/x86/math-emu/reg_ld_str.c:88:2: error: ignoring return value of
> function declared with 'warn_unused_result' attribute
> [-Werror,-Wunused-result]
>         __copy_from_user(sti_ptr, s, 10);
>         ^~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~
> arch/x86/math-emu/reg_ld_str.c:1129:2: error: ignoring return value of
> function declared with 'warn_unused_result' attribute
> [-Werror,-Wunused-result]
>         __copy_from_user(register_base + offset, s, other);
>         ^~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/x86/math-emu/reg_ld_str.c:1131:3: error: ignoring return value of
> function declared with 'warn_unused_result' attribute
> [-Werror,-Wunused-result]
>                 __copy_from_user(register_base, s + other, offset);
>                 ^~~~~~~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

What was the CONFIG for this? I didn't hit these in my build tests.

> Moreover, the same code also ignores the return value from most
> get_user()/put_user()/FPU_get_user()/FPU_put_user() calls,
> which have no warn_unused_result annotation (they are macros,
> but I think something could be done if we want to have that
> annotation to catch some of the other such users).

It would certainly make sense to mark those as __must_check too... now
tracking this here for anyone that wants to take a stab at it:
https://github.com/KSPP/linux/issues/16

-- 
Kees Cook
