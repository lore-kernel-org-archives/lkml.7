Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5225C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE88F20674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMwpu52e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfFXW2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 18:28:38 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38258 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfFXW2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 18:28:36 -0400
Received: by mail-lf1-f67.google.com with SMTP id b11so11207486lfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 15:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z0+SMfdKLkHiYdeKZRrRpJIZYVtwz3wkkP0MSdnnB1o=;
        b=LMwpu52eHheCRvAD6cL8mcJguFfurnwGVRo5cHnYlmes2lq4sYIv0XckYQ+0mJVt3X
         TlZBtX+WHycL8X08yDUAYEMs7CFNWTfJAhO+jk+zw4tmi3PvMUZoZIHWcgzR9ZCKdVJg
         UduQE10LZuNud/HuSd1BypEftNOeucaOKdmrO1g+9+0MFDO9dwzkSL2rQrL157q5jPKD
         GRhTjYXnENLzKdrJX+99RKPjqqPf/2TgfdCSWUr52jDGJL7h7qGI1eyUDowHU90CmkGl
         G/UrJJ8z2O0l64JDfDgpgeSZFCeJ3jnSw9FXHMLTcOvvMBwOgUuEYs7BAXi28dF0f0xS
         F4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z0+SMfdKLkHiYdeKZRrRpJIZYVtwz3wkkP0MSdnnB1o=;
        b=VnWCU2eCkxCMYOapWyd/r2zGaEq7gRSxsAaPNmaWDiTbc7cXkmY/W9PON5FQa6pBHz
         u7eJEEGLujknp9+6S1FQQ6tk2IW4RaLAZxqwWQuB40m3KQpbC55Zxs5N5gUxqJwRy8v+
         QV5+C0BLpR9CJOlFzdePixNF40reZhGL5lVrCLsPNINOpLfa2zPbhuO19uGuna2dbRi5
         XCkCL8lvK8A9ZDsvrDiajoRMGPKkXpF4/ryoS2Zr/K1bWp6y2G2Cf/7T1DRNIZozwef7
         RkxTzuwJsV01tsa+gNbm2UHqf45O3Vu5yuA0nSMqLOevtVyieEuKOMI5JThF14Tdsf3H
         ffVw==
X-Gm-Message-State: APjAAAV2wv8SRvcxU4OLtQrl5egm5UfRfIcGu11SaSj9Fu4UbkMm5tA1
        pn1uxOSGvP0QZg9q3WQIVN+xMO+4pRo2QHh5Qio=
X-Google-Smtp-Source: APXvYqzckYB9vK8ScS+LDrxIkRtw0bQqM379YwGj3+lwzrEayfCRhK6CJQlWzOKX4HT0+4P836VDEX9UeJK/Cqxf9Vs=
X-Received: by 2002:a19:d5:: with SMTP id 204mr11911213lfa.66.1561415314931;
 Mon, 24 Jun 2019 15:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190624161913.GA32270@embeddedor> <20190624193123.GI3436@hirez.programming.kicks-ass.net>
 <b00fc090d83ac6bd41a5db866b02d425d9ab20e4.camel@perches.com>
 <20190624203737.GL3436@hirez.programming.kicks-ass.net> <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
In-Reply-To: <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 25 Jun 2019 00:28:23 +0200
Message-ID: <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joe Perches <joe@perches.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shawn Landden <shawn@git.icu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 10:53 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Once the C++17 `__attribute__((fallthrough))` is more widely handled by C compilers,
> static analyzers, and IDEs, we can switch to using that instead. Also, we are a few
> warnings away (less than five) from being able to enable -Wimplicit-fallthrough. After
> this option has been finally enabled (in v5.3) we can easily go and replace the comments
> to whatever we agree upon.

Indeed -- the decision last year was to wait for a while since not
everyone had support for it. My branch is waiting here:

    https://github.com/ojeda/linux/tree/compiler-attributes-fallthrough

The good news is that there is some progress. For instance, LLVM is
working on supporting the GNU spelling:

    https://reviews.llvm.org/D63260
    https://bugs.llvm.org/show_bug.cgi?id=37135
    https://github.com/ClangBuiltLinux/linux/issues/235

Also note that C2x may get [[fallthrough]]. See N2267 and N2335. At
that point, surely tools/IDEs/analyzers will support it :-) The
question is whether we want to wait that long to replace the comments.

On related news, we also may get __has_c_attribute() standardized
(i.e. we use __has_attribute() now), too, see N2333.

Cheers,
Miguel
