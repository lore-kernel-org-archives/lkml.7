Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA1FC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15F5217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556062737;
	bh=FarfMsBON2wVeKeFLYM23dvgsKR/dn3Lkyqqbk5qHCI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=g/I4IWM1QY2mXq8T2sN0meiC4xS+1XcR2jXuPkF4rGbbVonGCwlLy/rqYgISWrooW
	 Qvj5rV08HSgm+EgaZuzhuF9YwHLAGWgBTKkoJ6RECLpsQb7IPiCUoDIm76vvbEnAev
	 0/vYxty7G2BalvngvALrwQL6EPed7Lo61gNjt/N0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfDWXi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:38:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46153 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfDWXi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:38:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id h21so15049661ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RQz3lUf1EmLWgKWXIVHNqHD2UYhMFujm+b89zfJ5izo=;
        b=dmkWF3fkHY6cwgwbqyTzgMaMtF9uK5BHmJiLtCV5Rhhuh2x560Da34o2nKLtFjrt+G
         Ip6nh5PlMn98b0+sk2q1ZVgMceqD1cpXcmKud5uF9xidgu/aDcaKuArQMR9zTxZ65M0y
         UOpoTqoM7a4N83XwWoJUqgHTrIRooxXFjrFpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQz3lUf1EmLWgKWXIVHNqHD2UYhMFujm+b89zfJ5izo=;
        b=YBWPBR30XJHg/4F+SZYzwpH4Vp8BY/VOxrfLcJBGF6uODP3AbpanjV140mK3xKXw/d
         H+LgtaLXbR4SVKtImFuElaENbr+VH5z4MfkehnC2CyGKQyFW+xThKTcX8q/jf96CqQj3
         FhS7qZ8zRcmLT3CEGolVTsmqODg3XdWGjclOE7PgailJywz1l3oSyivNsxHCb3ByACc4
         Z0n1TTbVQwHJ0jrZokWMvaFPUEjM8pZWnTsrnMbpveujWTY7n4Lf4KHQQrdktRnishX8
         6r/q6IvuB4bTHBqUeGmlOBnImliG4i6rtn7tr9djkMvkwjJuFeysrb83nhmAscXt+f4h
         PvVg==
X-Gm-Message-State: APjAAAX/NqM6TZJFINhVbj+ERP1FX1tpPz7D5EZ8C1YifN8OQkw5sY03
        jQl6/KkxH530fTEhF2DdbOUMSW9g4cA=
X-Google-Smtp-Source: APXvYqyTEIc/B8ZPi91EqnVyeb/6iFi3p5N/wPYav1fvo81oYyHQC5X20JU3kCG00V7j1rezlAkgBQ==
X-Received: by 2002:a2e:894e:: with SMTP id b14mr13365732ljk.158.1556062733119;
        Tue, 23 Apr 2019 16:38:53 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id q18sm2862659lfm.81.2019.04.23.16.38.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 16:38:51 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id v1so621892lfg.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:38:51 -0700 (PDT)
X-Received: by 2002:ac2:43cf:: with SMTP id u15mr15231930lfl.67.1556062731342;
 Tue, 23 Apr 2019 16:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAQwHRJL=3yD_7P2mMSVnwZbayww+dHC22+v4oTpMZv58w@mail.gmail.com>
 <CALCETrVSM0vrMVr2y0ECAQ=tNGvBs=im2Kxongq-jvdzUBevbg@mail.gmail.com>
In-Reply-To: <CALCETrVSM0vrMVr2y0ECAQ=tNGvBs=im2Kxongq-jvdzUBevbg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Apr 2019 16:38:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiV2gLQkp6JFQYewL1uzgWnwEK9fKWP3AfZbcu2Lv_GrQ@mail.gmail.com>
Message-ID: <CAHk-=wiV2gLQkp6JFQYewL1uzgWnwEK9fKWP3AfZbcu2Lv_GrQ@mail.gmail.com>
Subject: Re: Does vdso_install attempt to re-compile objects under root privilege?
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 11:47 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> Hmm.  I suppose an alternative would be for vdso_install to fail if
> the vdso isn't built?

I absolutely abhor even the concept of building the kernel as root,
and I think it should be actively disallowed. Our build system is
good, but it's good as in "clever and complex" rather than necessarily
good as in "very secure".

So anybody who builds the kernel as root is doing something seriously
wrong, in my opinion.

That's partly exactly _because_ we have a lot of magical and very
powerful build rules, and complicated implicit things going on.

For example, our dependencies aren't even about just the files in the
kernel repository itself, we have clever things like "if the compiler
has been updated and features or version changes, we'll automatically
rebuild, because it's part of our clever build system checks".

But that is also part of the reason why I absolutely do *not* want any
root-building to happen, because our build setup is simply way too
clever.

If root builds stuff, you'll end up with root-owned generated
subdirectories or various config files etc, and even if you don't have
security issues, it can complicate the build later as a regular user.

I've had the build occasionally fail in odd ways, because some
root-owned file was now no longer removable (usually it's the
auto-generated header files in the directory, and the root-generated
and owned directory is now not writable by the developer any more).
And every time it happens, I shudder.

So all of that simply boils down to "root should not be running those
complex rules for our config and dependency magic".

At the same time, "make install" obviously needs to be done as root.

All of which is why I opine that "make install" should never build
anything at all, it should purely be used as a "install previously
built files".

So yes, I'd much prefer just failing over trying to build as root (or
even trying to figure out dependencies as root).

> What's the ideal outcome here?

I'd basically like the rule for "make install" to be that it never
ever generates a single file in the build tree, so that there are
never any root-owned (or root-overwritten) files there.

So "make install" should even avoid all dependency checking, for the
simple reason that if you happen to do a system update between "make"
and "make install", our smart dependencies should never say "oh, the
compiler version has changed, so now I'll rebuild everything as root
just because 'make install'".

So I think the ideal outcome is just "fail if you can't find the files
to install".

                     Linus
