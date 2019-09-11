Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1CDC49ED7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 02:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC83C21D82
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 02:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSkmHAeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfIKCgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 22:36:48 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45072 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfIKCgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 22:36:47 -0400
Received: by mail-io1-f67.google.com with SMTP id f12so42277485iog.12;
        Tue, 10 Sep 2019 19:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OwUw/A+EuWCuR5fA3FXok+c2wlYUpc7vdIubwfDS7IA=;
        b=bSkmHAeUBk6i8XFvgk1v0d1YocIoUrBFVfhPqlhu3N4fOjDvoD9EKa5F7KTsgSREs2
         o5xzdhi6N4aiRN9s4Q0hBRGZflMQutIV+HiSEwfjTg2AiQOLAdhAs1kI4An2ef3WCNVL
         aXK56vdC4ezdwGGkjS3YSc+HNWAGPyYd/9Ok1CJwvAR/9Q+cUUT8x1hGlC/dGojKguBw
         z0TcOLN8zfDnbs89SyXBu4UAJdL/OwgajnmSsah4twlbSlnf+m2zN8PT5zm+aA0bz1gj
         CJcwOIE3nP1fYa+Fe3Ci3Wyjj0kA0IkcVZMyHWvJE+2rBWhXsFMAbP73H7eIf/V+/JR2
         CIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OwUw/A+EuWCuR5fA3FXok+c2wlYUpc7vdIubwfDS7IA=;
        b=U66vT1HYn8DDLmODFNqoDWV/4lrg9MCfJ5YY+R9qJm4wP7JC+I2qRYBYVXFgLJcdeB
         LydniOzurW7bQ40Lm7sSWQWOsJ2uaU8juvV26uvcubFlSmiQxouXDw5obhHIXIrJC3xm
         tdTQeI2aPsTKK+Xsfu1/MzkDY+vh/jc03l8Bo20Yd7N+ryvIDLcL2y3BTOMav34feyVc
         6Zonm65GnPEYvMd4qNxiuecl2KkGLKK2KTrHI1I27mspvZNXPr46sJNgILfi/mTOC86s
         mIX+VrHplHkvYV/5+WiwLwsJe2FbR9LIhurB1D2KsiozZzI4Suz3UwztxFRwynZxboAj
         DwhA==
X-Gm-Message-State: APjAAAV0ysR88yjMmDltjOn1yTyAHCcWjKOMGBRQR2Hdsfb7j6fY3dUg
        UZlA24yi9mjSV7fCNPQmc4jlBMgXDWU87TDdXkP4+Q==
X-Google-Smtp-Source: APXvYqyJ8ndRsk4DRRqFvjYNPP3fbctVHqsRkMdlHOlE1KyA4ZrDzKhq+wPo3x4T57rpNyZnntrLcrIIBHq6s2fubcY=
X-Received: by 2002:a6b:e609:: with SMTP id g9mr13267243ioh.7.1568169406511;
 Tue, 10 Sep 2019 19:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
 <1567004515-3567-2-git-send-email-peng.fan@nxp.com> <CABb+yY2tRjazjaogpM7irqgTD+PdwsfqCxk5hP-_czrET3V5xQ@mail.gmail.com>
 <AM0PR04MB4481785CABB44A8C71CFB8D788BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY2TREpO7+TFcGgsgQrkmMWwFAgtuJ4GnLPPQ+GEBuh07w@mail.gmail.com>
 <AM0PR04MB448161C632722DF10989008088BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY2SrMF8e1iLyLqb-rJyBx4ajA0hZ6D=LFtuMNtXYjgccA@mail.gmail.com>
 <AM0PR04MB448133D1F4C887A82C679CEB88BD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CABb+yY2t-oz6KqvCTsOJZqcMAUaR9Cbj014m7dCFXSBAMCojww@mail.gmail.com> <20190909143230.48b1143f@donnerap.cambridge.arm.com>
In-Reply-To: <20190909143230.48b1143f@donnerap.cambridge.arm.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 10 Sep 2019 21:36:35 -0500
Message-ID: <CABb+yY3kfLbdSSdQtZUu9HU1YbXSpbQWW85m0sieR7bJJYBaFA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
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

On Mon, Sep 9, 2019 at 8:32 AM Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Fri, 30 Aug 2019 03:12:29 -0500
> Jassi Brar <jassisinghbrar@gmail.com> wrote:
>
> Hi,
>
> > On Fri, Aug 30, 2019 at 3:07 AM Peng Fan <peng.fan@nxp.com> wrote:
> > >
> > > > Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the ARM
> > > > SMC/HVC mailbox
> > > >
> > > > On Fri, Aug 30, 2019 at 2:37 AM Peng Fan <peng.fan@nxp.com> wrote:
> > > > >
> > > > > Hi Jassi,
> > > > >
> > > > > > Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc
> > > > > > for the ARM SMC/HVC mailbox
> > > > > >
> > > > > > On Fri, Aug 30, 2019 at 1:28 AM Peng Fan <peng.fan@nxp.com> wrote:
> > > > > >
> > > > > > > > > +examples:
> > > > > > > > > +  - |
> > > > > > > > > +    sram@910000 {
> > > > > > > > > +      compatible = "mmio-sram";
> > > > > > > > > +      reg = <0x0 0x93f000 0x0 0x1000>;
> > > > > > > > > +      #address-cells = <1>;
> > > > > > > > > +      #size-cells = <1>;
> > > > > > > > > +      ranges = <0 0x0 0x93f000 0x1000>;
> > > > > > > > > +
> > > > > > > > > +      cpu_scp_lpri: scp-shmem@0 {
> > > > > > > > > +        compatible = "arm,scmi-shmem";
> > > > > > > > > +        reg = <0x0 0x200>;
> > > > > > > > > +      };
> > > > > > > > > +
> > > > > > > > > +      cpu_scp_hpri: scp-shmem@200 {
> > > > > > > > > +        compatible = "arm,scmi-shmem";
> > > > > > > > > +        reg = <0x200 0x200>;
> > > > > > > > > +      };
> > > > > > > > > +    };
> > > > > > > > > +
> > > > > > > > > +    firmware {
> > > > > > > > > +      smc_mbox: mailbox {
> > > > > > > > > +        #mbox-cells = <1>;
> > > > > > > > > +        compatible = "arm,smc-mbox";
> > > > > > > > > +        method = "smc";
> > > > > > > > > +        arm,num-chans = <0x2>;
> > > > > > > > > +        transports = "mem";
> > > > > > > > > +        /* Optional */
> > > > > > > > > +        arm,func-ids = <0xc20000fe>, <0xc20000ff>;
> > > > > > > > >
> > > > > > > > SMC/HVC is synchronously(block) running in "secure mode", i.e,
> > > > > > > > there can only be one instance running platform wide. Right?
> > > > > > >
> > > > > > > I think there could be channel for TEE, and channel for Linux.
> > > > > > > For virtualization case, there could be dedicated channel for each VM.
> > > > > > >
> > > > > > I am talking from Linux pov. Functions 0xfe and 0xff above, can't
> > > > > > both be active at the same time, right?
> > > > >
> > > > > If I get your point correctly,
> > > > > On UP, both could not be active. On SMP, tx/rx could be both active,
> > > > > anyway this depends on secure firmware and Linux firmware design.
> > > > >
> > > > > Do you have any suggestions about arm,func-ids here?
> > > > >
> > > > I was thinking if this is just an instruction, why can't each channel be
> > > > represented as a controller, i.e, have exactly one func-id per controller node.
> > > > Define as many controllers as you need channels ?
> > >
> > > I am ok, this could make driver code simpler. Something as below?
> > >
> > >     smc_tx_mbox: tx_mbox {
> > >       #mbox-cells = <0>;
> > >       compatible = "arm,smc-mbox";
> > >       method = "smc";
> > >       transports = "mem";
> > >       arm,func-id = <0xc20000fe>;
> > >     };
> > >
> > >     smc_rx_mbox: rx_mbox {
> > >       #mbox-cells = <0>;
> > >       compatible = "arm,smc-mbox";
> > >       method = "smc";
> > >       transports = "mem";
> > >       arm,func-id = <0xc20000ff>;
> > >     };
> > >
> > >     firmware {
> > >       scmi {
> > >         compatible = "arm,scmi";
> > >         mboxes = <&smc_tx_mbox>, <&smc_rx_mbox 1>;
> > >         mbox-names = "tx", "rx";
> > >         shmem = <&cpu_scp_lpri>, <&cpu_scp_hpri>;
> > >       };
> > >     };
> > >
> > Yes, the channel part is good.
> > But I am not convinced by the need to have SCMI specific "transport" mode.
>
> Why would this be SCMI specific and what is the problem with having this property?
> By the very nature of the SMC/HVC call you would expect to also pass parameters in registers.
> However this limits the amount of data you can push, so the option of reverting to a
> memory based payload sounds very reasonable.
>
Of course, it is very legit to pass data via mem and many platforms do
that. But as you note in your next post, the 'transport' doesn't seem
necessary doing what it does in the driver.

Cheers!
