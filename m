Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929D0C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 04:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B012082C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 04:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TxHlpLPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfHSENG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 00:13:06 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:20030 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHSENG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 00:13:06 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x7J4CkH6025355
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 13:12:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x7J4CkH6025355
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566187967;
        bh=zawdGZ9ZyNmfYfyUdpwVBwZFTc+KSsHNfxOU2+IVi2E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TxHlpLPY9q/MvzcpjcY8U9IfHjyyjQwEkvAcj8aewNLTKBJpq0ZqnEs0lFtvhOBxs
         TGmm1fWQJZwMYdNmQx6qwxFpcAs2TGKEDjSn0nKYTUU40gvwzMry1vT3H9K4LG/TwO
         NZINvAbSn4FEBSU7ZhUPwmhmtEOuWIjzyNHnjb6dCJE8UYGT6No1Gtbg0vCZo6LYJB
         T9IsnkPJbfFjgAKmzOPNx3LWsFG3Pd6Mpc8CYj5UOK+sZ9I5bTF/ls/h1JbXlQBbmo
         yydh0g/9DdVOWgRdERxps/BdxKXNJUKDR7z2XUk/VMr+lvqTEDmrFAiA9CRXyn+ATt
         aznftmZT4pnKg==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id b20so322910vso.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 21:12:47 -0700 (PDT)
X-Gm-Message-State: APjAAAUgWezgGMDK6Bmwc/XMBGkeALVk2/aFyeWX+fzpzYhgUW9aGPm3
        cwRBNb3EEOspuSFfqTEc3lb6yc0g8FqQs5mECS4=
X-Google-Smtp-Source: APXvYqxZWGF3+HnlOCLODkSxLgONq1AiUQ/7Qzg9X7ABdYlPKFtw/zxeBnwxF8hgshBpwXCwlb5WHLuf6u89bG7yL5w=
X-Received: by 2002:a05:6102:20c3:: with SMTP id i3mr13018980vsr.155.1566187965946;
 Sun, 18 Aug 2019 21:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190618030926.30616-1-yamada.masahiro@socionext.com>
 <1318390798.95477.1560838785550.JavaMail.zimbra@nod.at> <CAK7LNARA62uqi8rkDeJ=zjA6vnruTAH2VGOBd4=sQMhF+FHMLA@mail.gmail.com>
 <957967732.18164.1561621143523.JavaMail.zimbra@nod.at> <CAK7LNAQLheA3E0UrjirNHzpS2x+xmjc2YCupCBMNoHOwviz6GQ@mail.gmail.com>
 <1574230514.38485.1563091693340.JavaMail.zimbra@nod.at> <CAFLxGvxYa9AZiSLBVeDtXznab41me8jBUMoGNvcMDfAZQ8wr7g@mail.gmail.com>
In-Reply-To: <CAFLxGvxYa9AZiSLBVeDtXznab41me8jBUMoGNvcMDfAZQ8wr7g@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 19 Aug 2019 13:12:09 +0900
X-Gmail-Original-Message-ID: <CAK7LNARY6beyondOjsQg-vMFCORoTYYM76drnERHfSYsKu92RA@mail.gmail.com>
Message-ID: <CAK7LNARY6beyondOjsQg-vMFCORoTYYM76drnERHfSYsKu92RA@mail.gmail.com>
Subject: Re: [PATCH v2] jffs2: remove C++ style comments from uapi header
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 4:14 PM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> On Sun, Jul 14, 2019 at 10:08 AM Richard Weinberger <richard@nod.at> wrot=
e:
> >
> > ----- Urspr=C3=BCngliche Mail -----
> > > Looks like this trivial patch missed the pull request.
> > >
> > >
> > > My motivation is to make sure UAPI headers
> > > are really compilable in user-space,
> > > and now checked by the following commit:
> > >
> > > commit d6fc9fcbaa655cff2d2be05e16867d1918f78b85
> > > Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > Date:   Mon Jul 1 09:58:40 2019 +0900
> > >
> > >    kbuild: compile-test exported headers to ensure they are self-cont=
ained
> > >
> > >
> > >
> > > Is there a chance for it being merged,
>
> Appled.
>
> --
> Thanks,
> //richard


I checked next-20190819, but I still do not see this patch.
Where has this patch gone?



--=20
Best Regards
Masahiro Yamada
