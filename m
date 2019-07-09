Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D01CC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA012087F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHZpz09J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfGISqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:46:33 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37982 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfGISqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:46:33 -0400
Received: by mail-ot1-f67.google.com with SMTP id d17so20991907oth.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 11:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mPb3oFVH7SXAIMMb5SqF2LANi5F8/gGzo3aFgFykbQ0=;
        b=MHZpz09J6MD/WjV0jxLzTdV5rfe+IWSGbMi6gj9Yuz0TZKgeLc1dHH3q519x4+Y77t
         Av6vMpMGQNXS9RAK2XUBdYw/czT0Vz6SyBWPH6o4TXY/CamX8fiNrNXJThPA5U7iXwtv
         07bfjHpEeFiO6R6xDM1Mi829x6K/R1Sw1IUU71+/+TMgJKmH3Xp2P3xkpOamJ5WtDP8a
         fUh/zyRR2tc/ivQb/1N61ppfa4/bisMxjK90MCvqPudhS7d05MCj933O6IcLRTwgAQPI
         WIu7560aNuehe7ZmVjvwJDKqwxeLYxKj+5NC3JqQ5pl7D7F9fHZU0uxFy57jiKw9V0na
         22Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mPb3oFVH7SXAIMMb5SqF2LANi5F8/gGzo3aFgFykbQ0=;
        b=Q96bEXahyxsQzftrJafgcxyqITGffgMZAeF2fc5xCAA8TZlNqg2xU1GsjmW4xtYlGG
         Aa7H0HSCCT/RTc0VFTkHDE6Bm+C5NAHt8KKuSyIpne9ptJKuwwnSEU+5eOjDR/KamVQN
         fhMs0zDtQf4SZVD/hhyVd2aH2QGlQ7pJ/XZ/wkdK3rd+nkYw5eLR1JlmCFWuGIVuHL15
         2xT6HrOdlzMdFswYhxHBFg+OzfHUhS3GToUCcKKC0Zt5jvIBc5JOQ1WI6IRuVv5fyeez
         Fguz5vTSqJy2Ndsp9WrWayGEH+6WkMNV2si/XpuajtI0GGtpjC5S78lyrjrgT+YJQJLQ
         6SjQ==
X-Gm-Message-State: APjAAAW4x+9AfjI0G2w7NPv3+hMs6OfJnHst/FYVnOB5MgC/rFX5U1FG
        AZgTWfUZIvP1CwBuuGklKp7d9bxI2ydXC6BBkVxTcw==
X-Google-Smtp-Source: APXvYqz9N0T8TDLvPYLq0MtIpqlLe9Lf1wjvSwxRq+/OSRCQEutGhNJ74KM9LYWjm/x1jcXn6Mreh2OWbvNG/T+q0es=
X-Received: by 2002:a05:6830:1688:: with SMTP id k8mr21121565otr.233.1562697992105;
 Tue, 09 Jul 2019 11:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190709183612.2693974-1-arnd@arndb.de>
In-Reply-To: <20190709183612.2693974-1-arnd@arndb.de>
From:   Marco Elver <elver@google.com>
Date:   Tue, 9 Jul 2019 20:46:20 +0200
Message-ID: <CANpmjNNiygcPkXSFWGNZtOf6LC1Z_xjnim=4hH_KMDEZ9SodDg@mail.gmail.com>
Subject: Re: [PATCH] mm/kasan: fix kasan_check_read() compiler warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2019 at 20:36, Arnd Bergmann <arnd@arndb.de> wrote:
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

Thanks, this was fixed more generally in v5:
http://lkml.kernel.org/r/20190708170706.174189-1-elver@google.com

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
