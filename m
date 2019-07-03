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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F3FC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF08218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m01HNG6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfGCNKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:10:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34819 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCNKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:10:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id c27so2781320wrb.2;
        Wed, 03 Jul 2019 06:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Bobaa50WXbR9Y4LcY/j1xmyJEA8EpS2B/y8I4HgN8Y=;
        b=m01HNG6wrx/reIarGAfsQfArF84e7O4uyXNBjqkc9OOTg8rv7kmLMtGi/FGFpq/IHM
         LLFm+60f/VkHVa/kdCHMn3Gdk31L0i7zSM8d7O9Yop9simcXDE2BFiTdV5wWl9ApObxn
         dF3oVE8bQ7aJhpHFPcU+LGNtNDRgbAxjQfMy5gHMowF1EQq5jWLIvX2mz5NOP6Cr5jva
         WH7a83cBEgSceLeUh7dtKLV7cUNsAVryRJWwIGXFU7WSdK0WzKrsuFiIxA3/ARt4L5p4
         5kvXGVYykMG1z5CkyV+VVwmJ2z9YwW1gBVglW86TSqLoXPg99UbW1QKZ/wEPhWppm3xq
         72Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Bobaa50WXbR9Y4LcY/j1xmyJEA8EpS2B/y8I4HgN8Y=;
        b=AEqEQhW8J79qychvVLeQYIvs7ZwWlOQJCVN87SU0wX5b3FN/fsVhTKXbpZi1W7QMGk
         UdNrRjV6Qh2skfKsT0lnyYCNkrGaPdfzq9mh2QwLfkaPhIyIGSEwOrKgRzNRhl1EvkRv
         HzsgJZnen8uSjec5PoGcORNgdAG/Shq6InLBRsGSBN8nsi3vvpOQzyMNgR2ThdJ0RJjV
         zXvLcxbmGKilKLW6q6MYg0C36DwV9p3W2N+VlAKjwQ/VZrKUpu+cTLcY0mSEGMxxCSif
         tV2AhbIW7MQAzvbvj7vV7DkEA91B4A46D0uLLJgwQhg58b3cSP4O/G9wQTVjoOiexqgm
         wCEw==
X-Gm-Message-State: APjAAAWeiXFCRqMALzTyoQs3zf0ovszVj3IFfOUW+JOrsdngz2LSG1QL
        YFmpKOOrRCMpl3qfz9WvOsPkoB71sAYPnPwB9tk=
X-Google-Smtp-Source: APXvYqzxRCWgYBv94XndsktY7TXLYzN563M7b6eZz6JCymcmhJ0NgQ/r9yxy7ERMDwsgfwNkZOv6T+elFv3Cp6CEi1w=
X-Received: by 2002:adf:b69a:: with SMTP id j26mr21775717wre.93.1562159449703;
 Wed, 03 Jul 2019 06:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190702132353.18632-1-andradanciu1997@gmail.com> <9ea5109f8645c3f27a9e350c5f9b2d4c@www.akkea.ca>
In-Reply-To: <9ea5109f8645c3f27a9e350c5f9b2d4c@www.akkea.ca>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 3 Jul 2019 16:10:38 +0300
Message-ID: <CAEnQRZDCpPju7xBBY9=e0dWt=A9c3t3g88pEw+teoZmmOiiKXQ@mail.gmail.com>
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

On Wed, Jul 3, 2019 at 4:01 PM Angus Ainslie <angus@akkea.ca> wrote:
>
> Hi Andra,
>
> I tried this out on linux-next and I'm not able to record or play sound.
>
> I also added the sai2 entry to test out our devkit and get a PCM timeout
> with that.

Hi Angus,

There are still lots of SAI patches that need to be upstream. Me and Andra
will be working on that over this summer.

>
> On 2019-07-02 07:23, Andra Danciu wrote:
> > SAI3 and SAI6 nodes are used to connect to an external codec.
> > They have 1 Tx and 1 Rx dataline.
> >
> > Cc: Daniel Baluta <daniel.baluta@nxp.com>
> > Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> > ---
> > Changes since v2:
> >       - removed multiple new lines
> >
> > Changes since v1:
> >       - Added sai3 node because we need it to enable audio on pico-pi-8m
> >       - Added commit description
> >
> >  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 29
> > +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > index d09b808eff87..736cf81b695e 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -278,6 +278,20 @@
> >                       #size-cells = <1>;
> >                       ranges = <0x30000000 0x30000000 0x400000>;
> >
> > +                     sai6: sai@30030000 {
> > +                             compatible = "fsl,imx8mq-sai",
>
> I don't find this compatible string in sound/soc/fsl/fsl_sai.c. Aren't
> the registers at a different offset from "fsl,imx6sx-sai".

Yes, you are right on this. We are trying to slowly push all our internal-tree
patches to mainline. Obviously, with started with low hanging fruits, DTS
nodes and small SAI fixes.

Soon, we will start to send patches for SAI IP ipgrade for imx8.

>
> How is this supposed to work ?
>

For the moment it won't work unless we will upstream all our SAI
internal patches.
But we will get there hopefully this summer.

Thanks,
Daniel.
