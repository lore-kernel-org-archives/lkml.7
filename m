Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EF0C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242AD20705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H37n2vyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgAHOlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:41:46 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41298 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgAHOlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:41:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id x8so1679271pgk.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 06:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pmfr4lT+9w9idepjsVRbi3vih8NhxWk03pCzh2kY1TM=;
        b=H37n2vyIH55gzmQlLagmHwa+ll3F9/TwM2PMzE71ifUtYXqOpcSIaHMJq1YMdsVuOy
         4Qh6w06cGhhxeRo3z3Ib+a6XxhOf1kjpCQOojK0GCr3P9mesVRYsOuvCHmXRJ9epZNLk
         YopMferNnK1gLz6vW0EatYwdbceYUKyXGzxrW6A2vqtV6ksiHTuk9Why+mWTCEPDj2bU
         rsp7itq17//T03fscxF7lam4D3IPEO7IZRHSB7wBo5dCu3djjZpRTkypjWyVnECgd9f6
         I9qaeaWx6v7hX0MkFk/y8bpqKuNPnEQCyiLExjBTOH7q05TRi66QdKaHbbUv9GnWzyma
         wXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pmfr4lT+9w9idepjsVRbi3vih8NhxWk03pCzh2kY1TM=;
        b=VskxJFjBIkLsPEvsF7Gr5Mh1dGr2ucVkGDEASsexb+aevd88wbiaAgQAKADgLMxYZq
         K2Y0sSNcmcZGQudm0vY+k5a/7JJsDbGl7D54ni/CshKYULFs0HOnB17onqI9WfDh7YSv
         IaA47zE3hWk1K1YSkLefTnrmp/STvwOYqTv5gyc1zdX5ZB2UktE1z/9hug6e+e6mmn5j
         qU1skJ4dVnU02jgEoO9rx3oe5M2ep3CQvlBahTEC3QFpSJVHd7JrknDwOB/vJK1C90wb
         TJnHlESsdaorVQdpRVjiBxRwRa5yFrPNOYW1JDJ/t2bCGQe1b54Zfhjn6EHBru6jfFN+
         v1Uw==
X-Gm-Message-State: APjAAAUIxsWLTVLlHB3Vu6W3eKSBstDoe24s++iSh1vMLajlseF9Dv1S
        +AXTzOofYa6tjqFvDuJqw0KYaazynDtuKIniiUoK5A==
X-Google-Smtp-Source: APXvYqxgRLFNG2TmAcrgc+v7RSS0iaETQOarqjz2xxveDTmD+eCmm8vd+A2S/avlEoADjQeCpeSplwQlcyX+xL17Reo=
X-Received: by 2002:aa7:961b:: with SMTP id q27mr5376393pfg.23.1578494505168;
 Wed, 08 Jan 2020 06:41:45 -0800 (PST)
MIME-Version: 1.0
References: <201912301716.xBUHGKTi016375@pmwg-server-01.pmwglab> <CAK8P3a1OsiUV5YuwzSJ4CsD8NHJHjedTA4K7xBKK6Q-4kA8t5g@mail.gmail.com>
In-Reply-To: <CAK8P3a1OsiUV5YuwzSJ4CsD8NHJHjedTA4K7xBKK6Q-4kA8t5g@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 8 Jan 2020 06:41:31 -0800
Message-ID: <CAFd5g46YYiC-aeAGumqOMiNZ71h2dGH==F_bdj+pwQ5YOHo3GA@mail.gmail.com>
Subject: Re: kunit stack usage, was: pmwg-ci report v5.5-rc4-147-gc62d43442481
To:     Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>
Cc:     PMWG CI <pmwg-ci@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Private Kernel Alias <private-kwg@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Stephen Boyd

On Tue, Jan 7, 2020 at 4:37 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Dec 30, 2019 at 6:16 PM PMWG CI <pmwg-ci@linaro.org> wrote:
> >
> >
> > The error/warning: 1 drivers/base/test/property-entry-test.c:214:1: warning: the frame size of 3128 bytes is larger than 2048 bytes [-Wframe-larger-than=]
> > ... was introduced by commit:
> >
> > commit c032ace71c29d513bf9df64ace1885fe5ff24981
> > Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Date:   Wed Dec 4 10:53:15 2019 -0800
> >
> >     software node: add basic tests for property entries
>
> This problem is a result of the KUNIT_ASSERTION() definition that puts
> a local struct on the stack interacting badly with the structleak_plugin
> when CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is set in
> allmodconfig:
>
> pe_test_uint_arrays() contains a couple of larger variables, plus 41
> instances of KUNIT_EXPECT_*() or KUNIT_ASSERT_*(), each one
> of these adds its own copy of the structure, eventually exceeding
> the warning limit.

Uh oh, sorry about that.

> We can work around this locally by splitting up the largest four
> functions in this file (pe_test_uints, pe_test_uint_arrays, pe_test_strings,
> and pe_test_reference) into smaller functions that stay below the
> warning limit, but it would be nice to find a way for kunit to not
> use as much stack space. Any suggestions?

Agreed. I have a couple ideas. The grossest idea, which I am guessing
most people won't like is to go back to the stream builder method,
basically build the message as we go on the heap; however, the current
method was created specifically to not do that which much help from
Stephen (CC'ed), so probably not want we want to do.

Another idea, the struct just exists to pack up data and ship it off
to a function which handles the expectation/assertion. Consequently,
the struct is only used inside the expectation/assertion macro; it is
not needed before the macro block and is not needed after it. So could
we maybe make some kind of expectation/assertion union so that we know
they are all the same size, and then somehow tag the stack allocation
so that we only ever have one copy in a stack frame? I am not sure if
that kind of compiler magic exists. I guess one way to accomplish this
is to make a dummy function in KUnit whose job it is to call the unit
test function, which allocates the object, and then calls the unit
test function with a reference to the object allocation; then we could
just reuse that allocation and we can avoid making a bunch of
piecemeal heap allocations.

What do people think? Any other ideas?

Also, sorry in advance for delayed responses: I am on vacation until
the 13th and then I will be at LCA until the 18th.

Cheers!
