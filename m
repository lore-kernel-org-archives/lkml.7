Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F42C433FF
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 18:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148FC20844
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 18:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564942187;
	bh=yNbUc9lK5hXPW+w2NvLHArob1B8WYiMHFXU4MjRTujk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jib0h1OItSrmPpYhhcT6VKpLmC4/0bB+wMwXjY6oes0H2w5eXGtmurJMYN60xkUeX
	 bJqyhduDUFJUoX2PJOceWuiQqsVSfwN+j+CWv3Og1wdkiIrjUvR1ZOlGy86oxP6dyn
	 w5rpeHirKLNT/LEiddaaMPVhizlG/I/aewJeErN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfHDSJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 14:09:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42216 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfHDSJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 14:09:41 -0400
Received: by mail-lf1-f66.google.com with SMTP id s19so56253816lfb.9
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 11:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wuBlwfX+hCs0Uc67OFIfuS67/SKzbTgBZUEERY3pI40=;
        b=E315dOoLFMqppqp5n5kltpgS92j72T86foZlb+w3GlUbAIAQBSgMxt5G1EJSE3/aOu
         WRr0D5qZXenrvlsM5M0QYelhXeeshSDV09e49feROiwBmtuu7LgX7Vw1snhcgZ1kNM/g
         eqvCOC2JKgyPUTbRknS1L/YSIj7+8KyqUFzeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wuBlwfX+hCs0Uc67OFIfuS67/SKzbTgBZUEERY3pI40=;
        b=dCpQoAn/1b7hUJ2vJQXXeuU6+TrGzCfgDLCh2dvmDUdQvNkXzzCjl7OvgdgN/k08EL
         HyM2KS3L1kN6arjXvEj8kdKaB3qPMsrv9s3ZEH240cTG1FgSNQI2X9yjy/HnSWj+3ChM
         9Gemhb1ghUfO+2oO/g2+eAgLsm2ONPkNMGZ6uVe+j9QTCOo6vE+CydAjL5HuGXfUtbYc
         i3lMx+79+KmvPBkPItOXsn25WZ9o1ZUpA0FfFg+qNeJsJFDiE3QmG4lTzQ3tb7Aahfv8
         NXlkIDx5UiIIfVHyICBM4+RHRYo6+n5Iydm6UQ0QIG6LqcsXFHF748Cx+ZXcKInEvlXX
         evgQ==
X-Gm-Message-State: APjAAAVV0bsA1Y8LfD23gU9+8dcqZWgyzwjHF/0uCAvJ4b1XwfFek2Ik
        DzVnd0/Am5H946f1I/8DoDMZN633jUE=
X-Google-Smtp-Source: APXvYqyAU+6tL+7g7huoqlO0LWE7JQGGtRaix39JJg3Br2HnRrXjt4aqbwDXj3DC6vI6NL6PTs64+g==
X-Received: by 2002:a05:6512:1da:: with SMTP id f26mr68275520lfp.129.1564942178425;
        Sun, 04 Aug 2019 11:09:38 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 2sm16526827lji.94.2019.08.04.11.09.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2019 11:09:36 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id v16so2381299lfg.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2019 11:09:35 -0700 (PDT)
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr59076019lfp.61.1564942175718;
 Sun, 04 Aug 2019 11:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
 <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com> <c0669a7130645a20e99915385b7e712360c31ed9.camel@perches.com>
In-Reply-To: <c0669a7130645a20e99915385b7e712360c31ed9.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Aug 2019 11:09:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1PAJR6ChVXE7O_H2wEG=1mWxi2uc0fH5bthOC_81uTA@mail.gmail.com>
Message-ID: <CAHk-=wg1PAJR6ChVXE7O_H2wEG=1mWxi2uc0fH5bthOC_81uTA@mail.gmail.com>
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
To:     Joe Perches <joe@perches.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 4, 2019 at 11:01 AM Joe Perches <joe@perches.com> wrote:
>
> Linus?  Do you have an opinion about this RFC/patch?

So my only real concern is that the comment approach has always been
the really traditional one, going back all the way to 'lint' days.

And you obviously cannot use a #define to create a comment, so this
whole keyword model will never be able to do that.

At the same time, all the modern tools we care about do seem to be
happy with it, either through the gcc attribute, the clang
[[clang:fallthrough]] or the (eventual) standard C [[fallthrough]]
model.

So I'm ok with just saying "the comment model may be traditional, but
it's not very good".

I didn't look at all the patches, but the one I *did* see had a few issues:

 - it didn't seem to handle clang

 - we'd need to make -Wimplicit-fallthrough be dependent on the
compiler actually supporting the attribute, not just on supporting the
flag.

without those changes, nobody can actually start doing any
conversions. But I assume such patches exist somewhere, and I've just
missed them.

               Linus
