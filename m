Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84492C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C72205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBAu/RLD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfH0MnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:43:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44039 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfH0MnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:43:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id c81so14032365pfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 05:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=rycJM2D5prTLrrH7Hf0CHWcl07PTs5XDdWvVYECd+zg=;
        b=SBAu/RLD60WBNJeJUBJxeto+d7UuFS4xT44856oUORrMm2fGMk+faZoTzV7iFbhSfq
         m09JrtWR4/3S1yY5S6798/OnCe1uMfRTNKfKMJdp/HmYKXZxcewAoHURdJWfz0Yy5mdE
         PbUlKQGY4E+CHf0C+LVsjYgY/skz0k8HlT+t7AQ394PQeAEiSN1Nk8Kt0Oh4U38pDMcK
         puK76ddYhV/tpaEcsiCh3s2AeGqRWZVPoInNXGtotsQSHl7wG9fwaGC0Q6VYLOKh2IqZ
         LT4FUdvZohQxC5X12Qmczj5aTjaBC3KHb+P87/7sVDGSJpwwXmEjx+fM7wQI3uPHPFzN
         XYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=rycJM2D5prTLrrH7Hf0CHWcl07PTs5XDdWvVYECd+zg=;
        b=mbI+jvgoXJEz/8hXuYHcoPt5fxhj5gic9D0CSwKvM/kFdcDeTd8wcgD58MxZc7exL4
         SBgUgGTomdBW/4Uvu/oAlgIU80DnjYtv6bFTadO665D3nQb9g8SiZiVhToF7aPPcYGAv
         Sj4iRryHdQanpwbrU0fTr3OTHkI38uRaoLwSyzalXhlxFP2ELo+NHnb8ndLvRSbk4GKp
         5K5VMr9vjwUVkthlCh9dOd/LK/2cjJQjC+ge3AYPuGw1s+WyCXlKFu0vm2vAMujcsPyy
         HiTpV1fzLYHJqEiYBpCHBZnzfEhmOpwqq1rsN84DMPgXbMhsjalYasmsY6d9qWEQxjKz
         mR4A==
X-Gm-Message-State: APjAAAVz/22bMyawovpa+Pm7+lCgp6RZkZnb1CVQdMsGc+jlZBzsA2gW
        TBKxf/Jh5xb/knzETMXGDyI=
X-Google-Smtp-Source: APXvYqxU+6kIePxFDiIADXJobNIlHJxzyOCQhFRbglIPwBowiPcPmwAq2PZP8f1L2UQzZC9VquUL9A==
X-Received: by 2002:a63:e807:: with SMTP id s7mr20439815pgh.194.1566909783295;
        Tue, 27 Aug 2019 05:43:03 -0700 (PDT)
Received: from localhost (14-202-91-55.tpgi.com.au. [14.202.91.55])
        by smtp.gmail.com with ESMTPSA id y188sm15405719pfb.115.2019.08.27.05.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 05:43:02 -0700 (PDT)
Date:   Tue, 27 Aug 2019 22:42:20 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: a bug in genksysms/CONFIG_MODVERSIONS w/ __attribute__((foo))?
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ben Hutchings <ben@decadent.org.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>
References: <CAKwvOdnJAApaUhTQs7w_VjSeYBQa0c-TNxRB4xPLi0Y0sOQMMQ@mail.gmail.com>
        <CAKwvOdkbY_XatVfRbZQ88p=nnrahZbvdjJ0OkU9m73G89_LRzg@mail.gmail.com>
        <1566899033.o5acyopsar.astroid@bobo.none>
        <CAK7LNARHacanVT6XjRDkFJDETWX6qHfUJCFhskCVG6aDL-bt1g@mail.gmail.com>
In-Reply-To: <CAK7LNARHacanVT6XjRDkFJDETWX6qHfUJCFhskCVG6aDL-bt1g@mail.gmail.com>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1566908344.dio7j9zb2h.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada's on August 27, 2019 8:49 pm:
> Hi.
>=20
> On Tue, Aug 27, 2019 at 6:59 PM Nicholas Piggin <npiggin@gmail.com> wrote=
:
>>
>> Nick Desaulniers's on August 27, 2019 8:57 am:
>> > On Mon, Aug 26, 2019 at 2:22 PM Nick Desaulniers
>> > <ndesaulniers@google.com> wrote:
>> >>
>> >> I'm looking into a linkage failure for one of our device kernels, and
>> >> it seems that genksyms isn't producing a hash value correctly for
>> >> aggregate definitions that contain __attribute__s like
>> >> __attribute__((packed)).
>> >>
>> >> Example:
>> >> $ echo 'struct foo { int bar; };' | ./scripts/genksyms/genksyms -d
>> >> Defn for struct foo =3D=3D <struct foo { int bar ; } >
>> >> Hash table occupancy 1/4096 =3D 0.000244141
>> >> $ echo 'struct __attribute__((packed)) foo { int bar; };' |
>> >> ./scripts/genksyms/genksyms -d
>> >> Hash table occupancy 0/4096 =3D 0
>> >>
>> >> I assume the __attribute__ part isn't being parsed correctly (looks
>> >> like genksyms is a lex/yacc based C parser).
>> >>
>> >> The issue we have in our out of tree driver (*sadface*) is basically =
a
>> >> EXPORT_SYMBOL'd function whose signature contains a packed struct.
>> >>
>> >> Theoretically, there should be nothing wrong with exporting a functio=
n
>> >> that requires packed structs, and this is just a bug in the lex/yacc
>> >> based parser, right?  I assume that not having CONFIG_MODVERSIONS
>> >> coverage of packed structs in particular could lead to potentially
>> >> not-fun bugs?  Or is using packed structs in exported function symbol=
s
>> >> with CONFIG_MODVERSIONS forbidden in some documentation somewhere I
>> >> missed?
>> >
>> > Ah, looks like I'm late to the party:
>> > https://lwn.net/Articles/707520/
>>
>> Yeah, would be nice to do something about this.
>=20
> modversions is ugly, so it would be great if we could dump it.
>=20
>> IIRC (without re-reading it all), in theory distros would be okay
>> without modversions if they could just provide their own explicit
>> versioning. They take care about ABIs, so they can version things
>> carefully if they had to change.
>=20
> We have not provided any alternative solution for this, haven't we?
>=20
> In your patch (https://lwn.net/Articles/707729/),
> you proposed CONFIG_MODULE_ABI_EXPLICIT.

Right, that was just my first proposal, but I am not confident that I
understood everybody's requirements. I don't think the distro people
had much time to to test things out.

One possible shortcoming with that patch is no per-symbol version. The=20
distro may break an ABI for a security fix, but they don't want to break
all out of tree modules if it's an obscure ABI. The counter argument to=20
that is they should just rename the symbol in their kernel for such=20
cases, so I didn't implement it without somebody describing a good
requirement.

> If it is good enough for distros, we merge it first,
> give them time to migrate over to it, then finally remove modversions??

I guess. Do we really need to merge and wait? If they _really_ want it,
and won't put in effort to convert their kernel packaging, then they
can carry the patch and support it quite easily. The code doesn't
change frequently so it should not be a big roadblock

I'm more concerned about developer and hobbyists etc who don't have the
resources. But IIRC we are satisfied that git version has superseded
the benefits of modversions for that case now.

Thanks,
Nick
=
