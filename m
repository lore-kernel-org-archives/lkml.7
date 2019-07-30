Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEF4C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF4920659
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564516459;
	bh=mvFGF4QreA0iuEQi+qIzBskQcAJhanO/1s7TD8JcZ28=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cZsOT+r51wsOTZFi+EiSPPrPZE9dtDpjY4n975S6QNx9Fmn2oHw+HroUQEG29Kdzi
	 kdCLO1GZd7VPkNI4eOWpMQUGQl3NJnQHX53D0gfp8nDhkvdZN+0dto1FE2BWkPKYb+
	 FTWLgCc2m0bIB0s/Zee9HJpTVXit+KHq7ZQGqaQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfG3TyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:54:18 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43784 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfG3TyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:54:17 -0400
Received: by mail-lf1-f66.google.com with SMTP id c19so45618595lfm.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 12:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DYwRL+eADA+1dm6nanHrVrPUx1TH3By+TzxwtKS/MUA=;
        b=HZfi31FgKPsyasTOb6vCxjP1sz7LClL3ngurJ8kvFZDA8/FUuK7rTNeFLHAi9xar1e
         KdFF+m6+ZryEaiM5B/0RTgTyuF6P37hFSKrrTZWJeO5TJN17R9x5xHUGj13OwwuETnpb
         Zt2dsRfhsFX4p8QCIFo4VxubYwsVHIHX6kMGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYwRL+eADA+1dm6nanHrVrPUx1TH3By+TzxwtKS/MUA=;
        b=puVXKc0qMljLuK3oHbhNj+pABLlofuTvi+Btt43x2wdCj/oxKlLFmj6NogTqpeJI7v
         zOm1jC4ilGX9H6+pjWZ26SfLtK9c1gmUJc4kwjcsALweRoCMpbLAkG1hxpJ4RalOHe3a
         1wVWdtTfXAMzO8KnpRXZlWC1js18mYg4iLaVeTes/8OQx2ButWJrXZmQh0jHYVOU0NH+
         Upn1W7pQ2WguEVfSH7cqcFYy00xJcNmeqNcbnXlCRggZpaWA6luWY4rMTpYHp9IY7hAs
         sEo5qIJs98YcSQFDbQaQCXzctnzFm9Uquq0qJImCkBoyWYZdOJ58raVlg6JFuVvWsCR6
         6efg==
X-Gm-Message-State: APjAAAXn6cK99jJ/bJwwC7Oz+dsJJ0854AjhR1eMm5Y/0hK67NSEhIPS
        vLuUzD0qLIFZ/qPCVB4CNmc0tTgT9Ts=
X-Google-Smtp-Source: APXvYqxI9px/v73KRwqbTDDTTQyOfre86qfi9BRwiyp82RqJaMaTAQViIHI6W0Hq1o/KFagSvB8CVA==
X-Received: by 2002:ac2:48a5:: with SMTP id u5mr57404285lfg.62.1564516454825;
        Tue, 30 Jul 2019 12:54:14 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id t21sm11356184lfl.17.2019.07.30.12.54.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 12:54:13 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id v24so63380201ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 12:54:13 -0700 (PDT)
X-Received: by 2002:a2e:9b83:: with SMTP id z3mr33651123lji.84.1564516453281;
 Tue, 30 Jul 2019 12:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <201907281218.F6D2C2DD@keescook> <CAHk-=wj+1vDh2=eZExibYF9Lo0GsGxaAjxCSwpUFVURrN44cUQ@mail.gmail.com>
 <201907281507.B3F11DD54@keescook> <CAG_fn=Us9wREo+9PG-jPCTXsNv-rencgYHowtwXahuYBgdDs4A@mail.gmail.com>
In-Reply-To: <CAG_fn=Us9wREo+9PG-jPCTXsNv-rencgYHowtwXahuYBgdDs4A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Jul 2019 12:53:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTM+cN7zyUZacGQDv3DuuoA4LORNPWgb1Y_Z1p4iedNQ@mail.gmail.com>
Message-ID: <CAHk-=wgTM+cN7zyUZacGQDv3DuuoA4LORNPWgb1Y_Z1p4iedNQ@mail.gmail.com>
Subject: Re: [GIT PULL] meminit fix for v5.3-rc2
To:     Alexander Potapenko <glider@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 6:53 AM Alexander Potapenko <glider@google.com> wrote:
>
> I wonder how hard it should be to make a zero-filling GCC plugin?
> I'm not a big fan of hacking GCC, but it shouldn't differ much from
> the existing GCC plugins that initialize locals.

The thing is, as long as it's a plugin, I don't think we can rely on
it. The gcc people will rightly just laugh at us if we were to report
a bug with some kernel plugin.

So I'd like the zeroing of local variables to be a native compiler
option, so that we can (_eventually_ - these things take a long time)
just start saying "ok, we simply consider stack variables to be always
initialized".

> I've some stale data collected on an x86 QEMU instance.
> For 0x00 stack initialization:
>  - hackbench, netperf and parallel Linux build were virtually free
> (slowdown within stdev)
>  - for af_inet_loopback the slowdown was ~4%
> For 0xAA stack initialization:
>  - netperf and parallel Linux build were free
>  - for hackbench the slowdown was ~1.5%
>  - for af_inet_loopback the slowdown was ~7%

So I would expect that we have some special cases where we end up
having arrays (or big structures) on the stack that end up being
critical, and where initializing them is clearly  abad idea.

Then we can verify manually are very much initialized, and that we
could then mark and say "this is uninitialized".

So when a compiler has an option to initialize stack variables, it
would probably _also_ be a very good idea for that compiler to then
support a variable attribute that says "don't initialize _this_
variable, I will do that manually".

But if we in ten years had a kernel model where only allocations and
variables that were _explicitly_ uninitialized, that would be lovely.

Then you can grep for those and verify that "yes, this is safe".

We've historically had the reverse model - things are uninitialized by
default, and you have to explicitly initialize them. Turning that on
its head is what I would like to do long-term.

(For normal allocations that wouldn't be too bad: get rid of
__GFP_ZERO and friends, and instead do __GFP_UNINITIALIZED).

Again - I don't think we want a world where everything is
force-initialized. There _are_ going to be situations where that just
hurts too much. But if we get to a place where we are zero-initialized
by default, and have to explicitly mark the unsafe things (and we'll
have comments not just about how they get initialized, but also about
why that particular thing is so performance-critical), that would be a
good place to be.

This, btw, is why I also think that the "initialize with poison" is
pointless and wrong. Yes, it can find bugs, but it doesn't really help
improve the general situation, and people see it as a debugging tool,
not a "improve code quality and improve the life of kernel developers"
tool.

                Linus
