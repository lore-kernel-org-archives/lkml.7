Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958EDC282DC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 01:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6615A2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 01:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555551345;
	bh=t3djVohQhsnFHTNoSybpVk5Pus6dANYeEQB6Rq7UnCk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=H/gR5SsmasPTgU59qRKZxW27GJ+EjCfD3bXlNS4rmXxeP9jaM+r7hzLbSlwHos2LX
	 WgTf7ym19kYEzTHIiNZpfVvgZ5XT3C3+4sxhCKWV9JVN3AcGgPEKp8KjMKru7tuUQZ
	 7ELAWMdNRbYpYs0qKNHLNV7BKXCj/xzlEzkUcnHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387846AbfDRBfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 21:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729331AbfDRBfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 21:35:40 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B977F21872;
        Thu, 18 Apr 2019 01:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555551339;
        bh=t3djVohQhsnFHTNoSybpVk5Pus6dANYeEQB6Rq7UnCk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bzatYYyAQ/IY7bzLms8qEwPVxXGDdmlb12kIvM3MVI5vjG/5OHqjRY/r5wB/GMFUO
         QgSdomhZi+/Bv65RzDntixPH2IQofOyEE3mkyxHKzHUxRHeUD5x0Q5/8hmEqs+w77p
         EZ5flVL6OxvS/peeLoheQe1/MtburzahLz7rS5Vc=
Received: by mail-qt1-f173.google.com with SMTP id k14so560955qtb.0;
        Wed, 17 Apr 2019 18:35:39 -0700 (PDT)
X-Gm-Message-State: APjAAAUMbVgfkz4DRBZG5jJ586dVwjd0tndqNBNjAdeiaCtbOMPCyucK
        HSx6hDrteiwEWTi1hOA9144AoPgozT4mfuXCVQ==
X-Google-Smtp-Source: APXvYqxNZ7hcdLYsozYNOaTUKU61rv1CUqvpva89sJ8kxFJrlPP23w/Dp+bepFxUmW4Sqbjp1qgjpeeM8OCDbsAn6No=
X-Received: by 2002:ac8:2a51:: with SMTP id l17mr77787896qtl.76.1555551338863;
 Wed, 17 Apr 2019 18:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190412150625.28384-1-luca@z3ntu.xyz> <15255825.75VNnaJK3T@g550jk>
In-Reply-To: <15255825.75VNnaJK3T@g550jk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 17 Apr 2019 20:35:27 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL7awWWLK3G6u2yzse2aU7KUSuUELuacCnCpfErWA_UaQ@mail.gmail.com>
Message-ID: <CAL_JsqL7awWWLK3G6u2yzse2aU7KUSuUELuacCnCpfErWA_UaQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: input: add GPIO controllable vibrator
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Coly Li <colyli@suse.de>, Lee Jones <lee.jones@linaro.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." 
        <linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 11:02 AM Luca Weiss <luca@z3ntu.xyz> wrote:
>
> On Freitag, 12. April 2019 17:06:23 CEST Luca Weiss wrote:
> > Provide a simple driver for GPIO controllable vibrators.
> > It will be used by the Fairphone 2.
> >
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> >  .../bindings/input/gpio-vibrator.txt          | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/input/gpio-vibrator.txt
> >
> > diff --git a/Documentation/devicetree/bindings/input/gpio-vibrator.txt
> > b/Documentation/devicetree/bindings/input/gpio-vibrator.txt new file mode
> > 100644
> > index 000000000000..93e5a8e7622d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/gpio-vibrator.txt
> > @@ -0,0 +1,20 @@
> > +* GPIO vibrator device tree bindings
> > +
> > +Registers a GPIO device as vibrator, where the vibration motor just has the
> > +capability to turn on or off. If the device is connected to a pwm, you
> > should +use the pwm-vibrator driver instead.
> > +
> > +Required properties:
> > +- compatible: should contain "gpio-vibrator"
> > +- enable-gpios: Should contain a GPIO handle
> > +
> > +Optional properties:
> > +- vcc-supply: Phandle for the regulator supplying power
> > +
> > +Example from Fairphone 2:
> > +
> > +vibrator {
> > +     compatible = "gpio-vibrator";
> > +     enable-gpios = <&msmgpio 86 GPIO_ACTIVE_HIGH>;
> > +     vcc-supply = <&pm8941_l18>;
> > +};
>
> I see that the yaml based device tree binding docs seem to be the new hotness?
> Is there any "policy" / preference about new drivers?

Not required yet, but welcomed. It's still a trickle so we can work
out any issues and in some cases the common bindings still need to be
done. I'm starting to ask subsystem maintainers to require DT schemas
though.

This one looks straightforward to use the schema.

Rob
