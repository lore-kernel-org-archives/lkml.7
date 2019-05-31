Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8194EC04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5744026B5B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 15:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nXGiYMKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfEaPMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 11:12:16 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44672 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfEaPMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 11:12:16 -0400
Received: by mail-oi1-f193.google.com with SMTP id e189so1228434oib.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 08:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Qecf3R/ylaKOMr7DmXC4K+hYJVpsjs/jTI03UY5jdQ=;
        b=nXGiYMKOLA7YGgplBCRIJzpPWLDIZmGlt9K/TwWZDoSmIE/xQoxoZfIXKz4vHURMoI
         rFjo5oJuFv90ZQpZy3iSNNRnvbwKqzrNOjUdM8MNHpP0eyrAEsLzQZFxd91a4t0d7szi
         7b2+8Hk3lvVFDPLYe3C6Lt4GXeBISmr+cs40tDKOsMU893Q4nDV6nDyx87nsOvsgrQ9V
         dT4HOBylvnvTVmlbms02uM9BzQvQi0k20BIF+ujGx31brk+Y2rsuPdrauCAV5FdqxiJ2
         8FCKq83x/1gThxBVLdDMSuRRQC6vxWyrz+OcdkOjkNiDLZXADVqgAd5kfmIXdOtPqvuY
         CMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Qecf3R/ylaKOMr7DmXC4K+hYJVpsjs/jTI03UY5jdQ=;
        b=Nekz+vIuMyWr1soRr6jjJ1FoeCUIT4TOkdE/gKQ1HrkOf4jXmus28FP7slRRVo0Bkc
         lUTBVM2rgdDRSkRZLaZABdwd5VMwox4RgFb2U0yp0x+7K18jsoQNN5twbN7EFoeGvuPq
         qpq86mAwp9wqZoC6/JUtuQGQWEUx2jG7+9TB21KxfvS/l9HpRVx/aiiW51y5GhW9MYMe
         1owiGSD/n0PNf0K3sQkWqs8/8qjpuDICDbHJldm2u9Md25bby6ADeJFHXA3cdfJo5na6
         Q8jHVdaEgZxvHphZb/80NflrEDVJWOh3hrrwbWJ7+tATik1cEFm1Nq/Zygg82uUq4M+w
         sDSw==
X-Gm-Message-State: APjAAAWpkriX7yNBfaSVHKuof4d4ZS/MFFXsbcF597iRkeYlJXng/Yso
        2H++SOsHcL2P1kJ77vgSUDS8hQlr6DhXTY4IqiFMsg==
X-Google-Smtp-Source: APXvYqz2u/BFQpedb+wPDZ0V+HO0iENm7b7iW0qYSXm5W7S4qdLUCWpDFuo2g4YKBqRxd03ZFgRnvyjAy0IrgDzGoZs=
X-Received: by 2002:aca:e044:: with SMTP id x65mr6446367oig.70.1559315535037;
 Fri, 31 May 2019 08:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190529141500.193390-1-elver@google.com>
In-Reply-To: <20190529141500.193390-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 31 May 2019 17:12:03 +0200
Message-ID: <CANpmjNNH2e5YpxKymXE0sTgcrrW0z0EP+dEsPJOfTQJ19yS_Yg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Bitops instrumentation for KASAN
To:     Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addressed comments, and sent v3:
http://lkml.kernel.org/r/20190531150828.157832-1-elver@google.com

Many thanks!

-- Marco

On Wed, 29 May 2019 at 16:23, Marco Elver <elver@google.com> wrote:
>
> The previous version of this patch series and discussion can be found
> here:  https://lkml.org/lkml/2019/5/28/769
>
> The most significant change is the change of the instrumented access
> size to cover the entire word of a bit.
>
> Marco Elver (3):
>   lib/test_kasan: Add bitops tests
>   x86: Move CPU feature test out of uaccess region
>   asm-generic, x86: Add bitops instrumentation for KASAN
>
>  Documentation/core-api/kernel-api.rst     |   2 +-
>  arch/x86/ia32/ia32_signal.c               |   9 +-
>  arch/x86/include/asm/bitops.h             | 210 ++++----------
>  include/asm-generic/bitops-instrumented.h | 317 ++++++++++++++++++++++
>  lib/test_kasan.c                          |  75 ++++-
>  5 files changed, 450 insertions(+), 163 deletions(-)
>  create mode 100644 include/asm-generic/bitops-instrumented.h
>
> --
> 2.22.0.rc1.257.g3120a18244-goog
>
