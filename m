Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915C2C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7C6216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 05:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWFYV5rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfHAFcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 01:32:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44297 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfHAFcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 01:32:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so72081990wrf.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 22:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=huNfAOKjl+kk+4Jtq0u6/qi6NLR+RYJid7AxvJTx6iY=;
        b=FWFYV5rxxlAYxAyoz/kKo31BDIaLqpIqBrNWI0UIl/b7/S4FYjmih8RX2OMahtJZ0P
         8su1AOW2vd6neyowrzCnQzv1dFWesGMLkemIjw/yETxa1X/2DXRPUr9JtSnSFMfgBsuU
         wlsEtfODcgAQ079oIj/sHHVU+6k3s9j8Lur5KGllD1lDFPmDO+MYO4ZojPr3gQq+GQtX
         NNy8zD4WNZO8+9Os0mlEw4IbovjIfQ6NoXG1JsVxiyNau5fs86qT8Ff8eJe034BW10Yz
         QldOQUWCevUbtw1eUE3LU83A8qzYOi1/rjPJ78QJDQUHbtOVRN2nlhS9pdGjO2ps+Ncg
         bLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=huNfAOKjl+kk+4Jtq0u6/qi6NLR+RYJid7AxvJTx6iY=;
        b=CkvuUIlOZoRQErT19NBE9SWRWHpywTLMu5kgH4+BOUmt/HdmFPLgrbW3zlglHYVNzQ
         A+8mLVF/BUMyYw03PPJJqId0WBoE9UQ2jSr0EerQRzQUMHEdtdAYYKcFtRqUhRea32tM
         f61sCDaplb6hyz6Hte8/1poXy5bHLWeLBWjCQQnCklGVLBe7apdY4H+s9DdzFIr4fGmd
         8eVmSdcwAB9rLOkMm6g5HpYAJyU7yAeevFml4DK8KYBi/iiHBQhvOZH4jfYjc9/DANm4
         H/rxYsTfxc7puMDeJ2SRsh0VWayt3aIReN3cJYELdrD3GAgPBWIQPft3VmCPmnrEa8NU
         J5pg==
X-Gm-Message-State: APjAAAVX8KEIw4WGQ/oAlsNodeveOTcxclbWJ+mbXRXWhVET17P/C415
        wL8dhRoUlQY7+9Vyv9Jh2eg=
X-Google-Smtp-Source: APXvYqzGfkEtAIaSRDZ/5FHdZBBGE9LyWinhe6pQxrmSPYLcwZ/eZiDN2S5PQ04+spdYxBWXDX0+Kw==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr136182150wrp.101.1564637518192;
        Wed, 31 Jul 2019 22:31:58 -0700 (PDT)
Received: from jernej-laptop.localnet (cpe-194-152-11-237.cable.triera.net. [194.152.11.237])
        by smtp.gmail.com with ESMTPSA id o7sm61277403wmf.43.2019.07.31.22.31.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 22:31:57 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com, maxime.ripard@bootlin.com
Cc:     codekipper@gmail.com, Christopher Obbard <chris@64studio.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Subject: Re: [linux-sunxi] Re: [PATCH v4 6/9] ASoC: sun4i-i2s: Add multi-lane functionality
Date:   Thu, 01 Aug 2019 07:31:55 +0200
Message-ID: <1589203.0AjJVEASy3@jernej-laptop>
In-Reply-To: <20190731122953.2u3iabd6gkn7jv7k@flea>
References: <20190603174735.21002-1-codekipper@gmail.com> <2092329.vleAuWJ0xl@jernej-laptop> <20190731122953.2u3iabd6gkn7jv7k@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 31. julij 2019 ob 14:29:53 CEST je Maxime Ripard napisal(a):
> On Tue, Jul 30, 2019 at 07:57:10PM +0200, Jernej =C5=A0krabec wrote:
> > Dne torek, 04. junij 2019 ob 11:38:44 CEST je Code Kipper napisal(a):
> > > On Tue, 4 Jun 2019 at 11:02, Christopher Obbard <chris@64studio.com>=
=20
wrote:
> > > > On Tue, 4 Jun 2019 at 09:43, Code Kipper <codekipper@gmail.com> wro=
te:
> > > > > On Tue, 4 Jun 2019 at 09:58, Maxime Ripard
> > > > > <maxime.ripard@bootlin.com>
> >=20
> > wrote:
> > > > > > On Mon, Jun 03, 2019 at 07:47:32PM +0200, codekipper@gmail.com=
=20
wrote:
> > > > > > > From: Marcus Cooper <codekipper@gmail.com>
> > > > > > >=20
> > > > > > > The i2s block supports multi-lane i2s output however this
> > > > > > > functionality
> > > > > > > is only possible in earlier SoCs where the pins are exposed a=
nd
> > > > > > > for
> > > > > > > the i2s block used for HDMI audio on the later SoCs.
> > > > > > >=20
> > > > > > > To enable this functionality, an optional property has been
> > > > > > > added to
> > > > > > > the bindings.
> > > > > > >=20
> > > > > > > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > > > > >=20
> > > > > > I'd like to have Mark's input on this, but I'm really worried
> > > > > > about
> > > > > > the interaction with the proper TDM support.
> > > > > >=20
> > > > > > Our fundamental issue is that the controller can have up to 8
> > > > > > channels, but either on 4 lines (instead of 1), or 8 channels o=
n 1
> > > > > > (like proper TDM) (or any combination between the two, but that
> > > > > > should
> > > > > > be pretty rare).
> > > > >=20
> > > > > I understand...maybe the TDM needs to be extended to support this=
 to
> > > > > consider channel mapping and multiple transfer lines. I was think=
ing
> > > > > about the later when someone was requesting support on IIRC a whi=
le
> > > > > ago, I thought masking might of been a solution. These can wait as
> > > > > the
> > > > > only consumer at the moment is LibreELEC and we can patch it ther=
e.
> > > >=20
> > > > Hi Marcus,
> > > >=20
> > > > FWIW, the TI McASP driver has support for TDM & (i think?) multiple
> > > > transfer lines which are called serializers.
> > > > Maybe this can help with inspiration?
> > > > see
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tre
> > > > e/s
> > > > ound/soc/ti/davinci-mcasp.c sample DTS:
> > > >=20
> > > > &mcasp0 {
> > > >=20
> > > >     #sound-dai-cells =3D <0>;
> > > >     status =3D "okay";
> > > >     pinctrl-names =3D "default";
> > > >     pinctrl-0 =3D <&mcasp0_pins>;
> > > >    =20
> > > >     op-mode =3D <0>;
> > > >     tdm-slots =3D <8>;
> > > >     serial-dir =3D <
> > > >    =20
> > > >         2 0 1 0
> > > >         0 0 0 0
> > > >         0 0 0 0
> > > >         0 0 0 0
> > > >     >
> > > >     >;
> > > >    =20
> > > >     tx-num-evt =3D <1>;
> > > >     rx-num-evt =3D <1>;
> > > >=20
> > > > };
> > > >=20
> > > > Cheers!
> > >=20
> > > Thanks, this looks good.
> >=20
> > I would really like to see this issue resolved, because HDMI audio supp=
ort
> > in mainline Linux for those SoCs is long overdue.
> >=20
> > However, there is a possibility to still add HDMI audio suport (stereo
> > only) even if this issue is not completely solved. If we agree that
> > configuration of channels would be solved with additional property as
> > Christopher suggested, support for >2 channels can be left for a later
> > time when support for that property would be implemented. Currently,
> > stereo HDMI audio support can be added with a few patches.
> >=20
> > I think all I2S cores are really the same, no matter if internally
> > connected to HDMI controller or routed to pins, so it would make sense =
to
> > use same compatible for all of them. It's just that those I2S cores whi=
ch
> > are routed to pins can use only one lane and >2 channels can be used on=
ly
> > in TDM mode of operation, if I understand this correctly.
> >=20
> > New property would have to be optional, so it's omission would result in
> > same channel configuration as it is already present, to preserve
> > compatibility with old device trees. And this mode is already sufficient
> > for stereo HDMI audio support.
>=20
> Yeah, it looks like a good plan.
>=20
> > Side note: HDMI audio with current sun4i-i2s driver has a delay (about a
> > second), supposedly because DW HDMI controller automatically generates =
CTS
> > value based on I2S clock (auto CTS value generation is enabled per
> > DesignWare recomendation for DW HDMI I2S interface).
>=20
> Is that a constant delay during the audio playback, or only at startup?

I think it's just at startup, e.g. if you're watching movie, audio is in sy=
nc,=20
it's just that first second or so is silent.

>=20
> > I2S driver from BSP Linux solves that by having I2S clock output
> > enabled all the time. Should this be flagged with some additional
> > property in DT?
>=20
> I'd say that if the codec has that requirement, then it should be
> between the codec and the DAI, the DT doesn't really have anything to
> do with this.

Ok, but how to communicate that fact to I2S driver then? BSP driver solves=
=20
that by using different compatible, but as I said before, I2S cores are not=
=20
really different, so this seems wrong.

Best regards,
Jernej


