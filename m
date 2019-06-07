Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9128C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5808E212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 20:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuSDK9d/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbfFGU1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 16:27:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33217 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbfFGU1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 16:27:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id x15so1824059pfq.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 13:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hSzQpwAiM+NRy/HIwuQOaL4l6Fd+62I0ixlRApmIXxg=;
        b=QuSDK9d/92EWHndE25zvgWp5ImGBwWWZLLMC1zNMpDzzq2SJoPio9YmJtPPXQ93DSw
         RNfFLtMfA2defydY7h8wb4mOvvVP8Dz01WJ6rpmYK3WAn8BkwSLNBhsfDihBBsrQPtmR
         Sh0rTT/7nJxNJRDkkDq4tJ/fV6CBkRMG8nEfQwuMySYIsF9ILZAJfb8ooiPyhUxcEHPk
         4J9JdkPre9sn5hA17a8qKwUvKjv60eSOln5Gbe4vRsfPXpa9BCgzg1kok79jRa8krR3d
         +u/d2gO28o6A4jsFWc9NrbwkjScwmcoZrTXNtsqI7GG1Cd0zQL9Ld0GfVfJHqc//fZai
         cEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hSzQpwAiM+NRy/HIwuQOaL4l6Fd+62I0ixlRApmIXxg=;
        b=DM+Xz7PGxouJ2pxOJCUhDd109nTJnbEYjrozyv8hWlLbv2bDyHns+ydtEKZTeBmW0B
         uIZc7yzIufe64TQDckHPs7bHdG3tyvSa8PUxxcSX2XgLOGcNDyMpJ4fwjxSNQo8wyH/p
         sFKm0tPRebrtEriAISVlW3Fe+BYpCCgo6gFV9zzt2HXEp3J/e+xUhSt7mTDbA0tiPimq
         SEqsVuMQOxbzL8i55yjb6hKrSYvJCDQR/I/Un+av7Hd2wPijj+MPGeHtaqaa456YGI4X
         U++ZBr2stfRTq7rR+dMizzp/hiwy1gtKptNuaJoFaBtPd5swArnQgH0pjn4mJexIFrzO
         0WVQ==
X-Gm-Message-State: APjAAAUC2Vt7/CqF2rV8Y46Qobg8q4QDRmic+7m+ofH1FqGImNQ6YPnj
        kdwpqftSIGnglrmwB9baGOO1N5yjvFmTNB/xxYEnUlW1s6M=
X-Google-Smtp-Source: APXvYqxamtxpEwMuMupwWMYImT3V0G9LaFfCOuX3uNXVmG//mY/dryDOWxY312/Qol7k8NpB0wtkuyyykyC6pSMxi9g=
X-Received: by 2002:aa7:82d6:: with SMTP id f22mr62257168pfn.151.1559939237240;
 Fri, 07 Jun 2019 13:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190515210202.21169-1-richard@nod.at> <CAO1O6sdU=kAYS2sTKwiagxrbg+fMer9nvbwA9C4LoFMgH7e1dQ@mail.gmail.com>
 <1644731533.84685.1559938164477.JavaMail.zimbra@nod.at>
In-Reply-To: <1644731533.84685.1559938164477.JavaMail.zimbra@nod.at>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Fri, 7 Jun 2019 22:27:09 +0200
Message-ID: <CAO1O6scuNXfgtaex_Ty4-5=DmBV43Sg28ntkzNgB5T2KwfXG3g@mail.gmail.com>
Subject: Re: [PATCH] ubifs: Add support for zstd compression.
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michele Dionisio <michele.dionisio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Den fre 7 juni 2019 kl 22:09 skrev Richard Weinberger <richard@nod.at>:
>
> Emil,
>
> ----- Urspr=C3=BCngliche Mail -----
> > In fs/ubifs/sb.c we have
> >
> > static int get_default_compressor(struct ubifs_info *c)
> > {
> >    if (ubifs_compr_present(c, UBIFS_COMPR_LZO))
> >        return UBIFS_COMPR_LZO;
> >
> >    if (ubifs_compr_present(c, UBIFS_COMPR_ZLIB))
> >        return UBIFS_COMPR_ZLIB;
> >
> >    return UBIFS_COMPR_NONE;
> > }
> >
> > Maybe add an entry for zstd here as well?
>
> Where would you add it? If we add it after UBIFS_COMPR_ZLIB,
> it will effectively never get selected, unless someone builds a kernel
> without lzo and zlib but zstd.
> If we add it before UBIFS_COMPR_ZLIB, it will be used always and users
> end up with unreadable files if they reboot to an older kernel.
> Please note that we didn't raise the UBIFS format version for zstd.
>
> So I'm not sure what is the best choice for the default filesystem.

My idea was at the end, i.e. it will only be used when LZO and ZLIB
are not selected to be included for UBIFS, for example when someone
compiles a minimal kernel who knows exactly which compression
algorithms will be used on that system. I guess that's the same reason
why zlib exists at all and is placed after lzo.
But of course the other positions also have their pros. If we perform
more benchmarks speed/size and conclude that zstd outperforms zlib for
all aspects, then maybe placing it between lzo and zlib could be an
option, but as you say we should avoid breaking compatibility with
older systems.
I did a single test today and compared lzo and zstd and on that test
lzo had faster decompression speed but resulted in larger space. I'll
do more tests later.

/Emil
