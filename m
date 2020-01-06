Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A97C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360F424676
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="u+d0lrvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgAFVZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:25:51 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:36437 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgAFVZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:25:51 -0500
Received: by mail-il1-f196.google.com with SMTP id b15so43815130iln.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 13:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QeWAJBY8qWlUfgcT5Ob4uwidE5Op2m/zDQqkj1Pwwfo=;
        b=u+d0lrvfRfyBUlad0PtUGp4TDtHVVoXvMSkev/UzeCLj+gmYa+XOiSOxd/NWzOD0Er
         Uk7rK9aQEwNzCSHqQiHoGTpysSey1Li6/KHxEvGSQgy5J1Xv2URX1BCgaeGYG/y6+YDP
         H4af5ag2IOE+d7NaUO4cQcIgDyPkBwCaz+r0CHxxwpLEEkNl3a5y7l5vXjI1IzNyHNZt
         7BTSnnkzHNc98GP1afarxCK/Sai0FbwP2NZu/tn8gv5xWZzskzqAti3cqnU4I82a9dnV
         /yHEzgOENJdom2xvFRDz+vvBdTMi9VUdmXs/vmrZ8EQiJ9E94Zh5oGcdiMOEIItyefuG
         n19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QeWAJBY8qWlUfgcT5Ob4uwidE5Op2m/zDQqkj1Pwwfo=;
        b=pXL5GMSD2yzFPl4Xx5f+DTUCP6V3nCbt/bjXEb27WAZvGIpvYCoWuP9Gyr9k8f2Xy4
         5OD6S1Fc9nyH9bUZZPS4zlC7az7xttyS0SKd7DRd+bSEnfbJBRdYEq3pnSboq371yAum
         C5FwWLTKtuJ9Asw3tKYyCD8H2OZ5HYELY3Mmyj5O4d5P/aZXNyucZ/lEVFJx22hvOMHX
         2ji+mIrKDHh1W2sPhhbPEEw7to2XEm+GZ4B757o21X27WlbxeqU2nMlWM4RFn2bE7iU3
         /eCu6iI+j3YAuTLzXUiq3K/xWiCJBmX/9OhyMzniCnZq/6gq8+0UsBSZF3ES8GPLUuX7
         eDsA==
X-Gm-Message-State: APjAAAWdpPESAN1NC0sWg39FlUeyv8JrpJYntMHshoPbXHcQWGc/m+5L
        A/YPDNWNPDcr+otawVaifB5Yku1x1mKuENTlLNhkig==
X-Google-Smtp-Source: APXvYqzue49yqTCM4LifES+9o9JWzgjn29YjX1cFXkGBq1hAH8OyArUIE0efM57Dp/bjZ4g7EYIqgKT4ep+s8IfQ7yM=
X-Received: by 2002:a92:60f:: with SMTP id x15mr84738951ilg.181.1578345950447;
 Mon, 06 Jan 2020 13:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20191230231953.29646-1-rjones@gateworks.com> <20191230231953.29646-2-rjones@gateworks.com>
 <20200103223225.GB654@bogus>
In-Reply-To: <20200103223225.GB654@bogus>
From:   Bobby Jones <rjones@gateworks.com>
Date:   Mon, 6 Jan 2020 13:25:39 -0800
Message-ID: <CALAE=UATZtN47J421Y4i+GqvijiiECAuc25kLSmYNAe6jGhxiA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] dt-bindings: arm: fsl: Add Gateworks Ventana
 i.MX6DL/Q compatibles
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 3, 2020 at 2:32 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Dec 30, 2019 at 03:19:49PM -0800, Robert Jones wrote:
> > Add the compatible enum entries for Gateworks Ventana boards.
> >
> > Signed-off-by: Robert Jones <rjones@gateworks.com>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 31 ++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index f79683a..8ed4c85 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -126,6 +126,22 @@ properties:
> >                - toradex,apalis_imx6q-ixora      # Apalis iMX6 Module on Ixora
> >                - toradex,apalis_imx6q-ixora-v1.1 # Apalis iMX6 Module on Ixora V1.1
> >                - variscite,dt6customboard
> > +              - gw,ventana                # Gateworks i.MX6DL or i.MX6Q Ventana
> > +              - gw,imx6q-gw51xx
>
> This doesn't match what you have in dts files. Please check with:
>
> make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/fsl.yaml
>
> You'll need a separate entry with 3 compatibles and 'gw,ventana' or drop
> it.

Hi Rob,

Sorry, I'm still getting used to the whole schema format and a bit
confused. Can you be more specific in how it doesn't match? I looked
at the imx6q-gw51xx.dts file where I got the entry from and it has the
following line:

compatible = "gw,imx6q-gw51xx", "gw,ventana", "fsl,imx6q";

Obviously I'm only submitting the gw59xx board device trees but a
previous version of this submission was asked to add all of the
compatible strings for the Gateworks boards. Are you asking me to only
post the gw59xx lines?

>
> > +              - gw,imx6q-gw52xx
> > +              - gw,imx6q-gw53xx
> > +              - gw,imx6q-gw5400-a
> > +              - gw,imx6q-gw54xx
> > +              - gw,imx6q-gw551x
> > +              - gw,imx6q-gw552x
> > +              - gw,imx6q-gw553x
> > +              - gw,imx6q-gw560x
> > +              - gw,imx6q-gw5903
> > +              - gw,imx6q-gw5904
> > +              - gw,imx6q-gw5907
> > +              - gw,imx6q-gw5910
> > +              - gw,imx6q-gw5912
> > +              - gw,imx6q-gw5913
> >            - const: fsl,imx6q
> >
> >        - description: i.MX6QP based Boards
> > @@ -152,6 +168,21 @@ properties:
> >                - ysoft,imx6dl-yapp4-draco  # i.MX6 DualLite Y Soft IOTA Draco board
> >                - ysoft,imx6dl-yapp4-hydra  # i.MX6 DualLite Y Soft IOTA Hydra board
> >                - ysoft,imx6dl-yapp4-ursa   # i.MX6 Solo Y Soft IOTA Ursa board
> > +              - gw,ventana                # Gateworks i.MX6DL or i.MX6Q Ventana
> > +              - gw,imx6dl-gw51xx
> > +              - gw,imx6dl-gw52xx
> > +              - gw,imx6dl-gw53xx
> > +              - gw,imx6dl-gw54xx
> > +              - gw,imx6dl-gw551x
> > +              - gw,imx6dl-gw552x
> > +              - gw,imx6dl-gw553x
> > +              - gw,imx6dl-gw560x
> > +              - gw,imx6dl-gw5903
> > +              - gw,imx6dl-gw5904
> > +              - gw,imx6dl-gw5907
> > +              - gw,imx6dl-gw5910
> > +              - gw,imx6dl-gw5912
> > +              - gw,imx6dl-gw5913
> >            - const: fsl,imx6dl
> >
> >        - description: i.MX6SL based Boards
> > --
> > 2.9.2
> >
