Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC864C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB9E2341B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pi0qaK8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfH3Hwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:52:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34444 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfH3Hww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:52:52 -0400
Received: by mail-io1-f65.google.com with SMTP id s21so12305804ioa.1;
        Fri, 30 Aug 2019 00:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=seOfZY8E9V8LAq9iFiH8rIsovSOi3J9Kn5HK9Pe9dT0=;
        b=pi0qaK8xrhzeSNZR1sW1g2NxUcg2TWC1pxlDvOLT4BraWo0mC2LKPARENHylbYQK00
         CmHIL0JyMyL4qblKksLvduPxOebrXQ5/2IV/K4AxFD8sCPx0HknjGu9kGpuNcjSTaWn+
         WwjtLXGhAmgqbLwu5TcPZhY6S4l2ivV2iSI+rFwrUPn4/gjG588atx/SJqxUwKfScSlT
         r6s2N2Ym4rOOCfDW95S2/ooqezcP1HTAC7QW2ph52eeKlojjDSemmqYxyG91POrwxsFh
         gO7P96Jazx26FzuSOZP7IUnsCDqsTS67AMc94Ur8MyEH4qw7SSQuabf7PbmpVpm+yaLW
         bKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=seOfZY8E9V8LAq9iFiH8rIsovSOi3J9Kn5HK9Pe9dT0=;
        b=aCmAVBhKI23mIuKXU8JkA572UKRa6qh7rElH+SF9kp4Iz57dYLg6KcaQ9vKzBCGBaA
         ti8ijCh03BRsSTwllmnCGFg8QmOUfgXWRsHe3oP0DvzrY8J6FCvZGboZ9UqStnYyZurp
         9SVDJQSiE/T60ZxqG/X1no6cdSUTKfFnaf41568foKrZJgonZkIoy4Aec2lc1jqTIf+T
         XgPh/+0E4KwtfKVNGzuXkh03IczbFObzn5Ys8ULQPNtiOq1FequGDug4IXGH3FSSXS1x
         j7VFJ4kC/ZDsozYQVseb0IM2GVRCYuZIuq8oMxT1vDnH45pmRaAThm1tU/oQWefQLn4o
         3NfQ==
X-Gm-Message-State: APjAAAUJ5g6SnGfduTls8FXElJSovZIZahou/0IX2Z+iil5o71sDNoRf
        LZcCqAO2KP+FMxGBXmSmavYhQr1ySqGZYZhTisU=
X-Google-Smtp-Source: APXvYqyK3/xKO/LsIQrSgVRrAhBUX11IoBGyPGLJu5Azl4D58IpKNhO0XKvks/BAOd9dtKtu2lAAlWNaXpr9Ijnz6UM=
X-Received: by 2002:a5e:8c0a:: with SMTP id n10mr12862989ioj.69.1567151571826;
 Fri, 30 Aug 2019 00:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
 <1567004515-3567-2-git-send-email-peng.fan@nxp.com> <CABb+yY2tRjazjaogpM7irqgTD+PdwsfqCxk5hP-_czrET3V5xQ@mail.gmail.com>
 <AM0PR04MB4481785CABB44A8C71CFB8D788BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY2TREpO7+TFcGgsgQrkmMWwFAgtuJ4GnLPPQ+GEBuh07w@mail.gmail.com> <AM0PR04MB448161C632722DF10989008088BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB448161C632722DF10989008088BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 30 Aug 2019 02:52:40 -0500
Message-ID: <CABb+yY2SrMF8e1iLyLqb-rJyBx4ajA0hZ6D=LFtuMNtXYjgccA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 2:37 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi Jassi,
>
> > Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
> > SMC/HVC mailbox
> >
> > On Fri, Aug 30, 2019 at 1:28 AM Peng Fan <peng.fan@nxp.com> wrote:
> >
> > > > > +examples:
> > > > > +  - |
> > > > > +    sram@910000 {
> > > > > +      compatible = "mmio-sram";
> > > > > +      reg = <0x0 0x93f000 0x0 0x1000>;
> > > > > +      #address-cells = <1>;
> > > > > +      #size-cells = <1>;
> > > > > +      ranges = <0 0x0 0x93f000 0x1000>;
> > > > > +
> > > > > +      cpu_scp_lpri: scp-shmem@0 {
> > > > > +        compatible = "arm,scmi-shmem";
> > > > > +        reg = <0x0 0x200>;
> > > > > +      };
> > > > > +
> > > > > +      cpu_scp_hpri: scp-shmem@200 {
> > > > > +        compatible = "arm,scmi-shmem";
> > > > > +        reg = <0x200 0x200>;
> > > > > +      };
> > > > > +    };
> > > > > +
> > > > > +    firmware {
> > > > > +      smc_mbox: mailbox {
> > > > > +        #mbox-cells = <1>;
> > > > > +        compatible = "arm,smc-mbox";
> > > > > +        method = "smc";
> > > > > +        arm,num-chans = <0x2>;
> > > > > +        transports = "mem";
> > > > > +        /* Optional */
> > > > > +        arm,func-ids = <0xc20000fe>, <0xc20000ff>;
> > > > >
> > > > SMC/HVC is synchronously(block) running in "secure mode", i.e, there
> > > > can only be one instance running platform wide. Right?
> > >
> > > I think there could be channel for TEE, and channel for Linux.
> > > For virtualization case, there could be dedicated channel for each VM.
> > >
> > I am talking from Linux pov. Functions 0xfe and 0xff above, can't both be
> > active at the same time, right?
>
> If I get your point correctly,
> On UP, both could not be active. On SMP, tx/rx could be both active, anyway
> this depends on secure firmware and Linux firmware design.
>
> Do you have any suggestions about arm,func-ids here?
>
I was thinking if this is just an instruction, why can't each channel
be represented as a controller, i.e, have exactly one func-id per
controller node. Define as many controllers as you need channels ?

-j
