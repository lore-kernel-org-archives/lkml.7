Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BE1C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B30720873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd4qes53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfGSLuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 07:50:06 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45932 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfGSLuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:50:06 -0400
Received: by mail-oi1-f194.google.com with SMTP id m206so24035885oib.12;
        Fri, 19 Jul 2019 04:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sqpTcP76z8L1qAX6ZIXz8oQ1xDJvx6eMGKj4s5NJ4n4=;
        b=bd4qes53GBobFCQjiSauq8kko/7lDoscPritfqpd7h/NfzroV52tvn57Qt4nLg/MDZ
         gnNOw0YQmSxdV2YLiKfb7LLmgz8iHznTxZAACh/IPiIdIMsqfN28Z3RO3tGYlR9ob+Sr
         XlnAux65a7xlSAaPyepAcJCfmIcS/uc7Ix3qoSzepLhj4qXywdHrTVU1TVWvs0C5GUQG
         If3PkDVd/xE/RzS2AExYFWIW7+Kyhx3MEk2Xhu6E1HMJWcwnomQukWTaiepmlvFnOS/u
         A3DeCZIuf4Yg4Oqjy1pDtWwASCaznZkERw4FqyY8AZMYCJUACciqXfHr2rV4cw1U6aWE
         1tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sqpTcP76z8L1qAX6ZIXz8oQ1xDJvx6eMGKj4s5NJ4n4=;
        b=HYkAnrd14WEsUXIjZGSSoaXRZ3nskAvp3n23JCPooX+PV0WdRm3E0/FAL6/RErzjFz
         p3Vpv8yjK8V1CQjkzIerWOYRiGBVr5FaJE6+57sa1P/nHkIYU/cFDYOdE5KFfEofhUIR
         yHJpw/kJ/CSR3lLbvJXiRMAEzxlPv0kAuGGLiiLObxvKlHYNlV1f4X/i15CPT0wSr5b0
         mnDHTRqOcnDD70/3MFMuTYl9EoWCatz8hpi8R3VdXeahGznj0SNO9Q+UleGyBftXapce
         x3t52Oi+rOfwkSGqCFe6BhiAqNLi+0Tyy8lwvm0z4biwmRQyNVIdicL6ZC8wgcXSkBmg
         N1cw==
X-Gm-Message-State: APjAAAUKqoR2R8C1vk8qc4DMBuRvbolg5lpl0PdUZOCThvEIVGvDIHfq
        7J/gjefCc8s8BMKAENjTvcso5ChskCelHW/VqeA=
X-Google-Smtp-Source: APXvYqzTzot0TaouNF6K1z/L7Hs8zJ+9SFAcylB1aJuoJDSPAmqyWlbMSaqn+piwy+TqxrQfg7WIaGyMlSocp0wU8CM=
X-Received: by 2002:aca:2303:: with SMTP id e3mr23263015oie.112.1563537004914;
 Fri, 19 Jul 2019 04:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190719104802.18070-1-andradanciu1997@gmail.com>
 <20190719104802.18070-2-andradanciu1997@gmail.com> <CAOMZO5Btu1Shou=dGRrG74e5UjHnh7NtR4+4ETK0t_1Zt48Crw@mail.gmail.com>
In-Reply-To: <CAOMZO5Btu1Shou=dGRrG74e5UjHnh7NtR4+4ETK0t_1Zt48Crw@mail.gmail.com>
From:   Andra Danciu <andradanciu1997@gmail.com>
Date:   Fri, 19 Jul 2019 14:49:54 +0300
Message-ID: <CAJNLGswXF8XtZKnFtzaK+7Xvs0Ygwwh4WP5PiO8Csc7pDG1vNA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm64: dts: fsl: pico-pi: Add a device tree for
 the PICO-PI-IMX8M
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ping Bai <ping.bai@nxp.com>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <Michal.Vokac@ysoft.com>,
        Li Yang <leoyang.li@nxp.com>, sriram.dash@nxp.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Pramod Kumar <pramod.kumar_1@nxp.com>, pankaj.bansal@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Richard Hu <richard.hu@technexion.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

I compiled with W=3D1 and you are right, they cause warning. I will remove =
them.

=C3=8En vin., 19 iul. 2019 la 14:19, Fabio Estevam <festevam@gmail.com> a s=
cris:
>
> Hi Andra,
>
> On Fri, Jul 19, 2019 at 7:48 AM andradanciu1997
> <andradanciu1997@gmail.com> wrote:
>
> > +       pmic: pmic@4b {
> > +               reg =3D <0x4b>;
> > +               compatible =3D "rohm,bd71837";
> > +               /* PMIC BD71837 PMIC_nINT GPIO1_IO12 */
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&pinctrl_pmic>;
> > +               clocks =3D <&pmic_osc>;
> > +               clock-names =3D "osc";
> > +               clock-output-names =3D "pmic_clk";
> > +               interrupt-parent =3D <&gpio1>;
> > +               interrupts =3D <3 GPIO_ACTIVE_LOW>;
> > +               interrupt-names =3D "irq";
> > +
> > +               regulators {
> > +                       #address-cells =3D <1>;
> > +                       #size-cells =3D <0>;
>
> #address-cells and  #size-cells are not needed and they cause warnings wi=
th W=3D1:
>
>   DTC     arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
> arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dts:77.14-196.5: Warning
> (avoid_unnecessary_addr_size):
> /soc@0/bus@30800000/i2c@30a20000/pmic@4b/regulators: unnecessary
> #address-cells/#size-cells without "ranges" or child "reg" property
>
> Please remove them.
