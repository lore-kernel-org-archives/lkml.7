Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD51BC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 04:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904CC21E6F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 04:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v3tngBRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfIZEGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 00:06:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33945 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfIZEGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 00:06:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id a11so987985wrx.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 21:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6O3te8B9v8EP6DXpJUILeaiDwfu4hKzbhFKk3O+2hIc=;
        b=v3tngBRzkkXSqdYaxFo8J7luIFDI39Ap3QuDsvssko/+ZHYvZuvrad7LKYrqWn91h+
         7PGLiYa+aajdMpuogbeUQG3uwqfjFeU0Uy2i/HscJCvA0DDmSPgZXvUedBp+XsButXN1
         popFqiRWQbu3GOuijlgg9In8sebmnJQlTBTfHZc73ic4kkFFJd73rxDM2TWM4a+ZWa0t
         pJ4BEH7j4LlPSfEru9bRZGRXRme/NKEG1OTinK8bg0lq9vfj3ejSGkacxvmU7QpQfYnr
         rEo4EewiFnPDtCfjV1o5V6SmGG4k7zRPL932ypV1FIv3YZpiFhK/hV1f9FuZtEDIC0fp
         0j7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6O3te8B9v8EP6DXpJUILeaiDwfu4hKzbhFKk3O+2hIc=;
        b=hq/3DGzUT/2bw1zxfO1hwXVBZtxa98wJ6BLRQ0tocYL4IO/PkAOkHjqe0effKx5oSD
         6R537ZfCMg8NcJOx/GNk8xu7Bsfs2mA44jfFoVHffGwOemVTVdt0nkDS5JGtRHrUGQEt
         QezRlC7LB+P/OlvaxDt98clUupU9WtI9hkK2hg2hvrJC5WZvE/Xg8Ysi5G59HZuLsp6/
         Hdpv3mYLlu/CFQC+PyNWvuLNzoxDFZ59A2yfl2K/TciAnFGJHA8O98UPLUhZ6u1Msa5i
         7bi7fh9cc2hC8fIqcshfBnq5HQseMV2z7iVwGZWhAvJPaRksjgQ+hWKuCq7xObwJFBmj
         P8FA==
X-Gm-Message-State: APjAAAXa76v3Up7JD66SMqMcVUVWQUdKXBJSbloC5dCVefpJuQdQDBCC
        Lb2PexAhcHiBO4tqjHyIybL5Qvgz/tJhdjLr/h4wKQ==
X-Google-Smtp-Source: APXvYqxi/aX/Sa4He/GsphASBb2GpvqD6GZsxYhQ8cRbVT/ddgFXaL5HlvJdKn0pRwCVZ5q5FZsT6iLR5jdo5KkMGYs=
X-Received: by 2002:adf:d08b:: with SMTP id y11mr1171535wrh.50.1569470807953;
 Wed, 25 Sep 2019 21:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190925234224.95216-1-john.stultz@linaro.org>
 <20190925234224.95216-5-john.stultz@linaro.org> <1569461658.32135.12.camel@mhfsdcap03>
In-Reply-To: <1569461658.32135.12.camel@mhfsdcap03>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 25 Sep 2019 21:06:34 -0700
Message-ID: <CALAqxLX=csTtnqr2Hc9v_R8ex8zPj_P1JvSyjZXUKEqSaF=gPA@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: usb: dwc3: of-simple: add compatible for HiSi
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yu Chen <chenyu56@huawei.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 6:34 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> On Wed, 2019-09-25 at 23:42 +0000, John Stultz wrote:
> > +++ b/Documentation/devicetree/bindings/usb/hisi,dwc3.txt
> > @@ -0,0 +1,52 @@
> > +HiSi SuperSpeed DWC3 USB SoC controller
> > +
> > +Required properties:
> > +- compatible:                should contain "hisilicon,hi3660-dwc3" for HiSi SoC
> > +- clocks:            A list of phandle + clock-specifier pairs for the
> > +                     clocks listed in clock-names
> > +- clock-names:               Should contain the following:
> > +  "clk_usb3phy_ref"  Phy reference clk
> It's not good idea to apply phy's clock in dwc3's node

Hey! Thanks for taking a look at this!

So first, my apologies, I'm not the driver author and I don't have any
real specs on the hardware other then what's in the source tree I'm
working on.  Not the ideal person to be documenting the binding, but I
realized we still needed some binding documentation (although a few
other dwc-of-simple compat entries are undocumented), so this is my
rough stab at it. :/

Given the name clk_usb3phy_ref I'm assuming its a phy reference clock,
but I honestly don't know if I'm getting that wrong.  It all seems to
be leveraging the fact that the dwc-of-simple driver batch enables and
disables all the clocks w/o really looking at the names.

Do you have a recommendation for what would be best here? I suspect
it's necessary to enable/disable the clk in a similar path(though I'm
unfortunately traveling this week so I can't validate that). Do I try
to move the clk_usb3phy_ref clock enable/disable handling to somewhere
else?

thanks
-john
