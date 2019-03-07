Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE20C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0132081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S443FOeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfCGOto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:49:44 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35134 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGOtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:49:43 -0500
Received: by mail-qt1-f193.google.com with SMTP id p48so17335193qtk.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 06:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wk+Zp6CmdEl+rwUHirABi5bFji8WOLksmtyNzmIEkZ0=;
        b=S443FOeoILMW8SauUs0/8IFwiPYA40KYyJk7sh0uhXeUCYJuNtUwksdxukcxhTLAF6
         5Pyu52svdfLFJx/dqc05HZOmNNyWYYFgqESKMkcljYkRz4PaTttJeyA9wUTkAqGEi+fp
         IsE+DDGl5kLfEgShUT3H/pp+0/eFpFZCvo9nQEEpNECfsBdKxZltZEE6m6mNbwtk2B85
         UQgVb/5f9+W6hoaZiaYJVxH+TxAOSqcvW1bdoMrDKyq7MEAhJaOSfadSsiUsvZw/Ij5m
         sdzrB9dwdJIxY7y9g0kWHYzxgNLPLBoaCJCnptqzn7sFhZkEfIT2S3q5fNr361dhikM5
         98dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wk+Zp6CmdEl+rwUHirABi5bFji8WOLksmtyNzmIEkZ0=;
        b=WHo6YUSZZnDl0WmJAW1Fm4zf5Xy64mji9EuFVSAoNaCY9kBCGdf58FROj8uXwHQSJV
         mbyL64N6mStEE3OcwMLPyBH5ZKTixWNVEtJN45nfEnSgjJ28dezPGYmjZBISx07GO59h
         NIiqqecUJWhZoX0Q7SxX5jgMUgzUUo+2caeCzVG7/39Fl0sUWAkoZ+HfAuUM3nkAmT/r
         bgjt9fkcUV4MOPkkel+JbulaTt1YCGO+z42+ORc8l6OJilVYoOKQAvMajLEeQBTggVq5
         pyJOmB0W4aemOQ9PkXSsNT1dBBcJFFtYZ3EI+s3lPlrY4cYR3l/nXtdffh0PsbDQrPcC
         XccQ==
X-Gm-Message-State: APjAAAXfRU72RxWhZNFvSUrkJaCQeH1UMEcs7yb8cYKywl4ePL+D1y4/
        FBxvlnazw25W55pjK/824dUWB4158w/dUYREC5g=
X-Google-Smtp-Source: APXvYqw1drbPMo82yDVTc1V79Yl94h0KL32HLFrcu8ZKpYkVRN+sx4NhEjsAxapB4gr4Sdutweb7P8p0c7H9u60V0no=
X-Received: by 2002:a0c:963d:: with SMTP id 58mr10965020qvx.25.1551970182274;
 Thu, 07 Mar 2019 06:49:42 -0800 (PST)
MIME-Version: 1.0
References: <20190228002725.57444-1-gwendal@chromium.org> <CAFqH_52tWw8pGwY5fdAPQ6npbfWA7o4OhtPxvbUbCh5TdnbSew@mail.gmail.com>
 <CABXOdTfqPKq34OVDmJ9qjTr0nqarhpN=f37m3xH9iuHxex+xrw@mail.gmail.com>
 <CAFqH_50ZQtbOqG+u9VLT8m=9jvv_XQsghUTCuySu-=vho6rLKw@mail.gmail.com> <CABXOdTf3kt9EnyBB=8BjpiOOJ3=OaVodqKxTJkZC6=sTqry2jg@mail.gmail.com>
In-Reply-To: <CABXOdTf3kt9EnyBB=8BjpiOOJ3=OaVodqKxTJkZC6=sTqry2jg@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 7 Mar 2019 15:49:30 +0100
Message-ID: <CAFqH_53uYy0oTTYSJkkgM+Sz+uJYpJ3pAq0LtRjCKaZF0FS0gg@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros: Update EC protocol to match current EC code
To:     Guenter Roeck <groeck@google.com>
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

Hi Lee,
Missatge de Guenter Roeck <groeck@google.com> del dia dc., 6 de mar=C3=A7
2019 a les 19:58:
>
> On Wed, Mar 6, 2019 at 10:27 AM Enric Balletbo Serra
> <eballetbo@gmail.com> wrote:
> >
> > Hi Guenter,
> >
> > Missatge de Guenter Roeck <groeck@google.com> del dia dc., 6 de mar=C3=
=A7
> > 2019 a les 18:20:
> > >
> > > [resending in plain text mode ]
> > >
> > > On Wed, Mar 6, 2019 at 8:57 AM Enric Balletbo Serra <eballetbo@gmail.=
com> wrote:
> > > >
> > > > Hi Gwendal,
> > > >
> > > > Many thanks to send this upstream.
> > > >
> > > > Missatge de Gwendal Grignou <gwendal@chromium.org> del dia dj., 28 =
de
> > > > febr. 2019 a les 1:31:
> > > > >
> > > > > Chromebook Embedded Controller protocol is defined in the kernel =
at
> > > > > cros_ec_commands.h.
> > > > > The source of trust for the EC protocol is at
> > > > > https://chromium.googlesource.com/chromiumos/platform/ec/+/master=
/include/ec_commands.h
> > > > >
> > > > > Only needed changes have been picked up from this file to the ker=
nel
> > > > > include file leading to gaps between the upstream version and wha=
t the
> > > > > latest ECs can do.
> > > > >
> > > > > Fill the gaps to ease future integrations. Changes from the origi=
nal
> > > > > files is header/footer for license and include files for alignmen=
t.
> > > > >
> > > > > Check this include file works on ChomeOS kernel 4.14 and 4.19 on =
eve.
> > > > >
> > > > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > > > > ---
> > > > >  include/linux/mfd/cros_ec_commands.h | 3627 ++++++++++++++++++++=
+-----
> > > >

Just for if I was not clear after the discussion this is an ack from my sid=
e

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> > > > I'm wondering if we should move this file to include/uapi at some
> > > > point as this file is also used as user-space API for some userspac=
e
> > > > applications.
> > > >
> > > > While we are here I'd suggest if we can also fix the few errors (3)
> > > > and warnings (5) spotted by checkpatch. With that it's an ack from =
my
> > > > side.
> > > >
> > > > Being strict, though, on most cases the variables are going to be u=
sed
> > > > in code that can be seen by user-space programs so maybe we should
> > > > really need to switch to __u8/__u16/etc exportable data types inste=
ad
> > > > of the uint8_t/uint16_t/etc types (those are not aimed to be used
> > > > within the kernel). For those types that are internal we should use
> > > > in-kernel type (u8/u16/etc)
> > > >
> > > > There is also the use of the BIT macro instead of the (1 << x), I k=
now
> > > > that this is a maintainer preference.
> > > >
> > > Is all that even possible ?
> >
> > Sorry, if I wasn't clear from my side, I should have marked those as
> > nit, as in this case, I don't really mind, but I remember Lee
> > requesting some of those changes for this file.
> >
> > What I want to avoid is the desynchronization again. As this file
> > belongs to the MFD subsystem Lee needs to be happy with it or at least
> > know that we're not following the kernel style because is an imported
> > file (i.e not using the BIT macro, doing this example because I know
> > he takes care of this).
> >
> > So I think that the main question here is if an imported file like
> > this is acceptable in the include/linux/mfd?
> >
>
> I find it highly (and more and more) confusing about what is
> acceptable in the kernel and where, and what isn't. There are imported
> files all over the place, and they seem to be widely acceptable and
> accepted. It is difficult to keep track of what is acceptable and what
> isn't on a per subsystem basis. I'll step back and keep my confusion
> to myself.
>

In theory, I should be cc'ied if someone sends a modification to this
file, also Guenter and Benson. So we can take care that is synced with
the EC code and doesn't diverge again. I think that this is the main
purpose.

Thanks,
 Enric

> > > After all, this is an imported file, and
> > > we don't usually expect that imported files meet the Linux kernel
> > > coding style.
> > >
> >
> > I remember seeing somewhere that the EC code was following the Linux
> > kernel style? Now I am not able to find where.
> >
>
> You are correct: https://www.chromium.org/chromium-os/ec-development
>
> Running checkpatch over the code, it doesn't look like that is
> followed, though, much less enforced.
>
> Guenter
>
> > Thanks,
> >  Enric
> >
> > > Thanks,
> > > Guenter
> > >
> > > > [snip]
> > > >
> > > > Thanks,
> > > >  Enric
