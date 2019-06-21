Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61601C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC80208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3vi2AAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfFUNcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:32:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38577 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfFUNcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:32:52 -0400
Received: by mail-io1-f67.google.com with SMTP id j6so918024ioa.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 06:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZOu+sVSXpOqICESmggSM2r4CPCyuPx9bs4vYuIKuU68=;
        b=G3vi2AAOl4hhhusP8y7LXnvpUAsLTdGJFfvknAJ17R1YOy9TvoJJ3x7kaY/yQ4gr7a
         g6a7wOgKUJn9B7X1Wy6wO2KCv+8vRXCkrWcO+VKunYTrgBfaEZq9uyvo/pQQxhF6M0SG
         py8beLFr5Lg5jBqNXGNLWrUfPx7UJMX/0QYzTkkfSkX3opZgtR7tg5A8s/pLHnXvOzF/
         mEFa9x4BTkqGp3bWQ5ZC2svEcgAY9/BX6yekUT6McoUBo4wfUx1f3GcYNs5n6YpCoZdF
         mv2+WJ0uUtJRVmJITvuMqg9rf0Y0r8Sjeb9VAh/s5Mdklc02L9tX5a88QkRnlEBhNTqp
         wiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZOu+sVSXpOqICESmggSM2r4CPCyuPx9bs4vYuIKuU68=;
        b=Fya2qOQegw2tBePeN3IA3b9o2lQhZcFgMqqwwIzsJUKHP0KSj6GMOBVbEFI2I83MAc
         LtAYMwUf5HaNzbuV4IYhhj5wCGMksMlUe2w7OFsgBImC9J3fh3TFoZ4Iq5fV3zURdwfj
         5VMMwXLzUBMFZDy8NEgKXlTAr5s72GN2r3O1ZHxYFHZb5+c59Lrnh+hhXEb2mDLEpRz9
         v9T4a98TAe7X6n60Hfa3uaVtL3Iha0HJUfqDOYRGVPPNjDQvQYG9KZ9wAsJYhPnZelmY
         bW6QqdiXKaSSgy0L2RV/Xho/0J/tvsvGc/M0cvXVD51cWhq+QcENzjigkzCMdi5R4j8l
         MbSg==
X-Gm-Message-State: APjAAAUEqJNNOl/sTweE1C2oOgPu1uWL9dHdvGbU1XYzkCrBiPcQEZJR
        J71MDzWLPv3pHlhGflCM1Pp4oy4UWWX67rdovin5Ug==
X-Google-Smtp-Source: APXvYqywBx+off9TrCkhXHGnxEFiuOzAKv+SiaNKvZJdidbzBrWYeoOWgFVT6uKrIaXpibz3u3FQ/cPBVwvmh4sxkd0=
X-Received: by 2002:a02:1a86:: with SMTP id 128mr8265567jai.95.1561123971509;
 Fri, 21 Jun 2019 06:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190618094731.3677294-1-arnd@arndb.de> <201906201034.9E44D8A2A8@keescook>
 <CAK8P3a2uFcaGMSHRdg4NECHJwgAyhtMuYDv3U=z2UdBSL5U0Lw@mail.gmail.com>
In-Reply-To: <CAK8P3a2uFcaGMSHRdg4NECHJwgAyhtMuYDv3U=z2UdBSL5U0Lw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 21 Jun 2019 15:32:40 +0200
Message-ID: <CAKv+Gu-A_OWUQ_neUAprmQOotPA=LoUGQHvFkZ2tqQAg=us1jA@mail.gmail.com>
Subject: Re: [PATCH] structleak: disable BYREF_ALL in combination with KASAN_STACK
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jun 2019 at 11:44, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jun 20, 2019 at 7:36 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Jun 18, 2019 at 11:47:13AM +0200, Arnd Bergmann wrote:
> > > The combination of KASAN_STACK and GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
> > > leads to much larger kernel stack usage, as seen from the warnings
> > > about functions that now exceed the 2048 byte limit:
> >
> > Is the preference that this go into v5.2 (there's not much time left),
> > or should this be v5.3? (You didn't mark it as Cc: stable?)
>
> Having it in 5.2 would be great. I had not done much build testing in the last
> months, so I didn't actually realize that your patch was merged a while ago
> rather than only in linux-next.
>
> BTW, I have now run into a small number of files that are still affected
> by a stack overflow warning from STRUCTLEAK_BYREF_ALL. I'm trying
> to come up with patches for those as well, we can probably do it in a way
> that also improves the affected drivers. I'll put you on Cc when I
> find another one.
>

There is something fundamentally wrong here, though. BYREF_ALL only
initializes variables that have their address taken, which does not
explain why the size of the stack frame should increase (since in
order to have an address in the first place, the variable must already
have a stack slot assigned)

So I suspect that BYREF_ALL is defeating some optimizations where.
e.g., the call involving the address of the variable is optimized
away, but the the initialization remains, thus forcing the variable to
be allocated in the stack frame even though the initializer is the
only thing that references it.
