Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED366C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD2F206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klldFEUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfHNOwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:52:38 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43110 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfHNOwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:52:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id e12so38698181otp.10;
        Wed, 14 Aug 2019 07:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LE9bCOi3fgM77T3hJ0EjLAjiJBaAYnU/w04iUO3AhrI=;
        b=klldFEUjvKAWMbt8cIXxkXbpqdwzHJagqEl8faKaELgCOO/YJq52UPWsuledkssXak
         HS6sBAZ8T0ncB2JmCu4mN9Qk9g26Sc00Y4qRFNtZGcy+kR5N3HQQW/jSlibvr9RhwIiQ
         1+1DFVmkZJUHXTjn1xvvZxcaX/nAjmLe5pwj8bQHj8nBvxINVYYs9876JmMmJJcK5FJq
         NfHmY0PEFWnOJiVbIsXhPtCd1Fg+0a+q5vkgiSj76/sYg1UYczVQrqG8rVjzI4uAsCQS
         75bIAO9u3hTrGxIVDqmWfQG1h3JwGpD9Bho3OnqiM6eBteJ3bkbIvjp4uqHi9M6XID/o
         GmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LE9bCOi3fgM77T3hJ0EjLAjiJBaAYnU/w04iUO3AhrI=;
        b=h7F1I2Grc8lGWBQ+UWszTQk1R/bajdXYKd6Vu/B20+iTNaLBlCbar2ADBXupRl21om
         zBxi5GjHw8kWlPfewG3p1LBPDYJQpEyzhDbrF9ZyaK0hyMyNHo0fAeYzlIdW2FRzO6El
         jHDHxnFgqx0OCQN+mFKTCHgmeUyjU3ppoI4MV9HrbzkLaY/yqu2Fhrnk1aKB6InWNitP
         bek+P3PkhgtpPsjhstRXf7p1p4T9+Adig6tlmJIGVwe68BPsZ3ugzFJ2ma4p4aZ1bB8c
         OzmPJmUYxyjDwHHcJyVRwTfD6wkvzeJsF2cYGDPgUOOTkPh4XU4n/vfQzU4MTCifX6FA
         g7dg==
X-Gm-Message-State: APjAAAW8MLA6dzsj2itCTe19jk9xGDc4p5+tcQxrRO862wNz3gC3dpgz
        LtsybfQ9nLHa+ktLHjzND/SZV24xW6AQjz4CnV8=
X-Google-Smtp-Source: APXvYqzwP7Oanm4rNC3H3XlkdoD28KPFtrzYX/SlNeMG5UeKPjAE3US8kr3ngvS0Es4sOJC5yHA8GMzaBhoFQdc1pEk=
X-Received: by 2002:a6b:6516:: with SMTP id z22mr303258iob.7.1565794356826;
 Wed, 14 Aug 2019 07:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190717192616.1731-1-tushar.khandelwal@arm.com>
 <20190717192616.1731-2-tushar.khandelwal@arm.com> <CABb+yY04vW-i35N6P57KSKgmMAYkrA2CDyUvA-bLCZMxiZaocw@mail.gmail.com>
 <CABb+yY1SeHTgZQNAHJW+dZG=khah5c5igtKy+MrjADnZF29Aow@mail.gmail.com>
 <VI1PR0601MB21113C48E719B2C79EC2FE508FC20@VI1PR0601MB2111.eurprd06.prod.outlook.com>
 <CABb+yY3yMWbUiQnJgfQhwnW1OM3aoFL3ZFc018E-fxGichi-4Q@mail.gmail.com>
 <VI1PR0601MB2111A5A4E951F011D389A8978FD90@VI1PR0601MB2111.eurprd06.prod.outlook.com>
 <CABb+yY3Ni7wV+ui1LO7TERWQH_BoakZbPq961wdRPB4X-nwS2A@mail.gmail.com> <20190814100518.GA21898@e107155-lin>
In-Reply-To: <20190814100518.GA21898@e107155-lin>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 14 Aug 2019 09:52:25 -0500
Message-ID: <CABb+yY1jZs0OU-oi86iNNHiqBTjaY6ixFPMoUPkU6MCH_YrwLg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mailbox: arm_mhuv2: add device tree binding documentation
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Morten Borup Petersen <morten_bp@live.dk>,
        Tushar Khandelwal <tushar.khandelwal@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tushar.2nov@gmail.com" <tushar.2nov@gmail.com>,
        "nd@arm.com" <nd@arm.com>,
        Morten Borup Petersen <morten.petersen@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 5:05 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Aug 13, 2019 at 11:36:56AM -0500, Jassi Brar wrote:
> [...]
>
> > > >>
> > > >> As mentioned in the response to your initial comment, the driver does
> > > >> not currently support mixing protocols.
> > > >>
> > > > Thanks for acknowledging that limitation. But lets also address it.
> > > >
> > >
> > > We are hesitant to dedicate time to developing mixing protocols given
> > > that we don't have any current usecase nor any current platform which
> > > would support this.
> > >
> > Can you please share the client code against which you tested this driver?
> > From my past experience, I realise it is much more efficient to tidyup
> > the code myself, than endlessly trying to explain the benefits.
> >
>
> Thanks for the patience and offer.
>
Ok, but the offer is to Morten for MHUv2 driver.

> Can we try the same with MHUv1 and SCMI
> upstream driver.
>
MHUv1 driver is fine as it is.
I did try my best to keep you from messing the SCMI driver, without success
https://lkml.org/lkml/2017/8/7/924
