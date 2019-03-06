Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972F0C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685C5205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oIwlDMF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfCFS6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:58:07 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35496 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfCFS6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:58:06 -0500
Received: by mail-yw1-f68.google.com with SMTP id s204so10908025ywg.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 10:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+ZUb58DPvs+1LwePJJnz/Y+H0iPbyRfGahGY+7UcEWc=;
        b=oIwlDMF0kpLAerHBrCOsyJjHboTYRFAaPKjUbP6uMWuzKTKvu0DqyQ3AMJ57tM2ItB
         VBtb9FO0fJRAy8iITHKNKsjn1kj8Exb6F7az5nZqqZ01AKN3Yz9KUWUDkt7oXrLLu52j
         ctZNao4vtxcOz87xZSe12oifQ5+mP5hEO8PI+5ovW89CoBny7jXei+N3yC8GRJRehGXD
         Rw4eRl8uM1zyvLCFbI0m2e4icoCDUsfmfRZAw/U623bQ0+Lb90goPra9t5uREn/WwRdX
         3PiHcsl7JlwJTFX+I2VIadAOpZ+KC97csfZqE08XWs7w7mm5onWQBLacA3iopedA2ZOH
         YQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+ZUb58DPvs+1LwePJJnz/Y+H0iPbyRfGahGY+7UcEWc=;
        b=HqTDugitj7g7svS5mSA6EgMwGfIiY8Gdi5lONRDtae8CuKS6zjVRqRqZwLBhOwmu++
         YoI+ri2XmmKq6+NOi+zBHWZCKqFRsIRiDcpQ7uqUo/BtC8dbE1Z3x2RE6XBY82loCIZG
         i+3EHuQGb1qCWY/td99oKNj8A8Wa8FrmRpkJ/aZBuTYOKDxgkFEk+D83tjvC3/AdyAdR
         YY2D/YgTzq9N3ErQjxr6MowjDzOFL8vYlcQuE82mo1BIuF4QeWVrBEIjQlwHoXCgXxoC
         S/RhegGp29um49z687hEGn3bftKU68w5kHRlhrVfez7z0+rfv6WejcW+L51WnseKcH3d
         mNZg==
X-Gm-Message-State: APjAAAVkIPFy7DPXd4Bu9Z39teDQKkTnLbS0V6kKF201B2SDwYv7l8h0
        9FgXFGVf5yeaSbN4dHRQfsv3JEAHxaxKL4Op8OODBCZ5kB9tww==
X-Google-Smtp-Source: APXvYqxKC3mT2ujfG87Gzgt+kuzqEnyrl7Qb6XH5ajqRkH663Aj/7AoH2J4b7op9HOAT5UCgWG9OT39W4DDHUIxYwLc=
X-Received: by 2002:a81:a609:: with SMTP id d9mr6731699ywh.17.1551898685247;
 Wed, 06 Mar 2019 10:58:05 -0800 (PST)
MIME-Version: 1.0
References: <20190228002725.57444-1-gwendal@chromium.org> <CAFqH_52tWw8pGwY5fdAPQ6npbfWA7o4OhtPxvbUbCh5TdnbSew@mail.gmail.com>
 <CABXOdTfqPKq34OVDmJ9qjTr0nqarhpN=f37m3xH9iuHxex+xrw@mail.gmail.com> <CAFqH_50ZQtbOqG+u9VLT8m=9jvv_XQsghUTCuySu-=vho6rLKw@mail.gmail.com>
In-Reply-To: <CAFqH_50ZQtbOqG+u9VLT8m=9jvv_XQsghUTCuySu-=vho6rLKw@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 6 Mar 2019 10:57:53 -0800
Message-ID: <CABXOdTf3kt9EnyBB=8BjpiOOJ3=OaVodqKxTJkZC6=sTqry2jg@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros: Update EC protocol to match current EC code
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 10:27 AM Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
>
> Hi Guenter,
>
> Missatge de Guenter Roeck <groeck@google.com> del dia dc., 6 de mar=C3=A7
> 2019 a les 18:20:
> >
> > [resending in plain text mode ]
> >
> > On Wed, Mar 6, 2019 at 8:57 AM Enric Balletbo Serra <eballetbo@gmail.co=
m> wrote:
> > >
> > > Hi Gwendal,
> > >
> > > Many thanks to send this upstream.
> > >
> > > Missatge de Gwendal Grignou <gwendal@chromium.org> del dia dj., 28 de
> > > febr. 2019 a les 1:31:
> > > >
> > > > Chromebook Embedded Controller protocol is defined in the kernel at
> > > > cros_ec_commands.h.
> > > > The source of trust for the EC protocol is at
> > > > https://chromium.googlesource.com/chromiumos/platform/ec/+/master/i=
nclude/ec_commands.h
> > > >
> > > > Only needed changes have been picked up from this file to the kerne=
l
> > > > include file leading to gaps between the upstream version and what =
the
> > > > latest ECs can do.
> > > >
> > > > Fill the gaps to ease future integrations. Changes from the origina=
l
> > > > files is header/footer for license and include files for alignment.
> > > >
> > > > Check this include file works on ChomeOS kernel 4.14 and 4.19 on ev=
e.
> > > >
> > > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > > > ---
> > > >  include/linux/mfd/cros_ec_commands.h | 3627 +++++++++++++++++++++-=
----
> > >
> > > I'm wondering if we should move this file to include/uapi at some
> > > point as this file is also used as user-space API for some userspace
> > > applications.
> > >
> > > While we are here I'd suggest if we can also fix the few errors (3)
> > > and warnings (5) spotted by checkpatch. With that it's an ack from my
> > > side.
> > >
> > > Being strict, though, on most cases the variables are going to be use=
d
> > > in code that can be seen by user-space programs so maybe we should
> > > really need to switch to __u8/__u16/etc exportable data types instead
> > > of the uint8_t/uint16_t/etc types (those are not aimed to be used
> > > within the kernel). For those types that are internal we should use
> > > in-kernel type (u8/u16/etc)
> > >
> > > There is also the use of the BIT macro instead of the (1 << x), I kno=
w
> > > that this is a maintainer preference.
> > >
> > Is all that even possible ?
>
> Sorry, if I wasn't clear from my side, I should have marked those as
> nit, as in this case, I don't really mind, but I remember Lee
> requesting some of those changes for this file.
>
> What I want to avoid is the desynchronization again. As this file
> belongs to the MFD subsystem Lee needs to be happy with it or at least
> know that we're not following the kernel style because is an imported
> file (i.e not using the BIT macro, doing this example because I know
> he takes care of this).
>
> So I think that the main question here is if an imported file like
> this is acceptable in the include/linux/mfd?
>

I find it highly (and more and more) confusing about what is
acceptable in the kernel and where, and what isn't. There are imported
files all over the place, and they seem to be widely acceptable and
accepted. It is difficult to keep track of what is acceptable and what
isn't on a per subsystem basis. I'll step back and keep my confusion
to myself.

> > After all, this is an imported file, and
> > we don't usually expect that imported files meet the Linux kernel
> > coding style.
> >
>
> I remember seeing somewhere that the EC code was following the Linux
> kernel style? Now I am not able to find where.
>

You are correct: https://www.chromium.org/chromium-os/ec-development

Running checkpatch over the code, it doesn't look like that is
followed, though, much less enforced.

Guenter

> Thanks,
>  Enric
>
> > Thanks,
> > Guenter
> >
> > > [snip]
> > >
> > > Thanks,
> > >  Enric
