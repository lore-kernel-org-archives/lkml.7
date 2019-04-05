Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BD6C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF4D21738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9tD8QS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbfDEQlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:41:20 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44886 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731183AbfDEQlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:41:20 -0400
Received: by mail-yw1-f67.google.com with SMTP id c4so2520832ywa.11;
        Fri, 05 Apr 2019 09:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I04mRZEsGnp/G5+0HowH3d5T9LRJwlxfv9bmSxLUcmA=;
        b=Z9tD8QS3CLVWkQTNgyk41LXuFPPVrzQrJLuYLnm+0qBJ130TFlPo+Pvb7xiMHZdS2u
         F1/jMCcila2YXv4hC9ze5YuFPpobXFKe3g3MFmA3G7U7lWqy5GW/MTrhVUUCulPbnjdi
         4WZ3zgRUqHGoAix3tgVAKHjf3ZsWeSjkfaCoyujD5P+YF4foJTQTutQ28AG0hPlwYoU+
         JqVZe4XGhDli2sLME7tohRZv4AyX1SdhUhQpPZWjEoSbZlhIT5NZpaKbhjqvkMUAoWGZ
         vv1aw1XH9sHq2wPwBvk2l1ZxdKK08WvH3SSagbpk7zqCsehP+w11wxmM8zcUj7aKvoTJ
         rLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I04mRZEsGnp/G5+0HowH3d5T9LRJwlxfv9bmSxLUcmA=;
        b=rarAkQ5f1Q7ULovmnJ4mnYt19FprS+id97gCP2IzUD5Ij7NNV8laBzM56OWjNC/gil
         rQmRBNnem6yL+B/Fr+Pc6MzMqorOzNkgHPH1j5kJ4q/Ba7ANrIjOigihk97BERMNPuW3
         JXDPXdjVax9SGi83HjozBin2YzpkOqdmh1Tr2dZWNRWfZ48JVA/56zrC+w6TxiFty6FR
         pHm7BKoa/14h9ruSCLfEXVXs6xgFuivNY4l0GDYlksWwG9qch+5InelyEZRGLN+48Lsj
         djai5anqlV3IFJHPWeJtI+7wmHWYMsjGv+aBiVUWRBrHL5L7CCf0G5c1V/t5UIJUI2Ol
         SxHA==
X-Gm-Message-State: APjAAAWKrWNaGLuJ9eUltya1Gj6NQAMAc3oputsxyU932Hm7q3/SLkdq
        1fFusoVwZyClS2HzHy7fer//szlAeZz21sgjpgY=
X-Google-Smtp-Source: APXvYqz5+K00spGH0/q2+sygQY4XGSemK/+OU7/08dqWbO+U0wCdEmlL85WrLBDCYwvJBmMBH2+JicVSGlm3N+HieAs=
X-Received: by 2002:a0d:d645:: with SMTP id y66mr11299577ywd.459.1554482478893;
 Fri, 05 Apr 2019 09:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190405122446.2101-1-peron.clem@gmail.com> <20190405150846.nurg6h4ykwtiib2v@flea>
In-Reply-To: <20190405150846.nurg6h4ykwtiib2v@flea>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 5 Apr 2019 18:42:52 +0200
Message-ID: <CAJiuCccbHg9ig4ZnyCzYAB1AqxCZLqtCF_7gKEiCD+ATwNYD-Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] arm64: allwinner: h6: orangepi: Add PIO regulators
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 5 Apr 2019 at 17:08, Maxime Ripard <maxime.ripard@bootlin.com> wrot=
e:
>
> On Fri, Apr 05, 2019 at 02:24:42PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > OrangePi One Plus and OrangePi Lite2 use the same PIO regulators.
> >
> > Add this in the common device tree.
> >
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/ar=
ch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > index b2526dac2fcf..fd2af5095425 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> > @@ -72,6 +72,12 @@
> >       status =3D "okay";
> >  };
> >
> > +&pio {
> > +        vcc-pc-supply =3D <&reg_bldo2>;
> > +        vcc-pd-supply =3D <&reg_cldo1>;
> > +        vcc-pg-supply =3D <&reg_bldo3>;
> > +};
> > +
> >  &r_i2c {
> >       status =3D "okay";
> >
> > @@ -191,6 +197,11 @@
> >       };
> >  };
> >
> > +&r_pio {
> > +        vcc-pl-supply =3D <&reg_aldo1>;
> > +        vcc-pm-supply =3D <&reg_bldo3>;
> > +};
> > +
>
> How was this tested?
Sorry maybe I should mention that but I don't own an OrangePi or a Pine H64=
.

But this should have the same issue than the Beelink GS1.

>
> Please run checkpatch on your patches as well.
Thanks for the advice,
Clement

>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
