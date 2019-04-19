Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EDAC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BC3204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNsDU3SU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfDSSjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:39:04 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36750 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfDSSjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:39:01 -0400
Received: by mail-it1-f193.google.com with SMTP id y10so9506697itc.1;
        Fri, 19 Apr 2019 11:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1u4P30QW5skkaJsHDqOc8QtC53uRsJT/X9i8uTHPt3k=;
        b=oNsDU3SUvtMPq3wWJilxawt0TRthfdVa0auU66IxjEAAt/drJJeJ6i7t3XtSwQVWai
         852/2EwxxJaXrJmoN0JsG1Js2DfNZzmkVx6PEo/+HQOYp2tfaTo1XdtllidHV5O8jhMl
         pZZ/IKfBrmY+D7QOYBcbHJrI14Dizjt0iUNpNcm5ZtHYPtgWs7nIwdvbjCBoJdBqtEHq
         V6BppiqpvQsstYeIm1DL9XIsnFYsWF0rPVTXndRiE0/qtbjpH+P74XRrpMXzJ/jyIpOI
         vjpjvre1erpAUZ9+yeXVpByPwAVg4q4K8jD55jXo2ZjjifSms9j8UmX2WC+Lm5e6Wwhk
         c+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1u4P30QW5skkaJsHDqOc8QtC53uRsJT/X9i8uTHPt3k=;
        b=XlsSswYxzV0iAIGRGgSFlyVUcyDhHUh/CuFD1hUZx64n6TDhSXtJByL9oWiNi/rYaw
         KSBofciV1++YPGJdkFvqO2GudNZv49zpDPCq0ZjrPX/t8F6eXwVe3Va2DYpHiBckKtDi
         iC60o/f+WGxK5YddBx9mVN9i2+2+5EdSpHxRVMHLejO+Ud1zmnhsuKAWvdZjBNHO9YNz
         kcho2zlgdqiVHchVe9Dp5QNzBwPCZ0jXn4hA/bL+TpEDuh3rJCvwQl6nZG/YQlXVHTt5
         y/ox22xWeKe7tqJXgzRYihOeWoPFd1tKv+3FWjElfmgudNOnFV75rRSoDZE129K3U/ac
         IN1A==
X-Gm-Message-State: APjAAAXCtPb0FraVuTwL2GAQ93qiRJBHbQ3TyailoxtS1Ey97XD7noPf
        A6Idp+D+UMALKdsI//ugzwQykMKSTqSxUQbhDLAJVnlUP7hU
X-Google-Smtp-Source: APXvYqzd/vOB2+p3xIauiqtMqq7JFZgz/Cp1XYULhBHhx/NPA18PAVgawPDXMDHQmNzSnEOPlPsL9TZ7P9GgAwAZw8o=
X-Received: by 2002:a02:cd02:: with SMTP id g2mr2939574jaq.70.1555685146976;
 Fri, 19 Apr 2019 07:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <1555660717-18731-1-git-send-email-kernelfans@gmail.com> <alpine.DEB.2.21.1904191009040.3174@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904191009040.3174@nanos.tec.linutronix.de>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 19 Apr 2019 22:45:35 +0800
Message-ID: <CAFgQCTtaP24gXUs_dh4h8qCsA-TKHc5A-vs5oiezfwuR_qjQvA@mail.gmail.com>
Subject: Re: [PATCH] kernel/crash: make parse_crashkernel()'s return value
 more indicant
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julien Thierry <julien.thierry@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Hackmann <ghackmann@android.com>,
        Stefan Agner <stefan@agner.ch>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 4:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, 19 Apr 2019, Pingfan Liu wrote:
>
> > At present, both return and crash_size should be checked to guarantee the
> > success of parse_crashkernel().
> > Simplify the way by returning negative if fail, positive if success. In
> > case of failure, -EINVAL for bad syntax, -1 for the parsing results in
> > crash_size=0.
>
> I'm not entirely sure what you are trying to say here, but '-1' is not an
> improvement at all. We surely are not short of proper error codes, right?
>
The different negative return values are only used by x86. The option
"crashkernel=X,high", which is only used on x86, causes parse_kernel()
to return -EINVAL, then let parse_crashkernel_high() have a try.

When parsing crashkernel=size@offset and crashkernel=range1:size1,
there are other cases of failure, which is not worth to call
parse_crashkernel_high() to have a try. That is "-1" aiming for.

First, in parse_crashkernel_mem(), if demanded size is bigger than
system ram, this one looks like -ENOMEM, but -ENOMEM normally is used
for allocation. Second, in parse_crashkernel_mem(), if system ram is
not inside the range listed by "crashkernel=". Third, crashkernel=0MB
is given in the option (not in practice, but can not forbid user to do
so).

All of these cases can be treated as -EINVAL, but hard to define the
error codes.
> Also I don't see any positive return value > 0. So what is this about:
>
Yes. 0 is enough for success.  I had thought about returning 1 if
@offset is specified in crashkernel. But at present, no use case for
it.

> > --- a/arch/ia64/kernel/setup.c
> > +++ b/arch/ia64/kernel/setup.c
> > @@ -277,7 +277,7 @@ static void __init setup_crashkernel(unsigned long total, int *n)
> >
> >       ret = parse_crashkernel(boot_command_line, total,
> >                       &size, &base);
> > -     if (ret == 0 && size > 0) {
> > +     if (ret >= 0) {
>
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^  ????
>
> >       if (!memory_region_available(crash_base, crash_size)) {
> > diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> > index 45a8d0b..0b626e2 100644
> > --- a/arch/powerpc/kernel/fadump.c
> > +++ b/arch/powerpc/kernel/fadump.c
> > @@ -376,7 +376,7 @@ static inline unsigned long fadump_calculate_reserve_size(void)
> >        */
> >       ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> >                               &size, &base);
> > -     if (ret == 0 && size > 0) {
> > +     if (ret >= 0) {
>
> and this ?
>
> >               unsigned long max_size;
> >
> >               if (fw_dump.reserve_bootvar)
> > diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
> > index 63f5a93..9f3e61a 100644
> > --- a/arch/powerpc/kernel/machine_kexec.c
> > +++ b/arch/powerpc/kernel/machine_kexec.c
> > @@ -122,7 +122,7 @@ void __init reserve_crashkernel(void)
> >       /* use common parsing */
> >       ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> >                       &crash_size, &crash_base);
> > -     if (ret == 0 && crash_size > 0) {
> > +     if (ret >= 0) {
>
> Again.
>
> >               crashk_res.start = crash_base;
> >               crashk_res.end = crash_base + crash_size - 1;
> >       }
> > --- a/arch/sh/kernel/machine_kexec.c
> > +++ b/arch/sh/kernel/machine_kexec.c
> > @@ -157,7 +157,7 @@ void __init reserve_crashkernel(void)
> >
> >       ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> >                       &crash_size, &crash_base);
> > -     if (ret == 0 && crash_size > 0) {
> > +     if (ret >= 0) {
>
> And some more.
>
> >               crashk_res.start = crash_base;
> >               crashk_res.end = crash_base + crash_size - 1;
> >       }
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index 3d872a5..62d07d4 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -526,11 +526,11 @@ static void __init reserve_crashkernel(void)
> >
> >       /* crashkernel=XM */
> >       ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
> > -     if (ret != 0 || crash_size <= 0) {
> > +     if (ret == -EINVAL) {
>
> Without an explanation why this proceedes on error codes other than EINVAL
> this is uncomprehensible. Comments exist for a reason.
>
As explained above, deciding whether to let parse_crashkernel_high() try.

> >               /* crashkernel=X,high */
> >               ret = parse_crashkernel_high(boot_command_line, total_mem,
> >                                            &crash_size, &crash_base);
> > -             if (ret != 0 || crash_size <= 0)
> > +             if (ret < 0)
> >                       return;
> >               high = true;
>
> > @@ -87,7 +87,7 @@ static int __init parse_crashkernel_mem(char *cmdline,
> >               cur = tmp;
> >               if (size >= system_ram) {
> >                       pr_warn("crashkernel: invalid size\n");
> > -                     return -EINVAL;
> > +                     return -1;
>
> Well, this is incomprehensible as well. The pr_warn() says invalid and then
> you change the error code to something magic.
>
As explained above, want to know whether worth to let
parse_crashkernel_high() try.

What about the following alternative method? Treating crash_size=0 as
-EINVAL. Then on x86, just call parse_crashkernel_high() blindly to
have a try. Thanks for your review.

Regards,
Pingfan
