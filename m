Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3244C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 01:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F82206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 01:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvXsAm1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbfJJBiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 21:38:25 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44024 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731553AbfJJBiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 21:38:24 -0400
Received: by mail-yb1-f195.google.com with SMTP id y204so1395261yby.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 18:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UFJYsUva5FRhcAbZsdQcSuIVXzC9BSS6Ql6F/47Wmsk=;
        b=cvXsAm1qlmc+Kbv8i7YhK9zObTtu1ly7yMvlUxQMutSbYVH95MgCajf07z+x+zufvJ
         agz6VDwepjFNpv0zWKXH1nYHgoOgA+JmuYf63UOHiqz8yowM+06edu7A8w+EWHGDJcC3
         4/JCFGwNqfNV8Z5rt+xsZVoLuslm2q1AMNPPeofdPgphamXuUaIZAKOZXkvnaRi2XIaU
         f0+WcyTD0LVRdG4VnbNCpnmyhyVOPDkWYhCdLGB7hGP4PgsbAuz9ZwQ7/yAfaOpyL7VF
         jZKlHGYStG7dboM/75SjdMtz1mNsq3C3npFYuxO3IQlg+qxZCbFXtXfAV6a5IVUwppxn
         ZGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UFJYsUva5FRhcAbZsdQcSuIVXzC9BSS6Ql6F/47Wmsk=;
        b=SuNWqY/Z5gQvUhjcpNbhGrEGeVbj3TP83adQKP5O77q4Ex0F0/2GuVAg1h+EwdodC7
         BQFZ1JhwVT4TkZ51xWy2+VkZbhCTQwIezuZ3Gm9xn4oTxOjbiSAGMPHfJIsANqrUv6VO
         UN+sglh6y2VO5uADKJxZVcA7wI/0u/dM1LVMDUO+HsjRddR0nloKyAZhn0eO48NyCZQ+
         CNDcVvvF7NBHMaOYRJF8iNfXtSwIS0COwFRzDkAijKs42sfjvbgFNNrSSFl7aae80J4p
         HtbX285D4enfAg5lv3lV01X7oBwZAZZ3YyaLZDJXjbA+/uQnBfsYIC34pc8sT4Kcwojv
         0Ugw==
X-Gm-Message-State: APjAAAV/R7tn6A9DFuvmgVDDb0W0DLrw3CSbi12uSl+DMOqQdai4sfOg
        g8us74tvvD2Z1fLyuCTbm+pApw6ghM7LO4UPdz6/zjUI8yY=
X-Google-Smtp-Source: APXvYqy5qQm96zZkZ//ly0S8Fu08YzPKTdph55FfVXIY19+1yN1kD1nrf2mh/IACpgkcsDp8rZx4QM+4gtNJMtIXviI=
X-Received: by 2002:a5b:d50:: with SMTP id f16mr3995164ybr.25.1570671503860;
 Wed, 09 Oct 2019 18:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191009192105.GC26530@ZenIV.linux.org.uk>
In-Reply-To: <20191009192105.GC26530@ZenIV.linux.org.uk>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 9 Oct 2019 18:38:12 -0700
Message-ID: <CAMo8BfKUOmExGRMaUPmcRsy=iyRrguLF6JOLUMegNnzkF9vcvQ@mail.gmail.com>
Subject: Re: [PATCH] xtensa: fix {get,put}_user() for 64bit values
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 12:21 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> First of all, on short copies __copy_{to,from}_user() return the amount
> of bytes left uncopied, *not* -EFAULT.  get_user() and put_user() are
> expected to return -EFAULT on failure.
>
> Another problem is get_user(v32, (__u64 __user *)p); that should
> fetch 64bit value and the assign it to v32, truncating it in process.
> Current code, OTOH, reads 8 bytes of data and stores them at the
> address of v32, stomping on the 4 bytes that follow v32 itself.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> --
> diff --git a/arch/xtensa/include/asm/uaccess.h b/arch/xtensa/include/asm/uaccess.h
> index 6792928ba84a..155174ddb7ae 100644
> --- a/arch/xtensa/include/asm/uaccess.h
> +++ b/arch/xtensa/include/asm/uaccess.h
> @@ -100,7 +100,7 @@ do {                                                                        \
>         case 4: __put_user_asm(x, ptr, retval, 4, "s32i", __cb); break; \
>         case 8: {                                                       \
>                      __typeof__(*ptr) __v64 = x;                        \
> -                    retval = __copy_to_user(ptr, &__v64, 8);           \
> +                    retval = __copy_to_user(ptr, &__v64, 8) ? -EFAULT : 0;     \

Sure, I agree with that.

>                      break;                                             \
>                 }                                                       \
>         default: __put_user_bad();                                      \
> @@ -198,7 +198,12 @@ do {                                                                       \
>         case 1: __get_user_asm(x, ptr, retval, 1, "l8ui", __cb);  break;\
>         case 2: __get_user_asm(x, ptr, retval, 2, "l16ui", __cb); break;\
>         case 4: __get_user_asm(x, ptr, retval, 4, "l32i", __cb);  break;\
> -       case 8: retval = __copy_from_user(&x, ptr, 8);    break;        \
> +       case 8: {                                                       \
> +               __u64 __x = 0;                                          \
> +               retval = __copy_from_user(&__x, ptr, 8) ? -EFAULT : 0;  \
> +               (x) = *(__force __typeof__(*(ptr)) *) &__x;             \
> +               break;                                                  \
> +       }                                                               \

There's also the following code in the callers of this macro, e.g. in
__get_user_nocheck:

        long __gu_err, __gu_val;                                \
        __get_user_size(__gu_val, (ptr), (size), __gu_err);     \
        (x) = (__force __typeof__(*(ptr)))__gu_val;             \

the last line is important for sizes 1..4, because it takes care of
sign extension of the value loaded by the assembly.
At the same time the first line doesn't make sense for the size 8
as it will result in value truncation.

How about the following change instead:

diff --git a/arch/xtensa/include/asm/uaccess.h
b/arch/xtensa/include/asm/uaccess.h
index 6792928ba84a..c54893651d69 100644
--- a/arch/xtensa/include/asm/uaccess.h
+++ b/arch/xtensa/include/asm/uaccess.h
@@ -100,7 +100,7 @@ do {
                         \
        case 4: __put_user_asm(x, ptr, retval, 4, "s32i", __cb); break; \
        case 8: {                                                       \
                     __typeof__(*ptr) __v64 = x;                        \
-                    retval = __copy_to_user(ptr, &__v64, 8);           \
+                    retval = __copy_to_user(ptr, &__v64, 8) ? -EFAULT
: 0;     \
                     break;                                             \
                }                                                       \
        default: __put_user_bad();                                      \
@@ -172,7 +172,8 @@ __asm__ __volatile__(
         \

 #define __get_user_nocheck(x, ptr, size)                       \
 ({                                                             \
-       long __gu_err, __gu_val;                                \
+       long __gu_err;                                          \
+       __typeof__(*(ptr) + 0) __gu_val;                        \
        __get_user_size(__gu_val, (ptr), (size), __gu_err);     \
        (x) = (__force __typeof__(*(ptr)))__gu_val;             \
        __gu_err;                                               \
@@ -180,7 +181,8 @@ __asm__ __volatile__(
         \

 #define __get_user_check(x, ptr, size)                                 \
 ({                                                                     \
-       long __gu_err = -EFAULT, __gu_val = 0;                          \
+       long __gu_err = -EFAULT;                                        \
+       __typeof__(*(ptr) + 0) __gu_val = 0;                            \
        const __typeof__(*(ptr)) *__gu_addr = (ptr);                    \
        if (access_ok(__gu_addr, size))                 \
                __get_user_size(__gu_val, __gu_addr, (size), __gu_err); \
@@ -198,7 +200,7 @@ do {
                         \
        case 1: __get_user_asm(x, ptr, retval, 1, "l8ui", __cb);  break;\
        case 2: __get_user_asm(x, ptr, retval, 2, "l16ui", __cb); break;\
        case 4: __get_user_asm(x, ptr, retval, 4, "l32i", __cb);  break;\
-       case 8: retval = __copy_from_user(&x, ptr, 8);    break;        \
+       case 8: retval = __copy_from_user(&x, ptr, 8) ? -EFAULT : 0;
 break;  \
        default: (x) = __get_user_bad();                                \
        }                                                               \
 } while (0)

Here __typeof__(*(ptr) + 0) makes enough room for all cases
in the __get_user_size and the "+0" part takes care of pointers
to const data.

-- 
Thanks.
-- Max
