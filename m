Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B822CC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7391C206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5V6TDvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfDLLgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:36:25 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:40723 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfDLLgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:36:24 -0400
Received: by mail-vk1-f194.google.com with SMTP id l17so2074496vke.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 04:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cGZZ4BuYydyibp4+F7cQcUxUprpuCPDg3YV5UtmfK3Q=;
        b=W5V6TDvWfTA98iTJDUS9B+Lye3NfD+qqaZ7C+4KDq/wUxNXjzVUOAxN3q5lOVm5FEI
         kSgCEyIv62qpAx99tKqBIWv1WZzeejMvB/rWWXSl0VeevNUFS0boXuF2o4CNsxKsMH8F
         Xvy4rpV3h2hVYpfYQEmj6kq4KvLBvBRnN3J2W70rnuyDGWObr59cURT4OOyhsmEgaY9g
         hR0e/q1JrGDTUMon/5KLePl6qbkxEEoWi1q26P4KcIk8KJyIz3vGpOzAdNKtu9rLkkIS
         WSqq7Oe1ch0WzUD2EZrXH6srAiOT7xmC010z181+nfKWlHNC/hEGIo3iwnLpy5ObOWnx
         Oz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cGZZ4BuYydyibp4+F7cQcUxUprpuCPDg3YV5UtmfK3Q=;
        b=ANpxN4wiYpQJ9dn50hQ5Eqt2NUl/Y3fiLWUckbA/D94Ko0HsisOmUjcwwd7De0V7NP
         8dqeybUqWqYoCvFLhqg4DQIf0qbSH265+R/ELhWTBwQTt6dWbX3wYMNl+ImmUPdG8Sqr
         QOi1QlcW/+10P0gD6qQOif+HANCV2IrcTf5ppgtokq41JEBujJFslZt8wx1Fz1jIxu5I
         HTt0tdEy7LVpSQ75zbWKD2EnQn0I/7/s4JV40/BarEJCMc1GUq5h4rB9AMfgU0wk3ld+
         VLSyo1y0aclG99Y8lcNW8ZjAWsp82+PfQO+X9xMIzKcob6FuF6sYcvilg2wnaxmlrMj8
         or7A==
X-Gm-Message-State: APjAAAXmD6YYmKCFS1LoPqDTlqGDGyGMKR7YlG+f/k97PPy/K5YBFahs
        leGAzaPAytx+hr+sbXKVB2Jc0TV7r75KTOGPpWww6A==
X-Google-Smtp-Source: APXvYqxVuFm8+GuVTJZhqK5OB/d/md10shGu3xv6XGzvzIhzVGjme+OIXyOVUI3sdzYA/Td6zlFTF2sZmKzTWCCIIHY=
X-Received: by 2002:a1f:bf4b:: with SMTP id p72mr30997977vkf.77.1555068983154;
 Fri, 12 Apr 2019 04:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190411180117.27704-1-keescook@chromium.org> <20190411180117.27704-4-keescook@chromium.org>
In-Reply-To: <20190411180117.27704-4-keescook@chromium.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 12 Apr 2019 13:36:12 +0200
Message-ID: <CAG_fn=VqXUTF+rLPcGNR8=kmNFdSAqmMKb9r9=SkoDcg7RrKnQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] security: Implement Clang's stack initialization
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
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
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 8:01 PM Kees Cook <keescook@chromium.org> wrote:
>
> CONFIG_INIT_STACK_ALL turns on stack initialization based on
> -ftrivial-auto-var-init in Clang builds, which has greater coverage
> than CONFIG_GCC_PLUGINS_STRUCTLEAK_BYREF_ALL.
>
> -ftrivial-auto-var-init Clang option provides trivial initializers for
> uninitialized local variables, variable fields and padding.
>
> It has three possible values:
>   pattern - uninitialized locals are filled with a fixed pattern
>     (mostly 0xAA on 64-bit platforms, see https://reviews.llvm.org/D54604
>     for more details, but 0x000000AA for 32-bit pointers) likely to cause
>     crashes when uninitialized value is used;
>   zero (it's still debated whether this flag makes it to the official
>     Clang release) - uninitialized locals are filled with zeroes;
>   uninitialized (default) - uninitialized locals are left intact.
>
> This patch uses only the "pattern" mode when CONFIG_INIT_STACK_ALL is
> enabled.
>
> Developers have the possibility to opt-out of this feature on a
> per-variable basis by using __attribute__((uninitialized)), but such
> use should be well justified in comments.
>
> Co-developed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
Tested-by: Alexander Potapenko <glider@google.com>
> ---
>  Makefile                   |  5 +++++
>  security/Kconfig.hardening | 15 ++++++++++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index c0a34064c574..a7d9c6cd0267 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -745,6 +745,11 @@ KBUILD_CFLAGS      +=3D -fomit-frame-pointer
>  endif
>  endif
>
> +# Initialize all stack variables with a pattern, if desired.
> +ifdef CONFIG_INIT_STACK_ALL
> +KBUILD_CFLAGS  +=3D -ftrivial-auto-var-init=3Dpattern
> +endif
> +
>  DEBUG_CFLAGS   :=3D $(call cc-option, -fno-var-tracking-assignments)
>
>  ifdef CONFIG_DEBUG_INFO
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index 3dd7a28c3822..5dd61770d3f0 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -18,9 +18,12 @@ config GCC_PLUGIN_STRUCTLEAK
>
>  menu "Memory initialization"
>
> +config CC_HAS_AUTO_VAR_INIT
> +       def_bool $(cc-option,-ftrivial-auto-var-init=3Dpattern)
> +
>  choice
>         prompt "Initialize kernel stack variables at function entry"
> -       depends on GCC_PLUGINS
> +       depends on CC_HAS_AUTO_VAR_INIT || GCC_PLUGINS
>         default INIT_STACK_NONE
>         help
>           This option enables initialization of stack variables at
> @@ -76,6 +79,16 @@ choice
>                   of uninitialized stack variable exploits and informatio=
n
>                   exposures.
>
> +       config INIT_STACK_ALL
> +               bool "0xAA-init everything on the stack (strongest)"
> +               depends on CC_HAS_AUTO_VAR_INIT
> +               help
> +                 Initializes everything on the stack with a 0xAA
> +                 pattern. This is intended to eliminate all classes
> +                 of uninitialized stack variable exploits and informatio=
n
> +                 exposures, even variables that were warned to have been
> +                 left uninitialized.
> +
>  endchoice
>
>  config GCC_PLUGIN_STRUCTLEAK_VERBOSE
> --
> 2.17.1
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
