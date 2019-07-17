Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375C5C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AF22173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXI3hn+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfGQOEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 10:04:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41047 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfGQOEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 10:04:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so21769798wrm.8;
        Wed, 17 Jul 2019 07:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZznUD/3Doukl7awZznF628Vg6/9V6wzQqJQaI/2mctw=;
        b=LXI3hn+8n+V+6M8Q47325XdmRfkVNVfYLcd+e1GHj2TtXbZBiNh1fwFhgQoQrYcVZG
         UKIzpZnomSpzeOvsRwgz8S1YD2FNizYVlsW6noHnfRTSqQGamq10fCEyxHxg3loqYkrU
         nxdKO2LGO144u7GLuhmHbFHl/jheY/bhvflyOzi2Oj/dfONYGufdifrbhHjcZtSY6+hJ
         QiI7nZFkH71dQbVIoGhk6kV1sSVq06jXG94aB7IxUoi7qBC3Fte3Z+yV4XD3y3I8UaAX
         BnO4ZSLi3RApiAzB6KuD02WUdNIleg98kwZc+8APi+T5PEyKk+9P0SSh6atW8vthCjrw
         McJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZznUD/3Doukl7awZznF628Vg6/9V6wzQqJQaI/2mctw=;
        b=twJT7BntRAHIg4ckwhj5GeVyRwqrXZhS7LCOWw3KmmPfBK4nwTD8bCWmVdHKmc+pMI
         27gWfh7wCeNHSDrI77HLUO4D6OpQtGuyz2oHrskNYxfw1EGvUXvMbCbGSdxUChz5T8DZ
         grjxgtoqs3LuNZg6dius+oT79JGoaG0luXCAN0QPR5Lu4yyxBD4lVWfi4Os81TVk/AaH
         Of98/RPHNuHbEgDXIItymX8MYitgH4i5OR4OnzlXfm7Q4NWfUyofTuabdmcM3QFRfSCH
         X9weNidDg3F3f3hZDL3fSnQSClIRJDK0StIgEoHU0BjglfRYaCD5WAi0jzRvI6aIIRVr
         oFSw==
X-Gm-Message-State: APjAAAXle3HGaBJndhHR8Z99efmjsEMXBqARS+f6aZj0odT9DG35HjtH
        BJxlIPpoVO5H3fWginyX+25IaoRay6OSr4p9hh4=
X-Google-Smtp-Source: APXvYqzpP960/74duT8ltae4WRae9+c2tEyndB2cDroFKwAvE4YQsyVSRFcoFAD1nYGVeU/h2sY49bvQ9GPuyk8AvC4=
X-Received: by 2002:adf:f450:: with SMTP id f16mr12451048wrp.335.1563372252370;
 Wed, 17 Jul 2019 07:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190702132353.18632-1-andradanciu1997@gmail.com>
 <9ea5109f8645c3f27a9e350c5f9b2d4c@www.akkea.ca> <CAEnQRZDCpPju7xBBY9=e0dWt=A9c3t3g88pEw+teoZmmOiiKXQ@mail.gmail.com>
 <9e196ce51eac9ce9c327198c4a2911a8@www.akkea.ca> <CAEnQRZCoOyyZVs0=BjXB5=wYe3XW9GOF9JvwjhSU9BsChh08uA@mail.gmail.com>
 <1563292685.2676.12.camel@pengutronix.de>
In-Reply-To: <1563292685.2676.12.camel@pengutronix.de>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 17 Jul 2019 17:04:01 +0300
Message-ID: <CAEnQRZDSzjMUQ36BCE=wQUN3fRg_pL2cDb1xxFz222LoZrmW_A@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: imx8mq: Add sai3 and sai6 nodes
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Angus Ainslie <angus@akkea.ca>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Andra Danciu <andradanciu1997@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>, andrew.smirnov@gmail.com,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 6:58 PM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Daniel,
>
> Am Mittwoch, den 03.07.2019, 16:25 +0300 schrieb Daniel Baluta:
> > > On Wed, Jul 3, 2019 at 4:12 PM Angus Ainslie <angus@akkea.ca> wrote:
> > >
> > > Hi Daniel,
> > >
> > > On 2019-07-03 07:10, Daniel Baluta wrote:
> > > > > > > On Wed, Jul 3, 2019 at 4:01 PM Angus Ainslie <angus@akkea.ca> wrote:
> > > > >
> > > > > Hi Andra,
> > > > >
> > > > > I tried this out on linux-next and I'm not able to record or play
> > > > > sound.
> > > > >
> > > > > I also added the sai2 entry to test out our devkit and get a PCM
> > > > > timeout
> > > > > with that.
> > > >
> > > > Hi Angus,
> > > >
> > > > There are still lots of SAI patches that need to be upstream. Me and
> > > > Andra
> > > > will be working on that over this summer.
> > > >
> > > > >
> > > > > On 2019-07-02 07:23, Andra Danciu wrote:
> > > > > > SAI3 and SAI6 nodes are used to connect to an external codec.
> > > > > > They have 1 Tx and 1 Rx dataline.
> > > > > >
> > > > > > > > > > > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > > > > > > > > > > Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> > > > > > ---
> > > > > > Changes since v2:
> > > > > >       - removed multiple new lines
> > > > > >
> > > > > > Changes since v1:
> > > > > >       - Added sai3 node because we need it to enable audio on pico-pi-8m
> > > > > >       - Added commit description
> > > > > >
> > > > > >  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 29
> > > > > > +++++++++++++++++++++++++++++
> > > > > >  1 file changed, 29 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > > > > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > > > > index d09b808eff87..736cf81b695e 100644
> > > > > > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > > > > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > > > > > @@ -278,6 +278,20 @@
> > > > > >                       #size-cells = <1>;
> > > > > >                       ranges = <0x30000000 0x30000000 0x400000>;
> > > > > >
> > > > > > > > > > > +                     sai6: sai@30030000 {
> > > > > > +                             compatible = "fsl,imx8mq-sai",
> > > > >
> > > > > I don't find this compatible string in sound/soc/fsl/fsl_sai.c. Aren't
> > > > > the registers at a different offset from "fsl,imx6sx-sai".
> > > >
> > > > Yes, you are right on this. We are trying to slowly push all our
> > > > internal-tree
> > > > patches to mainline. Obviously, with started with low hanging fruits,
> > > > DTS
> > > > nodes and small SAI fixes.
> > > >
> > > > Soon, we will start to send patches for SAI IP ipgrade for imx8.
> > > >
> > > > >
> > > > > How is this supposed to work ?
> > > > >
> > > >
> > > > For the moment it won't work unless we will upstream all our SAI
> > > > internal patches.
> > > > But we will get there hopefully this summer.
> > > >
> > >
> > > Shouldn't a working driver be upstream before enabling it in the
> > > devicetree ?
> >
> > I see your point here and maybe your suggestion is the ideal
> > way to do things.
> >
> > Anyhow, I don't see a problem with adding the node in dts
> > because CONFIG_FSL_SAI is not set in the default config.
> >
> > We try to speedup the upstreaming process giving the fact
> > that SAI patches will go through audio maintainer's tree and
> > the DTS patches will most likely go through Shawn's tree.
>
> I've also looked at adding audio support to one of the custom boards I
> have here and was caught a bit off guard by the fact that the SAI
> driver is totally broken for i.MX8M due to missing patches, as I
> assumed the necessary bits are in place before the DT patches are
> landed. It's certainly not how things are usually done.
>
> This also means the DT description of the SAI nodes is wrong, as they
> are actually not compatible to the "fsl,imx6sx-sai". The register
> layout is moved around, so there is no point in claiming any backwards
> compat with the old SAI version.
>
> Do you have an ETA when the necessary patches for the i.MX8M SAI will
> be available for test and review?

No ETA for this. Sorry! We try to upstream it as soon as possible
