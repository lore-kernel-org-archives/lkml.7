Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01291C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE1D206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSK/3UR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732545AbfJJCVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 22:21:02 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46278 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfJJCLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 22:11:52 -0400
Received: by mail-yw1-f66.google.com with SMTP id l64so1469014ywe.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 19:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=woyaIkIQv6Xs21ozbrL0GY7iKCTuq76f+v68JretALk=;
        b=dSK/3UR3/ac63/FVph2mecjCuuCfPMnqYKYexzIGXFHLESmymGyJvuEOkNJxmopgLf
         5xrb/JWTOx3bD1bIQTBrrkOa6GrKrJt1Mcnwrrz2GG5XB59jgbYMVCJf1wDWXFn3NNj1
         kkSiaomXd8DWEQe6AePVRU47qYr4Nst8PBIv3QVxcCp5RPOHk8JOXsB0rzEVO3wTPtKT
         eL8RzJgX5Av2Jc0ZJBR50ttog9yzygYjYrEtDm+BpEWEz7el2WE08oF9KSfgINM/QKwK
         otJ35OkhiqPAhB22Hnq1b2ZIsDIbX1ugGOMFdDCxERwi1Jx7K8YvjslVMFDun/cDyymv
         G0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=woyaIkIQv6Xs21ozbrL0GY7iKCTuq76f+v68JretALk=;
        b=fiE7tegCEP5o1yXxY8dN3xsuqM9Q1550UQoohgF+Ccatnt1WlJdsRctNFK0B4kPA7T
         Mlk6JSNoB12a1/CViy0KHmuq/+pxh9RefjQxSfcUrurb/X5z2yAMyJKaCNvVT+ncatUr
         hog/bbJOdj2P51nSJroi2bGmVOShuJK3P5nZcDy2teWehlZ629tPY8ey+4vbd9iJAJ5m
         DvBPZn4XXXkYu+5+Tutqlw88aLhUOhiNdOQ0zho1cm4H+4bTlFfQpWwDSPs8MrPh+QjW
         djajidCrhVWKhSfqU3CeVU5jp4Igh9T/QijFn2KvlLKJAF7FvCaalxCTBACqpjn11ZIM
         scMA==
X-Gm-Message-State: APjAAAURQkyZIWo7T9S1XcjUwJ0qQMk7HRvHVMZFZWmXaLA77rhmyb0C
        g16f70UKFmdCXzhJ1B++K8Iz98D3AL6GyMqDReIGl4gtLFE=
X-Google-Smtp-Source: APXvYqzCRWZDmD2E9YFKDujrVGkDM9cpNNyJ94dqrwW0mY7ENRS6hBWtMFes2xo1pKhFn0Is8FgWCwtUQDcOWPsVbcI=
X-Received: by 2002:a81:254d:: with SMTP id l74mr5160055ywl.409.1570673511796;
 Wed, 09 Oct 2019 19:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191009192105.GC26530@ZenIV.linux.org.uk> <CAMo8BfKUOmExGRMaUPmcRsy=iyRrguLF6JOLUMegNnzkF9vcvQ@mail.gmail.com>
 <20191010015606.GD26530@ZenIV.linux.org.uk>
In-Reply-To: <20191010015606.GD26530@ZenIV.linux.org.uk>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 9 Oct 2019 19:11:40 -0700
Message-ID: <CAMo8BfLo4hy+WGA7p+7iZaLmmgFOyzMRAtG5dzNj=JEU04GoKA@mail.gmail.com>
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

On Wed, Oct 9, 2019 at 6:56 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Oct 09, 2019 at 06:38:12PM -0700, Max Filippov wrote:
>
> > There's also the following code in the callers of this macro, e.g. in
> > __get_user_nocheck:
> >
> >         long __gu_err, __gu_val;                                \
> >         __get_user_size(__gu_val, (ptr), (size), __gu_err);     \
> >         (x) = (__force __typeof__(*(ptr)))__gu_val;             \
> >
> > the last line is important for sizes 1..4, because it takes care of
> > sign extension of the value loaded by the assembly.
> > At the same time the first line doesn't make sense for the size 8
> > as it will result in value truncation.
>
> Right you are...
>
> > +       long __gu_err;                                          \
> > +       __typeof__(*(ptr) + 0) __gu_val;                        \
>
> What would __u64 __gu_val; end up with for smaller sizes?

It does good job with little endian cores, i.e. the generated code is
the same in both cases, but on big endian it looks into wrong register
of the register pair that represents __gu_val. E.g.:

foo_in_s8_out_s8:
        entry   sp, 32  #
        mov.n   a7, sp  # a5,
# /home/jcmvbkbc/ws/tensilica/linux/linux-xtensa/arch/xtensa/kernel/signal.c:518:
gen_outs(8)
        movi.n  a8, 0   # __gu_err,
#APP
# 518 "/home/jcmvbkbc/ws/tensilica/linux/linux-xtensa/arch/xtensa/kernel/signal.c"
1
        1: l8ui  a10, a2, 0                     # __gu_val, p
2:
   .section  .fixup,"ax"
   .align 4
   .literal_position
5:
   movi   a2, 2b                        # __cb
   movi   a10, 0                        # __gu_val
   movi   a8, -14                       # __gu_err,
   jx     a2                            # __cb
   .previous
   .section  __ex_table,"a"
   .long        1b, 5b
   .previous
# 0 "" 2
#NO_APP
        extui   a2, a11, 0, 8   #, __gu_val
        retw.n

> I don't have
> xtensa cross-toolchain at the moment, so I can't check it easily;
> what does =r constraint generate in such case?

Lower register of the register pair.

> Another thing is, you want to zero it on failure, to avoid an uninitialized
> value ending up someplace interesting....

Ok, this?

diff --git a/arch/xtensa/include/asm/uaccess.h
b/arch/xtensa/include/asm/uaccess.h
index 6792928ba84a..0bdaadf1636e 100644
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
+       __typeof__(*(ptr) + 0) __gu_val = 0;                    \
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


-- 
Thanks.
-- Max
