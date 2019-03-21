Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41AEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A44B20835
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XznYnbcy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfCUBRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:17:53 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:51084 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCUBRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:17:52 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x2L1HTbR020993;
        Thu, 21 Mar 2019 10:17:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x2L1HTbR020993
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553131050;
        bh=LTWDhopzxxu9JE5HWBxBqn2mciGGYRbeaZCMrsGnQBA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XznYnbcyWiKN3tNNghDdrNKKFPLu2Bgvns1fAp9qIlpzFxzFeC5VYbKWHR4HAcFAQ
         Cgfpsgdmcq1uLbIgmLNGioQPOFVCQJxUy0JEFnyMsmO97nRlZbk6/X2QITvFr4uVPX
         px4WxSXxIPoW07jiTRbCiUxiCw1PZWWuBqTZMRk4KbE7y3NmsPEU8MD3X6r3QwBWWR
         7eaV7PXreRr1RQcLW59jo1+m5lpruIJnS5/pGroHxlgmwElArd7n6mDhI6sqr1QVD/
         3My2gMghzmymWX5DPZO9YeSznrdJt1XHCoHYf212ifrtD9DvXB8K+v55RZEIlLnFRf
         igD3wQazkqk4g==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id w13so2751325vsc.4;
        Wed, 20 Mar 2019 18:17:30 -0700 (PDT)
X-Gm-Message-State: APjAAAXT5BxFzLNZXpXdaEk+le6j/4n9h9ESRIIdoa832N7OhEXDUktu
        qAngxGBPHVlxNCoOVmPTExTAIjgKPJ+LHktr/K4=
X-Google-Smtp-Source: APXvYqx23ZXhJ/HIFU+r1cmiNyDKlaajt7HnbHlEbWk6DCosu4z4osMLVTDE/ouw3/aTVUnrIacMi689MfXX7s/ByG8=
X-Received: by 2002:a67:7a43:: with SMTP id v64mr456996vsc.54.1553131049161;
 Wed, 20 Mar 2019 18:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <1552968156-3920-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1552968156-3920-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 21 Mar 2019 10:16:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNARuyLG52m1oe_2MeuoThR4qur9HgE3ZCz4=jyuvrqew+g@mail.gmail.com>
Message-ID: <CAK7LNARuyLG52m1oe_2MeuoThR4qur9HgE3ZCz4=jyuvrqew+g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: skip sub-make for in-tree build with GNU Make 4.x
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Andreas Schwab <schwab@suse.de>,
        David Howells <dhowells@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 1:03 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Commit 2b50f7ab6368 ("kbuild: add workaround for Debian make-kpkg")
> annoyed people who want to wrap the top Makefile with GNUmakefile
> or something in order to customize it for their use.
>
> On second thought, we do not need to run the sub-make for in-tree
> build with Make 4.x because the 'MAKEFLAGS += -rR' issue only happens
> on GNU Make 3.x.
>
> With this commit, people will get back the workflow, and the Debian
> make-kpkg will still work.
>
> Fixes: 2b50f7ab6368 ("kbuild: add workaround for Debian make-kpkg")
> Reported-by: Andreas Schwab <schwab@suse.de>
> Reported-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild/fixes.


>
>  Makefile | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 99c0530..d9591f2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -31,26 +31,12 @@ _all:
>  # descending is started. They are now explicitly listed as the
>  # prepare rule.
>
> -# Ugly workaround for Debian make-kpkg:
> -# make-kpkg directly includes the top Makefile of Linux kernel. In such a case,
> -# skip sub-make to support debian_* targets in ruleset/kernel_version.mk, but
> -# displays warning to discourage such abusage.
> -ifneq ($(word 2, $(MAKEFILE_LIST)),)
> -$(warning Do not include top Makefile of Linux Kernel)
> -sub-make-done := 1
> -MAKEFLAGS += -rR
> -endif
> -
>  ifneq ($(sub-make-done),1)
>
>  # Do not use make's built-in rules and variables
>  # (this increases performance and avoids hard-to-debug behaviour)
>  MAKEFLAGS += -rR
>
> -# 'MAKEFLAGS += -rR' does not become immediately effective for old
> -# GNU Make versions. Cancel implicit rules for this Makefile.
> -$(lastword $(MAKEFILE_LIST)): ;
> -
>  # Avoid funny character set dependencies
>  unexport LC_ALL
>  LC_COLLATE=C
> @@ -153,6 +139,7 @@ $(if $(KBUILD_OUTPUT),, \
>  # 'sub-make' below.
>  MAKEFLAGS += --include-dir=$(CURDIR)
>
> +need-sub-make := 1
>  else
>
>  # Do not print "Entering directory ..." at all for in-tree build.
> @@ -160,6 +147,15 @@ MAKEFLAGS += --no-print-directory
>
>  endif # ifneq ($(KBUILD_OUTPUT),)
>
> +ifneq ($(filter 3.%,$(MAKE_VERSION)),)
> +# 'MAKEFLAGS += -rR' does not immediately become effective for GNU Make 3.x
> +# We need to run sub-make to avoid implicit rules in the top Makefile.
> +need-sub-make := 1
> +# Cancel implicit rules for this Makefile.
> +$(lastword $(MAKEFILE_LIST)): ;
> +endif
> +
> +ifeq ($(need-sub-make),1)
>  PHONY += $(MAKECMDGOALS) sub-make
>
>  $(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: sub-make
> @@ -171,8 +167,11 @@ sub-make:
>         $(if $(KBUILD_OUTPUT),-C $(KBUILD_OUTPUT) KBUILD_SRC=$(CURDIR)) \
>         -f $(CURDIR)/Makefile $(filter-out _all sub-make,$(MAKECMDGOALS))
>
> -else # sub-make-done
> +endif # need-sub-make
> +endif # sub-make-done
> +
>  # We process the rest of the Makefile if this is the final invocation of make
> +ifeq ($(need-sub-make),)
>
>  # Do not print "Entering directory ...",
>  # but we want to display it when entering to the output directory
> @@ -1757,7 +1756,7 @@ existing-targets := $(wildcard $(sort $(targets)))
>
>  endif   # ifeq ($(config-targets),1)
>  endif   # ifeq ($(mixed-targets),1)
> -endif   # sub-make-done
> +endif   # need-sub-make
>
>  PHONY += FORCE
>  FORCE:
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
