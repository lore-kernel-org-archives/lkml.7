Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B46FC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 00:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6774820B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 00:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJ/PCl/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfHAAAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 20:00:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46356 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfHAAAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 20:00:53 -0400
Received: by mail-lf1-f65.google.com with SMTP id z15so44477134lfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 17:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UL3lL/rjWfes+fqBB30GeSXSR3w1JyhR+8U0f8P1eUw=;
        b=TJ/PCl/hQElX3wQElbIdv9BNHS1NuixG7oAZ1vxbVQI1gHIpQ2dLcHWzSabCbNsIck
         N+AN3yb/710sXZrzNBPNKg1cZUhxr5pbsDr2/6OsRwHQ/2eivwLtwI2Rgmn3HOgBStVO
         oKQjm9mfVNxXCLTtbojX+1ZRACMN3Yg9PuLJeck8OD3typdwUOjDXisb13Kf5W9kh0cl
         xOPr/c1T4x9zxRxb3ean0ZH331bALNvBdBTVvHNKCJtc6XCWtNkVdBsLvYNTFx0+1j8z
         vBuwJo9HBVVy22IUjspo9icTkIlv369ddxDzivDujEy37iDyO2ZzGZqHU8LtDHCKbjEN
         LTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UL3lL/rjWfes+fqBB30GeSXSR3w1JyhR+8U0f8P1eUw=;
        b=ownrlZ7WI2QpanNUN3rdd2hM2d3zhrZ5+fuNG+4aM25jBYhQVYoq/ltX1ApzQdDGt5
         E9r3u3XmtduY+LqLaTvIWbFX+MWqFjZkZyjeNakirDOKW+tATFTzdlEq1fMm0YmGysLX
         X4vIl3rUd0+EeGvgOhKgKg1FfMOkxyxNlT2wrfJ6ihVM8ynpnzhqQ/BKX2m1L/meqYT3
         XLbICWIo3lQYcfxcUHFTM3vtE0RvpY1ROpnb2PHBQ73AngXtNpVmJ3h8YpzTJRGiSD4a
         lT8nnlBANRC9ZJJizz0GDwnFpJIo1b7JThmR+/F5tsMdjkn1w4c+dJv30g5iUXTLHjl+
         Cytg==
X-Gm-Message-State: APjAAAUyVuSIFsxsjB9BMvNSiEiKcOGK9FZMY3lfJKBmeUItm5LwHmkf
        RMQjMNHxvVnPW7z+QIH4BJPJKLyUgu7ZeoP1eeE=
X-Google-Smtp-Source: APXvYqyVR9Jw2IEjs3RpzZhA9WGMXRPDZprpVZ03AGtFNzUueb8zofEXBp8yudB8I27SzDu4mUgXdSRgbd/JquIKk0I=
X-Received: by 2002:ac2:46d5:: with SMTP id p21mr26506546lfo.133.1564617651943;
 Wed, 31 Jul 2019 17:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
 <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
 <20190731171429.GA24222@amd> <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com>
 <765E740C-4259-4835-A58D-432006628BAC@zytor.com> <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
 <201907311301.EC1D84F@keescook> <CANiq72kMpP_PSBb0e5wMVNiuYvwSWdR+x_H_tPrEnQ_j1y7X+Q@mail.gmail.com>
 <beb1762387a4132a2bb4c47397b737d77dd88742.camel@perches.com>
In-Reply-To: <beb1762387a4132a2bb4c47397b737d77dd88742.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 1 Aug 2019 02:00:41 +0200
Message-ID: <CANiq72nhw5tmd7zCAyAA32ekW01GYPqcJbTMCVeUpaeb7dWTKA@mail.gmail.com>
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
To:     Joe Perches <joe@perches.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 12:07 AM Joe Perches <joe@perches.com> wrote:
>
> Note also that this doesn't actually _use_ fallthrough
> it just reserves it.

If we are reserving it, we should be giving a compile error instead. I
don't see how users will understand they shouldn't use it just yet (it
is the same as adding it, which actually looks more like
encouragement!).

Cheers,
Miguel
