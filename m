Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F7FC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3020C20674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="klSroD0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbfIDGXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 02:23:04 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:39348 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfIDGXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:23:03 -0400
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x846MjSa007900;
        Wed, 4 Sep 2019 15:22:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x846MjSa007900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1567578166;
        bh=f/Vt6AfJ/h0GmLP4nlGQ6fG5Sb31T5I6KrbEB4uL3XQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=klSroD0qCQpZ5U6pxi2/qRowXcLbgDr38bNgsFdq09oA5xRagfY68AYymJmL2UKlZ
         AdN3EX+pOaZXFigtquwmXFnvIz3YR5SyvpELIcqwh15t9FojM4OT3w//5DNBllrIS6
         8jcWank4fplhHLSRIv52JaVQuXE5k/O5ezpgG5ovUix9gr7t72Y2U85WCK6zchNNJI
         IGep9b/kvtqmmEuB+oOySx5SD5G4+ClVDvd1oagm+uuBhiKUFk40Yrf9WaJNoy0z1a
         NNwxMd4a2bXNJgvA3NvxjGlIrwB+ZlBl4kmYV1maLKxeec0WoF6e/8B3E0jIXdQNVi
         GUbzyrXAys9UQ==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id u18so2480760uap.2;
        Tue, 03 Sep 2019 23:22:46 -0700 (PDT)
X-Gm-Message-State: APjAAAXmjG0wAViQZJiZZVD4ViCOYzE0bTlAmHaEhT/5Imq3Vsn9JUxM
        sPFYEV7uTykDw1/7OcHReJ49uoEVO4UsVr1MdD4=
X-Google-Smtp-Source: APXvYqwXqIiEkpz8t5zX3CwWA0I7b3aQl9vXC5xpQV6eLWDVUn+QwNnliorr9pE1hNc0I8hJVRq/h0Tg+eKQL9tTnI0=
X-Received: by 2002:a9f:2213:: with SMTP id 19mr6836107uad.25.1567578165238;
 Tue, 03 Sep 2019 23:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190904101259.2687cea4@canb.auug.org.au> <CAK7LNAT=qUi76cF776GcT=UYce5QBo+_24gLwXH7ra15=1xLvQ@mail.gmail.com>
In-Reply-To: <CAK7LNAT=qUi76cF776GcT=UYce5QBo+_24gLwXH7ra15=1xLvQ@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 4 Sep 2019 15:22:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ8VJz8fxecnEWmbFCpD0rgt4tjoipOX0g3oY0xU8xt5w@mail.gmail.com>
Message-ID: <CAK7LNAQ8VJz8fxecnEWmbFCpD0rgt4tjoipOX0g3oY0xU8xt5w@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 10:00 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Hi Stephen,
>
> On Wed, Sep 4, 2019 at 9:13 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >

For today's linux-next, please squash the following too.

(This is my fault, since scripts/mkuboot.sh is a bash script)


diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 41c50f9461e5..2d72327417a9 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -374,7 +374,7 @@ UIMAGE_ENTRYADDR ?= $(UIMAGE_LOADADDR)
 UIMAGE_NAME ?= 'Linux-$(KERNELRELEASE)'

 quiet_cmd_uimage = UIMAGE  $@
-      cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux \
+      cmd_uimage = $(BASE) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux \
                        -C $(UIMAGE_COMPRESSION) $(UIMAGE_OPTS-y) \
                        -T $(UIMAGE_TYPE) \
                        -a $(UIMAGE_LOADADDR) -e $(UIMAGE_ENTRYADDR) \





-- 
Best Regards
Masahiro Yamada
