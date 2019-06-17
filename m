Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CABC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97072089E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 22:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvhSsFe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfFQWgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 18:36:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43601 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfFQWgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 18:36:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id cl9so4769813plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 15:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jdPOeSR0Djd1OnJVTCbTPPRB0AwFbffNcyIU9XNlUrI=;
        b=FvhSsFe0xJQ6kkNZED5XOWFPTr+5IIUSXOWSREhWeRO0F48d81LQ8TTYnGcPBXDvwF
         rYV3zplOT0xAd+7DVtHF16M2D6+csR5oXsaXVBOzFqE8yQIkh++z6eboFnElJFXoMq1m
         X4Y4mNJW+Ai5wy4/JE+mzwXHflc3Nn09x4Bqjcdeq7EXvdqRMkQxp4LbJ+2yzLQ60tLI
         oFuC0BnD6KkH0w84v/jAN/ELhWiTBD7YnstocUq/IOWTE9dm8P0Wl3y3brBWzIEipQ+Z
         UJXSPWu3w/Kft0QNl59+twLoJHubqrEmg5Z8QhbrePuorJ6vpo5oEKk1Rrdf1iq+/+5n
         FeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdPOeSR0Djd1OnJVTCbTPPRB0AwFbffNcyIU9XNlUrI=;
        b=Xy7EeEuv7HcY5gL6t49rw+Qt/60wx7VXEBlOip5moOhd05tBbS13QO4eBV2Z6HFznr
         K6kDbSf523L8j2GaDGMAVfK4LIAbCKKTXxQOym4zwpxDC4V4JmksgNsWHyQLW2H0e/kp
         l33L0kDUYz+oHxHIhoxShz3jJGPfJoTyzWysiadPeKel6/fnS2MHV6FGftQ21uj7lIHh
         RzCwfbZ9QzWblBN3dtgwBCcDP0GSHpK07IiQW7zZQIL17bGcns4z0rJJbjeECTybLDGC
         tAj3tdNz7hMoQQexW8jHDo/0Xpaw4i2PI3gCw1QQKAUyTNbh1l0kHoNc9O2oDT2ADAvV
         /H5w==
X-Gm-Message-State: APjAAAXUuabeG0kRSpS+o/DL3VGRVTXeJpzOlgWEdd7TBzbiizr1r7FN
        lJHVhzPRdOk2uhQWs8QQ/gcxQ8+/8318lGOghZy7ug==
X-Google-Smtp-Source: APXvYqyIDfYRgcl0TzgvphcVwpNSKrCUQNyUrhxHdebAHU6PpFtHnmbpQ4raVuEfYLlFhJaCw6WhbN8sqI4ojiHbmo8=
X-Received: by 2002:a17:902:b696:: with SMTP id c22mr105753228pls.119.1560810966818;
 Mon, 17 Jun 2019 15:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190617222034.10799-1-linux@rasmusvillemoes.dk> <20190617222034.10799-8-linux@rasmusvillemoes.dk>
In-Reply-To: <20190617222034.10799-8-linux@rasmusvillemoes.dk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 17 Jun 2019 15:35:55 -0700
Message-ID: <CAKwvOdn5fhCTqtciKBwAj3vYQMhi06annzxcdC1GjKxri=dHnw@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] dynamic_debug: add asm-generic implementation for DYNAMIC_DEBUG_RELATIVE_POINTERS
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 3:20 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> A 64 bit architecture can allow reducing the size of the kernel image by
> selecting HAVE_DYNAMIC_DEBUG_RELATIVE_POINTERS, but it must provide
> a proper DEFINE_DYNAMIC_DEBUG_METADATA macro for emitting the struct
> _ddebug in assembly. However, since that does not involve any
> instructions, this generic implementation should be usable by most if
> not all.
>
> It relies on
>
> (1) standard assembly directives that should work on
> all architectures
> (2) the "i" constraint for an constant, and
> (3) %cN emitting the constant operand N without punctuation
>
> and of course the layout of _ddebug being what one expects.
>
> Now, clang before 9.0 doesn't satisfy (3) for non-x86 targets.

Thanks so much for resending with this case fixed, and sorry I did not
implement (3) sooner!  I appreciate your patience.
Acked-by: Nick Desaulniers <ndesaulniers@google.com>

I'm happy to help test this series, do you have a tree I could pull
these from quickly?  Anything I should test at runtime besides a boot
test?
-- 
Thanks,
~Nick Desaulniers
