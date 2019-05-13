Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0275CC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BFB2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="A2NezLU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbfEMN4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 09:56:02 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:42216 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbfEMN4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 09:56:02 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x4DDtrJD000439
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 22:55:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x4DDtrJD000439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557755754;
        bh=GKa0/XhA2V5agnSr1M250vRxQ9JoLrHwFQTBlihVHZw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A2NezLU4rB7LoX8IMRZd2m4BP0V8uI1kRfoMdC14R5xIeo5PitG+FrU3NdRQpOew4
         9RqK5eITEAmv+/ekZOiGVA0u+P6qg981h6T0XX2IE8gouF/9FwkHPmGINxhW9RRi59
         8igcdRh/1CeXnNQnvTZQ4/QaowmQnDTh53o/AWkwePAnoB2U+ffQsC5O9+pvTkc4M7
         x0ztU8EE9u1u2/cfVZUSUgtYAbI1uFcglHX1ulypEwr+I19g0eaVb6iSEzqvyEwZ+g
         yD9veq4FAbafhgsFs1ViB7ZA2PmtdubjqjrVg+H1AD4aC0a8cLyYrcbE6IUjhrq/ox
         5vxIOpiqNB1Ow==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id g187so8042807vsc.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 06:55:54 -0700 (PDT)
X-Gm-Message-State: APjAAAW0N2o0pPBaOVlTHcQQp3EY1VMzkhMQutqEzu8dELctvKhP/kCi
        raDMie3wE2XMT1r+1ux3qyrYZ+lpnzS+gx6+U6I=
X-Google-Smtp-Source: APXvYqxIyOecTEYmuZ9dJbhMFII02Kz7kZc+p8l16ixv3t6b/99y+iYBwzuOVT/a/uU4pr8i+3oANjnFqABcTGA/Q6Y=
X-Received: by 2002:a67:f443:: with SMTP id r3mr13613203vsn.179.1557755753123;
 Mon, 13 May 2019 06:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190513112254.22534-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190513112254.22534-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 13 May 2019 22:55:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQjukukcfz9-SyFhqZOZ1v18CJDVA8Zmn5RL92Q=73ZxA@mail.gmail.com>
Message-ID: <CAK7LNAQjukukcfz9-SyFhqZOZ1v18CJDVA8Zmn5RL92Q=73ZxA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/boot: fix broken way to pass CONFIG options
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>, Rob Herring <robh@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rodrigo R. Galvao" <rosattig@linux.vnet.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Mark Greer <mgreer@animalcreek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 9:33 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Commit 5e9dcb6188a4 ("powerpc/boot: Expose Kconfig symbols to wrapper")
> was wrong, but commit e41b93a6be57 ("powerpc/boot: Fix build failures
> with -j 1") was also wrong.
>
> Check-in source files never ever depend on build artifacts.
>
> The correct dependency is:
>
>   $(obj)/serial.o: $(obj)/autoconf.h
>
> However, copying autoconf.h to arch/power/boot/ is questionable
> in the first place.
>
> arch/powerpc/Makefile adopted multiple ways to pass CONFIG options.
>
> arch/powerpc/boot/decompress.c references CONFIG_KERNEL_GZIP and
> CONFIG_KERNEL_XZ, which are passed via the command line.
>
> arch/powerpc/boot/serial.c includes the copied autoconf.h to
> reference a couple of CONFIG options.
>
> Do not do this.
>
> We should have already learned that including autoconf.h from each
> source file is really fragile.
>
> In fact, it is already broken.
>
> arch/powerpc/boot/ppc_asm.h references CONFIG_PPC_8xx, but
> arch/powerpc/boot/utils.S is not given any way to access CONFIG
> options. So, CONFIG_PPC_8xx is never defined here.
>
> Just pass $(LINUXINCLUDE) and remove all broken code.
>
> I also removed the -traditional flag to make include/linux/kconfig.h
> work. I do not understand why it needs to imitate the behavior of
> pre-standard C preprocessors.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


I re-read my commit log, and I thought it was needlessly
too offensive. Sorry about that.

I will reword the commit log and send v2.




-- 
Best Regards
Masahiro Yamada
