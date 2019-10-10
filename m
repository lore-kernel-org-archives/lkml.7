Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D14CECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED8E206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfJJO37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:29:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36478 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfJJO36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:29:58 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iIZS0-0004JV-6u; Thu, 10 Oct 2019 14:29:56 +0000
Date:   Thu, 10 Oct 2019 15:29:56 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xtensa: fix {get,put}_user() for 64bit values
Message-ID: <20191010142956.GG26530@ZenIV.linux.org.uk>
References: <20191009192105.GC26530@ZenIV.linux.org.uk>
 <CAMo8BfKUOmExGRMaUPmcRsy=iyRrguLF6JOLUMegNnzkF9vcvQ@mail.gmail.com>
 <20191010015606.GD26530@ZenIV.linux.org.uk>
 <CAMo8BfLo4hy+WGA7p+7iZaLmmgFOyzMRAtG5dzNj=JEU04GoKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfLo4hy+WGA7p+7iZaLmmgFOyzMRAtG5dzNj=JEU04GoKA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 07:11:40PM -0700, Max Filippov wrote:

> > I don't have
> > xtensa cross-toolchain at the moment, so I can't check it easily;
> > what does =r constraint generate in such case?
> 
> Lower register of the register pair.

OK...

> > Another thing is, you want to zero it on failure, to avoid an uninitialized
> > value ending up someplace interesting....
> 
> Ok, this?

>  #define __get_user_nocheck(x, ptr, size)                       \
>  ({                                                             \
> -       long __gu_err, __gu_val;                                \
> +       long __gu_err;                                          \
> +       __typeof__(*(ptr) + 0) __gu_val = 0;                    \
>         __get_user_size(__gu_val, (ptr), (size), __gu_err);     \
>         (x) = (__force __typeof__(*(ptr)))__gu_val;             \
>         __gu_err;                                               \
> @@ -180,7 +181,8 @@ __asm__ __volatile__(
>          \
> 
>  #define __get_user_check(x, ptr, size)                                 \
>  ({                                                                     \
> -       long __gu_err = -EFAULT, __gu_val = 0;                          \
> +       long __gu_err = -EFAULT;                                        \
> +       __typeof__(*(ptr) + 0) __gu_val = 0;                            \
>         const __typeof__(*(ptr)) *__gu_addr = (ptr);                    \
>         if (access_ok(__gu_addr, size))                 \
>                 __get_user_size(__gu_val, __gu_addr, (size), __gu_err); \
> @@ -198,7 +200,7 @@ do {
>                          \
>         case 1: __get_user_asm(x, ptr, retval, 1, "l8ui", __cb);  break;\
>         case 2: __get_user_asm(x, ptr, retval, 2, "l16ui", __cb); break;\
>         case 4: __get_user_asm(x, ptr, retval, 4, "l32i", __cb);  break;\
> -       case 8: retval = __copy_from_user(&x, ptr, 8);    break;        \
> +       case 8: retval = __copy_from_user(&x, ptr, 8) ? -EFAULT : 0;
>  break;  \
>         default: (x) = __get_user_bad();                                \
>         }                                                               \
>  } while (0)

Hmm...   Looking at __get_user_size(), we have retval = 0; very early
in it.  So I wonder if it should simply be
#define __get_user_size(x, ptr, size, retval)                           \
do {                                                                    \
        int __cb;                                                       \
        retval = 0;                                                     \
        switch (size) {                                                 \
        case 1: __get_user_asm(x, ptr, retval, 1, "l8ui", __cb);  break;\
        case 2: __get_user_asm(x, ptr, retval, 2, "l16ui", __cb); break;\
        case 4: __get_user_asm(x, ptr, retval, 4, "l32i", __cb);  break;\
        case 8: if (unlikely(__copy_from_user(&x, ptr, 8)) {            \
                        retval = -EFAULT;                               \
                        x = 0;                                          \
                }                                                       \
                break;                                                  \
        default: (x) = __get_user_bad();                                \
        }                                                               \
} while (0)
so that 64bit case is closer to the others in that respect (i.e. zeroing
done on failure and out of line).  No?
