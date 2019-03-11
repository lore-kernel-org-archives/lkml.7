Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B9FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E23A206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sAg0dYDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfCKOgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:36:35 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35835 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfCKOgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:36:33 -0400
Received: by mail-it1-f194.google.com with SMTP id 188so7613153itb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AYMaaKGT50+tvBELW19NFxhvJmK21mF7es5UP0w70Xw=;
        b=sAg0dYDq+IMvw3cyL266o9K8lSG6OlJMk9auPbXP2zvOHZU6MuSYNJhAekl6JxBQSE
         ksOo7CsTsCC2q5KEXfpPztGyYPZL0pbDDR7/9NAbRLmOYlL9Ex3KTJpSv2PcdPkxwlZA
         ytvAZF3ZiGItv3I4RMdPnmJHAvZrt/6Oh6cBugpD/83P/IqcPicBv6hL4CbyZZ6tLHib
         uJmihsi8A+TQ1j5zk7igDPYgCcABSZjkhG6qdqIVBA7CoNz+ix6+Cq6X//4c6eDve9iB
         adYZHuIm1ZlTECGrQe7JxUPgFmbySaMoDjT6/OvMTYlZhnPVAme8NAYaV8pTyh7FUI9O
         57Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AYMaaKGT50+tvBELW19NFxhvJmK21mF7es5UP0w70Xw=;
        b=dLv634jI6mzSW4w1+D5VCSnsPv4w82euKnIBs6X+3uVSYjmhH7ciG9f+W4yR36HJTK
         QVzCcIH8y3fDNf1TRyO81ArRoghgAcPWP+riK2rL8R5se0L5f65vj03L4pDfTHFP+ZqR
         XErWkfy8RZQQoLOqNGt0hnIY+b/PFYC+HhU3vOBxeNz0jrKZfZLczzSKfM34HBWhTv1K
         3+MEWCydsjM3ON4ql9J0ccbQaKXbSBPa5LdfRQY5ZreraNyCOvjnwFCT2zJ4FNPxEgzA
         oPUlIzITiiRXLpnvQUL3F7odonaFZuroshqDNyZowIysqy4WYsg+fZffk4EGcLjoPvO8
         86bA==
X-Gm-Message-State: APjAAAX4ydpljWJnQTfbTThz1hR2LF+Yh4eUtFXthyzkPENxX0hzy1+7
        4bY6jCV6ExzAd7dZ1CokSCCtyVgLQyvUgljKmo932Q==
X-Google-Smtp-Source: APXvYqzxpq5fJtibzLV4i4ZLeQXKQYC381rzhl549bDfQfSN4mRcT8Uzzj8eTTCXU1xDhvUrus1Vx/8IxJ1GTaPPeNo=
X-Received: by 2002:a24:2e90:: with SMTP id i138mr5415ita.158.1552314992434;
 Mon, 11 Mar 2019 07:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190307091514.2489338-1-arnd@arndb.de> <20190307091514.2489338-2-arnd@arndb.de>
 <CAKwvOdk=9j2HvtWOpdOEw9sm0Nh2oU3c1c6+hJJ5WMweAM=4EQ@mail.gmail.com>
 <20190307234850.nsbpkfcit3lnmytu@shell.armlinux.org.uk> <CAKv+Gu9VM2Vs3Q8+bPLsnt08dOmba6j54gnhiHkk=AHRzG8tVA@mail.gmail.com>
 <20190308095308.hjjrzdp4fzbbtnnv@shell.armlinux.org.uk> <CAKv+Gu_szWgw-KJASLYGJ6hJXh5K8WxnUn+UQkm7jUup=rqG6w@mail.gmail.com>
 <20190308103429.ycasmpt6tcpsoqps@shell.armlinux.org.uk> <CAKv+Gu_9=G3U6Yaw8fLfTP3QT38WdwrFaC-BqLTCr2NihWA2ZA@mail.gmail.com>
 <20190308105835.tovswk5rwxusmxdu@shell.armlinux.org.uk> <CAKv+Gu-Od+hBosThTWFooz9FMKnu3g0oNh_2hmidetbB-_YyjQ@mail.gmail.com>
 <CAK8P3a1ECw_g1AqsVavD8hhVEGqNk6Kcx_U0L=0d29eu561NhA@mail.gmail.com>
In-Reply-To: <CAK8P3a1ECw_g1AqsVavD8hhVEGqNk6Kcx_U0L=0d29eu561NhA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 11 Mar 2019 15:36:21 +0100
Message-ID: <CAKv+Gu8qgsnPV=uWR2jkJ5bsYihekkEvWNuw4whLdLrbBa7gnA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: futex: make futex_detect_cmpxchg more reliable
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019 at 15:34, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Mar 8, 2019 at 12:56 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> > On Fri, 8 Mar 2019 at 11:58, Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:
> > > On Fri, Mar 08, 2019 at 11:45:21AM +0100, Ard Biesheuvel wrote:
>
> >
> > Perhaps. So let me summarize what I do understand.
> >
> > 1) if futex_atomic_cmpxchg_inatomic() is instantiated *and executed*
> > with the same compile time constant value of 0x0 for newval and uaddr,
> > we end up with an opcode for the STRT instruction that is CONSTRAINED
> > UNPREDICTABLE, but we will never execute it since the preceding load
> > will fault and enter the fixup handler.
> > 2) such occurrences of futex_atomic_cmpxchg_inatomic() are unlikely to
> > occur in the code, but may be instantiated by the compiler when doing
> > constant propagation (like in the ilog2() case I quoted), but these
> > instantiations will never be called
> > 3) both clang and gcc may map different inline asm input operands onto
> > the same register if the value is guaranteed to be the same (i.e.,
> > they are both compile time constants)
> >
> > My statement about uaddr was slightly misguided, in the sense that our
> > invocation of STRT does use the post-index variant, but with an
> > increment of zero, so the value written back to the register equals
> > the original value. But it does explain why this opcode is CONSTRAINED
> > UNPREDICTABLE in the first place.
> >
> > Given 2) above, I wonder if anyone could confirm whether adding
> > 'BUG_ON(__builtin_constant_p(uaddr))' silences the warning as well.
>
> Like this?
>
> diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
> index 0a46676b4245..e6e9b403cd61 100644
> --- a/arch/arm/include/asm/futex.h
> +++ b/arch/arm/include/asm/futex.h
> @@ -57,6 +57,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>         /* Prefetching cannot fault */
>         prefetchw(uaddr);
>         __ua_flags = uaccess_save_and_enable();
> +       BUG_ON(__builtin_constant_p(uaddr) || !uaddr);
>         __asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
>         "1:     ldrex   %1, [%4]\n"
>         "       teq     %1, %2\n"
>
> This had no effect here.
>
> My first attempt (before finding the original patch from Mikael Pettersson)
> was to change the probe to pass '1' as the value instead of '0', that
> worked fine.
>

Which probe is that?
