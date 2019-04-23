Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE40CC282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D2D217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="UiRr4bOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfDWQHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:07:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39326 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbfDWQHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:07:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id l18so7702826pgj.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/6yGNw+GddeG+JGK7yWuf2Vdt5FOQ0zTBy3ljzfqBg4=;
        b=UiRr4bOdWC4Yr+hy2WKLYg1BrqWUtayOk+O7ylBgu9sQi/yt6to0sRGuvM6SYS7Gjm
         r+P5niyvJmJOu+dS/BksvvPjfKTgilVxI2m7QtOI+tnJUmW2xwUC7+r9UbBJRpqulPyp
         Fi9f3f7NmMbBnJFAKGlZbj80GO3zgHVY6J5l5TvqFoLUp8nvvdadqAIbmAbhRzf3Z6dO
         F1g55E6U4+wBVXdHqch+opg+7veDYRcoGJcn+IO1qQAeZvAnqk/F1Uw7YAu0EQi7lqqt
         x0grR+mE0e2HBZIEr5nHm3DTb7oyYuUxOLF9Oi26hN5VimZipHmmgwIraFHMIo5kPlQk
         sSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/6yGNw+GddeG+JGK7yWuf2Vdt5FOQ0zTBy3ljzfqBg4=;
        b=iNrwTnb7uTHIqTkAI8CJS5EhmxU8973IDYPuVeq7CTTGmhZnxWIZDWjpUPjrl9noE1
         BM/rtK093tRhHgrFqRQsnGvTMIcQ+cs1T8VbyD8IYShuhIWYN39/hA25pgKuUUsDWBOW
         aszYNLLK/PB6hHhFsQWaJM71DoVep4ovm4brYW1YNZ/Hce4cpDI/mZamFwu4EEPyp2uD
         NoqaFcdcONMNONDl0Ik/3QldOiyC82pprWeewlb+1ipa23SDs2zWsNgayjT/l5KekUHo
         AGRp+NWFRRwdyUxvItMYdeH7cMbvduv3g4tBj48VnxE0KuXVAxMEjDa6748AnFYP/OE2
         DTMQ==
X-Gm-Message-State: APjAAAV9St+1TmYT/x4BEfsaQHQpTnTnArvYSI8Rsptpw/zPLEtjp7MW
        bo3fNc6OUB7DQ0qL/KUKHib5lA==
X-Google-Smtp-Source: APXvYqy8AC4d+BvWkifWyma+BkNGRsgxkP0k610zpgUd8DVOzWg/wETNM/CHFKJ/jnSscWDGu1JqZA==
X-Received: by 2002:a63:c54d:: with SMTP id g13mr22435956pgd.376.1556035624380;
        Tue, 23 Apr 2019 09:07:04 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:909f:2a1b:c449:c291? ([2601:646:c200:1ef2:909f:2a1b:c449:c291])
        by smtp.gmail.com with ESMTPSA id o66sm4176929pfb.184.2019.04.23.09.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:07:03 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: mmotm 2019-04-19-14-53 uploaded (objtool)
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190423082448.GY11158@hirez.programming.kicks-ass.net>
Date:   Tue, 23 Apr 2019 09:07:01 -0700
Cc:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D7626BC0-FCE9-4424-A6F5-D4AAB6727ED4@amacapital.net>
References: <20190419215358.WMVFXV3bT%akpm@linux-foundation.org> <af3819b4-008f-171e-e721-a9a20f85d8d1@infradead.org> <20190423082448.GY11158@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 23, 2019, at 1:24 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Fri, Apr 19, 2019 at 09:36:46PM -0700, Randy Dunlap wrote:
>>> On 4/19/19 2:53 PM, akpm@linux-foundation.org wrote:
>>> The mm-of-the-moment snapshot 2019-04-19-14-53 has been uploaded to
>>>=20
>>>   http://www.ozlabs.org/~akpm/mmotm/
>>>=20
>>> mmotm-readme.txt says
>>>=20
>>> README for mm-of-the-moment:
>>>=20
>>> http://www.ozlabs.org/~akpm/mmotm/
>>>=20
>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>> more than once a week.
>>=20
>> on x86_64:
>>=20
>>  CC      lib/strncpy_from_user.o
>> lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x315: cal=
l to __ubsan_handle_add_overflow() with UACCESS enabled
>>  CC      lib/strnlen_user.o
>> lib/strnlen_user.o: warning: objtool: strnlen_user()+0x337: call to __ubs=
an_handle_sub_overflow() with UACCESS enabled
>=20
> Lemme guess, you're using GCC < 8 ? That had a bug where UBSAN
> considered signed overflow UB when using -fno-strict-overflow or
> -fwrapv.
>=20
> Now, we could of course allow this symbol, but I found only the below
> was required to make allyesconfig build without issue.
>=20
> Andy, Linus?
>=20
> (note: the __put_user thing is from this one:
>=20
>  drivers/gpu/drm/i915/i915_gem_execbuffer.c:    if (unlikely(__put_user(of=
fset, &urelocs[r-stack].presumed_offset))) {
>=20
> where (ptr) ends up non-trivial due to UBSAN)
>=20
> ---
>=20
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess=
.h
> index 22ba683afdc2..c82abd6e4ca3 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -427,10 +427,11 @@ do {                                    \
> ({                                \
>    __label__ __pu_label;                    \
>    int __pu_err =3D -EFAULT;                    \
> -    __typeof__(*(ptr)) __pu_val;                \
> -    __pu_val =3D x;                        \
> +    __typeof__(*(ptr)) __pu_val =3D (x);            \
> +    __typeof__(ptr) __pu_ptr =3D (ptr);            \

Hmm.  I wonder if this forces the address calculation to be done before STAC=
, which means that gcc can=E2=80=99t use mov ..., %gs:(fancy stuff).  It pro=
bably depends on how clever the optimizer is. Have you looked at the generat=
ed code?

Other than that, it seems reasonable to me.

> +    __typeof__(size) __pu_size =3D (size);            \
>    __uaccess_begin();                    \
> -    __put_user_size(__pu_val, (ptr), (size), __pu_label);    \
> +    __put_user_size(__pu_val, __pu_ptr, __pu_size, __pu_label);    \
>    __pu_err =3D 0;                        \
> __pu_label:                            \
>    __uaccess_end();                    \
> diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
> index 58eacd41526c..07045bc4872e 100644
> --- a/lib/strncpy_from_user.c
> +++ b/lib/strncpy_from_user.c
> @@ -26,7 +26,7 @@
> static inline long do_strncpy_from_user(char *dst, const char __user *src,=
 long count, unsigned long max)
> {
>    const struct word_at_a_time constants =3D WORD_AT_A_TIME_CONSTANTS;
> -    long res =3D 0;
> +    unsigned long res =3D 0;
>=20
>    /*
>     * Truncate 'max' to the user-specified limit, so that
> diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
> index 1c1a1b0e38a5..0729378ad3e9 100644
> --- a/lib/strnlen_user.c
> +++ b/lib/strnlen_user.c
> @@ -28,7 +28,7 @@
> static inline long do_strnlen_user(const char __user *src, unsigned long c=
ount, unsigned long max)
> {
>    const struct word_at_a_time constants =3D WORD_AT_A_TIME_CONSTANTS;
> -    long align, res =3D 0;
> +    unsigned long align, res =3D 0;
>    unsigned long c;
>=20
>    /*
>=20
