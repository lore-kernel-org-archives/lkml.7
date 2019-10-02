Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63606C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FE121783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="0y23Igke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfJBKqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 06:46:35 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:34153 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfJBKqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 06:46:35 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x92AkQ6s002702
        for <linux-kernel@vger.kernel.org>; Wed, 2 Oct 2019 19:46:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x92AkQ6s002702
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1570013186;
        bh=Bglfj+Tuvo1CYXOErH0eUGGYGUYhZ/vzszNXppdwH4o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0y23Igke+GNeXli2RExdapfhItMcwAkqmiCIjt/jM53ItrnsDRZya4g3SPCcjCSUg
         xbSwlcBHPodVGJTDceVcwJTve+GsfGyuQkgjDH6NnaJ7tAcXDtXKdGOR65CnoRihiq
         uq3uSEyWUfIdbxZLGSqaA2jjjnADxKijlZvmHsbkFqdJ4DNf/oo3qpmqyRKorTRqvY
         JIGk0UuWqS7BOZZL+NeHiovoxYX61RKqW4I/TodW49UIuhf2olmLCYtoqnwqUOb3hE
         j19B9HUJJOBJmyN/DBbouJplz0asQTaRYVeqCxWBESYmoGVBjV5MSVC91KAX3mHpPF
         GBjv4ETVtXb5A==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id y129so10587944vsc.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 03:46:26 -0700 (PDT)
X-Gm-Message-State: APjAAAVe94qcxfRFntcqW5pKL2Vmx+YoRBppqeVWpe9fTMfewpg9EHHl
        4XbXvkvpQuObJCgHv/Q1oWYjXNPnd4ykOzRSkhE=
X-Google-Smtp-Source: APXvYqwnWcwGj7cbZH6Fuzdub/hV3jKwA9Rxcz5Wb1PJQDEfO9FDFIGjBpO9FnJZ2wl7xvO0Evhm0eiWtzOKFA06RNY=
X-Received: by 2002:a67:ec09:: with SMTP id d9mr1416180vso.215.1570013185365;
 Wed, 02 Oct 2019 03:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191001083701.27207-1-yamada.masahiro@socionext.com>
 <CAKwvOd=NObDXDL3jz9ZX9wo4tn747peBJPTj0DXyLerixgL+wQ@mail.gmail.com> <20191002082454.GQ25745@shell.armlinux.org.uk>
In-Reply-To: <20191002082454.GQ25745@shell.armlinux.org.uk>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 2 Oct 2019 19:45:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQkPQbYvRoQqwa7gZ7H62m=5br7E=+E5WdmYWakDRafLA@mail.gmail.com>
Message-ID: <CAK7LNAQkPQbYvRoQqwa7gZ7H62m=5br7E=+E5WdmYWakDRafLA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: add __always_inline to functions called from __get_user_check()
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Stefan Agner <stefan@agner.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 5:25 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
> Masahiro Yamada, please send this to the patch system, thanks.

Done.  (8908/1)

Thanks.

-- 
Best Regards
Masahiro Yamada
