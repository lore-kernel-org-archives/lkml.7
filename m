Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AF2C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAEC21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 20:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lv4yJe49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfJBUpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 16:45:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36961 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbfJBUpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 16:45:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id i1so524674wro.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 13:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jIRr3vuyuHhrBwVmAhx40vU7nfIocHRyk3SvX/TxJC4=;
        b=lv4yJe494FP24e+BxkKzcTuskkg8FrNyh9qdqcSg1Dcv3YTx+dhl1QGHDCgV45qcWp
         ZNxzSzgnJql+p8K7F/qHe7DvnikBq2EAL6deWohmcmE3Dj4an0zi7HZZWN4d4KleAWHa
         5B2L54OLRlITlgizMY4oi/giR85rWAuBn8BtcqRdE4qAwtGHlX1AB2jG9lQKvYR/v9XG
         0/eBFQYRZtUvWtTCaV/fcGYg9WsYWSWFigtWx8zQdWoOa/r8/okmQQrR6DCQdWZFteKt
         h4B4l8//QXMkN4rcXtV8xBx2veLPPNQ+WOSeMF2/QnBw1rAxLy7BLvMtGMSWk6C1fJmU
         Wbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jIRr3vuyuHhrBwVmAhx40vU7nfIocHRyk3SvX/TxJC4=;
        b=kYvSf5OV0za0Rr4dPebQ4kcHcGWcye5bnbIQPqdMrSIWteCzoveu3fz2TDxk8kVthX
         GL4tbp66/TVDAFX7/IMaXXqxcmRSRyeJ5OSGxBw66TB+Q2H6omPVmibsCRgqOec+Rfg1
         jVI0gnH1+9mjWHMJN+JuSfGUISgk9A85eIFpeIg8+oinGa9EzxNDElNHupe3daJ9pJ46
         vGDa17vcJgRe0c12dxDNlyO4osfo6H8zrQ3MnKBo15egTHX6t2GTXH7X1kEui5nqUwSk
         Wtiw5TxqgPk3akdR1vjmMkqvZ4U6rXkk0xSLdc7hQgGLpIPFLLAcj+1gSKQ0fyNzWfAJ
         p2/g==
X-Gm-Message-State: APjAAAWcWRk1K3uMiYhKD3MJKK2kUfuMvjsQnbaAiT0Kcr7bfZbWUGMB
        DCLoDXFUX9yRsQo2CfpKAAgTruIKKlwt+k2UmFcLQw==
X-Google-Smtp-Source: APXvYqy+TnevZ77P69zWyJBKS6NLgVRkGaL2594mjSL4rzRv021kXGI1tgDYK/GUZKWeJltREM0md2yRhQO0pJ/k90w=
X-Received: by 2002:a5d:40cf:: with SMTP id b15mr3499059wrq.141.1570049128814;
 Wed, 02 Oct 2019 13:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190925234224.95216-1-john.stultz@linaro.org>
 <20190925234224.95216-5-john.stultz@linaro.org> <1569461658.32135.12.camel@mhfsdcap03>
 <CALAqxLX=csTtnqr2Hc9v_R8ex8zPj_P1JvSyjZXUKEqSaF=gPA@mail.gmail.com> <1569480152.32135.16.camel@mhfsdcap03>
In-Reply-To: <1569480152.32135.16.camel@mhfsdcap03>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 2 Oct 2019 13:45:17 -0700
Message-ID: <CALAqxLUo59DDn=XhofOTHHkpuQPPTxx_jiTTA_o8sedCsxEkiw@mail.gmail.com>
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

On Wed, Sep 25, 2019 at 11:42 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> On Wed, 2019-09-25 at 21:06 -0700, John Stultz wrote:
> > On Wed, Sep 25, 2019 at 6:34 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> > > On Wed, 2019-09-25 at 23:42 +0000, John Stultz wrote:
> > > > +++ b/Documentation/devicetree/bindings/usb/hisi,dwc3.txt
> > > > @@ -0,0 +1,52 @@
> > > > +HiSi SuperSpeed DWC3 USB SoC controller
> > > > +
> > > > +Required properties:
> > > > +- compatible:                should contain "hisilicon,hi3660-dwc3" for HiSi SoC
> > > > +- clocks:            A list of phandle + clock-specifier pairs for the
> > > > +                     clocks listed in clock-names
> > > > +- clock-names:               Should contain the following:
> > > > +  "clk_usb3phy_ref"  Phy reference clk
> > > It's not good idea to apply phy's clock in dwc3's node
...
> > Given the name clk_usb3phy_ref I'm assuming its a phy reference clock,
> > but I honestly don't know if I'm getting that wrong.  It all seems to
> > be leveraging the fact that the dwc-of-simple driver batch enables and
> > disables all the clocks w/o really looking at the names.
> >
...
> If it's phy clock, we should enable/disable it in phy driver, maybe we'd
> better ask for help from Yu Chen

So I've been looking around the existing code and I'm not sure how we
got to clk_usb3phy_ref here.

Really it is the HI3660_CLK_ABB_USB, who's name is "clk_abb_usb" and
who's parent is "clk_gate_usb_tcxo_en"

So I'm thinking just specifying clk_abb_usb is more accurate here?

Does that sound reasonable?

thanks
-john
