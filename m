Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8991C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3639213F2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554772699;
	bh=rLjHczM1eoSRrpHR2Rcw+V0t8QCKzoYFvPsJ1LtNbQA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FkVyaH00u31nssxE3XLklvn/gqUx5/Ih2OI6CMUP/q7dcQDB2Dj1ek6f2RTDWaNF+
	 99vtZ++VTIXaDN6Pdf8kWqfPTU34g3V905zZ5vKp0G37+6C3W9bFr4Sm4wCB4NyVl/
	 GMh+/oUeIZfjFg9k4Pgm85JfZf8imLGa6U7k8kqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfDIBSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 21:18:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbfDIBSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 21:18:18 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F19321841;
        Tue,  9 Apr 2019 01:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554772697;
        bh=rLjHczM1eoSRrpHR2Rcw+V0t8QCKzoYFvPsJ1LtNbQA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZeYQtVe7pbmE3fqefs/62T4OIAc+kTJMvRjZ10UnRnuFQdKRcs5LmlZsk0Y0dUdTz
         XHptHdz/4pnWW5XugeSvnXi19Mj9hVLzjJ+7Vo4CZiWMvPWcvbSgWkm2t7fmq6crwr
         3PzMei7l6xHeuNBVkzK/jVpQeTgO4zDigvIEIH9E=
Received: by mail-qk1-f175.google.com with SMTP id w20so9259219qka.7;
        Mon, 08 Apr 2019 18:18:17 -0700 (PDT)
X-Gm-Message-State: APjAAAUMuJ0IgUG8OCGYj5yUiXdFnvkePz50E1pvXgoK3SvWqz1aTdKz
        j591PbAckPFQ6mPbX5LmNIN/yvoaavJNBAoZhQ==
X-Google-Smtp-Source: APXvYqwQ+7nn5OkCgR3ReLL2YIREWjc9gB13vhodkvVViZN2Mi237p/7zXwjo5pi+5ufShlhcU0IPkRhmqBMeS8/qBc=
X-Received: by 2002:a37:7183:: with SMTP id m125mr11798299qkc.119.1554772696266;
 Mon, 08 Apr 2019 18:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <1554303165-24813-1-git-send-email-f.suligoi@asem.it>
 <5ca84214.1c69fb81.e3ace.21e5@mx.google.com> <20190406125550.GA7480@piout.net>
 <58b8e1bc2b064abcb67db04369cf9c6e@asem.it>
In-Reply-To: <58b8e1bc2b064abcb67db04369cf9c6e@asem.it>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 8 Apr 2019 20:18:04 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLO20u39Vds_Z_S325D2My1aYKM6BS6RKdWSmyEVh-DtQ@mail.gmail.com>
Message-ID: <CAL_JsqLO20u39Vds_Z_S325D2My1aYKM6BS6RKdWSmyEVh-DtQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: rtc: add battery-low-hw-alarm property
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 2:22 AM Flavio Suligoi <f.suligoi@asem.it> wrote:
>
> HI,
>
> > On 06/04/2019 01:07:13-0500, Rob Herring wrote:
> > > On Wed, Apr 03, 2019 at 04:52:44PM +0200, Flavio Suligoi wrote:
> > > > Some RTC devices have a battery-low automatic detection circuit.
> > > > The battery-low event is usually reported with:
> > > >
> > > > - a bit change in a RTC status register
> > > > - a hw signaling (generally using an interrupt generation), changing
> > > >   the hw level of a specific pin;
> > > >
> > > > The new property "battery-low-hw-alarm" enable the RTC to generate the
> > > > hw signaling in case of battery-low event.
> > > >
> > > > Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> > > > ---
> > > >  Documentation/devicetree/bindings/rtc/rtc.txt | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt
> > b/Documentation/devicetree/bindings/rtc/rtc.txt
> > > > index a97fc6a..f93a44d 100644
> > > > --- a/Documentation/devicetree/bindings/rtc/rtc.txt
> > > > +++ b/Documentation/devicetree/bindings/rtc/rtc.txt
> > > > @@ -31,6 +31,9 @@ below.
> > > >                              expressed in femto Farad (fF).
> > > >                              The default value shall be listed (if
> > optional),
> > > >                              and likewise all valid values.
> > > > +- battery-low-hw-alarm :    Enable the "battery-low" output pin. This
> > function
> > > > +                            is available on the following devices:
> > > > +                            - pcf2127 - pin used for alarm: INTn
> > >
> > > Boolean? If there's cases where which pin is selectable, then we'd need
> > > this to take a value. Not sure how likely that is?
> > >
> >
> > Indeed, there is at least the pcf85363 that has two possible pins for
> > that interrupt. How would you select the pin then? a zero based index? a
> > string?

I prefer an index.

> I think the string could be clearer for the final user and would give
> more freedom for future changes.
> For example, we can call this property, instead of "battery-low-alarm" or
> "low-voltage-alarm", simply: "alarm-pin_1" and then the string argument
> can describe the function used; for example:
>
> alarm-pin_1 = "backup-supply-low-voltage-alarm";
> alarm-pin_2 = "......";

How many pins and functions then? And how does this relate to any interrupts?

Rob
