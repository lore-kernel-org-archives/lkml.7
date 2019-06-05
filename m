Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E546C28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67EEA20866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WVI7T+qZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfFEUso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:48:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40396 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfFEUso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:48:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so35137pfn.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 13:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gf36/FJbmvcIKQB71SoUxqFxDnsf/YtRh42eY1Za4A8=;
        b=WVI7T+qZtVEnyq5ZQtNNc6p8ErkwczAYREEK8DBsct2+ctCli/t1y+PGIeTMbkm3fo
         SstGkCzPWEb+Cx6li46d+n9sAQMufEh3WYdaLmWqU9b6lyPJ8lYKCCjcUzoMeJxfosx2
         drDkUF7J+5+mqVVkquXPaNaVMItINGIoMemq93eMTsMaVY0U6ACrdh9NtYefm357B5PH
         3w/wOk/4Y9PkD62xH7O573/32c2sugfS5y/ofkpiwKOgU2wPekGDUGQ64Sg8etaLiSGV
         IAXvSYStLoGg1BznpPh3rJcDmObUGqtNviYlYyljrGyrN2EyPxXuS6RaFg7JmQf0gZh5
         aqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gf36/FJbmvcIKQB71SoUxqFxDnsf/YtRh42eY1Za4A8=;
        b=meiW4OpcdOcuTtP7L0+vEpvxiKuuk9UHvzBfoFX4fs76iFuq7bhOwjlvocGIcFBQ0G
         bTjHgKIV/lzPFxzqJz2YMGqwUY6yHsnc+GsTR9/KO2pKApleCKbjn81nlpnqwqMjPEkp
         slF6B8AlDIjYKm+pztRB1zrFuaNhW82Gi/NMqb2WgYLrEUnX2hNyEd8DIPXwHqikn8AT
         fE1BB90wo05qTrVfsqoBEZ8OuOj5PpQgr/sp8diFr3KmCubdTbjD1x/Sj/zyAfzCa2aU
         T8bTBy3uKw5TIOHpH+H9/9+OeqfAjctAWs59LqoT/4o2wVP2QlSQm5lpMF4Dzw6EPifM
         MwkQ==
X-Gm-Message-State: APjAAAVuDJUoyOEq1QVOET9IYoVj2BmF22jr9l/ha4Ykm+ECiVFvFAIl
        m4lENO9dn24Cy6D5ItG5AuYFPNATzclmh06itT2rlA==
X-Google-Smtp-Source: APXvYqw04eb//flZxwX52rlKUE9uC5FQrN/EPO3Y+b+R/m9mxJBjNW8wJAFNaE/R9u6bPF2yyHx+uo26PEQ6Qbdgmds=
X-Received: by 2002:a63:52:: with SMTP id 79mr829652pga.381.1559767722964;
 Wed, 05 Jun 2019 13:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <779905244.a0lJJiZRjM@devpool35> <20190605162626.GA31164@kroah.com>
 <CAKv+Gu9QkKwNVpfpQP7uDd2-66jU=qkeA7=0RAoO4TNaSbG+tg@mail.gmail.com>
In-Reply-To: <CAKv+Gu9QkKwNVpfpQP7uDd2-66jU=qkeA7=0RAoO4TNaSbG+tg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 5 Jun 2019 13:48:31 -0700
Message-ID: <CAKwvOdnPcjESFrQRR_=cCVag3ZSnC0nBqF7+LFHrcDArT_segA@mail.gmail.com>
Subject: Re: Building arm64 EFI stub with -fpie breaks build of 4.9.x
 (undefined reference to `__efistub__GLOBAL_OFFSET_TABLE_')
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Rolf Eike Beer <eb@emlix.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 11:42 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> For the record, this is an example of why I think backporting those
> clang enablement patches is a bad idea.

There's always a risk involved with backports of any kind; more CI
coverage can help us mitigate some of these risks in an automated
fashion before we get user reports like this.  I meet with the
KernelCI folks weekly, so I'll double check on the coverage of the
stable tree's branches.  The 0day folks are also very responsive and
I've spoken with them a few times, so I'll try to get to the bottom of
why this wasn't reported by either of those.

Also, these patches help keep Android, CrOS, and Google internal
production kernels closer to their upstream sources.

> We can't actually build those
> kernels with clang, can we? So what is the point? </grumpy>

Here's last night's build:
https://travis-ci.com/ClangBuiltLinux/continuous-integration/builds/114388434

Also, Android and CrOS have shipped X million devices w/ 4.9 kernels
built with Clang.  I think this number will grow at least one order of
magnitude imminently.

> Alternatively, we can just revert this patch from 4.9

That would break at least the above devices next time Android and CrOS
pulled from stable.

> It would be helpful to get a relocation dump (objdump -r) of
> arm64-stub.o to figure out which symbol needs a 'hidden' annotation to
> prevent GCC from emitting it as a PIC reference requiring a GOT.

Sounds like the best way forward, as well as having more info on which
config/toolchain reliably reproduces the issue.
-- 
Thanks,
~Nick Desaulniers
