Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61377C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246B92075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="sqtrARbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388257AbfDDJRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:17:40 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:39207 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387796AbfDDJRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:17:36 -0400
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x349HEVv031586;
        Thu, 4 Apr 2019 18:17:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x349HEVv031586
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554369435;
        bh=4AArR6OEAV3ngV28h03ktSMtH+bfNdpbm3AseJvA2aA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sqtrARbT2rGJe7/Qq7erWhBFExxSHyUVh46LgqRSOh3klpa2rf+f+0vX8c3y51qNK
         SmBf0yqTyZnbI8xzioudrD8UVTNmEe13It+g3tLxrDoqwdVhqbRqDkGzqRuv8SQyG4
         gjROzSvVoqROM60uoGEhdmHI9g9VB3bY4cTErDyNZNZFcXBjY0TWO34i9hOGmL/knX
         my/gDOfMrbKHBDXkAcsHUnBVsfuNriU5ggWU1nBipg0oMXUawajVeg99EiqTabqdUi
         B50wff9kBFnYnRwqMSBmvHJIBR1Le2KDNRxlIsHfjgI9qshpxfm4fddgf93MfRRKT4
         ZBYypUdkYdCAA==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id d8so936916vsp.2;
        Thu, 04 Apr 2019 02:17:14 -0700 (PDT)
X-Gm-Message-State: APjAAAUTBf0n9MDeKNC/7++mgl8LUrzm5hrSYuQ01buCjMcBV7lPPi3L
        otHvd5TbD74U/aJKc46jV9hd0/GpWJY0mkfLsqY=
X-Google-Smtp-Source: APXvYqxxjrxhGCKEzHV2OX/sY332pADINIb8zk9rvqugHKqRv2hYjW/sinuR7RwKKAIb6kB7qw+wj7BnJ/qy/zMmfZk=
X-Received: by 2002:a67:fbcc:: with SMTP id o12mr3499643vsr.60.1554369433574;
 Thu, 04 Apr 2019 02:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190404084619.236418459@linuxfoundation.org> <20190404084621.593150895@linuxfoundation.org>
In-Reply-To: <20190404084621.593150895@linuxfoundation.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 4 Apr 2019 18:16:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS5qfvnZEGKVQpqdQz3EOj88bd4qLc4bqcUDMhSVpJQmw@mail.gmail.com>
Message-ID: <CAK7LNAS5qfvnZEGKVQpqdQz3EOj88bd4qLc4bqcUDMhSVpJQmw@mail.gmail.com>
Subject: Re: [PATCH 5.0 070/246] kbuild: make -r/-R effective in top Makefile
 for old Make versions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.


On Thu, Apr 4, 2019 at 6:11 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 5.0-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> [ Upstream commit 3812b8c5c5d527239ac015f1f2c7654da7fcfbba ]


Some people complaint about this commit.

If you backport this,
could you please backport the following two as well?

2b50f7ab63685cd247e32ad321f7338ed130d3d5
688931a5ad4e55ba0c215248ba510cd67bc3afb4


Thanks.
Masahiro Yamada






> Adding -rR to MAKEFLAGS is important because we do not want to
> be bothered by built-in implicit rules or variables.
>
> One problem that used to exist in older GNU Make versions is
>
>   MAKEFLAGS += -rR
>
> ... does not become effective in the current Makefile. When you are
> building with O= option, it becomes effective in the top Makefile
> since it recurses via 'sub-make' target. Otherwise, the top Makefile
> tries implicit rules. That is why we explicitly add empty rules for
> Makefiles, but we often miss to do that.
>
> In fact, adding -d option to older GNU Make versions shows it is
> trying a bunch of implicit pattern rules.
>
>  Considering target file `scripts/Makefile.kcov'.
>   Looking for an implicit rule for `scripts/Makefile.kcov'.
>   Trying pattern rule with stem `Makefile.kcov'.
>   Trying implicit prerequisite `scripts/Makefile.kcov.o'.
>   Trying pattern rule with stem `Makefile.kcov'.
>   Trying implicit prerequisite `scripts/Makefile.kcov.c'.
>   Trying pattern rule with stem `Makefile.kcov'.
>   Trying implicit prerequisite `scripts/Makefile.kcov.cc'.
>   Trying pattern rule with stem `Makefile.kcov'.
>   Trying implicit prerequisite `scripts/Makefile.kcov.C'.
>   ...
>
> This issue was fixed by GNU Make commit 58dae243526b ("[Savannah #20501]
> Handle adding -r/-R to MAKEFLAGS in the makefile"). So, it is no longer
> a problem if you use GNU Make 4.0 or later. However, older versions are
> still widely used.
>
> So, I decided to patch the kernel Makefile to invoke sub-make regardless
> of O= option. This will allow further cleanups.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  Makefile | 48 ++++++++++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 22 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 6d542aede778..1bc6749f5254 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -15,19 +15,6 @@ NAME = Shy Crocodile
>  PHONY := _all
>  _all:
>
> -# Do not use make's built-in rules and variables
> -# (this increases performance and avoids hard-to-debug behaviour)
> -MAKEFLAGS += -rR
> -
> -# Avoid funny character set dependencies
> -unexport LC_ALL
> -LC_COLLATE=C
> -LC_NUMERIC=C
> -export LC_COLLATE LC_NUMERIC
> -
> -# Avoid interference with shell env settings
> -unexport GREP_OPTIONS
> -
>  # We are using a recursive build, so we need to do a little thinking
>  # to get the ordering right.
>  #
> @@ -44,6 +31,21 @@ unexport GREP_OPTIONS
>  # descending is started. They are now explicitly listed as the
>  # prepare rule.
>
> +ifneq ($(sub-make-done),1)
> +
> +# Do not use make's built-in rules and variables
> +# (this increases performance and avoids hard-to-debug behaviour)
> +MAKEFLAGS += -rR
> +
> +# Avoid funny character set dependencies
> +unexport LC_ALL
> +LC_COLLATE=C
> +LC_NUMERIC=C
> +export LC_COLLATE LC_NUMERIC
> +
> +# Avoid interference with shell env settings
> +unexport GREP_OPTIONS
> +
>  # Beautify output
>  # ---------------------------------------------------------------------------
>  #
> @@ -112,7 +114,6 @@ export quiet Q KBUILD_VERBOSE
>
>  # KBUILD_SRC is not intended to be used by the regular user (for now),
>  # it is set on invocation of make with KBUILD_OUTPUT or O= specified.
> -ifeq ($(KBUILD_SRC),)
>
>  # OK, Make called in directory where kernel src resides
>  # Do we want to locate output files in a separate directory?
> @@ -142,6 +143,13 @@ $(if $(KBUILD_OUTPUT),, \
>  # 'sub-make' below.
>  MAKEFLAGS += --include-dir=$(CURDIR)
>
> +else
> +
> +# Do not print "Entering directory ..." at all for in-tree build.
> +MAKEFLAGS += --no-print-directory
> +
> +endif # ifneq ($(KBUILD_OUTPUT),)
> +
>  PHONY += $(MAKECMDGOALS) sub-make
>
>  $(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: sub-make
> @@ -149,16 +157,12 @@ $(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: sub-make
>
>  # Invoke a second make in the output directory, passing relevant variables
>  sub-make:
> -       $(Q)$(MAKE) -C $(KBUILD_OUTPUT) KBUILD_SRC=$(CURDIR) \
> +       $(Q)$(MAKE) sub-make-done=1 \
> +       $(if $(KBUILD_OUTPUT),-C $(KBUILD_OUTPUT) KBUILD_SRC=$(CURDIR)) \
>         -f $(CURDIR)/Makefile $(filter-out _all sub-make,$(MAKECMDGOALS))
>
> -# Leave processing to above invocation of make
> -skip-makefile := 1
> -endif # ifneq ($(KBUILD_OUTPUT),)
> -endif # ifeq ($(KBUILD_SRC),)
> -
> +else # sub-make-done
>  # We process the rest of the Makefile if this is the final invocation of make
> -ifeq ($(skip-makefile),)
>
>  # Do not print "Entering directory ...",
>  # but we want to display it when entering to the output directory
> @@ -1759,7 +1763,7 @@ $(cmd_files): ;   # Do not try to update included dependency files
>
>  endif   # ifeq ($(config-targets),1)
>  endif   # ifeq ($(mixed-targets),1)
> -endif  # skip-makefile
> +endif   # sub-make-done
>
>  PHONY += FORCE
>  FORCE:
> --
> 2.19.1
>
>
>


-- 
Best Regards
Masahiro Yamada
