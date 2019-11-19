Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7AFC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869DD21850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRMvjHCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfKSMDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 07:03:07 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37609 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfKSMDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 07:03:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id k14so16822386eds.4;
        Tue, 19 Nov 2019 04:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9LzW1Q0uBh1oJyJ7Zo/NpZsX1Pqj9fwypu9WglS3mAo=;
        b=BRMvjHCeM4Wp78wov/nC/TlaJFXx319rrfwZTNt23v4s2oZLN3HzcrgAQ+6ktY9ijZ
         pYZlEfilGte5kpaZ7n+1n/cDKSqa0+iYqXqqqeahuyY2wUaSrqzFaEq0Lyvf0/Pafk24
         Xxt74USfo9+xuYnO6hhN66I2+99GA9JGS5hcaLYI6Gtn8VgznkweJwNZJjWqB2EGIhja
         fj1wOZMsx1isY189Nrax3RCPTDvttjm7mtBZ00BLEU6kbkzB6C8nrSL4YOnY4cJrMvEk
         UBaZ8vKdqpol4WA4DbHgaq6RCMvh996gF02hkZdcR2cXxRdGbYPQO2AGfJ6PYMrR2pLo
         RzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9LzW1Q0uBh1oJyJ7Zo/NpZsX1Pqj9fwypu9WglS3mAo=;
        b=k4KIr/AVoiNSf40h8xzS0EgsTGd6MRS40HlyoFaK8B9ZOsnBw6yazzgrTvPRLZLJM0
         2iw3KBsm+E3p5QanJjjoSwFqEQtfTTVWkznuH8gFw4nmDOSnxi0OpGX5e6eNWTiluwhe
         jXfRsCWW8cvsh7/fank8QtX6gU54Aj3Q4xjyLEhpVTBWnmvrPz2nyApzb90vk1JF8z8S
         G6iTUFuB/SHPKobiFpEX7QjeZNN7SHdplnx+drswFig/ygkwSffwA4fLBJ/h2oj43aP5
         MbrXLrd2c5Ildc3/yKbRcce1fgAeBWnqap/4pFWvz0B3S3VriKy/oNJpoDhG5Shej5GL
         96zg==
X-Gm-Message-State: APjAAAUIrsqFDghYvAYd8JlIUoIY3bRoh8BtkyDNInwRMV3YEeSS4XC4
        pYiRYiEEK8pYJuu3MzTeFtyhjPqcEZe3yJ2JYnFJXJiY
X-Google-Smtp-Source: APXvYqz/CfunszFeAjEBCumDxz0iQHl/0vNAhHnc0LG+EzND8XJX4Zh7XETD3kGnwQN45EE4OYNY1SbhKbRZ+IYlowA=
X-Received: by 2002:a17:906:4dd5:: with SMTP id f21mr34336009ejw.203.1574164985365;
 Tue, 19 Nov 2019 04:03:05 -0800 (PST)
MIME-Version: 1.0
References: <20191114195609.30222-1-marco.franchi@nxp.com> <CAOMZO5Asp-m7zyY6dp72_VKZs0OisxX4B-PJtP4=GuE_-XDBsg@mail.gmail.com>
 <CAM4PwSX+tkCwt2vmBB4-WAdfaTbxUEutGjzKxCVQiAnWbtD3JA@mail.gmail.com> <CAOMZO5BsRMQUR1Noj_XXs8NBr1wg53aS7126kqaUot4=g8esZg@mail.gmail.com>
In-Reply-To: <CAOMZO5BsRMQUR1Noj_XXs8NBr1wg53aS7126kqaUot4=g8esZg@mail.gmail.com>
From:   Marco Franchi <marcofrk@gmail.com>
Date:   Tue, 19 Nov 2019 10:02:54 -0200
Message-ID: <CAM4PwSUvzhNFe5h9zuPHpm2L1q4Sn1ibsGtmp5xFy5g7M13Ueg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: freescale: add initial support for Google
 i.MX 8MQ Phanbell
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Marco Antonio Franchi <marco.franchi@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Fabio,

Em seg., 18 de nov. de 2019 =C3=A0s 17:29, Fabio Estevam
<festevam@gmail.com> escreveu:
>
> Hi Marco,
>
> On Mon, Nov 18, 2019 at 11:16 AM Marco Franchi <marcofrk@gmail.com> wrote=
:
>
> > > Also, is the schematics available?
> > Yes: https://storage.googleapis.com/site_and_emails_static_assets/Files=
/Coral-Dev-Board-baseboard-schematic.pdf
>
> Thanks. Would you also have the schematics for the SOM board?
I could not find the schematic, but at this page you will find a lot
of information regarding it:
https://coral.withgoogle.com/docs/som/datasheet/
>
> I tooked a quick look and I see a ALC5635 codec, but the dts shows
> WM8524 instead.
>
> Which one is correct?
Internally they are using WM8524, but I will confirm and test it again.
>
> > If I applied this change, I won't be able to boot the board, due to
> > the U-Boot dependence.
> > Should I try to apply the U-Boot mainline support first?
>
> You could build the mainline dtb and rename it with the fsl prefix
> locally so you could boot test it.
Cool! Thanks.
>
> Forgot to mention, but you also need to add a separate patch that adds
> this board entry into Documentation/devicetree/bindings/arm/fsl.yaml
Ok.
>
> Regards,
>
> Fabio Estevam

Thanks Fabio, I will apply these points too.

BR,
Marco
