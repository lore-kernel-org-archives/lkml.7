Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87058C47E49
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5810321D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572014333;
	bh=AkE3nm4ubF5/EO1cFZkqukp8zA1WVu1viPzaXXARFtM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ePp4o3D4InWUtrmrGcFjgZ5kdksDGoLCGLOgYz1TdVbh2Ke32z+MtLrMf2VlbHN6+
	 p1+VxpsSvShgB26+BFTPXVrWmKV1n7G+8s3sEAfHaudvV7/sRl32x5WxQFjaSYFWhC
	 tio+gDB++wotaB9H7iCgu9tRKWHaFsk3W03X5HVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439960AbfJYOiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:38:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436853AbfJYOiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:38:52 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90BD621D81;
        Fri, 25 Oct 2019 14:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572014330;
        bh=AkE3nm4ubF5/EO1cFZkqukp8zA1WVu1viPzaXXARFtM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YkHZ5Kdw6OzUmMHmtFlubwGhtQz9dGNx+Nl9C0c/bcWv7WTEvxqpev9ijPcwINPf0
         tqLjwnFbxagnzTARckMiLqCzWs3gFT1D2GEbkk0y+OfcIcVWrKwm9Wo7xWzr7BvGdU
         dK5K6kHroj/+8GlqBM2Dpip/Zn+T5k9di40qo1Ws=
Received: by mail-qt1-f181.google.com with SMTP id o25so3555747qtr.5;
        Fri, 25 Oct 2019 07:38:50 -0700 (PDT)
X-Gm-Message-State: APjAAAUDUhNbgXo7GY4vyhfjT7/8DC4JphKIFES16hft01zzeLrKy6dS
        dG4FZJxpaaZOJHzNSfW/v2bf8PQLwfGiQFWtxQ==
X-Google-Smtp-Source: APXvYqwP7zlM/7H+9Klz2cNbc5ag3yy3z3qx99EgctsarDBZBEDTLP4BVusibZ9dUCf9ps4wwRmLN7FD5B0tlpr89PI=
X-Received: by 2002:ac8:44d9:: with SMTP id b25mr3451209qto.300.1572014329732;
 Fri, 25 Oct 2019 07:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190114172930.7508-1-robh@kernel.org> <20190114172930.7508-2-robh@kernel.org>
 <CAMuHMdVnPREgPmn5TAmiqXSxuAYKv_AkQ6StZiDH79vKMRuBGg@mail.gmail.com>
In-Reply-To: <CAMuHMdVnPREgPmn5TAmiqXSxuAYKv_AkQ6StZiDH79vKMRuBGg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 25 Oct 2019 09:38:37 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLu3MAkY_YuSG=WtDCB3kwmQURstTwy2aVdkGv7m0JgMQ@mail.gmail.com>
Message-ID: <CAL_JsqLu3MAkY_YuSG=WtDCB3kwmQURstTwy2aVdkGv7m0JgMQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: serial: Move renesas,rzn1-uart into
 the snps-dw-apb-uart binding
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 7:56 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Mon, Jan 14, 2019 at 6:30 PM Rob Herring <robh@kernel.org> wrote:
> > The renesas,rzn1-uart binding only differs in compatible string from the
> > snps-dw-apb-uart binding. Move it there, converting it to json-schema in
> > the process.
> >
> > Cc: Phil Edworthy <phil.edworthy@renesas.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-serial@vger.kernel.org
> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> > --- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
> > @@ -15,6 +15,11 @@ allOf:
> >  properties:
> >    compatible:
> >      oneOf:
> > +      - items:
> > +          - enum:
> > +              - renesas,r9a06g032-uart
> > +              - renesas,r9a06g033-uart
> > +          - const: renesas,rzn1-uart
> >        - items:
> >            - enum:
> >                - rockchip,px30-uart
>
> With ARCH=arm and shmobile_defconfig, "make dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml"
> complains:
>
> arch/arm/boot/dts/r9a06g032-rzn1d400-db.dt.yaml: compatible:
> ['renesas,r9a06g032-uart', 'renesas,rzn1-uart', 'snps,dw-apb-uart'] is
> not valid under any of the given schemas
> arch/arm/boot/dts/r9a06g032-rzn1d400-db.dt.yaml: compatible:
> ['renesas,r9a06g032-uart', 'renesas,rzn1-uart', 'snps,dw-apb-uart'] is
> not valid under any of the given schemas
> arch/arm/boot/dts/r9a06g032-rzn1d400-db.dt.yaml: compatible:
> ['renesas,r9a06g032-uart', 'renesas,rzn1-uart', 'snps,dw-apb-uart'] is
> not valid under any of the given schemas
>
> Do you know what's wrong?

The addition doesn't allow for "snps,dw-apb-uart". Guess I relied on
the binding doc being accurate. So we need to either drop it from dts
files if the generic compatible is never useful (maybe simple cases
like earlycon?) or add it here.

Rob
