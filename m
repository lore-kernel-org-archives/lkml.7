Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D15C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29264208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfFUO3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:29:23 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37436 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfFUO3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:29:23 -0400
Received: by mail-qk1-f194.google.com with SMTP id d15so4548518qkl.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 07:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CWdNZb0wE4dC/rZhIJMb29V7hyTgCCOlQoVKnFRbUj0=;
        b=nkMnHCjfURsPXVcgUtD+UirSpuT7GDUOAQgTeRoDdGLqrVPkjzN9RVFchYIxjZGM56
         kUrEQ2GAhysChIh7eQmt5mKWpkwHeNpwhFoNYguL4wmtSvuzKo2mSH88p5jpaLYvkSl0
         bBjOQ4gyEbEHFzZzrdgeVpEiTxfbc6po73NeSBHsl5uKFERrbBlggQxfkOgTniaSEUtN
         7i4vBEvfEFsne3q5drLPVf135uOdFvtARpoRlsDIaz7dCNNYd1KipEXYhXwpuNtdi6i2
         2gchklkvoN8U9xRH1+cEcmOEuy9hJwod6I4ENB80sEmfdJsOjsZrfM687QWEhOFW+irv
         uqKg==
X-Gm-Message-State: APjAAAUYmAQBvRhGOnAcnwWDmB/G/aguQnbXCn4WXgvFvnUEsrr6lKn5
        oUEBBfiS/tjn0H+mFIoD9ZLTRf9TlmHCu+GRvB4KqKJyr8Q=
X-Google-Smtp-Source: APXvYqyzjrAMQA3W4bZICWFmeXwvEIIWgiICGlLPuf95yft8XRA2MUyiCXRRzjyQw81tt2dy1tLs7bespMYm0ShFBWs=
X-Received: by 2002:a05:620a:12db:: with SMTP id e27mr99441567qkl.352.1561127362445;
 Fri, 21 Jun 2019 07:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9pyf1AmjWOFFdJFXV9-OBv-ChpKZ130733+x=BtjF62mA@mail.gmail.com>
 <20190620141159.15965-1-Jason@zx2c4.com>
In-Reply-To: <20190620141159.15965-1-Jason@zx2c4.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 21 Jun 2019 16:29:06 +0200
Message-ID: <CAK8P3a14=isYJFZYZ5BGGPQY0eLCA7zswHTt=F7Yd4kN-8EtrA@mail.gmail.com>
Subject: Re: [PATCH 1/3] timekeeping: add missing non-_ns functions for fast accessors
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 4:12 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Previously there was no analogue to get proper ktime_t versions of the
> fast variety of ktime invocations. This commit makes the interface
> uniform with the other accessors.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>

Consistent is good, not sure if there is a real use for the *_fast()
functions returning a ktime_t, but I don't mind adding them.

> +.. c:function:: ktime_t ktime_get_mono_fast_ns( void )
> +               ktime_t ktime_get_raw_fast_ns( void )
> +               ktime_t ktime_get_boottime_fast_ns( void )
> +               ktime_t ktime_get_real_fast_ns( void )
> +
>  .. c:function:: u64 ktime_get_mono_fast_ns( void )
>                 u64 ktime_get_raw_fast_ns( void )
>                 u64 ktime_get_boot_fast_ns( void )

Typo: you have the same function names listed twice here,
one of them should be ktime_get_mono_fast() instead of
ktime_get_mono_fast_ns().

Also, we might want to rename ktime_get_boot_fast_ns()
to ktime_get_boottime_fast_ns in the process. It seems there
is only a single caller.

      Arnd
