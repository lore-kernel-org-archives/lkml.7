Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C943AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CF62084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 05:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YP4NCvvk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfCLFDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 01:03:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42472 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfCLFDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 01:03:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id o9so1149573wrv.9;
        Mon, 11 Mar 2019 22:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ujeKSdpurBvV0kIlQTS8l+E4O7rsoHG6auAAX6bWdjg=;
        b=YP4NCvvktxdjsBQ4kpouI+hBDkjSQrSh5cSzVQUaZ1yv0SpDVZKXlkC30d6ToVDTDQ
         0B0CHyrrP/xS7UvlJo1zAiEmW6o6c6x4JKHCf9EB1w4XaxCDIm3VvQGgUN1L7vaC1via
         InztyNxiEUEWhUZx045zkH9qXWURPur75slg5tDvuDPeYB0Yxxg1d9OD4W6avgDo4wCu
         HN0orKnQrSTJo60/rGXRWSq+0hUb+yLG/fVHLTntYdDw6tqTqCjzzFo/VnSpbT83Dg9k
         Z+AFucFdYUmc/2ZNriSZooPJQXhOtGBzKPVDx5+ox6+Fzac7QFYyLXGE9j/mIWOA2niU
         4HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=ujeKSdpurBvV0kIlQTS8l+E4O7rsoHG6auAAX6bWdjg=;
        b=otSHRdWK6Lfe+H+HlkeRTJHlP5J0Nh9nORTqrK+y/3pkmBbDurcikghAHhwtuYuHE1
         DaCVnxmCjcl6demL2kqOFoEQp7NufzdUSAGb+8TRvYVAQZex75EfnCQ7utQLIGNus6RI
         0TpzsDM0YxRL1JePlNqnx7gNYBz/lJaiRZiKEvuhgUvbKJKexB0xKqW0t49ZKemsdvv9
         aL1fU/pa4Eq35RSrAidnIq4Mp/ZJfFcusjWcWuITnNNW4xAPlBx3bYnlaGrMTwYBBBtr
         uW3dUhhvp36CTw5uYJ+Bqfo2mScG3k7LZpIoZqzoxvESDrWzf+3ZD2XkN8HhZVl7ayQu
         lhgg==
X-Gm-Message-State: APjAAAUAUuMbSBUTm2GaZGYS564bLNxIUE2bOX13fa+Q+OS1RJV/dhVo
        jWgHm0kNBhbKjrB5DNUyph8vmjgZQEDEYlKCjms=
X-Google-Smtp-Source: APXvYqz5qxCINOo98D+9cdo1pshRGoNbHhuBoLK84jz3klQpgmyx68G46fn2j7nnXCygpaug+O4Td4E98Hz3WALRbSU=
X-Received: by 2002:adf:9167:: with SMTP id j94mr23629743wrj.106.1552367011278;
 Mon, 11 Mar 2019 22:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181125161859.GA5277@arx-s1> <20181220175009.GF9408@ulmo> <CAJeuY7-StNNDpBPyw1JH5Jmc-NhDw67F6Veh0S2tBTmENCTY8Q@mail.gmail.com>
In-Reply-To: <CAJeuY7-StNNDpBPyw1JH5Jmc-NhDw67F6Veh0S2tBTmENCTY8Q@mail.gmail.com>
From:   Hao Zhang <hao5781286@gmail.com>
Date:   Tue, 12 Mar 2019 13:03:19 +0800
Message-ID: <CAJeuY7_gx=PBhF4t40nCCWia-aq1G3t9D9nKS7ejOh56t2RkHQ@mail.gmail.com>
Subject: Fwd: [PATCH v3 1/6] Documentation: ARM: sunxi: pwm: add Allwinner sun8i.
To:     Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        linux-gpio@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org,
        linux-sunxi@googlegroups.com, Hao Zhang <hao5781286@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ---------
From: Hao Zhang <hao5781286@gmail.com>
Date: 2019=E5=B9=B43=E6=9C=8812=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=
=8812:59
Subject: Re: [PATCH v3 1/6] Documentation: ARM: sunxi: pwm: add Allwinner s=
un8i.
To: Thierry Reding <thierry.reding@gmail.com>


Thierry Reding <thierry.reding@gmail.com> =E4=BA=8E2018=E5=B9=B412=E6=9C=88=
21=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=881:50=E5=86=99=E9=81=93=EF=
=BC=9A
>
> On Mon, Nov 26, 2018 at 12:18:59AM +0800, Hao Zhang wrote:
> > This patch adds Allwinner sun8i pwm binding document.
> >
> > Signed-off-by: Hao Zhang <hao5781286@gmail.com>
> > ---
> >  .../devicetree/bindings/pwm/pwm-sun8i.txt          | 24 ++++++++++++++=
++++++++
> >  1 file changed, 24 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt b/Docu=
mentation/devicetree/bindings/pwm/pwm-sun8i.txt
> > new file mode 100644
> > index 0000000..7531d85
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> > @@ -0,0 +1,24 @@
> > +Allwinner sun8i R40/V40/T3 SoC PWM controller
> > +
> > +Required properties:
> > +  - compatible: Should be one of:
> > +    - "allwinner,sun8i-r40-pwm"
> > +  - reg: Physical base address and length of the controller's register=
s
> > +  - interrupts: Should contain interrupt.
> > +  - clocks: From common clock binding, handle to the parent clock.
> > +  - clock-names: Must contain the clock names described just above.
> > +  - pwm-channels: PWM channels of the controller.
>
> Why do you need this? In the cover letter you say:
>
>         "The sun8i R40/T3/V40 PWM has 8 PWM channals ..."
>
> Why does this need to be specified in the DT?

T3 PWM has 8 channals, i think it is necessary to tell user how to
specify it Instead of
hardcode the channal myself :)

Thanks for review :)

>
> Thierry
> -----BEGIN PGP SIGNATURE-----
>
> iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwb1k4ACgkQ3SOs138+
> s6EOyA//auHjqjKwvjCLwWgHXdVr26cFUnFn/Ml6ZHHRe+oLCiYsatv4AZfGFvZ7
> CIGWN3zUu9c5YoDOd1isauQYgRtTsShWYC4gPxFFK9hWfb8f3o/wG60whkNDuvLL
> 1SAQ/KJTC01LQIEXfHlb60EPvKCtt4YUQG4PkTGBGOHSO+MhWQHRLy5aLaq+d3yH
> KHaDZ0PuZvYNnFWi7W/ggraiIlRToPH8HanFzGew+gUfPjClrczjrGqgn8u0bAL6
> MuKDMHLgjI/D8cs7XIaXc/OCPsp69B4JGrRJsxYh0KGKthaYDeKAUERpvsltDhGT
> oTB55mJPZlriaiEOSwPrj+M0JQe9AnUIBVEiSIP2dSn8+rcSlWd10ysEjnCH/Ea7
> ARkamiRCk2hgOhZlDZcm+hjh7VxnJinaYahGFXMszpVgCScHT/fjZKexGqX8NJa8
> EWRJjeJaS1jLpLb7ZhM0iZrhzSC638G/5z3+1CWmyxwOvICb0FXzQDCTNSm1t8DO
> NicV26tAWMIvDEW5PcTqrJaSvQmNrr4MiBiqocKs4N+ZA7Ey8JQW0oUFzwiwD6Ew
> HaOuVXDlha1SZNK2tEnTDsTctXefl+eB7xeQ8MOHPp3yeKrpQlj4gHSyNOboEaXR
> 8el/ZC1gGYHPeFGPSgXTbRNFwNY8/9GKPfP5cUgLc+e1B7oWAHg=3D
> =3D9v1O
> -----END PGP SIGNATURE-----
