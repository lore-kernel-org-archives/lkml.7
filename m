Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929A3C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE6720718
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ7yrdfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfKVL4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:56:35 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36271 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfKVL4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:56:35 -0500
Received: by mail-ed1-f66.google.com with SMTP id f7so5778421edq.3;
        Fri, 22 Nov 2019 03:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=myV3lKf8LP8zgt7/x2kHqtOs6MwOjmNsOxknrMDY0ng=;
        b=VQ7yrdfJ+b8iOC+zpO0ugY7dMTPSCsYa7A2gTPvEWMTPUFp+kltiZXnVeTpQrMRTTV
         sUFNKD9SJFA0zurJvqWjUvgty76PVzvoHHH5aEsWJD4Kl5eMgu9wjScwCd2ITaa8b/vK
         MzLM5yaDrDz6IdGpOdQ29yArA0YM9wWefREL2XGTbTSIqeRj0K4vQlM+2T1ARxlkSenl
         THt5NeDxfNxxPyEsKY3GIDN5k/sfsiHvcpNhI9N3f14JPs6WmCpVef8aOtPzNHnAoD2J
         9Fm+YRhj05y4FJvytds4mlL7D9IK9Ig0wwPBbCiZg8LAIOtaB+03OdBXXtwDohdS6VWC
         ontw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=myV3lKf8LP8zgt7/x2kHqtOs6MwOjmNsOxknrMDY0ng=;
        b=YuzlOyZfTIukVarXCneJOBWDqhPz2URxy3wDM1sP6ipQqTdegusqWe+WwvQBNE2l3H
         Nt9WvLhILXEePNPXBvfYo2hCxQuPhVhHbZxTUbMpMic5ccvE6Vika1ZINxJi4X7FUhhv
         0o0bkZ7H/o09yF+zb0AXSahBM1g5oi7R4UP1U4UzsayBXceYsbXvXjKT8DstKs3F8hGI
         PhmvfDb75Mhp2rLN9sjZSvE5fzXEY8WJMtpqO/oBbRD8WzTOgUlWgd9kMIEVJYVMfK9x
         8HlT7ilNnztSPho8P5T+BpWpbq5qIxQOHgRfgo/0U1VpHbR5IcvyIFaWQjrv1GLF46ba
         ArAg==
X-Gm-Message-State: APjAAAVypWpEFgHafCh0Mvzv9TWGbAKHO39njZODUdxqanngvKWUXYKW
        njSUAVCtk9mrAYP2l9NGmKZjEeD4hOwgV54ksIU=
X-Google-Smtp-Source: APXvYqxYvHXQjj3nxnwa8FYn66nKlRY69aGEXxyFBuEfXNzyt7zIFpEnsN09uAqv+7c0vjuzjmibcFvkSNUtCulAfYs=
X-Received: by 2002:a17:906:4dd5:: with SMTP id f21mr21480540ejw.203.1574423793266;
 Fri, 22 Nov 2019 03:56:33 -0800 (PST)
MIME-Version: 1.0
References: <20191121162520.10120-1-marco.franchi@nxp.com> <20191121162520.10120-2-marco.franchi@nxp.com>
 <CAOMZO5ByMkp1i=rMScgadT9_ucnsxqn_pnSP4bmLUPnxPdYHvw@mail.gmail.com>
In-Reply-To: <CAOMZO5ByMkp1i=rMScgadT9_ucnsxqn_pnSP4bmLUPnxPdYHvw@mail.gmail.com>
From:   Marco Franchi <marcofrk@gmail.com>
Date:   Fri, 22 Nov 2019 08:56:22 -0300
Message-ID: <CAM4PwSWJYrN=xSWNiwxHYS9XMWJFmnpAByVhsOV75kBBF4M3Xg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: freescale: add initial support for
 Google i.MX 8MQ Phanbell
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Marco Antonio Franchi <marco.franchi@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "atv@google.com" <atv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

Em qui., 21 de nov. de 2019 =C3=A0s 15:22, Fabio Estevam
<festevam@gmail.com> escreveu:
>
> Hi Marco,
>
> On Thu, Nov 21, 2019 at 1:25 PM Marco Antonio Franchi
> <marco.franchi@nxp.com> wrote:
> >
> > This patch adds the device tree to support Google Coral Edge TPU,
> > historicaly named as fsl-imx8mq-phanbell, a computer on module
> > which can be used for AI/ML propose.
> >
> > It introduces a minimal enablement support for this module and
> > was totally based on the NXP i.MX 8MQ EVK board and i.MX 8MQ Phanbell
>
> Please remove the "totally based on the NXP i.MX 8MQ EVK board" as
> they are different boards.
>
> > +       memory@40000000 {
> > +               device_type =3D "memory";
> > +               reg =3D <0x00000000 0x40000000 0 0xc0000000>;
>
> The memory size here does not match with the one used in the Google repo.
Thanks.
>
> With these changes you can add:
>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
Ok, I will add it at the v3.

Best regards,
Marco
