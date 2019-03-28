Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939F7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206E920700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="X5cSn+DD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfC1AyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:54:08 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:32208 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfC1AyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:54:08 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x2S0rjYk018060;
        Thu, 28 Mar 2019 09:53:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x2S0rjYk018060
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553734426;
        bh=2mx2J5O3zw4hCfyw5Ru6B+hQYLb2vUR8J0yq5IUvvyc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X5cSn+DDxjtkW9VVnY5i7Z/zEipwJsjOOwX9BMohVC/yeMJfJ1Gqc4Y+g9UjV0gUt
         vrvbxV0Hm7TFjpzrE3IX1GLRXXvoWSahYpj8HmfgniUIXqf7Hq7wGQupquz3mWkJOP
         YRKzFFkYPDOmLWLjoiWrND4Tz97oYcqDe9I4H9a6yGuz5b28rdAPwtNAhz3ROV28S4
         9w6ayrrE7Iy9CLxYh6LxKOgezVGgwi6HW6vTxN339+/h8NqYyqCn1oBGJ0gJlmDyp+
         N4X3d9BTrmipIeZmFNmzMq8J1LaO1ayNQ2MVbXBDnVy8iI91hQ3FrUK1MSrqS617tk
         mDCuj+Jb+Yl7A==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id e1so11118638vsp.2;
        Wed, 27 Mar 2019 17:53:46 -0700 (PDT)
X-Gm-Message-State: APjAAAUdkoOsldZ3/QCVtiYLWhCitul+w7XncqWL+4VPEBoIqRuKc3bO
        4dELrGH98fG8z8wM55N0Sz2CLPlhyxzTrzIm3sM=
X-Google-Smtp-Source: APXvYqw3iSwMiR6EQqTw5AzHc3PNpATQShQC7mcHET+RR1+bLZLnFAr7/sY2Z/Sz8aUXwedMgp6oE3NFMZgYAL0ju+I=
X-Received: by 2002:a67:74cd:: with SMTP id p196mr24284207vsc.215.1553734425033;
 Wed, 27 Mar 2019 17:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <155372999953.7602.13784796495137723805.stgit@warthog.procyon.org.uk>
 <155373004377.7602.1209303093988055088.stgit@warthog.procyon.org.uk>
In-Reply-To: <155373004377.7602.1209303093988055088.stgit@warthog.procyon.org.uk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 28 Mar 2019 09:53:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNASRNyA9-Pfau=vyy9WZdjNEVD2gJxh+DrthRrKh6fgQhA@mail.gmail.com>
Message-ID: <CAK7LNASRNyA9-Pfau=vyy9WZdjNEVD2gJxh+DrthRrKh6fgQhA@mail.gmail.com>
Subject: Re: [RFC PATCH 01/68] kbuild: skip sub-make for in-tree build with
 GNU Make 4.x
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Andreas Schwab <schwab@suse.de>,
        linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David,


On Thu, Mar 28, 2019 at 8:41 AM David Howells <dhowells@redhat.com> wrote:
>
> From: Masahiro Yamada <yamada.masahiro@socionext.com>
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
> Signed-off-by: David Howells <dhowells@redhat.com>


Why should this patch be included in a
totally unrelated patch series?


I already applied this to my fixes branch,
and am planning to send a PR to Linus soon.

(Sorry, I missed to send a PR for -rc2)




> ---
>
>  Makefile |   31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index c0a34064c574..cd38d203e71a 100644
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
>


-- 
Best Regards
Masahiro Yamada
