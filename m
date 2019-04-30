Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74986C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457E52147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Mxlq6/XD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfD3QpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:45:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38875 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfD3QpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:45:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so4576240wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 09:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DI88UJavFREMtcapTn4kSI8YIiW9Nb5tvYB0Uy7xQRg=;
        b=Mxlq6/XDXOeUcKyZMvPhIlUMod5TF11G7iv0AOvc3jLmsKcr4wA4vWnpVU39rGSrLa
         YlFplpkh6KO+fC0hr8dJc+kX5DMO/QL9skYTZKfLLJBlNKCyGoeeFzQ3Ey2/zQbO6cSa
         ledSWkjuHxqVn4eteGH2w+/nm2Hm6qt7ALkXjls2czh8031Louy4vdgOs7+CCMRaXgfw
         dXpJFQGkNV9e1yu4WVOTJ2cMgB/dw/3yokGBRvimVWgkgdTG8S/EfUyNeUPTlKYDnxc3
         koggoEFmGq6OdIe7prlxmftgvw3xsH+vMAvvhjlD2WLw7JTOBYI5xZPwyWfZBVkxQBEl
         ikqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DI88UJavFREMtcapTn4kSI8YIiW9Nb5tvYB0Uy7xQRg=;
        b=NcQehPyK3HTI7biRW+udlhP/lfnRD62NWkshz4HrZuOhAR0wJri5JNNnT4DgJf0X+C
         TGGboxlcV3hrPWOAxb5mJRp+kcdfVf1ceMqTvnFR1XGCYcecYapyjW3ptbsMfTWYwM+Z
         ioIRu67NvWt3dTvhnR9RfBOk0qlg6z+bEjIo243vExENPUQIUV/9bGRUwQn+7ZIB5Cym
         L+P6HLk9iAfVYua9+viLUsUIeR5sHvip7tRc8c/x0BhUxiVygkoyuWENWCtndhoJBpfm
         8d1ZNaFGP/iT3MBBy+qsX1PNwSbeElYY6ZVh8dsN06tidCI3CHtMq+6LuNhAIKuAr9b/
         3EUw==
X-Gm-Message-State: APjAAAV+Wg2jEAQ0Wlsk3Vr9Qf3X0ky2YyydSUKqjfR9YmXOEsBgapoc
        z4+cGJgilTXhFioIgdX0KZ9H17F+ilLmu3hzgJXFvQ==
X-Google-Smtp-Source: APXvYqx64tlCkwaX608ZCAb0nn4es1HdpFN9NUKiPe8uGp1bnQgUkHnaQabDG7Zi+nVrCdlDxkC9Chub2kj9v+/eWeM=
X-Received: by 2002:a7b:c844:: with SMTP id c4mr3717331wml.108.1556642712705;
 Tue, 30 Apr 2019 09:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1403291930.git.luto@amacapital.net> <a424b189ce3ced85fe1e82d032a20e765e0fe0d3.1403291930.git.luto@amacapital.net>
 <CAK7LNATXWYLovDGGn6cJgM61W1qF3d4RJfaiOJpH49WqTFPskQ@mail.gmail.com>
In-Reply-To: <CAK7LNATXWYLovDGGn6cJgM61W1qF3d4RJfaiOJpH49WqTFPskQ@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 30 Apr 2019 09:45:01 -0700
Message-ID: <CALCETrVP2Xfm1Ffw3o_BaEpHgW+RanKu6sM3LEP_8RAvYrBOOA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] x86,vdso: Create .build-id links for unstripped
 vdso files
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 4:42 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Andy,
>
> On Sat, Jun 21, 2014 at 4:23 AM Andy Lutomirski <luto@amacapital.net> wrote:
> >
> > With this change, doing 'make vdso_install' and telling gdb:
> >
> > set debug-file-directory /lib/modules/KVER/vdso
> >
> > will enable vdso debugging with symbols.  This is useful for
> > testing, but kernel RPM builds will probably want to manually delete
> > these symlinks or otherwise do something sensible when they strip
> > the vdso/*.so files.
> >
> > If ld does not support --build-id, then the symlinks will not be
> > created.
> >
> > Note that kernel packagers that use vdso_install may need to adjust
> > their packaging scripts to accomdate this change.  For example,
> > Fedora's scripts create build-id symlinks themselves in a different
> > location, so the spec should probably be updated to remove the
> > symlinks created by make vdso_install.
> >
> > Signed-off-by: Andy Lutomirski <luto@amacapital.net>
> > ---
>
> I was looking into this, but
> I am not familiar enough with this area.
>
>
> Could you tell me how it works?
>
>
> I use Ubuntu 18.04 LTS.
> Luckily, it has build-id symlinks by default,
> so I should be able to test it easily.
>
>
>
> masahiro@pug:~$ uname -r
> 4.15.0-47-generic
> masahiro@pug:~$ cd /lib/modules/4.15.0-47-generic/vdso/
> masahiro@pug:/lib/modules/4.15.0-47-generic/vdso$ file vdso64.so
> vdso64.so: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV),
> dynamically linked,
> BuildID[sha1]=d742540fb9ded5c3650dbe9ae20c0f39e386464c, with
> debug_info, not stripped
> masahiro@pug:/lib/modules/4.15.0-47-generic/vdso$ ls -l
> .build-id/d7/42540fb9ded5c3650dbe9ae20c0f39e386464c.debug
> lrwxrwxrwx 1 root root 15 Mar 13 13:37
> .build-id/d7/42540fb9ded5c3650dbe9ae20c0f39e386464c.debug ->
> ../../vdso64.so
>
>
> I dumped the vdso embedded in the kernel,
> and I confirmed its build-id matches
> to the one of unstripped vdso.
>
>
> So, I expect the vdso with symbol info will be automatically loaded
> by setting debug-file-directory to /lib/modules/4.15.0-47-generic/vdso.
> Am I right?
>
> If it works as expected, how should it look like?
>
> I started gdb like this:
>
> $ gdb date
>
> Then, I did:
>
> (gdb) set debug-file-directory
> /usr/lib/debug:/lib/modules/4.15.0-47-generic/vdso
> (gdb) show debug-file-directory
> The directory where separate debug symbols are searched for is
> "/usr/lib/debug:/lib/modules/4.15.0-47-generic/vdso".
> (gdb) run
>
>
> The list of shared library looks like follows:
>
>
> (gdb) info sharedlibrary
> From                To                  Syms Read   Shared Object Library
> 0x00007ffff7dd5f10  0x00007ffff7df4b20  Yes         /lib64/ld-linux-x86-64.so.2
> 0x00007ffff7a052d0  0x00007ffff7b7dc3c  Yes
> /lib/x86_64-linux-gnu/libc.so.6
>                                         No          linux-vdso.so.1
>
>
>
> The first two shared objects shows "Yes" because debug info
> is available under /usr/lib/debug/lib/x86_64-linux-gnu/
> and associated by .gnu_debuglink.
>
>
> linux-vdso.so.1 shows "No".
> Does it mean no symbol was included ?
>

It's been a long time since I've looked at this, and I don't remember
all the details.  I think your best bet may be to run gdb under strace
and to try to figure out what it's doing.
