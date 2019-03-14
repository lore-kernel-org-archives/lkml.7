Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15029C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 02:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE05217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 02:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfCNCYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 22:24:09 -0400
Received: from ozlabs.org ([203.11.71.1]:53551 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfCNCYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 22:24:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44KXZt2snjz9s70;
        Thu, 14 Mar 2019 13:24:06 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Paul Mackerras <paulus@samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: use $(origin ARCH) to select KBUILD_DEFCONFIG
In-Reply-To: <CA+7wUsxruu0GdyRGJ3vsjRvSBAptMn8_f5BmeMo=-E3zbhGGxQ@mail.gmail.com>
References: <1550223519-18290-1-git-send-email-yamada.masahiro@socionext.com> <CA+7wUswJ5+nb3OdZYrx6++batRMUcnje3jLTgdN4zAQo=--xBg@mail.gmail.com> <CAK7LNAQUEivnhFnmkP+5uCHRJcYWDtK_fm2gB0rsbzGv1taBCg@mail.gmail.com> <CA+7wUsxruu0GdyRGJ3vsjRvSBAptMn8_f5BmeMo=-E3zbhGGxQ@mail.gmail.com>
Date:   Thu, 14 Mar 2019 13:24:03 +1100
Message-ID: <87y35i9osc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Malaterre <malat@debian.org> writes:
> On Sat, Feb 16, 2019 at 3:26 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>>
>> On Sat, Feb 16, 2019 at 1:11 AM Mathieu Malaterre <malat@debian.org> wrote:
>> >
>> > On Fri, Feb 15, 2019 at 10:41 AM Masahiro Yamada
>> > <yamada.masahiro@socionext.com> wrote:
>> > >
>> > > I often test all Kconfig commands for all architectures. To ease my
>> > > workflow, I want 'make defconfig' at least working without any cross
>> > > compiler.
>> > >
>> > > Currently, arch/powerpc/Makefile checks CROSS_COMPILE to decide the
>> > > default defconfig source.
>> > >
>> > > If CROSS_COMPILE is unset, it is likely to be the native build, so
>> > > 'uname -m' is useful to choose the defconfig. If CROSS_COMPILE is set,
>> > > the user is cross-building (i.e. 'uname -m' is probably x86_64), so
>> > > it falls back to ppc64_defconfig. Yup, make sense.
>> > >
>> > > However, I want to run 'make ARCH=* defconfig' without setting
>> > > CROSS_COMPILE for each architecture.
>> > >
>> > > My suggestion is to check $(origin ARCH).
>> > >
>> > > When you cross-compile the kernel, you need to set ARCH from your
>> > > environment or from the command line.
>> > >
>> > > For the native build, you do not need to set ARCH. The default in
>> > > the top Makefile is used:
>> > >
>> > >   ARCH            ?= $(SUBARCH)
>> > >
>> > > Hence, $(origin ARCH) returns 'file'.
>> > >
>> > > Before this commit, 'make ARCH=powerpc defconfig' failed:
>> >
>> > In case you have not seen it, please check:
>> >
>> > http://patchwork.ozlabs.org/patch/1037835/
>>
>> I did not know that because I do not subscribe to ppc ML.
>>
>> Michael's patch looks good to me.
>
> OK
>
>>
>> If you mimic x86, the following will work:
>>
>
> Nice! Michael do you have a preference ?

Yeah I don't like playing games with ARCH. Doing so means auto builders
and other build scripts need to learn about the special rules for ARCH,
which is a pain.

So I'll merge my patch, which I think will also work for Masahiro's
case.

cheers
