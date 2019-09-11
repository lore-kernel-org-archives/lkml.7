Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF88C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D55D20863
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfIKPDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 11:03:13 -0400
Received: from foss.arm.com ([217.140.110.172]:49172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728054AbfIKPDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 11:03:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D1821000;
        Wed, 11 Sep 2019 08:03:12 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D9AE3F67D;
        Wed, 11 Sep 2019 08:03:11 -0700 (PDT)
Date:   Wed, 11 Sep 2019 16:03:08 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
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
Subject: Re: [PATCH v5 1/2] dt-bindings: mailbox: add binding doc for the
 ARM SMC/HVC mailbox
Message-ID: <20190911160308.30878cc3@donnerap.cambridge.arm.com>
In-Reply-To: <CABb+yY2rppSOgqMy+R294d94xwi5UPR55Eo-WB8KA6m11nG3iQ@mail.gmail.com>
References: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
        <1567004515-3567-2-git-send-email-peng.fan@nxp.com>
        <20190909164208.6605054e@donnerap.cambridge.arm.com>
        <CABb+yY2rppSOgqMy+R294d94xwi5UPR55Eo-WB8KA6m11nG3iQ@mail.gmail.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2019 21:44:11 -0500
Jassi Brar <jassisinghbrar@gmail.com> wrote:

Hi,

> On Mon, Sep 9, 2019 at 10:42 AM Andre Przywara <andre.przywara@arm.com> wrote:
> >
> > On Wed, 28 Aug 2019 03:02:58 +0000
> > Peng Fan <peng.fan@nxp.com> wrote:
> >
[ ... ]
> >  
> > > +
> > > +  arm,func-ids:
> > > +    description: |
> > > +      An array of 32-bit values specifying the function IDs used by each
> > > +      mailbox channel. Those function IDs follow the ARM SMC calling
> > > +      convention standard [1].
> > > +
> > > +      There is one identifier per channel and the number of supported
> > > +      channels is determined by the length of this array.  
> >
> > I think this makes it obvious that arm,num-chans is not needed.
> >
> > Also this somewhat contradicts the driver implementation, which allows the array to be shorter, marking this as UINT_MAX and later on using the first data item as a function identifier. This is somewhat surprising and not documented (unless I missed something).
> >
> > So I would suggest:
> > - We drop the transports property, and always put the client provided data in the registers, according to the SMCCC. Document this here.
> >   A client not needing those could always puts zeros (or garbage) in there, the respective firmware would just ignore the registers.
> > - We drop "arm,num-chans", as this is just redundant with the length of the func-ids array.
> > - We don't impose an arbitrary limit on the number of channels. From the firmware point of view this is just different function IDs, from Linux' point of view just the size of the memory used. Both don't need to be limited artificially IMHO.
> >  
> Sounds like we are in sync.
> 
> > - We mark arm,func-ids as required, as this needs to be fixed, allocated number.
> >  
> I still think func-id can be done without. A client can always pass
> the value as it knows what it expects.

I don't think it's the right abstraction. The mailbox *controller* uses a specific func-id, this has to match the one the firmware expects. So this is a property of the mailbox transport channel (the SMC call), and the *client* should *not* care about it. It just sees the logical channel ID (if we have one), which the controller translates into the func-ID.

So it should really look like this (assuming only single channel controllers):
mailbox: smc-mailbox {
    #mbox-cells = <0>;
    compatible = "arm,smc-mbox";
    method = "smc";
    arm,func-id = <0x820000fe>;
};
scmi {
    compatible = "arm,scmi";
    mboxes = <&smc_mbox>;
    mbox-names = "tx"; /* rx is optional */
    shmem = <&cpu_scp_hpri>;
};

If you allow the client to provide the function ID (and I am not saying this is a good idea): where would this func ID come from? It would need to be a property of the client DT node, then. So one way would be to use the func ID as the Linux mailbox channel ID:
mailbox: smc-mailbox {
    #mbox-cells = <1>;
    compatible = "arm,smc-mbox";
    method = "smc";
};
scmi {
    compatible = "arm,scmi";
    mboxes = <&smc_mbox 0x820000fe>;
    mbox-names = "tx"; /* rx is optional */
    shmem = <&cpu_scp_hpri>;
};

But this doesn't look desirable.

And as I mentioned this before: allowing some mailbox clients to provide the function IDs sound scary, as they could use anything they want, triggering random firmware actions (think PSCI_CPU_OFF).

So I think we should have a required "arm,func-id" property, with exactly one 32-bit value (again assuming single channel controllers).

Cheers,
Andre.
