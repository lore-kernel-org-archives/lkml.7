Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABAFCA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 18:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3E320679
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 18:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8evbIc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfJZSy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 14:54:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45211 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfJZSy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 14:54:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id q13so5772723wrs.12
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 11:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WOCOgOVP9/3KdLQah7ogN6soj9MgJBMp5zydxBeS4k4=;
        b=R8evbIc/iJ/MP2CwCJW8LJbpCKX6L5gP4U+EiT1Rsqa38pVgY81dZZ9UUnHnNFNol9
         C2rd5dS4G9oJVzHdBXpIwGPjv++7CFWhsyi/NBVB1V4qy0d0OEcziYb9eg1040LkuS7D
         /Rafr+VFCc4d8NDklQv1JCPEIf/lLlegPm5P2uYZrKg9IYF3NlKCWVWhKsaPukZdpHIg
         XM11dOkZnNZNhdxtjJmRGLZp7pEj9C8JrRD2di014GA+XI5w3qeOuIKk1ImhTA5dX/3u
         pqlQwZLfFnIzpXXiyXzyerPfGbFiSIlg2kyF0duukW6sKIRnOae5tSx+KnR3Vie1XX3a
         oZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WOCOgOVP9/3KdLQah7ogN6soj9MgJBMp5zydxBeS4k4=;
        b=sErbs7CJBvoTAb7ppCOxLgcInSnkBcNMH1xCJu8VQOsrxxdur1UeB4xZpUEsRz2iZq
         wjtTxLqidsI1AjEFyOAi8LHopZHo1XjoeTQPotRe3vkBpePnUyIe/J1NdVnnIuo3zN+h
         aBY9DnZb9ro1oHhOo3pgs0UiCpGMgMQ+xj0Wtitl4/Srdnx94M3nEEU80N5PO0RUrjC6
         C7bal2kBarVdlQwqUKRomGCj17yQ82bdN9/HdGBp4WRelD0vjKx+RO83zSvNPBJQd419
         JGRA0O+EE3LhUNGf0fRTWpOlUJiG+9nYFsQJK4G+tv4NdD1yjZ1Pn2sF8hkYBdNpOvtI
         1bpA==
X-Gm-Message-State: APjAAAX1AKL+8SLJ2rhPeMpBvFjqAZR+v4zw10wQF0WpZToV8S2Y6kVW
        4JQyu1iJ2H9aiM+n3s+1KSPEINefNnKZmmJLEzc=
X-Google-Smtp-Source: APXvYqzyqxrAU1QqvoHlbftGy/crKZJM8TEtfIUPzJvpEntZhvyxhB4BHutPyxU4cFj5bPO0Ooop1VWRv0QnQdq2+X8=
X-Received: by 2002:adf:e286:: with SMTP id v6mr8558351wri.241.1572116065463;
 Sat, 26 Oct 2019 11:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20191015152654.26726-1-andrew.smirnov@gmail.com>
 <20191015152654.26726-3-andrew.smirnov@gmail.com> <20191026115524.GJ14401@dragon>
In-Reply-To: <20191026115524.GJ14401@dragon>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Sat, 26 Oct 2019 11:54:13 -0700
Message-ID: <CAHQ1cqHQar8ZoVa3p+LfuPyJixcwfeWv7spkmwyJc60cekEywQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: zii-ultra: Add node for accelerometer
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <festevam@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 26, 2019 at 4:55 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Tue, Oct 15, 2019 at 08:26:53AM -0700, Andrey Smirnov wrote:
> > Add I2C node for accelerometer present on both Zest and RMB3 boards.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: linux-arm-kernel@lists.infradead.org,
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  .../boot/dts/freescale/imx8mq-zii-ultra.dtsi   | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> > index 21eb52341ba8..8395c5a73ba6 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
> > @@ -262,6 +262,18 @@
> >       pinctrl-0 = <&pinctrl_i2c1>;
> >       status = "okay";
> >
> > +     accel@1c {
>
> s/accel/accelerometer
>
> I fixed it up and applied the series.
>

I'm fine with that change, but FYI, I originally had it as
"accelerometer', but changed to "accel" to match the name in DT for
RDU2.

Thanks,
Andrey Smirnov
