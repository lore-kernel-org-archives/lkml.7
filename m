Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAFCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 04:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE3C20989
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 04:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="HX82UyzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfCSEFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 00:05:53 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:39780 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfCSEFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 00:05:52 -0400
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x2J45g47031906;
        Tue, 19 Mar 2019 13:05:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x2J45g47031906
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552968343;
        bh=Pbhb72ggMSiHT9L0wn4R3yXj9eC7t3Lj5Fy3MsTujcg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HX82UyzIVDTgQuc9SqmBsRLIc0ymBrbvuELugLaTVt/GD2tsBvQzuvfkG7vgFSj27
         pG3+K0DD0IlEXMGqY8eHNZEHd/mFMJ+N5CN225KXPadhxwK1sO2+aodzZcD+4n/FHX
         lExuc4HkLdGFetQChXzQioIAGJp3KJxzkQZzt3V+14emRzDmptJww7AexlG3hTi8d0
         e8QpwQpVrfrOgx4fJAbu44gqQiZipLRncIDXXLqvfx6Hj+hc/t+D7TNoagqYgNR3CZ
         RuDkhR/K6up/r5skxLfe1DuDM1Cg/Xut5re2aKaYMd5Y+uT5yoTDa8XEH9xUVtf6ub
         g26855eEBGRrw==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id g8so2666961uaj.0;
        Mon, 18 Mar 2019 21:05:43 -0700 (PDT)
X-Gm-Message-State: APjAAAV9rJ8AoZMKWJvQnm6HGqFLbF2t09RodGwEDIdhr90wVlNx2lBL
        bhoAQjVMg1tbT7surLv3kvMSme+Wx6u/Low9x0I=
X-Google-Smtp-Source: APXvYqxPutyT7u3zhpojNTc59jnYZMgp68nKcZ/nEkSA6LNsTLx6d1kprzv0vhDuhyP2z2UwKcJFrkUuQAaZFGRsbuI=
X-Received: by 2002:ab0:14c6:: with SMTP id f6mr171595uae.30.1552968341845;
 Mon, 18 Mar 2019 21:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <23500.1552920217@warthog.procyon.org.uk>
In-Reply-To: <23500.1552920217@warthog.procyon.org.uk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 19 Mar 2019 13:05:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS4zVusQRQLFNmmza9U_zbNBrjyx4qyDcH8g1oL0AzHTQ@mail.gmail.com>
Message-ID: <CAK7LNAS4zVusQRQLFNmmza9U_zbNBrjyx4qyDcH8g1oL0AzHTQ@mail.gmail.com>
Subject: Re: Commit seems to prevent use of GNUmakefile wrappers
To:     David Howells <dhowells@redhat.com>
Cc:     Liz Zhang <lizzha@microsoft.com>, Lili Deng <v-lide@microsoft.com>,
        Manoj Srivastava <srivasta@debian.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,


On Mon, Mar 18, 2019 at 11:43 PM David Howells <dhowells@redhat.com> wrote:
>
> Hi Mashiro,
>
>         commit 2b50f7ab63685cd247e32ad321f7338ed130d3d5
>         Author: Masahiro Yamada <yamada.masahiro@socionext.com>
>         kbuild: add workaround for Debian make-kpkg
>
> seems to prevent the use of GNUmakefile wrappers to set the ARCH and
> CROSS_COMPILE make variables.  With this commit, I now see:
>
>         make: Entering directory '/data/fs/linux-fs'
>         Makefile:39: Do not include top Makefile of Linux Kernel
>         ***
>         *** Configuration file ".config" not found!
>         ***
>         *** Please run some configurator (e.g. "make oldconfig" or
>         *** "make menuconfig" or "make xconfig").
>         ***
>         Makefile:605: include/config/auto.conf: No such file or directory
>         make: *** No rule to make target '.config', needed by 'include/config/auto.conf'.  Stop.
>         make: Leaving directory '/data/fs/linux-fs'
>
> Do you have a suggestion as to how to work around this?  Here's a sample
> GNUmakefile content:
>
>         CROSS_COMPILE   := x86_64-linux-gnu-
>         ARCH            := x86_64
>         MFLAGS          += CROSS_COMPILE=$(CROSS_COMPILE) ARCH=$(ARCH)
>         export CROSS_COMPILE
>         export ARCH
>         include Makefile


I think the following will work.
(code was taken from scripts/mkmakefile)



------------------(GNUmakefile BEGIN)-------------------
CROSS_COMPILE   := x86_64-linux-gnu-
ARCH            := x86_64
MFLAGS          += CROSS_COMPILE=$(CROSS_COMPILE) ARCH=$(ARCH)
export CROSS_COMPILE
export ARCH

ifeq ("$(origin V)", "command line")
VERBOSE := $(V)
endif
ifneq ($(VERBOSE),1)
Q := @
endif

MAKEFLAGS += --no-print-directory

.PHONY: __sub-make $(MAKECMDGOALS)

__sub-make:
        $(Q)$(MAKE) -f Makefile $(MAKECMDGOALS)

$(filter-out __sub-make, $(MAKECMDGOALS)): __sub-make
        @:
------------------(GNUmakefile END)-------------------



Having said that, the previous cheesy workaround sucks.

How about this patch?
https://patchwork.kernel.org/patch/10858809/

I hope you will be able to wrap the top Makefile again.


--
Best Regards
Masahiro Yamada
