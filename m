Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC43C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9394D206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSzmtf8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfH0J7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:59:16 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:42959 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfH0J7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:59:16 -0400
Received: by mail-pf1-f180.google.com with SMTP id i30so13790121pfk.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 02:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=jEhFx3vfpD3BoJif8WNr9up64syJNyS88BzgF6CC/tw=;
        b=OSzmtf8urJchWBO8iAwIGX2h/49CmnJpgU2aOxixbWgU0KgQkkF+d2Uv0BkHMmcX+e
         R2dfuz+Tm3PiSx1u7jQWOJB53JpjVg5DLJAnp5QKBFMBOyF9537e+jFDrM5PcZpONggF
         qz9DslETqQ6rVtY8EfUY05YoYk5PgVj5GHqxwiL/FESEw040GiPnpBOaKUxywGpVcrvj
         RSyA9/BbD5L6Y9iBUVZDowWjskm+lCdkdl8g8CaknB0Otjr6nqdxygzRpIyl3oovM3ds
         AvyJRhpEHn9pQB/ki5Nen7nQXP90Imn/zSwLiKjNSDc0NX2/rhp7CtLG/HCMqh9G7rbR
         VU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=jEhFx3vfpD3BoJif8WNr9up64syJNyS88BzgF6CC/tw=;
        b=Uec9TZXb1dFFiFv9n9Ieimfj3dSMS3SCMySmLu1UOdhjvpRPz57CDiC+aoaJg86ReB
         ZuZ3uGhE0xau+dYgvXL1f5MxmY1rmAx7mq3kzafv5j9iT1ceMwACVygzDGMc22glgTSb
         jrTtIPRUNEMVcvIfOLFtouhrUQbYuGOstSFodOQUAYIpgGpAsTBZeReqjv6Sijs53t2C
         4JTFGKgwMZC7kVYMv9Ofnk0IeCxKA502G5fqQzw68C2vAFJsTMsA2f+mBvHC5TcaGXPK
         WDoqLkyAjWUDM7UWXBNpEmCip/UIQ8jXEDqbajt/ZCwkuVw+VL0gRIRQdnlIrxTYQDjc
         /acA==
X-Gm-Message-State: APjAAAX8OaJlSRJbLXNrWbRepX0FFoRHqNnCwxid/znlpuRvhegFpzU2
        ROsUlqZMFg7aAbS0PYDVTX0=
X-Google-Smtp-Source: APXvYqzc70xYfAdAuYYWfLJext1NnatVRi97AqWKlREl4d/w2pFprQtCI0RnNUOxfNg1UznRGBMJAA==
X-Received: by 2002:a63:6a4a:: with SMTP id f71mr20158183pgc.409.1566899955447;
        Tue, 27 Aug 2019 02:59:15 -0700 (PDT)
Received: from localhost (14-202-91-55.tpgi.com.au. [14.202.91.55])
        by smtp.gmail.com with ESMTPSA id g10sm23458048pfb.95.2019.08.27.02.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 02:59:14 -0700 (PDT)
Date:   Tue, 27 Aug 2019 19:58:37 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: a bug in genksysms/CONFIG_MODVERSIONS w/ __attribute__((foo))?
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <CAKwvOdnJAApaUhTQs7w_VjSeYBQa0c-TNxRB4xPLi0Y0sOQMMQ@mail.gmail.com>
        <CAKwvOdkbY_XatVfRbZQ88p=nnrahZbvdjJ0OkU9m73G89_LRzg@mail.gmail.com>
In-Reply-To: <CAKwvOdkbY_XatVfRbZQ88p=nnrahZbvdjJ0OkU9m73G89_LRzg@mail.gmail.com>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1566899033.o5acyopsar.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Desaulniers's on August 27, 2019 8:57 am:
> On Mon, Aug 26, 2019 at 2:22 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>>
>> I'm looking into a linkage failure for one of our device kernels, and
>> it seems that genksyms isn't producing a hash value correctly for
>> aggregate definitions that contain __attribute__s like
>> __attribute__((packed)).
>>
>> Example:
>> $ echo 'struct foo { int bar; };' | ./scripts/genksyms/genksyms -d
>> Defn for struct foo =3D=3D <struct foo { int bar ; } >
>> Hash table occupancy 1/4096 =3D 0.000244141
>> $ echo 'struct __attribute__((packed)) foo { int bar; };' |
>> ./scripts/genksyms/genksyms -d
>> Hash table occupancy 0/4096 =3D 0
>>
>> I assume the __attribute__ part isn't being parsed correctly (looks
>> like genksyms is a lex/yacc based C parser).
>>
>> The issue we have in our out of tree driver (*sadface*) is basically a
>> EXPORT_SYMBOL'd function whose signature contains a packed struct.
>>
>> Theoretically, there should be nothing wrong with exporting a function
>> that requires packed structs, and this is just a bug in the lex/yacc
>> based parser, right?  I assume that not having CONFIG_MODVERSIONS
>> coverage of packed structs in particular could lead to potentially
>> not-fun bugs?  Or is using packed structs in exported function symbols
>> with CONFIG_MODVERSIONS forbidden in some documentation somewhere I
>> missed?
>=20
> Ah, looks like I'm late to the party:
> https://lwn.net/Articles/707520/

Yeah, would be nice to do something about this.

IIRC (without re-reading it all), in theory distros would be okay
without modversions if they could just provide their own explicit
versioning. They take care about ABIs, so they can version things
carefully if they had to change.

I think we left that on hold because some of the bigger distros were
heading into releases and we didn't care to cause pain. I wonder if
we could try again.

What's your requirement for versioning?

Thanks,
Nick
=
