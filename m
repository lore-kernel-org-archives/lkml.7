Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA9CC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96EC82186A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 12:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558700974;
	bh=kkMeV3Qa9ZecFjYtXsmMBNygjCqjuPUH0BPe7UWSBes=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=08+tvLBHSNQucWGeK8rtOsKwd+06KfpO/TXIl38ddK3EBYvW2NC2Pdcdo17mXxrxO
	 bFcbGtWqr0aKizCz/Y61RqT26Icg6EWdFlqqFDgMJXeM5w5Bno8HByeQkQkoQWvY4g
	 2cuhIpUt86ETT3BRusz0/0iJcj1ct6eUvgsA+i0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403763AbfEXM3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 08:29:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389057AbfEXM3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 08:29:33 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A10742133D;
        Fri, 24 May 2019 12:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558700972;
        bh=kkMeV3Qa9ZecFjYtXsmMBNygjCqjuPUH0BPe7UWSBes=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rGljGda+WHDyJKj+CRGvm+n+fq0a+B/CHmlvdieBNDIC10WNowElnWEy/8HeY5Rzj
         uxotR1JsdPOU2qe9SaLSPmGgsT5x0EnsIhuBQg9b7SWHkOyiS/BvYvCfqkenmRmf/w
         vntu/FhMELK1PgnZRm8g+z8aP8Yc4y5luv33kPj0=
Received: by mail-qk1-f177.google.com with SMTP id q197so7236782qke.7;
        Fri, 24 May 2019 05:29:32 -0700 (PDT)
X-Gm-Message-State: APjAAAXG25TUDcnQrM+NQcJlEwKtXwZ0SanzBgFNdA0woCjxnQeo/SsR
        2iE8B38VOUTbHMa2I0GmG8kedNVnMIHk/ar3oA==
X-Google-Smtp-Source: APXvYqx2xqDEadQisTg7b1WEJZG9w2R5BeEk8IqwCYl56O2Vztp67RVbSkkhCGkdjSKdSi//kWMqFU8vKJEKBHTFnr4=
X-Received: by 2002:ac8:6b14:: with SMTP id w20mr64976477qts.110.1558700971929;
 Fri, 24 May 2019 05:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190509070657.18281-1-chuanhua.han@nxp.com> <20190517023728.GA15856@dragon>
 <AM6PR04MB4357C78FCEBA1B00AA42ED2E970B0@AM6PR04MB4357.eurprd04.prod.outlook.com>
 <AM6PR04MB586341334E62A663EE5E8BD18F0B0@AM6PR04MB5863.eurprd04.prod.outlook.com>
 <AM6PR04MB435758E1498B6A2BE0C0ACE397070@AM6PR04MB4357.eurprd04.prod.outlook.com>
 <AM6PR04MB58631458E6D851E4D83A77ED8F070@AM6PR04MB5863.eurprd04.prod.outlook.com>
 <AM6PR04MB435708872A4DBA92561C772597000@AM6PR04MB4357.eurprd04.prod.outlook.com>
 <AM6PR04MB5863FA1CE6D1E40F11B2E5008F000@AM6PR04MB5863.eurprd04.prod.outlook.com>
 <AM6PR04MB4357072E079BDD8D1866595797020@AM6PR04MB4357.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4357072E079BDD8D1866595797020@AM6PR04MB4357.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 24 May 2019 07:29:20 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+evXqKKyXLFbE+9o8X5BA9NWmcjvZ9-Y1Y7-pwcu8nJg@mail.gmail.com>
Message-ID: <CAL_Jsq+evXqKKyXLFbE+9o8X5BA9NWmcjvZ9-Y1Y7-pwcu8nJg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH] arm64: dts: ls1028a: fix watchdog device node
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     Leo Li <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ying Zhang <ying.zhang22455@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 4:48 AM Chuanhua Han <chuanhua.han@nxp.com> wrote:
>
> Hi, Rob Herring
>
> > -----Original Message-----
> > From: Leo Li
> > Sent: 2019=E5=B9=B45=E6=9C=8822=E6=97=A5 14:50


> > > > > > > > > -             wdog0: watchdog@23c0000 {
> > > > > > > > > -                     compatible =3D "fsl,ls1028a-wdt",
> > > > "fsl,imx21-wdt";
> > > > > > > > > -                     reg =3D <0x0 0x23c0000 0x0 0x10000>=
;
> > > > > > > > > -                     interrupts =3D <GIC_SPI 59
> > > > > > IRQ_TYPE_LEVEL_HIGH>;
> > > > > > > > > -                     clocks =3D <&clockgen 4 1>;
> > > > > > > > > -                     big-endian;
> > > > > > > > > -                     status =3D "disabled";
> > > > > > > > > +             cluster1_core0_watchdog: wdt@c000000 {
> > > > > > > >
> > > > > > > > Keep 'watchdog' as the node name,
> > > > > > > Thanks for your replay
> > > > > > > Do you mean replace the =E2=80=98wdt=E2=80=99 with =E2=80=98w=
atchdog=E2=80=99?
> > > > > > > and keep nodes sort in unit-address.
> > > > > > > What does this mean?
> > > > > >
> > > > > > That means order the nodes by the addresses (e.g. c000000,
> > > > > > c010000)
> > > > > The current order is correct=EF=BC=88The first is c000000, then c=
000000=EF=BC=89.
> > > >
> > > > But they are added after gpio@2320000 and before sata@3200000.
> > > I changed and made the second version of the patch, but I found the
> > > following error when I executed ./scripts/checkpatch.pl xxx.patch to
> > > check the patch:
> > >
> > > WARNING: DT compatible string vendor "arm" appears un-documented --
> > > check ./Documentation/devicetree/bindings/vendor-prefixes.txt
> > > #43: FILE: arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:351:
> > > + compatible =3D "arm,sp805", "arm,primecell";
> > >
> > > However, there is no vendor-prefixes.txt file in the
> > > ./Documentation/devicetree/bindings/ directory, only vendor-
> > > prefixes.yaml.
> > > Moreover, there are =E2=80=98arm=E2=80=99 vendors in vendor-prefixes.=
yaml.
> >
> > Added Rob Herring to the thread.
> >
> > > Request help=EF=BC=8Cthanks
> How can I solve this patch check error? Ask for help, thank you!

Ignore it. A fix to checkpatch.pl is pending.

Rob
