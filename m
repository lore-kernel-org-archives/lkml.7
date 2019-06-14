Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24455C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 19:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFD52173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 19:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIH+M8u6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfFNT4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 15:56:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42841 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfFNT4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 15:56:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id x17so3715360wrl.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 12:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tkfIkc5EEziIC8JttuF44VEsntcOdSTSm668OicBieA=;
        b=qIH+M8u6ZHF56mysF2rv7LgxnEGFYR951cqj5/ufPiitDHFKDiSzyDgKT0UHHa7Rtw
         dCXyZoQ6PxgjU7i8iacuMREE1//5Vxt/sdt6LkWWPiUaLa9Wz4tVFuXy8BYpCscurA4B
         +BFnfpmmTNMht6wpoSgG+h+cw9fRpSX+PYwNQOEQ3eAaBm/QcK6prEkZ/YDSnHqTx8Ij
         HIztDKPZmech4lNjF6gFc9Y38nNiOgwnw5Vx28LAx6Rgf8d0OQziAe8/XsJbFo0do1i1
         5bF8GfolMUILyUmsiSsazQMP4VdVln41Tu2/oJcriwLdUKKtyvakmU4ae1CRgzDAuDbh
         YjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tkfIkc5EEziIC8JttuF44VEsntcOdSTSm668OicBieA=;
        b=GFvyr74uVXK2pTSYyM5e/P+P6Jja4mR8j0oy8qf87/hZd3bhOuGhFy7CbndJHUbmk1
         zRU5nOMmQoq4D0+SR4TsOyU8RyweudRi3k1lkVh5aKKlMkvYvm4HNWszF50LwFKK2iYk
         i9WnaYhwEQwzoQiBd7yEov61UwL01ZUl6Dz3CTXXT+2b/lsAttVdh2xMb09Uhoy+S2/U
         DW2UjPN9cuPObGyPtL0//oJ2HtQnSBq0Ix/lVDKJKFNbg5C7OqmJip69r46I5ICOcFE/
         dXXpV2VMxYMQc0K06kiKSrzn0bZqfNn2AY9d38sciSFet1Pf3iNbW81hg7MQqaXQ1BL8
         wDGw==
X-Gm-Message-State: APjAAAVP959nYreHTdU9ph3VnepQzxFviD7HyndHl0TWGqViQzlnR3Vy
        c5Lcs0rjhwydgV4tr4OjP9mxBwHw
X-Google-Smtp-Source: APXvYqz4dnTX5FOuo1+mrF9OWokv0GO2DjUQU5Onl8cJM/+eoB8LwPhxf3ttG4o9SNRjq4RoASQQQg==
X-Received: by 2002:a5d:6389:: with SMTP id p9mr52574643wru.297.1560542202338;
        Fri, 14 Jun 2019 12:56:42 -0700 (PDT)
Received: from debian64.daheim (pD9E29824.dip0.t-ipconnect.de. [217.226.152.36])
        by smtp.gmail.com with ESMTPSA id a19sm2447233wmm.46.2019.06.14.12.56.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 12:56:41 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
        by debian64.daheim with esmtp (Exim 4.92)
        (envelope-from <chunkeey@gmail.com>)
        id 1hbsJU-0007ny-CJ; Fri, 14 Jun 2019 21:56:40 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>,
        Pawel Dembicki <paweldembicki@gmail.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Enable kernel XZ compression option on PPC_85xx
Date:   Fri, 14 Jun 2019 21:56:40 +0200
Message-ID: <4407251.g26ZO3zR3C@debian64>
In-Reply-To: <f988951c-3077-ab19-81eb-560418468d14@c-s.fr>
References: <20190603164115.27471-1-paweldembicki@gmail.com> <87ftodempa.fsf@concordia.ellerman.id.au> <f988951c-3077-ab19-81eb-560418468d14@c-s.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 14, 2019 12:06:48 PM CEST Christophe Leroy wrote:
>=20
> Le 13/06/2019 =E0 13:42, Michael Ellerman a =E9crit :
> > Daniel Axtens <dja@axtens.net> writes:
> >> Pawel Dembicki <paweldembicki@gmail.com> writes:
> >>
> >>> Enable kernel XZ compression option on PPC_85xx. Tested with
> >>> simpleImage on TP-Link TL-WDR4900 (Freescale P1014 processor).
> >>>
> >>> Suggested-by: Christian Lamparter <chunkeey@gmail.com>
> >>> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> >>> ---
> >>>   arch/powerpc/Kconfig | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> >>> index 8c1c636308c8..daf4cb968922 100644
> >>> --- a/arch/powerpc/Kconfig
> >>> +++ b/arch/powerpc/Kconfig
> >>> @@ -196,7 +196,7 @@ config PPC
> >>>   	select HAVE_IOREMAP_PROT
> >>>   	select HAVE_IRQ_EXIT_ON_IRQ_STACK
> >>>   	select HAVE_KERNEL_GZIP
> >>> -	select HAVE_KERNEL_XZ			if PPC_BOOK3S || 44x
> >>> +	select HAVE_KERNEL_XZ			if PPC_BOOK3S || 44x || PPC_85xx
> >>
> >> (I'm not super well versed in the compression stuff, so apologies if
> >> this is a dumb question.) If it's this simple, is there any reason we
> >> can't turn it on generally, or convert it to a blacklist of platforms
> >> known not to work?
> >=20
> > For some platforms enabling XZ requires that your u-boot has XZ support,
> > and I'm not very clear on when that support landed in u-boot and what
> > boards have it. And there are boards out there with old/custom u-boots
> > that effectively can't be updated.
>=20
> I don't think that it has anything to do with u-boot.
> AFAIK, today's mainline U-boot only supports GZIP (by default) and the=20
> following optional ones: LZO, LZMA, LZ4.
>=20
> If we want to set additional compression types for u-boot, it is not=20
> enough to select HAVE_KERNEL_XXXX, we also have to update uImage=20
> generation scripts.
>=20
> See the series I sent some time ago:=20
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=3D104153
> I'll resent it without bzip2 as today's uboot doesn't support bzip2 anymo=
re.
>=20
> >=20
> > But as a server guy I don't really know the details of all that very
> > well. So if someone tells me that we should enable XZ for everything, or
> > as you say just black list some platforms, then that's fine by me.
> >=20
>=20
> I guess we first need to understand how this is used.
>=20

to add to the confusion:

The powerpc arch is sort of special since it has the various targets have
different arch/powerpc/boot/wrapper for everyone unfamiliar (people from
ARM or other targets,) please look at:=20

https://www.kernel.org/doc/Documentation/powerpc/bootwrapper.txt

and see that this is very different from ARM, MIPS, x86, etc.

I think the cuImage*, dtbImage*, simpleImage, etc... wouldn't
be affected if the kernel is compressed by XZ, as in they should
still boot fine, altough XZ takes a bit longer to unpack of course.

However, for the uImage this could spell a problem, however "HAVE_KERNEL_XZ"
does not automatically entail that the wrapper script from above
compresses the generated uimage with LZMAd/xz. Instead this is controlled
by init/Kconfig and the "Kernel compression mode" setting there.=20
And currently that defaults to CONFIG_KERNEL_GZIP. So the wrapper script
currently gzipped uImages unless the target config overwrites it to
something else (and the target has the right=20
HAVE_KERNEL_XZ/BZIP2/LZMA/LZO/LZ4/... as well).

Regards,
Christian


