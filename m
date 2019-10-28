Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D12CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 17:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A27521479
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 17:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0PUA4Tj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbfJ1Rha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 13:37:30 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35703 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfJ1Rha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 13:37:30 -0400
Received: by mail-lj1-f195.google.com with SMTP id m7so12287348lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 10:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VuVinsI/3uiMH/uRjW5JsSQsBaqr+Zj6YBmT9PXcHok=;
        b=M0PUA4TjthTNgUv3eUuNaVYUk/T4pYaaHUCsnepsfmgtABGSfOWWgsuXT7yhF3AXtr
         SMuIn+qb+Lp6Ve89dGQ3FAybVuEm/bx3XL7zsAy7L0fJlHaabaUiFoekQkG3Z+2w5ykK
         j9pnaZ3k/t/8U1IIB5FCGwnQgLzgNTJnaHj4/Mp7fpfkbQpm4XtQUaVhiuYB1VSUcd3m
         yfRwWw7rn8jJVRgOlrmbWJ07vZtu5j78VARRhdI5ADwJgK7Q+3ixLsxG54xL3wE86d2Q
         wGKIMlzDtdb7KpSdqHL/lT14gEpKlqc7938aFegcHoMdoDMK3BwjJBuOzcme5Zudn/hW
         TIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VuVinsI/3uiMH/uRjW5JsSQsBaqr+Zj6YBmT9PXcHok=;
        b=jX7Po0I0Kr+DeRrYg4mdapK8hKq8v9Qd1Itg9hUqSwUP8JAdQ5hHIbYkDm0haycqW9
         WThGObhGdiqsU4ZggF7NuKBOYRh55OXnJDQv2muZqJiD9NsXpwRSsUZY/5KjAoCrVkp1
         nyACdUHlL71dzVzbDBdWXXSi1CRar76DP+DzS0ontOZht1Fn6UxNVhUMt85JMOv6yM2+
         0EbM5qInkGZHTKvR1pTYPOcHfgeNfgJRAQlcdnWlupHC88IJSZSmAPOjj4nxESTR60DB
         VybHAtrvHru7KAyHf1o7WzxEXzLYBleWr2oBuMmSWyYbhNFyZ9/8sNUyFF9F6nQyMC3X
         B/Gw==
X-Gm-Message-State: APjAAAUQJe6LbTmTFkKfK5aVKKnPXD8v36opQaVhCGJzkJI8Fa7kmRdK
        Fhka+Q2NRN1SCtb2pmZdeKvdvkwnZNGfUrpUQWaLexxW
X-Google-Smtp-Source: APXvYqwp9bMWwh61/3xfg8rvTEuaKSFdmIUm5fmu4mm0j81ToI7s29lW8sto7iheQxP9bCg2R39m1XQ7wl/n8RPeraU=
X-Received: by 2002:a2e:320d:: with SMTP id y13mr7421528ljy.145.1572284248866;
 Mon, 28 Oct 2019 10:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <7a15bc8ad7437dc3a044a4f9cd283500bd0b5f36.camel@perches.com>
In-Reply-To: <7a15bc8ad7437dc3a044a4f9cd283500bd0b5f36.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 28 Oct 2019 18:37:17 +0100
Message-ID: <CANiq72=B6XKwfkC9L4=+OxWtjxCp-94TWRG1a=pC=y636gzckA@mail.gmail.com>
Subject: Re: [PATCH] compiler*.h: Add '__' prefix and suffix to all
 __attribute__ #defines
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 12:43 PM Joe Perches <joe@perches.com> wrote:
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 72393a..b8c2145 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -5,27 +5,27 @@
>  #ifndef __ASSEMBLY__
>
>  #ifdef __CHECKER__
> -# define __user                __attribute__((noderef, address_space(1)))
> -# define __kernel      __attribute__((address_space(0)))
> -# define __safe                __attribute__((safe))
> -# define __force       __attribute__((force))
> -# define __nocast      __attribute__((nocast))
> -# define __iomem       __attribute__((noderef, address_space(2)))
> -# define __must_hold(x)        __attribute__((context(x,1,1)))
> -# define __acquires(x) __attribute__((context(x,0,1)))
> -# define __releases(x) __attribute__((context(x,1,0)))
> -# define __acquire(x)  __context__(x,1)
> -# define __release(x)  __context__(x,-1)
> +# define __user                __attribute__((__noderef__, __address_space__(1)))
> +# define __kernel      __attribute__((__address_space__(0)))
> +# define __safe                __attribute__((__safe__))
> +# define __force       __attribute__((__force__))
> +# define __nocast      __attribute__((__nocast__))
> +# define __iomem       __attribute__((__noderef__, __address_space__(2)))
> +# define __must_hold(x)        __attribute__((__context__(x, 1, 1)))
> +# define __acquires(x) __attribute__((__context__(x, 0, 1)))
> +# define __releases(x) __attribute__((__context__(x, 1, 0)))
> +# define __acquire(x)  __context__(x, 1)
> +# define __release(x)  __context__(x, -1)
>  # define __cond_lock(x,c)      ((c) ? ({ __acquire(x); 1; }) : 0)
> -# define __percpu      __attribute__((noderef, address_space(3)))
> -# define __rcu         __attribute__((noderef, address_space(4)))
> -# define __private     __attribute__((noderef))
> +# define __percpu      __attribute__((__noderef__, __address_space__(3)))
> +# define __rcu         __attribute__((__noderef__, __address_space__(4)))
> +# define __private     __attribute__((__noderef__))

Just in case: for these ones (i.e. __CHECKER__), did you check if
sparse handles this syntax? (I don't recall myself if it does).

Other than that, thanks for the cleanup too! I can pick it up in the
the compiler-attributes tree and put it in -next.

Cheers,
Miguel
