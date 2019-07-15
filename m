Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28C8C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B480A20665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNARhfF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfGOTVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:21:14 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42132 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbfGOTVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:21:13 -0400
Received: by mail-yw1-f67.google.com with SMTP id z63so7734929ywz.9;
        Mon, 15 Jul 2019 12:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T6L/T//A/hr8zs4n7h5mkmSwRWcgvC/d4JNrZUI4Hm8=;
        b=WNARhfF9FItohnvszMOVl4tf67FTBW8z6mVMLcqSbMbljIgUy+cX0Jp0YfAAn6kvUV
         6B6qTRPgZBjVJy0+wx5Cj2BakLpiAiVZthmkB8RwCAJT4lZqVISu/fGLTrTZrrYiHF+U
         yzM4+eKufO1eXC5AsamPg9bdbjtTI2uJcJPJsDIzAzR1eYQH2/3+DY2OOPuUGErHf+cH
         6s29jnfo/oPHtq5a/H0Sy1cvGpnTzS1ni4CRff8wbQQa+ysZ+sXz3lWCtiOED27rdf1t
         tkQL8IOHrjNfyHRrYx0QL8ftLKDHp1uf1JDapE1bQHyZKsu3iShgGsknBrH0rgd3UHOE
         ETDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T6L/T//A/hr8zs4n7h5mkmSwRWcgvC/d4JNrZUI4Hm8=;
        b=K4cSgTRJF26NeBuXwZ3+dfTANZMysO11wMBjvyBJWVkmWxqQF5jh7WsqD4co5BNOQw
         oOsp861a4HAI/G5Rt2vAD8H4aMt61/BfDoFCveFbFpPhinLw92c0uoO1j6rpskdAMyS8
         jYi3UOzjVVfLL+i0/o0zcX1vW/wP/0c3hrM7vJ9Qj9X7BOZXRCRbpEc5Vk/cz9xwyjlb
         b2iSROxJ3bdx7O1Zf9u+XNnfROSO76LajvD7Rw7I+rlzMQOWFSZwMPXwtzhcizSecOgb
         bcqaIh1X0u4QetQBDJLMyujkgyJdOIIeXlONQyEx+u/CLWOwtj58XT2u1YGYmXrdKNN6
         3FUA==
X-Gm-Message-State: APjAAAVhxSmJfckZUbEdw+Wv9rwvRbg6JlSLjRXe9NhGg2wAbg7hm9Za
        fDVQAnSV5XSFyD+mz9L+pVBMIk050ilJW+0jhu0=
X-Google-Smtp-Source: APXvYqxcM/GTLLwXLJ0XLGxzMQuEi34XclLyeCNzAgq1oLJCQsl7q05aszfWDHWZs0j8skZrYjD5o0W5JZ3MI1abTjQ=
X-Received: by 2002:a0d:d884:: with SMTP id a126mr16542399ywe.349.1563218472776;
 Mon, 15 Jul 2019 12:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190527200627.8635-1-peron.clem@gmail.com> <CAJiuCcfUhBxEr=o7VVpPROQZadQh7z1QC0SkWSYt-53Sj3H2qw@mail.gmail.com>
In-Reply-To: <CAJiuCcfUhBxEr=o7VVpPROQZadQh7z1QC0SkWSYt-53Sj3H2qw@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 15 Jul 2019 21:21:01 +0200
Message-ID: <CAJiuCcc3_1jZWV7G3+fFQYRZ8b6qcAbnH+K6pkRvww6_D=OMAw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Allwinner H6 SPDIF support
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm missing ACK from ASoC Maintainers patch 2-3-4.

It's really small paches, if you could have a look at it.
Many thanks,
Cl=C3=A9ment



On Fri, 14 Jun 2019 at 10:29, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Hi,
>
> On Mon, 27 May 2019 at 22:10, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.c=
om> wrote:
> >
> > *H6 DMA support IS REQUIRED*
>
> DMA has been merged, so this series can be merge when ASoC maintainers
> have reviewed it.
>
> Regards,
> Cl=C3=A9ment
>
> >
> > Allwinner H6 SoC has a SPDIF controller called One Wire Audio (OWA) whi=
ch
> > is different from the previous H3 generation and not compatible.
> >
> > Difference are an increase of fifo sizes, some memory mapping are diffe=
rent
> > and there is now the possibility to output the master clock on a pin.
> >
> > Actually all these features are unused and only a bit for flushing the =
TX
> > fifo is required.
> >
> > Also this series requires the DMA working on H6, a first version has be=
en
> > submitted by Jernej =C5=A0krabec[1] but has not been accepted yet.
> >
> > [1] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=
=3D89011
> >
> > Changes since v3:
> >  - rename reg_fctl_ftx to val_fctl_ftx
> >  - rebase this series on sound-next
> >  - fix dt-bindings due to change in sound-next
> >  - change node name sound_spdif to sound-spdif
> >
> > Changes since v2:
> >  - Split quirks and H6 support patch
> >  - Add specific section for quirks comment
> >
> > Changes since v1:
> >  - Remove H3 compatible
> >  - Add TX fifo bit flush quirks
> >  - Add H6 bindings in SPDIF driver
> >
> > Cl=C3=A9ment P=C3=A9ron (7):
> >   dt-bindings: sound: sun4i-spdif: Add Allwinner H6 compatible
> >   ASoC: sun4i-spdif: Move quirks to the top
> >   ASoC: sun4i-spdif: Add TX fifo bit flush quirks
> >   ASoC: sun4i-spdif: Add support for H6 SoC
> >   arm64: dts: allwinner: Add SPDIF node for Allwinner H6
> >   arm64: dts: allwinner: h6: Enable SPDIF for Beelink GS1
> >   arm64: defconfig: Enable Sun4i SPDIF module
> >
> >  .../sound/allwinner,sun4i-a10-spdif.yaml      |  1 +
> >  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  4 ++
> >  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 38 ++++++++++++++
> >  arch/arm64/configs/defconfig                  |  1 +
> >  sound/soc/sunxi/sun4i-spdif.c                 | 49 ++++++++++++++++---
> >  5 files changed, 87 insertions(+), 6 deletions(-)
> >
> > --
> > 2.20.1
> >
