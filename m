Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56749CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FB2208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 16:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YYg5GFM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390863AbfJ1QMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 12:12:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38538 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfJ1QMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 12:12:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id c13so7188525pfp.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 09:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=er/3bfy8IhrY9qdlrH4iVA2P4YvVI+kEvjcxpJ5t3Tk=;
        b=YYg5GFM1VkALdHGS6BUh/THlh98BO4lQRd9oHRTwBvZKpVOm/5B3IlOHnSWlITH5G8
         G2ySObKxllxMKU3YDTm8avJxKgPn0ifwgKcc2dAn4f+zQPoyxN8AuAsIGvPuswNrioDa
         rJ+yVZcZgZhL9Vl6OIMQs2W/dZeZAXTATYQGZAUqPZ9072sgt+OHut738p14d6IXu8Gp
         e05kkNlL9u9t7X6PJcv1Tu4LHZyabHwyYH4x9ZlaN4Rfvtxr5z2UMIHZTXu3l3pcaDXr
         PqYIEfk2kgZtv1dcTjVUTK+ECMMtaK0BE5Zzu9r8vdVFDo08e3YAQqLQBuNSAvIiqGe5
         I4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=er/3bfy8IhrY9qdlrH4iVA2P4YvVI+kEvjcxpJ5t3Tk=;
        b=uEfLt200QKYPpeWKD34iFB98OZ/0/v1zqRhwbak30JHADKroY8miiu6/FT57h3KcmK
         5n1KOmTfj0r46yhpI3eHhIpac3b+9Td3/sbJt/7Oehg+yrGriFl5tSpUdoovrNp1cavv
         2i69OJ9katvAgj9mDc8KhK0EgH0lMB1ow3i9VmL7npyZJbuoXmXyI/2HEMAj2mlu3iid
         dCnVO+7cUhM3KEn3uaXdeCk5Zj8YEtaDq00Ry2h6xD7+SYNjy/ZfhGA1nt0lUiJglpdV
         OwnAIVv5iA5ZeVYZNczPAfcyiTD0IvSOCktJFub+T/0ij8rhQ8EEe0+HQpiNiFXD50Mx
         fTNA==
X-Gm-Message-State: APjAAAWvcpjTZVAvXin9JTpM1/fOFlajofuuwQByLdslh84kk/Ybbc8v
        aI7YWeNOlK3F7JmZXfLJO2cknhds6iJA9uHcKYo57JUI
X-Google-Smtp-Source: APXvYqxMcM2ljmiDJULws8S/Qc6DgeI8dN5M8WCE5QU1AAUtlUW62cBWTzpa9KfUQJHyIYaeRob7iBiJBADm+hc/Ml0=
X-Received: by 2002:aa7:980c:: with SMTP id e12mr21491291pfl.165.1572279161877;
 Mon, 28 Oct 2019 09:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <7a15bc8ad7437dc3a044a4f9cd283500bd0b5f36.camel@perches.com>
In-Reply-To: <7a15bc8ad7437dc3a044a4f9cd283500bd0b5f36.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 28 Oct 2019 09:12:30 -0700
Message-ID: <CAKwvOdmE+i_3yrRvNHNVrt-jteDOtp7mEx1ZpvyXdNhOPkBg_A@mail.gmail.com>
Subject: Re: [PATCH] compiler*.h: Add '__' prefix and suffix to all
 __attribute__ #defines
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2019 at 3:03 PM Joe Perches <joe@perches.com> wrote:
>
> To avoid macro name collisions and improve portability use a
> double underscore prefix and suffix on all __attribute__ #defines.
>
> Before this patch, 33 of 56 #defines used a form like:
>
>         '#define __<type> __attribute__((__<attribute_name>__))'
>
> Now all __attribute__ #defines use that form.
>
> Signed-off-by: Joe Perches <joe@perches.com>

Thanks for the cleanup.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  include/linux/compiler-clang.h |  2 +-
>  include/linux/compiler-gcc.h   | 10 +++++-----
>  include/linux/compiler_types.h | 34 +++++++++++++++++-----------------
>  3 files changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 333a66..26d655f 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -19,7 +19,7 @@
>  /* emulate gcc's __SANITIZE_ADDRESS__ flag */
>  #define __SANITIZE_ADDRESS__
>  #define __no_sanitize_address \
> -               __attribute__((no_sanitize("address", "hwaddress")))
> +               __attribute__((__no_sanitize__("address", "hwaddress")))
>  #else
>  #define __no_sanitize_address
>  #endif
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index d7ee4c..7a2dee 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -76,7 +76,7 @@
>  #define __compiletime_error(message) __attribute__((__error__(message)))
>
>  #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
> -#define __latent_entropy __attribute__((latent_entropy))
> +#define __latent_entropy __attribute__((__latent_entropy__))
>  #endif
>
>  /*
> @@ -101,8 +101,8 @@
>         } while (0)
>
>  #if defined(RANDSTRUCT_PLUGIN) && !defined(__CHECKER__)
> -#define __randomize_layout __attribute__((randomize_layout))
> -#define __no_randomize_layout __attribute__((no_randomize_layout))
> +#define __randomize_layout __attribute__((__randomize_layout__))
> +#define __no_randomize_layout __attribute__((__no_randomize_layout__))
>  /* This anon struct can add padding, so only enable it under randstruct. */
>  #define randomized_struct_fields_start struct {
>  #define randomized_struct_fields_end   } __randomize_layout;
> @@ -140,7 +140,7 @@
>  #endif
>
>  #if __has_attribute(__no_sanitize_address__)
> -#define __no_sanitize_address __attribute__((no_sanitize_address))
> +#define __no_sanitize_address __attribute__((__no_sanitize_address__))
>  #else
>  #define __no_sanitize_address
>  #endif
> @@ -171,4 +171,4 @@
>  #define __diag_GCC_8(s)
>  #endif
>
> -#define __no_fgcse __attribute__((optimize("-fno-gcse")))
> +#define __no_fgcse __attribute__((__optimize__("-fno-gcse")))
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
>  extern void __chk_user_ptr(const volatile void __user *);
>  extern void __chk_io_ptr(const volatile void __iomem *);
>  # define ACCESS_PRIVATE(p, member) (*((typeof((p)->member) __force *) &(p)->member))
>  #else /* __CHECKER__ */
>  # ifdef STRUCTLEAK_PLUGIN
> -#  define __user __attribute__((user))
> +#  define __user __attribute__((__user__))
>  # else
>  #  define __user
>  # endif
> @@ -111,9 +111,9 @@ struct ftrace_likely_data {
>  #endif
>
>  #if defined(CC_USING_HOTPATCH)
> -#define notrace                        __attribute__((hotpatch(0, 0)))
> +#define notrace                        __attribute__((__hotpatch__(0, 0)))
>  #elif defined(CC_USING_PATCHABLE_FUNCTION_ENTRY)
> -#define notrace                        __attribute__((patchable_function_entry(0, 0)))
> +#define notrace                        __attribute__((__patchable_function_entry__(0, 0)))
>  #else
>  #define notrace                        __attribute__((__no_instrument_function__))
>  #endif
>
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/7a15bc8ad7437dc3a044a4f9cd283500bd0b5f36.camel%40perches.com.



-- 
Thanks,
~Nick Desaulniers
