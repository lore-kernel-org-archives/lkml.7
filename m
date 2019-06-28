Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1BBC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86712208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="jdecO9TB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfF1DoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 23:44:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46708 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfF1DoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:44:23 -0400
Received: by mail-io1-f67.google.com with SMTP id i10so9468949iol.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 20:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H94wx8BA9J9GrxF8s1ReCKmwP5vlxA1zO/6P1Z9SjDk=;
        b=jdecO9TBf25X5vOPSzeZ6Q4Ub0nwztKuiukrJk0YmMpJGrQ+ZiSaFzZuw0B5MNNJKz
         kcDBVaWNphJ1LgXyee3sUAIP2DCieVutHU8EhQnsUDHISPESChbnx3yePpe5tyvhS0k6
         1ffm+c1WspOZlgOIE9I+ki+KVft/O87Wizxw/Hz5MhjtK1URq0zDwUK8uWHBGzkk0o33
         ca/ZDi2qfNvAwBJ7up4l/em+s1655WtwzAdCVowMPrkkah/D4dB5L5TNFuxU7X7UwbzS
         TyOapXZLKsEKvXeiesdHoc+yq87LUrG4ax6oxGM1kaBXTYqYKeFltfNmDSHmJJWtotWp
         ziIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H94wx8BA9J9GrxF8s1ReCKmwP5vlxA1zO/6P1Z9SjDk=;
        b=Oxw/cUrsXrAKchgSTguRSOAE9qWpIciRZkprZtrLrHGi11uCq4HDEOr3XVKDI4XKlK
         AVMxECflRJXMeox4Jb6nomvdx6WWGGuZCXN688It+zx60lEM+oy7Wai5LVaUTngkl/fZ
         X5vBIe7fR5DnI2b1nUKfIsts/RoYxfs39uukt0HeKc1uW3FuI1h7MQg0mbqjf+E+UjJB
         z5Uh7wvRzcB9tm+a/ecpPEaIkfGZ8C3kh3gDixqjThxGEKZ+dbMguRwKi9cGP1us7v9I
         GHmZhLFDdsUwkm7d9d5G6oVCOUfcvJD2kwKoA1S8YZyrSKiTNPEphwYpvUxXgLiShFg8
         SZTg==
X-Gm-Message-State: APjAAAXr0XEH5cQLnZ5AqAwBRQ25IjIQWfcwoxW4Zs3UINXtaD4m2dRs
        zIB0yItOE8LrtU8FTxYLNnly5hR5kHK9CklVwX6gQw==
X-Google-Smtp-Source: APXvYqyw4c0/vIh1E6dBJwb49Zf7BaKQa7FwdAtik0IPSMljBy6iQV1QjStKVAh/l+dSKdDkRtw6KqRyH4Gy8jCzw4k=
X-Received: by 2002:a6b:ee15:: with SMTP id i21mr7951115ioh.281.1561693462611;
 Thu, 27 Jun 2019 20:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190619120337.78624-1-olof@lixom.net> <20190628000033.ipcypg4kny2whfz7@treble>
In-Reply-To: <20190628000033.ipcypg4kny2whfz7@treble>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 28 Jun 2019 11:44:10 +0800
Message-ID: <CAOesGMjqhEi8rEnYy8JxvRV8HE_eRxfiXtmZNErWYwAX6ni12Q@mail.gmail.com>
Subject: Re: [PATCH] objtool: Be lenient about -Wundef
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 8:00 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, Jun 19, 2019 at 05:03:37AM -0700, Olof Johansson wrote:
> > Some libelf versions use undefined macros, which combined with newer GCC
> > makes for errors from system headers. This isn't overly useful to fail
> > compiling objtool for.
> >
> > Error as seen:
> >
> > cc1: all warnings being treated as errors
> > In file included from arch/x86/../../elf.h:10,
> >                  from arch/x86/decode.c:14:
> > /usr/include/libelf/gelf.h:25:5: error: "__LIBELF_INTERNAL__" is not defined, evaluates to 0 [-Werror=undef]
> >  #if __LIBELF_INTERNAL__
> >      ^~~~~~~~~~~~~~~~~~~
> >
> > For this reason, skip -Wundef on objtool.
> >
> > Signed-off-by: Olof Johansson <olof@lixom.net>
>
> Sorry for the delay, I was out last week and I'm still getting caught
> up.
>
> Which libelf was this?  I'm guessing it's the old non-elfutils version
> which has been unmaintained for 10 years (and which doesn't work with
> objtool anyway).
>
> It would be nice if we could figure out a way to detect that libelf and
> report a more useful error for it.

Yeah, looks like my docker image pulled in the very old libelf 0.8.13,
but has elfutils available. I'll switch it over locally to resolve
this.


-Olof
