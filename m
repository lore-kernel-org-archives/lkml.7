Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADC1C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F6021835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XIr5Vi59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbfLERGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:06:02 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:41118 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730086AbfLERGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:06:01 -0500
Received: by mail-pj1-f66.google.com with SMTP id ca19so1530664pjb.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 09:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7wk4CqairQhNFXqEdRCw6JNGivGRG705siCYwDLW6U=;
        b=XIr5Vi59PCL7mDF7S31zINQtxrdEVNjQdXdAonLx36evfssZeaDVGKHHE4utT4P6kQ
         YJjD/mr8ywm4LRsdRGSXAe64c45GEfDZHqGY+RmI9x14jcbS0RIRvXAoxmQ73Avet921
         HxTHP/+ML2jdUhilAA7012/4V0SVYZAWcDMKRoSk1Bv+E6bMaVwk86WrcK++vtQVkpIZ
         K4P0kvboIcy/rrvAXxDeswdv7Ia+jsvQS/A07Rh7Lp9ua6hD9DZvA5Q9VWAbxBKDQF36
         gPYRaqbRxvlPJUsRp2JIL7Oa4zQPYY+qxIOeGIsqoH6DX0UJsqx1i3Wrfk0hST7R6KL+
         bePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7wk4CqairQhNFXqEdRCw6JNGivGRG705siCYwDLW6U=;
        b=Ot7lxROYZFg50/3vBJhckx5hClJ4uN/w5x7ZLoMMHsO/MJG6Sba0wNgEbnnJVTPk8O
         rhXTry2PML5jJjJvofeIQMKf0Uk03VZYhLeveOBKP2DgLbuqf8w86OCND/sgibrYpz16
         0JTBgZH0sxQW8pMeBiOa6rqUqGAbM8Dp61oLk14wY+p8zJJctjLKDv8+bLBk+alz4G8h
         xqDWzGJEKfFqcydfYla/q/v8fqFWFE9pc1XG4J4alAM0afd06jDTs4SaLFVlRlltvTJI
         +JxUCv8isz8i9oWw3PPLn6Q1J4DYaoGZDzMuHn8sNUshEEaDMhnXCbj4L9cpiNGn6moK
         LyeQ==
X-Gm-Message-State: APjAAAV1t7cxwVCQRi20IWvyuvp0zt9yeLZ8AbkGwal/3kEhrO7af0zq
        UN34W/DZYlDc63wPTt0EbhgE6XhfyIB70ABl59/ZgA==
X-Google-Smtp-Source: APXvYqxGNxIl+PYRT3HUFCyXLvzKfNGDvAYZZJcx5G23gtgSUHSg5Japdozn3v5P05BxhyKmcItDvlVvHMEsiuoalys=
X-Received: by 2002:a17:902:8ec8:: with SMTP id x8mr9539020plo.119.1575565560673;
 Thu, 05 Dec 2019 09:06:00 -0800 (PST)
MIME-Version: 1.0
References: <20191204225446.202981-1-dima@golovin.in> <CAKwvOdm-bhuJMRRN3tyNdb88+_TFd4m3b-7gX0-91VG4djzp+Q@mail.gmail.com>
 <23883331575506134@vla1-3991b5027d7d.qloud-c.yandex.net> <CAK7LNASQ_QGgm1Ec7R4yy6_qPj440V6Dg=DuuduEvqaqvBHBXg@mail.gmail.com>
In-Reply-To: <CAK7LNASQ_QGgm1Ec7R4yy6_qPj440V6Dg=DuuduEvqaqvBHBXg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 5 Dec 2019 09:05:49 -0800
Message-ID: <CAKwvOdkAvz41OMZ_JDTVdSGby8PGis0edzbztta8-8d_Z0QVhA@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: kbuild: allow readelf executable to be specified
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Dmitry Golovin <dima@golovin.in>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        Ross Burton <ross.burton@intel.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 8:25 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>
>
> On Thu, Dec 5, 2019 at 9:41 AM Dmitry Golovin <dima@golovin.in> wrote:
>>
>> 05.12.2019, 01:18, "'Nick Desaulniers' via Clang Built Linux" <clang-built-linux@googlegroups.com>:
>> >
>> > Grepping the kernel sources for `READELF`, it looks like
>> > arch/ia64/Makefile makes the same mistake. Would you mind fixing both
>> > cases in the same patch (v2)? I'm also curious about it's use in
>> > arch/ia64/scripts/unwcheck.py, and scripts/faddr2line. +ia64
>> > maintainers and list.
>> >
>> > I think if you simply remove the assignment on line 17 of
>> > arch/ia64/Makefile you should be fine.
>>
>> Perhaps something should be done to NM on line 16 of this file as well. Also
>> found similar invocation of `objcopy` in arch/riscv/kernel/vdso/Makefile.
>> I think IA64 and RISC-V changes should be made as separate commits.
>>
>> -- Dmitry
>
>
>
> I am fine with either way.
> I can take this patch, and also a one for IA64.

Whichever, as long as we don't have to wait for the base patch to land
via kbuild tree, then submit arch specific ones to their respective
trees months later.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
>
>
> You can send a patch for arch/riscv/kernel/vdso/Makefile
> to the riscv maintainer since it has no patch dependency.
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Thanks,
~Nick Desaulniers
