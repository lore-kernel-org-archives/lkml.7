Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C31EC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E123821019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/HsSNKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbfEMODW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:03:22 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39499 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729875AbfEMODW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:03:22 -0400
Received: by mail-it1-f194.google.com with SMTP id 9so13238083itf.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 07:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o0K1jdRqTpq5tDrpDekYObvydSm3rzMfeKGFkCtyf2M=;
        b=q/HsSNKcCdUmLvEpsJCqo/hbWvJI4lyWG49TCPP3b3L+gOOE0Paf9Qmx/2u7TUJjwl
         VOOHlLIZymsqnFlrL+9E3NH4Eemu36AaukySLP+9pcxfKO+DP8KR/vgp3YPUWQ57sjIG
         UMMT437BHEsmP0tNnbl9Xv+C+tFDTz8pIpX41APF4Ocxh1sTwfzTX3JAUE9bc2yPdQPk
         QZOPZhrQkW5Gu54Qh1wxuSAqi/J7oduLetIm/TkoYykymf/eJcp5Y9+f6bXBkbZGEKVW
         ZMfa6zqH7QazGyHFM7wT9f6Ve6i6PCVZaYRYs0wpJXAU/Yzw7SLTAs4QVg8BzcBaXuG1
         0x9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o0K1jdRqTpq5tDrpDekYObvydSm3rzMfeKGFkCtyf2M=;
        b=rq5Df1u+51LB7KuJOqQwo67XcvW0avSGj6UgoyO9tYzWQLXDv+WVZE7HhgwHcED1N0
         CF3GcROE9oKJTsfQylevGAUbWU0N1z6U1K8GY8WfMvf/8+UZvHUSfrJlYL6UQK8zWBng
         t8z1A8u/uJpCgWBBSB4pplGRHNyji8AamGMJcTIOZY9VNg3Wnk52RKCloy8crZsHp0qH
         SoG3dLNQ7LEdTKlI0AHgFhOGHCJ/YqRYAJmhLoaEFQpjiOddW7H0iP4u8tT+dCncHRS5
         7R03SwzTQKnDPrTVVcdaX7+LAYakKBBmuhK3iZXuUZ/ScutFcTxvY8MQVAy6guaIFMgg
         WPNg==
X-Gm-Message-State: APjAAAV2sov5dteCVg77TH5Oe1+P+obMmuzlXDEejInC3iO6R7sPU91f
        qIXHZpBzxh5YtMFMT9oNDWWo0RZsZkxm6U9YC2M=
X-Google-Smtp-Source: APXvYqyFUYOaKp/BwZkd9IwhAZafexR5iBDf2i/HPirvmIJEVvzAwxsNHaQ73Ig2B5P0Sn3pdeM3/SV2YHd0taZhFAc=
X-Received: by 2002:a24:d45:: with SMTP id 66mr19242619itx.9.1557756201465;
 Mon, 13 May 2019 07:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190513112254.22534-1-yamada.masahiro@socionext.com> <CAK7LNAQjukukcfz9-SyFhqZOZ1v18CJDVA8Zmn5RL92Q=73ZxA@mail.gmail.com>
In-Reply-To: <CAK7LNAQjukukcfz9-SyFhqZOZ1v18CJDVA8Zmn5RL92Q=73ZxA@mail.gmail.com>
From:   Oliver <oohall@gmail.com>
Date:   Tue, 14 May 2019 00:03:10 +1000
Message-ID: <CAOSf1CHJ1iAdJjGA+2xFmNFLen4WJ_-468tqTSnod7C=LWUq9Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc/boot: fix broken way to pass CONFIG options
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rodrigo R. Galvao" <rosattig@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Mark Greer <mgreer@animalcreek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 11:56 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Mon, May 13, 2019 at 9:33 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > Commit 5e9dcb6188a4 ("powerpc/boot: Expose Kconfig symbols to wrapper")
> > was wrong, but commit e41b93a6be57 ("powerpc/boot: Fix build failures
> > with -j 1") was also wrong.
> >
> > Check-in source files never ever depend on build artifacts.
> >
> > The correct dependency is:
> >
> >   $(obj)/serial.o: $(obj)/autoconf.h
> >
> > However, copying autoconf.h to arch/power/boot/ is questionable
> > in the first place.
> >
> > arch/powerpc/Makefile adopted multiple ways to pass CONFIG options.
> >
> > arch/powerpc/boot/decompress.c references CONFIG_KERNEL_GZIP and
> > CONFIG_KERNEL_XZ, which are passed via the command line.
> >
> > arch/powerpc/boot/serial.c includes the copied autoconf.h to
> > reference a couple of CONFIG options.
> >
> > Do not do this.
> >
> > We should have already learned that including autoconf.h from each
> > source file is really fragile.
> >
> > In fact, it is already broken.
> >
> > arch/powerpc/boot/ppc_asm.h references CONFIG_PPC_8xx, but
> > arch/powerpc/boot/utils.S is not given any way to access CONFIG
> > options. So, CONFIG_PPC_8xx is never defined here.
> >
> > Just pass $(LINUXINCLUDE) and remove all broken code.
> >
> > I also removed the -traditional flag to make include/linux/kconfig.h
> > work. I do not understand why it needs to imitate the behavior of
> > pre-standard C preprocessors.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
>
>
> I re-read my commit log, and I thought it was needlessly
> too offensive. Sorry about that.
>
> I will reword the commit log and send v2.
>

No worries. We know the bootwrapper is... not great.

>
>
>
> --
> Best Regards
> Masahiro Yamada
