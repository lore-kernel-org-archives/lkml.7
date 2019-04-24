Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11CBC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A43E218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 04:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Is9CTZxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfDXEHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 00:07:54 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:25669 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfDXEHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 00:07:53 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x3O47PRq031718;
        Wed, 24 Apr 2019 13:07:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x3O47PRq031718
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556078846;
        bh=3UDMqsndkmYz6XKGaN/fOzp7asY1sqsPmCYMIZ/pthA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Is9CTZxD+gWJS63291bVcYMxueP92S2R+nM3D7Xvbpq+dFAxMvUDbnz0jJKhPVIUZ
         bg9CFT8J0+B4wI5Y1YIetEqbDi+moH7sTW7yp68bmmNUSwOeTVD5cWv/b3IzG6nppx
         aeL+EQ6VCA+mtlbiEFO4bjPdh88INSqW4vVC8q3l0r52hMA+gCZBan91J/wynZ6y5/
         QyhYTTGKi7dsZ9eqri+I4j2EmnGr3RNgxguGet2dzi5aQoWgU2bWVfMISnFwkHN2tH
         U021iLIGB4hcXqjpFvywv+81RuQfzJf3vzRb/gPJqz6J6JwaLC1ehi3L55FcT6PtXg
         wU11win38vfDQ==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id b8so5563144uaq.7;
        Tue, 23 Apr 2019 21:07:26 -0700 (PDT)
X-Gm-Message-State: APjAAAWZviEF0EgvIFpRBuEalk/s+5oExhxXFezBWGXUqaPTYaVPsQiF
        ySZXH8y/eyOGN/iDwNipnNpIp7QUjd5djFkcmfQ=
X-Google-Smtp-Source: APXvYqxgPwzJ+rl5//wdR14yMfFng195Q9GeRnEE/SVrL9urTnkk9YzOB805qCg362+Zpwg+j81l4vbvuIxDqTOaXak=
X-Received: by 2002:ab0:7493:: with SMTP id n19mr1764615uap.121.1556078845150;
 Tue, 23 Apr 2019 21:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190423194925.32151-1-keescook@chromium.org>
In-Reply-To: <20190423194925.32151-1-keescook@chromium.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 24 Apr 2019 13:06:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNARuX8XfO=YRX9dYpipyBTCtMbQqLJfuk6iMLfLdZe1-KQ@mail.gmail.com>
Message-ID: <CAK7LNARuX8XfO=YRX9dYpipyBTCtMbQqLJfuk6iMLfLdZe1-KQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Refactor memory initialization hardening
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Potapenko <glider@google.com>,
        James Morris <jmorris@namei.org>,
        Alexander Popov <alex.popov@linux.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 4:49 AM Kees Cook <keescook@chromium.org> wrote:
>
> This refactors the stack memory initialization configs in order to
> keep things together when adding Clang stack initialization, and in
> preparation for future heap memory initialization configs.
>
> I intend to carry this in the gcc-plugins tree, but I'd really like
> to get Acks from Masahiro (Kconfig changes, Makefile change), and
> from James (adding the new Kconfig.hardening to security/Kconfig).

If needed,
Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


> Thanks!
>
> -Kees
>
> v3:
> - clean up menu/if with a merged "depends on" (masahiro)
> - add CONFIG_COMPILE_TEST defaults (masahiro)
>
> v2:
> - add plugin menu (masahiro)
> - adjust patch subject prefixes (masahiro)
> - drop redundent "depends" (masahiro)
> - fixed early use of CC_HAS_AUTO_VAR_INIT (masahiro)
> - dropped default-enabled for STACK_INIT_ALL (masahiro)
>
>
> Kees Cook (3):
>   security: Create "kernel hardening" config area
>   security: Move stackleak config to Kconfig.hardening
>   security: Implement Clang's stack initialization
>
>  Makefile                    |   5 ++
>  scripts/gcc-plugins/Kconfig | 126 ++-------------------------
>  security/Kconfig            |   2 +
>  security/Kconfig.hardening  | 164 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 177 insertions(+), 120 deletions(-)
>  create mode 100644 security/Kconfig.hardening
>
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
