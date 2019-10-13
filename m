Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9194AC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 17:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE06206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 17:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aaz/dotn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfJMRCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 13:02:32 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45910 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfJMRCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 13:02:32 -0400
Received: by mail-io1-f66.google.com with SMTP id c25so32306539iot.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 10:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y5EXXBAwwQtPJ53xui2dWiC39EIVV1N/CWUXrjlPr7o=;
        b=aaz/dotn+umYNxbMf0N27lTns2rUEnRXr3ncyAS8unjQPXipinDv30U1G3pR/NaY5x
         5TQlgYYDRtl50mIFY6g/ZFU/rETQ0X9RMjm6VgXusBevN254jSYYkPM2GM7E7BGBDJCc
         RmwkhOVMrLkI1mZ4BKvd/MXUBhijYnSSgj1vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5EXXBAwwQtPJ53xui2dWiC39EIVV1N/CWUXrjlPr7o=;
        b=qLGRe8gwkXlQymRGYtAFbcjacsKWMAcgRtAjX5JOCylk+T2s5V7O96QTDPEANVmOEM
         73v6zEMktmYna6Z6jQWjqsuItDsh+6MmpRxhl1ZhzT7Qe2Qz1NKNkeV6005NGTmcoL0i
         4pOdQl12YFhrLBC9V0FK69HARmZKK4EUXcgOdG2T83xIRLi6KYHKrjvsx238aUtQwGNx
         ouARlQoDUnQSSS9LjKtEdwnUpWIpLNHVcRFgR3N7L8dIItO6pIYQTD2dHrXMMEmVjE2r
         V+IA5UDqz26dbTNNpPQLPH+2AiO25FxaDkxtOWgdVrxB2uAnN9kLbv1XqagkEOwJkJPD
         W++Q==
X-Gm-Message-State: APjAAAWjscn0p1y+hdS4t/Q7WKpjnSy4HfyhNPlr3PYum2ELKHUARGHO
        lo2kzF0BW8Xd5tgMINEZPieaioDZEQrjVhmmSDz47w==
X-Google-Smtp-Source: APXvYqxe8O/zqzfE+BE/bWBaXmZwc8ddmkzF2zTRQsw5hvZGzCCUSKkZI14FxXesaHp6rT1xlHYB8wKYoOJ+CQ4U80w=
X-Received: by 2002:a6b:5c0f:: with SMTP id z15mr23291130ioh.173.1570986150676;
 Sun, 13 Oct 2019 10:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191005141913.22020-1-jagan@amarulasolutions.com>
 <20191005141913.22020-2-jagan@amarulasolutions.com> <20191007093122.ixrpzvy6ynh6vuir@gilmour>
In-Reply-To: <20191007093122.ixrpzvy6ynh6vuir@gilmour>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sun, 13 Oct 2019 22:32:18 +0530
Message-ID: <CAMty3ZA1azP3kkJPw6oZudcSQksF6i+STeW=oOh65cfHsj0QrQ@mail.gmail.com>
Subject: Re: [PATCH v10 1/6] dt-bindings: sun6i-dsi: Add A64 MIPI-DSI compatible
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 3:01 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> On Sat, Oct 05, 2019 at 07:49:08PM +0530, Jagan Teki wrote:
> > The MIPI DSI controller in Allwinner A64 is similar to A33.
> >
> > But unlike A33, A64 doesn't have DSI_SCLK gating so it is valid
> > to with separate compatible for A64 on the same driver.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  .../bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml        | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> > index dafc0980c4fa..cfcc84d38084 100644
> > --- a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> > +++ b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
> > @@ -15,7 +15,9 @@ properties:
> >    "#size-cells": true
> >
> >    compatible:
> > -    const: allwinner,sun6i-a31-mipi-dsi
> > +    enum:
> > +      - const: allwinner,sun6i-a31-mipi-dsi
> > +      - const: allwinner,sun50i-a64-mipi-dsi
>
> How did you test this? It will report an error when running the
> validation

I did follow the v9 comments [1] and forgot to do dt-doc-validate.
will send the v11 for this patch alone, will that be okay?

[1] https://patchwork.freedesktop.org/patch/307499/
