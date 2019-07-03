Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37569C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C1F218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpg6IaJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfGCNZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:25:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38390 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfGCNZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:25:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id p11so2817271wro.5;
        Wed, 03 Jul 2019 06:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4NwugRsrz30iTHZQgWt6F/3Ov8fl00xOltiwxUVEio8=;
        b=gpg6IaJ2V2R/S8X/fVZz+TVrGpioO30d1kedBhmuLkrgt48raO6wgYYtLQMI0SvZH8
         xOMeAXfBsRZCOnvNrZeBFCo500XqvHpTmjJNXjW3IGTvTjEYx/rClLrlnWh1rX4gaCQX
         Nxd8k8gSxt3B0QMV6mUHj0QG/bKQPiEKcQmDi8YY92Jtw0bdwFuMYYCmW2IpDK5sUMVl
         8qv2Uc+Mg7HoiZCajbjFv+O1WGCDYSQCf2SFM8wS1GL9a35GOnSJF/5srPQcPOlXcGWR
         lov25fTvovhq667L//7AO05bdZ+UicM3tDbMJw4XnDQa5VoAvcHS7/41wY7NrwoN/8bF
         t2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4NwugRsrz30iTHZQgWt6F/3Ov8fl00xOltiwxUVEio8=;
        b=PMh546tS69a8jMQuh8PYbblhriApIeqA4L8xFO64jej2hgsffiRQcaK0PCi4GwUdxx
         eSHGNvH5VjoRg86fmgqIDk9OjdmCarahe7SxNM72oLr/FftBze9yFKJtzyBKhxf5yN+n
         ECsf1AW9tTmvgd+pi0NnE8oEphP709sXPFpQKzFe/CigVt7VT2B+o1c0/e83wXIGoFCu
         2yh7wNucSRKdKu60fnVuKFy61MYBWWcj2hECx+TjSmYUVxr1Sjx+ZLLBJbxUidJ5e9cA
         y7e7CKrobe1kG15T8LDYMdUQjM5zqFA0/T10iV34UDpUXbS2P4mwV6YgQeGOsMtozEcj
         o+BQ==
X-Gm-Message-State: APjAAAUK9DPJ67p7yq/B/NkJmgRk4NHiMQDLHv4Dlzr3xq8mAJXXxkCa
        2gRotKfA2eAD/Q0Aehf0quCnc0Q5s0Xe4sgb1T4=
X-Google-Smtp-Source: APXvYqxo5f8uBoCPBbG+a3vlWIJP2lcqQMuX5HJWpva0kJNkHI1DRDi/7+BDTKw8Pzb4DjO37HrMXCarLAsyxHuzdcs=
X-Received: by 2002:adf:b69a:: with SMTP id j26mr21826997wre.93.1562160321848;
 Wed, 03 Jul 2019 06:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190702132353.18632-1-andradanciu1997@gmail.com>
 <9ea5109f8645c3f27a9e350c5f9b2d4c@www.akkea.ca> <CAEnQRZDCpPju7xBBY9=e0dWt=A9c3t3g88pEw+teoZmmOiiKXQ@mail.gmail.com>
 <9e196ce51eac9ce9c327198c4a2911a8@www.akkea.ca>
In-Reply-To: <9e196ce51eac9ce9c327198c4a2911a8@www.akkea.ca>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 3 Jul 2019 16:25:10 +0300
Message-ID: <CAEnQRZCoOyyZVs0=BjXB5=wYe3XW9GOF9JvwjhSU9BsChh08uA@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: imx8mq: Add sai3 and sai6 nodes
To:     Angus Ainslie <angus@akkea.ca>
Cc:     Andra Danciu <andradanciu1997@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, andrew.smirnov@gmail.com,
        Carlo Caione <ccaione@baylibre.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 4:12 PM Angus Ainslie <angus@akkea.ca> wrote:
>
> Hi Daniel,
>
> On 2019-07-03 07:10, Daniel Baluta wrote:
> > On Wed, Jul 3, 2019 at 4:01 PM Angus Ainslie <angus@akkea.ca> wrote:
> >>
> >> Hi Andra,
> >>
> >> I tried this out on linux-next and I'm not able to record or play
> >> sound.
> >>
> >> I also added the sai2 entry to test out our devkit and get a PCM
> >> timeout
> >> with that.
> >
> > Hi Angus,
> >
> > There are still lots of SAI patches that need to be upstream. Me and
> > Andra
> > will be working on that over this summer.
> >
> >>
> >> On 2019-07-02 07:23, Andra Danciu wrote:
> >> > SAI3 and SAI6 nodes are used to connect to an external codec.
> >> > They have 1 Tx and 1 Rx dataline.
> >> >
> >> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> >> > Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> >> > ---
> >> > Changes since v2:
> >> >       - removed multiple new lines
> >> >
> >> > Changes since v1:
> >> >       - Added sai3 node because we need it to enable audio on pico-pi-8m
> >> >       - Added commit description
> >> >
> >> >  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 29
> >> > +++++++++++++++++++++++++++++
> >> >  1 file changed, 29 insertions(+)
> >> >
> >> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> >> > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> >> > index d09b808eff87..736cf81b695e 100644
> >> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> >> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> >> > @@ -278,6 +278,20 @@
> >> >                       #size-cells = <1>;
> >> >                       ranges = <0x30000000 0x30000000 0x400000>;
> >> >
> >> > +                     sai6: sai@30030000 {
> >> > +                             compatible = "fsl,imx8mq-sai",
> >>
> >> I don't find this compatible string in sound/soc/fsl/fsl_sai.c. Aren't
> >> the registers at a different offset from "fsl,imx6sx-sai".
> >
> > Yes, you are right on this. We are trying to slowly push all our
> > internal-tree
> > patches to mainline. Obviously, with started with low hanging fruits,
> > DTS
> > nodes and small SAI fixes.
> >
> > Soon, we will start to send patches for SAI IP ipgrade for imx8.
> >
> >>
> >> How is this supposed to work ?
> >>
> >
> > For the moment it won't work unless we will upstream all our SAI
> > internal patches.
> > But we will get there hopefully this summer.
> >
>
> Shouldn't a working driver be upstream before enabling it in the
> devicetree ?

I see your point here and maybe your suggestion is the ideal
way to do things.

Anyhow, I don't see a problem with adding the node in dts
because CONFIG_FSL_SAI is not set in the default config.

We try to speedup the upstreaming process giving the fact
that SAI patches will go through audio maintainer's tree and
the DTS patches will most likely go through Shawn's tree.

thanks,
Daniel.
