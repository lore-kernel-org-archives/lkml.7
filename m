Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE5DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27EF2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fPm/hV4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbfH0VTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:19:49 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36895 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0VTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:19:49 -0400
Received: by mail-ot1-f66.google.com with SMTP id f17so626305otq.4;
        Tue, 27 Aug 2019 14:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgYmTClrC/asl3eR4xct5fw+wHifMzNWe21TIUQLX/s=;
        b=fPm/hV4QKJeCA+j5g3rsjtP+azHB2zk6ntrj6l42vnXDPvSw5O92sHbgitSFwflbUL
         m9UTet+JaUBIERtI7Kk8KIITgjMa5OR4KVwUZ2DCOadIm0gYaREA+QlQZQLI/U1Dfec+
         YVlh5AS0iutk7nU/yNOmzUUcSl7YRmgSLhbecVQPF2In2aJL1NGonYhsbhKw3tfqkS1L
         fKvwQn+zISyavxmXb2+7LBWu2vDAZ8FEFcC5VeUThlM4Nroz0dDjFb3l4mIYfH+ErOG2
         5A5B/DNvueCA+b7LJ3QVAtlfgg3EDfAxtTHTr9w+Wlb2JDc5Dlz4wXt4InnyEmfVXNty
         8v4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgYmTClrC/asl3eR4xct5fw+wHifMzNWe21TIUQLX/s=;
        b=bZhsXoFaforDtZNCBg6hhVCeStMjLyl4FQJ2TcNqNH/SuN2RMFpxLYaF3pHH7D1RJ1
         d/kMvdjcO0UDe7QhZFoHSjMbEIEnvhiaOuN7dIrxf93Sb8+ZGOf87UmByjtHuYGnAAVX
         ppKYbfOofZ1t/znCX05TWK9zvZGVl78CeBHL3IxYGnH5j4cP6JRXZDE4BR78N0UnhHXU
         S3r+0lXAMHmmEG+DrEvoYxOECEgY8G8dlRTVeWye3NDqkj2qK3lPMHBok7MjJuWnlO0R
         NBqnEc+uW+2DsEABenXd1uR/2GgVcFrUY1Pg4O5X9B/1HI48uPDnMA2puTqZPztoHoeo
         oCtg==
X-Gm-Message-State: APjAAAUjSzlvRRrVUd0n7JHR9bylJtvoLI+/PGqlNEXH+Y689Weik/+O
        6A/bngLvxlr4qPJQtgstBbvgc9bbKlGUcnXGmRlZ7g==
X-Google-Smtp-Source: APXvYqwwRRQN8HPUGgQVIpMqj1N2WMUBTzJ9Fh3YyiZAGgwoTYmJ49wk8Lo3LwUim1tFvC30tR6g38IAynQdpxOBCYk=
X-Received: by 2002:a9d:5c0f:: with SMTP id o15mr594707otk.81.1566940787892;
 Tue, 27 Aug 2019 14:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190824184912.795-1-linux.amoon@gmail.com> <CAFBinCCkEE8==-Sqqj_=Ofnx7_H-970dETwEmEPohs74806ZMw@mail.gmail.com>
 <CANAwSgTsua_x6fi7NzC2XjcV19OJcN3NhOT_niKXN4RR4X+qVQ@mail.gmail.com>
In-Reply-To: <CANAwSgTsua_x6fi7NzC2XjcV19OJcN3NhOT_niKXN4RR4X+qVQ@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 27 Aug 2019 23:19:36 +0200
Message-ID: <CAFBinCB45YkbgbRNx8aE+yrT7scT6BYZy1h9JozBxsoC6MZGSQ@mail.gmail.com>
Subject: Re: [PATCHv4 0/3] Odroid c2 usb fixs
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 6:38 AM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Martin,
>
> On Sun, 25 Aug 2019 at 02:48, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > Hi Anand,
> >
> > thank you for the patches
> >
> > On Sat, Aug 24, 2019 at 8:49 PM Anand Moon <linux.amoon@gmail.com> wrote:
> > [...]
> > > Anand Moon (3):
> > >   arm64: dts: meson: odroid-c2: p5v0 is the main 5V power input
> > >   arm64: dts: meson: odroid-c2: Add missing linking regulator to usb bus
> > >   arm64: dts: meson: odroid-c2: Disable usb_otg bus to avoid power
> > >     failed warning
> > this whole series is:
> > Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> Thanks, I have some more patch in line for this board.
great, any improvement counts (especially since most boards are
derived from Amlogic reference designs, so it's likely that more than
just the Odroid-C2 will benefit from your patches) :)
