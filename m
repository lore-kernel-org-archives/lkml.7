Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1339AC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31D72087F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TqfgNa9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfGISwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:52:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37390 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGISwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:52:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id g15so9906397pgi.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 11:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zm4J8N0L6YVDhgceNjwFTRje/qtdyRaa2MpVNyZc04Q=;
        b=TqfgNa9jexrjOJ6gY7s0A3tn6HxV+ZEzz7+cwfk326AguSsXA7PzEdvnt7bJqMSReI
         R5JrO62B6b7M7yK/xWNTmryCGtU50i3KXJ5y6fZQTTeSBC5AHZrUwEUcwJt6BnBJpKaA
         3Y5w/wdmDZn16MhFHyI4tbNPqO47vZSvrVDietwwzO9BJIIvzZiLi+QQqsM8H1wVSVIc
         zO4pDu0GVLIP6esKnNIrmoCIyRreebxSS79Ubof8J55S/OIa+lUxu7wy9+nFgZ179ywn
         38PsRvHbIPE1mbb160DHNhrc7QIYaIdU8+nsAAn1wVaPLqb5YKNNaZdnPR9/vaMZuorq
         WjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zm4J8N0L6YVDhgceNjwFTRje/qtdyRaa2MpVNyZc04Q=;
        b=ck2qLondVq4YWhVsb9yvBNcd0XMMOCM47n1tydQzxp4CRdrfod+3+jrI//JvgjaZ8X
         whXrlRfMMQ6bshLPzZLakAe45lbdEvSH76PtAeNFxXdZPxUuP5jMfJ8570SSy6JZOhyi
         75P0Chrw70KB2eygCU/xQqzGAfPeXYPF1IZx/enozH5gO1oWVzhOL6zXzMXiQbIlKAao
         xkxdoOAHLZxA6R541LHafHm3uGRGVuhhOhB3N+phpCrFVGtbON6LJYkPnpy/ghs82QaL
         rlU3WxVKBuo6ZOxQMcj+H5ScPlv21A//YcMQ4L7haKujVrCAfQUmqB93hf5wVI1jTjKq
         /54A==
X-Gm-Message-State: APjAAAVxLvFN0Ey5Ez4aA4VUnZm9bPS8Nvl+YKQ7Gj2PWTMLH9hkfM2z
        r/RN0cajIRvLzIpqUaAyRP06rt6fwIokvd3IgCCkPg==
X-Google-Smtp-Source: APXvYqwLUAm0MIc/3LKshcO9RnPHauY8Uingo7dGWc4NTLBaNUm5/Rsx/g0/NjNJpxe8lGOed/f36WJAifhjq2t4YoE=
X-Received: by 2002:a17:90a:2488:: with SMTP id i8mr1641346pje.123.1562698320036;
 Tue, 09 Jul 2019 11:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190709183612.2693974-1-arnd@arndb.de>
In-Reply-To: <20190709183612.2693974-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 9 Jul 2019 11:51:48 -0700
Message-ID: <CAKwvOdmFpkQDW_Y2y6FqVUdb-Eu5Qqxd-r=B=6GQqg5MGsTpAw@mail.gmail.com>
Subject: Re: [PATCH] mm/kasan: fix kasan_check_read() compiler warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 11:36 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The kasan_check_read() is marked 'inline', which usually includes
> the 'always_inline' attribute. In some configuration, gcc decides that
> it cannot inline this, causing a build failure:
>
> In file included from include/linux/compiler.h:257,
>                  from arch/x86/include/asm/current.h:5,
>                  from include/linux/sched.h:12,
>                  from include/linux/ratelimit.h:6,
>                  from fs/dcache.c:18:
> include/linux/compiler.h: In function 'read_word_at_a_time':
> include/linux/kasan-checks.h:31:20: error: inlining failed in call to always_inline 'kasan_check_read': function attribute mismatch

Sounds like the error `function attribute mismatch` is saying:
kasan_check_read has one set of function attributes, but the call site
read_word_at_a_time has different function attributes, so I wont
inline kasan_check_read into read_word_at_a_time.
__no_kasan_or_inline changes based on CONFIG_KASAN; was this from a
kasan build or not?

>  static inline bool kasan_check_read(const volatile void *p, unsigned int size)
>                     ^~~~~~~~~~~~~~~~
> In file included from arch/x86/include/asm/current.h:5,
>                  from include/linux/sched.h:12,
>                  from include/linux/ratelimit.h:6,
>                  from fs/dcache.c:18:
> include/linux/compiler.h:280:2: note: called from here
>   kasan_check_read(addr, 1);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> While I have no idea why it does this, but changing the call to the
> internal __kasan_check_read() fixes the issue.
>
> Fixes: dc55b51f312c ("mm/kasan: introduce __kasan_check_{read,write}")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/compiler.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index f0fd5636fddb..22909500ba1d 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -277,7 +277,7 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
>  static __no_kasan_or_inline
>  unsigned long read_word_at_a_time(const void *addr)
>  {
> -       kasan_check_read(addr, 1);
> +       __kasan_check_read(addr, 1);
>         return *(unsigned long *)addr;
>  }
>
> --
> 2.20.0
>


-- 
Thanks,
~Nick Desaulniers
