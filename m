Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE62C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF47208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYmdyv9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfENPW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 11:22:59 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33951 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfENPW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 11:22:58 -0400
Received: by mail-yw1-f65.google.com with SMTP id n76so14314884ywd.1;
        Tue, 14 May 2019 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EIqb4eEH0S4LgQ1Yuwg43BMgX8ef+eVurK6N5WcObMU=;
        b=vYmdyv9F2aheI/anon+QKteAny7T9Jkr5RqQgnGlUFC7tfsc6l0uZhzwhbGkpKWrM+
         0wIQgCkUqAIJJiuKcWpmOAP1rmiLDxREh2+HSn/77OrV2OmMe1GNryaK5Jhn6rMzT3bJ
         k7ecYwXz++aYRjdGRlKRK/baHs1CClyfvLZPqRIbMWxra8vFvLGZETpzx0FWraGbciky
         q0O/MwvkTRJBcA2bOTZykoX7/cO+79ijS0Lv86uRvIt5UvugjKjNs5tODTEkfpT5F4g6
         Ih9QJYumpv8dTaoCeesPt1IjlsdakWKtHqihnDqKfQLwWnTw37x8K9mhyhAs1u18HPX8
         3cuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EIqb4eEH0S4LgQ1Yuwg43BMgX8ef+eVurK6N5WcObMU=;
        b=Qp8UB2hWxjQrbVIZKKK+Fz5r8f6WEkr7fIi1S+RZpLFQ9UOUVbyKxYo8jgSKQkaz4z
         2ljmXE0hiX0Ho6b5HqBsC0ngXWxsoG/QYVS8Tp32dckSukSfGEKCvKhpPkdb4IiUMrDA
         kkGk71mTZbtJFdNyUqYls5bBWMkXEBnr+q3goXmf9nCoZgZTTc0vWyY97fA5qhJjgGe9
         76H0KfOYSq8WU4+EY2Zyy+Jf0lyiF/dx5E5qBWSUJmRb+JZ8B4o76oggSxXoG0FzpkMq
         MWMissyhB+jOisWKyiASAnoQWYcVfyehMnLcucF71c+Z475qI/1gqaMYJ0T6ih27kCgw
         4H6Q==
X-Gm-Message-State: APjAAAUcLVYy1dlgwXwpQpjBG4l10O4IA9YBNKtYb+Bxk7Cvxb+FBW06
        ugqjqSok131gKxhvXy3O3wjZ3kI8xrdiqvPTQNbf6PWOXpcOuw==
X-Google-Smtp-Source: APXvYqzsCBCwG+CsZWtmfQH5I1TFQjALA0U5fvim+GZofqMADF7Ffsdbqc9gP3rOktGVVJdHyqlZTkKTnqD3qMMrmPs=
X-Received: by 2002:a25:9b88:: with SMTP id v8mr17018094ybo.153.1557847377908;
 Tue, 14 May 2019 08:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190512174608.10083-1-peron.clem@gmail.com> <20190512174608.10083-6-peron.clem@gmail.com>
 <CAMty3ZBTO9+9HLikR8=KgWZQBp+1yVgxQ_rD-E8WeJ8VvpuAcA@mail.gmail.com> <CAGb2v64QpH2uL3Q2=ePEaYhrB1_J5uNT4VnBssBgwbOB0NDD0Q@mail.gmail.com>
In-Reply-To: <CAGb2v64QpH2uL3Q2=ePEaYhrB1_J5uNT4VnBssBgwbOB0NDD0Q@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 14 May 2019 17:22:46 +0200
Message-ID: <CAJiuCccZvk_rHmh4Trt+1uG0APu886Zp_DvUwGcMkph0U0biAA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v4 5/8] arm64: dts: allwinner: Add mali GPU
 supply for Pine H64
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan, Chen-Yu,

On Tue, 14 May 2019 at 12:18, Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Mon, May 13, 2019 at 2:28 AM Jagan Teki <jagan@amarulasolutions.com> w=
rote:
> >
> > On Sun, May 12, 2019 at 11:16 PM <peron.clem@gmail.com> wrote:
> > >
> > > From: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > >
> > > Enable and add supply to the Mali GPU node on the
> > > Pine H64 board.
> > >
> > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/a=
rch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> > > index 4802902e128f..e16a8c6738f9 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> > > @@ -85,6 +85,11 @@
> > >         status =3D "okay";
> > >  };
> > >
> > > +&gpu {
> > > +       mali-supply =3D <&reg_dcdcc>;
> > > +       status =3D "okay";
> > > +};
> >
> > I think we can squash all these board dts changes into single patch.
>
> Yes. Please do so for all patches with the same changes applied to differ=
ent
> boards, and authored by the same person.

I thought it was required to have "smallest" patch as possible.
And it's also better for tracking "Tested-by" tag.

I will squash them in the next version.

Thanks,
Clement
>
> ChenYu
