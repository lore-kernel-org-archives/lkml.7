Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0126BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19642075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBiu3Qda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbfC0JwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:52:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35800 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfC0Jv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:51:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id s39so7907625edb.2;
        Wed, 27 Mar 2019 02:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/5AIoA6ChhwDIegaA+cCOSrOTfzvCLOmDA5uUa6xubw=;
        b=KBiu3QdalWk+uy2S35xmGZmzR7JkdTt9uB+noCYRIudp6H4Tbobaya+SAq2y57+bue
         RXET1QkI5YifAHNdOUbIznEQgxDfDvSqRc5cwAjDhFeGepsLiI9DehzRdqnDKPIIj+ba
         Sa01n2SpNgi2/5BRKFJMmeeO4M6L2odH7GpLPWejxC+5LjUcTtnAfGNqqDK3TTypJzm5
         A+7g9DcWOhnszQ7QXJ70LIMkyHfF6pBOc89Nyve6MefzoRhWZBMY8f3L/UoYnH5SOAiS
         z4M49J7WcJxOjA8hiTx6C0xFA4ebO85MfbLnaJqt2yZFLdKSPT6osalW3nJjCU2BslO2
         CGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/5AIoA6ChhwDIegaA+cCOSrOTfzvCLOmDA5uUa6xubw=;
        b=kHKR+RWxF6rM7njetMnMQawZ/7qyVFsoQV7fue7NQuTb1SXozyKRMJJ3N5qjGQiHNM
         eciGnwEpjGrj4WzPaKxnN8IlBCnI6FufyG/Fjr7CZippUmUz/wPJdbFNwbQH7cb8SKqZ
         VoSRCMV9u4Ae7KWS4kVyVh449WvLQrscokpn3XzGBD4z/ZzuwvcSoMs80m2p+qfwL2Z1
         G8OGeB50N2xuPPexywNw1MlueW4fNXbe8kV7gypke2bqp9yQdoa++FZqcTuyZenhbtyw
         q2PgvPe/QSpp2DVt7EXbz39NBg4O/Ujlu1jRyzMXVrMXSh8vSpV9d6Ah5cLHpgU0RXBQ
         7cdA==
X-Gm-Message-State: APjAAAUpVHcpXUMPIYAY8nsh4q5DXUXGcLrK/FF2ath4kt83Mvo4Zq7z
        Wgw5PM6pZFePGQUeOk3yquNTOPF7IOMnIu3mrIs=
X-Google-Smtp-Source: APXvYqxja82EKeeVTfP4Uu6LO7CfFfwNHq2zdWAx9rwjiLRuyrD0Ma6yZ5eEmKVebIeER0womJZsFIrFIFaKYIqMn54=
X-Received: by 2002:a50:aa2e:: with SMTP id o43mr23262618edc.67.1553680317412;
 Wed, 27 Mar 2019 02:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190308120141.3698-1-daniel.baluta@nxp.com> <20190308120141.3698-2-daniel.baluta@nxp.com>
 <20190319143139.GA24315@dragon> <f5934d5bca4b9241d0ac84de463fbeed@www.akkea.ca>
In-Reply-To: <f5934d5bca4b9241d0ac84de463fbeed@www.akkea.ca>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 27 Mar 2019 11:51:45 +0200
Message-ID: <CAEnQRZD27=jCvGB_Go-niXyEtrFu=MP2Wyvvqcx2CpnQ4Npx-Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] arm64: dts: imx8mq: Add SDMA nodes
To:     Angus Ainslie <angus@akkea.ca>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        baruch@tkos.co.il, Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        ccaione@baylibre.com, Chris Spencer <spencercw@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>, agx@sigxcpu.org,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:44 PM Angus Ainslie <angus@akkea.ca> wrote:
>
> On 2019-03-19 07:31, Shawn Guo wrote:
> > On Fri, Mar 08, 2019 at 12:02:22PM +0000, Daniel Baluta wrote:
> >> SDMA1 is part of AIPS-3 region and SDMA2 is part
> >> of AIPS-1 region.
> >>
> >> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> >
> > Reviewed-by tag should go after your SoB, since that's the sequence of
> > how they come.
> >
> >> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> >> [initial submit in i.MX internal tree]
> >> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> >> [adaptation for linux-next]
> >
> > I would see these notes in commit log or even just cover letter.
> >
> > Shawn
> >
> >> ---
> >>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 22 ++++++++++++++++++++++
> >>  1 file changed, 22 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> >> b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> >> index 9155bd4784eb..9d48450453fb 100644
> >> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> >> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> >> @@ -234,6 +234,17 @@
> >>                              status = "disabled";
> >>                      };
> >>
> >> +                    sdma2: sdma@302c0000 {
> >> +                            compatible = "fsl,imx8mq-sdma","fsl,imx7d-sdma";
> >> +                            reg = <0x302c0000 0x10000>;
> >> +                            interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> >> +                            clocks = <&clk IMX8MQ_CLK_SDMA2_ROOT>,
> >> +                                     <&clk IMX8MQ_CLK_SDMA2_ROOT>;
> >> +                            clock-names = "ipg", "ahb";
> >> +                            #dma-cells = <3>;
> >> +                            fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
> >> +                    };
> >> +
> >>                      iomuxc: iomuxc@30330000 {
> >>                              compatible = "fsl,imx8mq-iomuxc";
> >>                              reg = <0x30330000 0x10000>;
> >> @@ -575,6 +586,17 @@
> >>                              status = "disabled";
> >>                      };
> >>
> >> +                    sdma1: sdma@30bd0000 {
> >> +                            compatible = "fsl, imx8mq-sdma","fsl,imx7d-sdma";
>
> There shouldn't be a space in the imx8mq compatible string.

Oh, nice catch. This patch series is already in so care to send a fix?

Otherwise, I will take care of it.

thanks,
Daniel.
