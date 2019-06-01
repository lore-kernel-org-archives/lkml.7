Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457DCC04AB6
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 00:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F992708E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 00:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7AQ2p/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfFAA3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 20:29:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36019 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfFAA3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 20:29:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id a8so17117734edx.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 17:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JNA+M2HNg5wC58bq9MZMCh6YyzsCVe0fiW59+AoI+uk=;
        b=g7AQ2p/RBhEEwukGt++EPQDzHYe3xAanZFkwZbDE2W/aOJnnVSHjYYJyumy9E3fGIK
         MOYIQP5P9hNJ/8I6BMNJauiYurLi7++SWUKkh10Q0nWDqa9uayZhElnX4el7hGmqoNvQ
         U7uDj2Hrst9GJYcVKnfWPPlSLGRmh66qyJC8yFR3EgO6/8uK/fwbLtw2klXXCQaeRD8/
         cAOBe+wMbSvjmTJrdxom7WKJ/rNw/wJEXVVro9JNLuP15MDMgzMFcESSm4cOTSUSbSKn
         h8IjqqdAea5IqczJoAirb11KMsrKfU/IZIVZODIfcvwgHHbdNwEoNCf5v/lUFY04XvUp
         O2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JNA+M2HNg5wC58bq9MZMCh6YyzsCVe0fiW59+AoI+uk=;
        b=oKIR9DKWWLdoAEmUG9P01q/THR+GNtNVQgatyEZtGydU3Q8b3FVnN1zalthuX/8kx/
         gAtDk6/1cu2JwBrg9UWUqoi7/B30a0FjAv9iC+0aylW1/2ikEcuRStv4JhSoSfQGoRzX
         rJKL8KrKohzjIAcBPMNFu+E8zgdZpW+IE1HY8SUHoRKZKrh0qDQ6oe1PeU4XkbqEJ33e
         ZHzujwu3oYWSyUtdA4EiDD6LVm16rdm9qnCmg1CzFBNToFcaqpFlK8hMEACd17ouGF/B
         SU8z3qM+54Gdqw99HxnTaRI9tB/ySISDte1LFF4JPsUKY4a1X5WStloOA6xFKGAGA0lm
         9gyw==
X-Gm-Message-State: APjAAAWSw5NpQNtK5F62Riy1fcnUoct5ZR+Q4GGTc9kxIrynvETVJqxm
        zJKZ/N9daGy6aDAThTV+A+Q=
X-Google-Smtp-Source: APXvYqyjHBP6Ky2mspUst454rSxki3hW4y23rkcxYomBYUoZjYnk+QD/AlcwIriW+0mzpinwEfLa/w==
X-Received: by 2002:a50:bb24:: with SMTP id y33mr14611589ede.116.1559348940661;
        Fri, 31 May 2019 17:29:00 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id h20sm1244729eja.37.2019.05.31.17.28.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 17:29:00 -0700 (PDT)
Date:   Fri, 31 May 2019 17:28:58 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Stefan Agner <stefan@agner.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] ARM: xor-neon: Replace __GNUC__ checks with
 CONFIG_CC_IS_GCC
Message-ID: <20190601002858.GA89184@archlinux-epyc>
References: <20190528235742.105510-1-natechancellor@gmail.com>
 <CAK8P3a0a0hMsZDkqKsfsyCWpdvDni72tjAxCz2VeAaU56zqrXg@mail.gmail.com>
 <20190531183227.GA34102@archlinux-epyc>
 <CAK8P3a1-_KRvoeK4w0b8775izox8fRm=NGJC=yicDRn7J5UW2Q@mail.gmail.com>
 <CAKwvOdkyk3qLMPquSZqXCFauTADJU5X9qJi_fhJqbUuCYBH-6Q@mail.gmail.com>
 <CAK8P3a2pYp6aaOSrtHKbVW+hPbwgj1An6dWNd-YLJyR5otvU-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2pYp6aaOSrtHKbVW+hPbwgj1An6dWNd-YLJyR5otvU-A@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 11:03:19PM +0200, Arnd Bergmann wrote:
> On Fri, May 31, 2019 at 10:06 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > On Fri, May 31, 2019 at 12:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > clang, I would suggest dropping your patch then, and instead adding
> >
> > I disagree.  The minimum version of gcc required to build the kernel
> > is 4.6, so the comment about older versions of gcc is irrelevant and
> > should be removed.
> 
> Sure, that's ok. It just feels wrong to remove a warning that points
> to a real problem that still exists and can be detected at the moment.
> 
> If we think that clang-9 is going to be fixed before its release,
> the warning could be changed to test for that version as a minimum,
> and point to the bugzilla entry for more details.
> 
>       Arnd

I just tested the arm64 implementation and it shows the same warnings
about cost as arm.

However, I see a warning as something that can be resolved by the user.
The GCC warning's solution is to just use a newer version of GCC
(something fairly easily attainable). This new warning currently has no
solution other than don't use clang.

It is up to you and Nick but I would say unless we are going to
prioritize fixing this, we shouldn't add a warning for it. I'd say it is
more appropriate to fix it then add a warning saying upgrade to this
version to fix it, like the GCC one (though I don't necessarily hate
adding the warning assuming that clang 9 will have it fixed).

Cheers,
Nathan
