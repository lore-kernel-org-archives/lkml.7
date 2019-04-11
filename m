Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B24C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B3A2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="YFR+/Rl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfDKIAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:00:00 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:36520 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfDKIAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:00:00 -0400
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x3B7xn5O000531;
        Thu, 11 Apr 2019 16:59:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x3B7xn5O000531
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554969590;
        bh=wT+gYNZ9zdUCbWMUcFqQyRo0k4Y6JKHnufjUb8FjAEk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YFR+/Rl7t0rJOjsYoT/3wRbz6Jp+iAtYM0CWEiJsJL4UQIfdyhMad47BaVL1P3HZ7
         uv7GJxsNEafjIN7tZbb7JI3iplJhkXZ/gAMahFhUWdjUjeM+wKrk6Z+grf+zWP5WYy
         AsBQnVMqSomTftNxRS/ZOkhYAFSjsL9wWhYTVEo6M05slHxv5VNA/Ayot61Q5UF4UQ
         6TW3tlHAu83NuKhJHbg60WP3XkIV/4ztoBIQbMnIgpqDshIjhFZJ9uvLH5T0TIlQdV
         Wr1ZiN3znpX/c/9j710/n0EALr0v2Z04Yx99Yn65AM7Zq6z0LHB4obxvWIw3888vOZ
         duyfDci2nra4w==
X-Nifty-SrcIP: [209.85.221.176]
Received: by mail-vk1-f176.google.com with SMTP id w140so1174053vkd.3;
        Thu, 11 Apr 2019 00:59:50 -0700 (PDT)
X-Gm-Message-State: APjAAAULusWgtpHY/+BRBverIvypGrFPgIIDH0uIxpM20edqRaA/tsNF
        rmqTwWbZcoIPJMbkAbCCFXfh+1WwCatXd6BrSRQ=
X-Google-Smtp-Source: APXvYqyq8f1ZWs11co7m1C6NOvFDLzUxkTvlQYzeGy6ZIuN9obfe8+41v+8hsHgSTjvx0ObBJIMDI0zhowk0JHpCA8s=
X-Received: by 2002:a1f:39c:: with SMTP id f28mr26765138vki.19.1554969588983;
 Thu, 11 Apr 2019 00:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190410161612.18545-1-keescook@chromium.org>
In-Reply-To: <20190410161612.18545-1-keescook@chromium.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 11 Apr 2019 16:59:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNATj3_=4pW6R7ie_EXh_X3U+JNK_6Y6NLT8XjftmezAbFA@mail.gmail.com>
Message-ID: <CAK7LNATj3_=4pW6R7ie_EXh_X3U+JNK_6Y6NLT8XjftmezAbFA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Kconfig: Refactor memory initialization hardening
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Popov <alpopov@ptsecurity.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 1:16 AM Kees Cook <keescook@chromium.org> wrote:
>
> This is a proposed alternative for the memory initialization series,
> which refactoring the existing gcc plugins into a separate Kconfig
> file and collects all the related options together with some more
> language to describe their differences. The last patch adds the
> Clang auto init option, as done by Alexander Potapenko.
>
> Since there isn't really a good way to "select" with dependencies,
> I've left out CONFIG_INIT_ALL_MEMORY for the moment...
>
> -Kees
>
> Kees Cook (3):
>   Kconfig: Create "kernel hardening" config area

I want to see "kconfig:" prefix in the subject line
only for changed in scripts/kconfig/.


>   kbuild: Move stackleak config to Kconfig.hardening

This is not a change in the build system.

>   kbuild: Implement Clang's stack initialization


I think "gcc-plugin:", "security:' or something is better for the
patch subjects, and this patch series is out of
my maintenance area.





>  Makefile                    |   5 ++
>  scripts/gcc-plugins/Kconfig | 121 +-------------------------
>  security/Kconfig            |   2 +
>  security/Kconfig.hardening  | 165 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 175 insertions(+), 118 deletions(-)
>  create mode 100644 security/Kconfig.hardening
>
> --
> 2.17.1
>


--
Best Regards
Masahiro Yamada
