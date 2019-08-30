Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB083C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764F52173E
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 08:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3//Wl0s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfH3IMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 04:12:42 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37356 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfH3IMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 04:12:41 -0400
Received: by mail-io1-f65.google.com with SMTP id q12so12355871iog.4;
        Fri, 30 Aug 2019 01:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NMrzUZakuedIUFLQ4qutVDpTqggQszwfrIEmL3MWamg=;
        b=Y3//Wl0sWaMJ6wZfWWTEwNj1Ox+8VsXUOD6+9/kw3jfi+mNkIE29xffetrvEfzI1Wq
         d3OnmMYj0mkdydFyG1GuZ4H2/jaP945KeSzyBAadRbsOU3qESLZgfEzG7NO4r+wLRnKn
         kTQg0qnEqIsZBSm5zKfvMw2jHU4+GtDYCEq6Y0y24huz5Z6Eu1wEOcO17KhzMerfQcxC
         i8isXfCddnFPsZcwXumtvx96t1lUFOiLWiywIij/V2wDIhO0wOWPisX1w0H/MTjopICW
         e25EVQIL9nLsmF8Yn8IdQi12o+lTtDTsa0hJcvyFleCOylBWCjxeaJen7T+LWmC/uXlO
         PiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NMrzUZakuedIUFLQ4qutVDpTqggQszwfrIEmL3MWamg=;
        b=aVc+/DmY3bmXTnlSteLS9pV17WGiZIMI1ZKxpmFTSE7YZFO+o0YaysXb4ilPJBSK+2
         Y3sp7CQbJnYY6rHTLU19KTPPCpXYyX8fY4YgdwcoQ32D34CoHEZj52aE0IXz4uUlEkpN
         VEylUZ0tp86DzMHpPwRMfgn4vMKAn5iMgPnAJqKAIvjY1x1ZR3z0xamBkspwThi6v799
         DIp42aI2BDngvBB8YRAqlRLfpV0ZwHuRtXBbTElY2Jr1mgy06Hdu4LaUTo8PaMEaigFo
         h0FtRpprqNJ4RMqjFRfNznvvZa7Q5C3dPS6s9Ld3Au1d7Eeol/wyHG8C7mpPrtCmDM4F
         MXxw==
X-Gm-Message-State: APjAAAWRzUBsMWPBZ87kn4b9iW2jOzKr+1sKP6KOdZZ2lxkt9XrdCY6M
        1PBzX2N3Ni6kcnd9GiBApkRW6/KwgA5xsfwONZSwRg==
X-Google-Smtp-Source: APXvYqzRkLgg62E5VqPsCQHPop+fShn/+BbHSzlhnrnA2SZOVRr9hhh4RYBbl4DSGWx+IK21jAy1mSaPlMkwqpKsgMI=
X-Received: by 2002:a5e:8c0a:: with SMTP id n10mr12946485ioj.69.1567152760530;
 Fri, 30 Aug 2019 01:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
 <1567004515-3567-2-git-send-email-peng.fan@nxp.com> <CABb+yY2tRjazjaogpM7irqgTD+PdwsfqCxk5hP-_czrET3V5xQ@mail.gmail.com>
 <AM0PR04MB4481785CABB44A8C71CFB8D788BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY2TREpO7+TFcGgsgQrkmMWwFAgtuJ4GnLPPQ+GEBuh07w@mail.gmail.com>
 <AM0PR04MB448161C632722DF10989008088BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY2SrMF8e1iLyLqb-rJyBx4ajA0hZ6D=LFtuMNtXYjgccA@mail.gmail.com> <AM0PR04MB448133D1F4C887A82C679CEB88BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB448133D1F4C887A82C679CEB88BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 30 Aug 2019 03:12:29 -0500
Message-ID: <CABb+yY2t-oz6KqvCTsOJZqcMAUaR9Cbj014m7dCFXSBAMCojww@mail.gmail.com>
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

On Fri, Aug 30, 2019 at 3:07 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
> > SMC/HVC mailbox
> >
> > On Fri, Aug 30, 2019 at 2:37 AM Peng Fan <peng.fan@nxp.com> wrote:
> > >
> > > Hi Jassi,
> > >
> > > > Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc
> > > > for the ARM SMC/HVC mailbox
> > > >
> > > > On Fri, Aug 30, 2019 at 1:28 AM Peng Fan <peng.fan@nxp.com> wrote:
> > > >
> > > > > > > +examples:
> > > > > > > +  - |
> > > > > > > +    sram@910000 {
> > > > > > > +      compatible = "mmio-sram";
> > > > > > > +      reg = <0x0 0x93f000 0x0 0x1000>;
> > > > > > > +      #address-cells = <1>;
> > > > > > > +      #size-cells = <1>;
> > > > > > > +      ranges = <0 0x0 0x93f000 0x1000>;
> > > > > > > +
> > > > > > > +      cpu_scp_lpri: scp-shmem@0 {
> > > > > > > +        compatible = "arm,scmi-shmem";
> > > > > > > +        reg = <0x0 0x200>;
> > > > > > > +      };
> > > > > > > +
> > > > > > > +      cpu_scp_hpri: scp-shmem@200 {
> > > > > > > +        compatible = "arm,scmi-shmem";
> > > > > > > +        reg = <0x200 0x200>;
> > > > > > > +      };
> > > > > > > +    };
> > > > > > > +
> > > > > > > +    firmware {
> > > > > > > +      smc_mbox: mailbox {
> > > > > > > +        #mbox-cells = <1>;
> > > > > > > +        compatible = "arm,smc-mbox";
> > > > > > > +        method = "smc";
> > > > > > > +        arm,num-chans = <0x2>;
> > > > > > > +        transports = "mem";
> > > > > > > +        /* Optional */
> > > > > > > +        arm,func-ids = <0xc20000fe>, <0xc20000ff>;
> > > > > > >
> > > > > > SMC/HVC is synchronously(block) running in "secure mode", i.e,
> > > > > > there can only be one instance running platform wide. Right?
> > > > >
> > > > > I think there could be channel for TEE, and channel for Linux.
> > > > > For virtualization case, there could be dedicated channel for each VM.
> > > > >
> > > > I am talking from Linux pov. Functions 0xfe and 0xff above, can't
> > > > both be active at the same time, right?
> > >
> > > If I get your point correctly,
> > > On UP, both could not be active. On SMP, tx/rx could be both active,
> > > anyway this depends on secure firmware and Linux firmware design.
> > >
> > > Do you have any suggestions about arm,func-ids here?
> > >
> > I was thinking if this is just an instruction, why can't each channel be
> > represented as a controller, i.e, have exactly one func-id per controller node.
> > Define as many controllers as you need channels ?
>
> I am ok, this could make driver code simpler. Something as below?
>
>     smc_tx_mbox: tx_mbox {
>       #mbox-cells = <0>;
>       compatible = "arm,smc-mbox";
>       method = "smc";
>       transports = "mem";
>       arm,func-id = <0xc20000fe>;
>     };
>
>     smc_rx_mbox: rx_mbox {
>       #mbox-cells = <0>;
>       compatible = "arm,smc-mbox";
>       method = "smc";
>       transports = "mem";
>       arm,func-id = <0xc20000ff>;
>     };
>
>     firmware {
>       scmi {
>         compatible = "arm,scmi";
>         mboxes = <&smc_tx_mbox>, <&smc_rx_mbox 1>;
>         mbox-names = "tx", "rx";
>         shmem = <&cpu_scp_lpri>, <&cpu_scp_hpri>;
>       };
>     };
>
Yes, the channel part is good.
But I am not convinced by the need to have SCMI specific "transport" mode.

thanks
