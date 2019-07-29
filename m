Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3120C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF651206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387586AbfG2LNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:13:23 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44591 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387450AbfG2LNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:13:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id k18so58152561ljc.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 04:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tOeU+CYtImamXwnMBo5r6FB06SkfmeDDgtJvh72e5f8=;
        b=DTo+QQMfRiez7Two+o3auKjZNTA0c5AZSuawM5vGgftI6FGOiPVgcpQqnzJC0f4yBD
         MOjTLleeEU4euMZPawQUyEX5YABdKgnFahVKWCL6K0foqRerR1NKjYa1eLNairT5JFsZ
         GUxsFxVX6rTmfUpr59XkS9lNaOn7G/lRvlfx3XVCfs545DNudSEue3+6AnUgEUFpBs5g
         NLtRrc0arywTxhVkWJLyjUi/j/YAEHltfe23oLBdDYv5rcoj/EDMCx7gMyp1ZgxDKHry
         xRbRgLsArKpmgoAlBIxFMHGep3npWtQcOqrkdgmo4jAG12LD8W/bWiN3ClsFBv24OiRQ
         RLNg==
X-Gm-Message-State: APjAAAU7Ubi4tDbTsIpO3P4mUr1ldRzDsPXSO0zT38Wxr7xWelo0VCX2
        4fI2Cab90Sdte65la7k0bUq0syQi8h3j/r6K6IwMtYQ2QKNmug==
X-Google-Smtp-Source: APXvYqzG7FwJx4QRNGscSaihpY7Vr0ay+3S0b2wkdslvjOo2SttVSKYiJDePex+9EPvXQRl/Az7gXZ/T0xfWNYeJJyI=
X-Received: by 2002:a2e:9643:: with SMTP id z3mr58586491ljh.43.1564398800931;
 Mon, 29 Jul 2019 04:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnkfhySwXY7YwuQezyx6cEpemZW4Hox1_4fQJm3-5hvM3G6gw@mail.gmail.com>
 <20190729095047.k45isr7etq3xkyvr@willie-the-truck> <1cfad84e-5a98-99bd-07c2-9db0cf37292b@arm.com>
 <CAGnkfhxXHPfMZVMy4Wjmy39E3Oh2U8FjVU8p8PprCnj5QFLMEg@mail.gmail.com> <cc6f9c8f-a4a1-7c71-1f89-72e1e8dd0cc8@arm.com>
In-Reply-To: <cc6f9c8f-a4a1-7c71-1f89-72e1e8dd0cc8@arm.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Mon, 29 Jul 2019 13:12:45 +0200
Message-ID: <CAGnkfhx6St+MYQuR_Duguk4Q9ieuL7sLCTL=G76-eqUcCAbpoA@mail.gmail.com>
Subject: Re: build error
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 1:08 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Matteo,
>
> On 29/07/2019 11:25, Matteo Croce wrote:
> > On Mon, Jul 29, 2019 at 12:16 PM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> >>
> >> Hi Matteo and Will,
> >>
> >>
> >> If I try to build a fresh kernel on my machine with the standard "make mrproper
> >> && make defconfig && make" I do not see the reported issue (Please see below
> >> scissors).
> >>
> >> At this point would be interesting to know more about how Matteo is building the
> >> kernel, and try to reproduce the issue here.
> >>
> >> @Matteo, could you please provide the full .config and the steps you used to
> >> generate it? Is it an 'oldconfig'?
> >>
> >
> > Hi,
> >
> > yes, this is an oldconfig from a vanilla 5.2, I attach it
> > (the non gzipped config was dropped by the ML filter)
> >
> >
>
> I tried your config file and seems working correctly:
>
> # cp ~/config ../linux-out/.config
> # make oldconfig
> # make
>
> arch/arm64/Makefile:56: CROSS_COMPILE_COMPAT not defined or empty, the compat
> vDSO will not be built
>
> ---
>
> Could you please send to me the config file that does not contain:
> CONFIG_CROSS_COMPILE_COMPAT_VDSO=""
>
> The original one I mean, on which you did not run make oldconfig.
> My suspect at this point is that the string passed to
> CONFIG_CROSS_COMPILE_COMPAT_VDSO is not completely empty.
>
> In fact if I do CONFIG_CROSS_COMPILE_COMPAT_VDSO=" " (single space),
> I do have a failure similar to the one you reported.
>

That's what I initially thought, but the string is effectively empty:

# make
arch/arm64/Makefile:58: *** gcc not found, check CROSS_COMPILE_COMPAT.  Stop.
# grep CROSS_COMPILE_COMPAT_VDSO .config |hexdump -C
00000000  43 4f 4e 46 49 47 5f 43  52 4f 53 53 5f 43 4f 4d  |CONFIG_CROSS_COM|
00000010  50 49 4c 45 5f 43 4f 4d  50 41 54 5f 56 44 53 4f  |PILE_COMPAT_VDSO|
00000020  3d 22 22 0a                                       |="".|
00000024


-- 
Matteo Croce
per aspera ad upstream
