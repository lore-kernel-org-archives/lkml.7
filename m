Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03963C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C279620872
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Or3of+ZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbfIKQzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 12:55:22 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43614 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729205AbfIKQzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:55:21 -0400
Received: by mail-io1-f65.google.com with SMTP id r8so22475266iol.10;
        Wed, 11 Sep 2019 09:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x17kcwTzLlp3AfSaKdZGwJQ4xIT8JG2uuYs3ld3gBdQ=;
        b=Or3of+ZM/yv75Ya1r+oOFZduWrVp1tGDuHRoCdr6HUO6H1JxbI1Y312hqPrDR2oHYy
         Kcv65TaVSQnM4k6Qp/25n9MvyICvzQcmj0TWnWhjwlkGScxgxlKpPWkAx4uRnlmK9MmP
         0PkahmtEzEWmSDw6BPjKAKdOaL9/W7AgPVnDElH/kDjUHRCQzq9yIu8DXKw0L4SuZgMV
         VVlP9upAsFnT79nxa7qO7mN5r13x4v7wyl+K0+BnSTykGhRLVTdq00w+aSWxC+/rjYK1
         K4B4Ox8b3NW13YdFCweUiKqMcDIwnGYm7Zb3fYQgUiUWyWkuI8MgFBvIXXq+qbxZd4ok
         CWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x17kcwTzLlp3AfSaKdZGwJQ4xIT8JG2uuYs3ld3gBdQ=;
        b=QOxZzAGNsN1XhR6z0lSqH7dm9cVPcDvLG4doLiWevq0kkbPF2nNbmQiDwXoS+4zmDN
         ivumR2cHl8QhGSHwZbHSLUoN+V7DA9gOFePrfj+t2LeeF89OLpvn1vdrLw2FrOWSjrLg
         nCB4hEiGesj9JLIrbrHd07taTslWmGzPPLzXV4Sd2jZnKwLGkDCycsBu5GA2NNqyoPCO
         3Fkvn2eDTdyONXssFLlUC/3jOr8Sweb0nFDOj5Z4cGZwflAKGWLdOaXvm4+Y6PWXMJAH
         U32i/2egQcoNM7gBeY8W9QwN1NeSbq/JYWrpD41wvD1+lhYottCA0Qy7hSuTBseHd1FW
         P6jQ==
X-Gm-Message-State: APjAAAX51y93MZhLlZWZtuKVncXdAuSHwIVBfUyP78hv4eyxS0cyLp9Q
        KdWRsPnfWx2bGu5Iihp/xJ+25Em8iDKRSJMxZ5g=
X-Google-Smtp-Source: APXvYqwpx89BGLysU2GSOowdBNkAvpvNXZaPuDIzD466qjSq4YPYqpsgCVd+LCc0T0bwN/jNMczZiKyEr5liu4d2ehg=
X-Received: by 2002:a6b:1646:: with SMTP id 67mr147961iow.11.1568220920591;
 Wed, 11 Sep 2019 09:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <1567004515-3567-1-git-send-email-peng.fan@nxp.com>
 <1567004515-3567-2-git-send-email-peng.fan@nxp.com> <20190909164208.6605054e@donnerap.cambridge.arm.com>
 <CABb+yY2rppSOgqMy+R294d94xwi5UPR55Eo-WB8KA6m11nG3iQ@mail.gmail.com> <20190911160308.30878cc3@donnerap.cambridge.arm.com>
In-Reply-To: <20190911160308.30878cc3@donnerap.cambridge.arm.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 11 Sep 2019 11:55:09 -0500
Message-ID: <CABb+yY1oZxvX+mRNmObAHsGoBfN0F4GO+9PSj06EFaF3DsnstA@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 10:03 AM Andre Przywara <andre.przywara@arm.com> wr=
ote:
>
> On Tue, 10 Sep 2019 21:44:11 -0500
> Jassi Brar <jassisinghbrar@gmail.com> wrote:
>
> Hi,
>
> > On Mon, Sep 9, 2019 at 10:42 AM Andre Przywara <andre.przywara@arm.com>=
 wrote:
> > >
> > > On Wed, 28 Aug 2019 03:02:58 +0000
> > > Peng Fan <peng.fan@nxp.com> wrote:
> > >
> [ ... ]
> > >
> > > > +
> > > > +  arm,func-ids:
> > > > +    description: |
> > > > +      An array of 32-bit values specifying the function IDs used b=
y each
> > > > +      mailbox channel. Those function IDs follow the ARM SMC calli=
ng
> > > > +      convention standard [1].
> > > > +
> > > > +      There is one identifier per channel and the number of suppor=
ted
> > > > +      channels is determined by the length of this array.
> > >
> > > I think this makes it obvious that arm,num-chans is not needed.
> > >
> > > Also this somewhat contradicts the driver implementation, which allow=
s the array to be shorter, marking this as UINT_MAX and later on using the =
first data item as a function identifier. This is somewhat surprising and n=
ot documented (unless I missed something).
> > >
> > > So I would suggest:
> > > - We drop the transports property, and always put the client provided=
 data in the registers, according to the SMCCC. Document this here.
> > >   A client not needing those could always puts zeros (or garbage) in =
there, the respective firmware would just ignore the registers.
> > > - We drop "arm,num-chans", as this is just redundant with the length =
of the func-ids array.
> > > - We don't impose an arbitrary limit on the number of channels. From =
the firmware point of view this is just different function IDs, from Linux'=
 point of view just the size of the memory used. Both don't need to be limi=
ted artificially IMHO.
> > >
> > Sounds like we are in sync.
> >
> > > - We mark arm,func-ids as required, as this needs to be fixed, alloca=
ted number.
> > >
> > I still think func-id can be done without. A client can always pass
> > the value as it knows what it expects.
>
> I don't think it's the right abstraction. The mailbox *controller* uses a=
 specific func-id, this has to match the one the firmware expects. So this =
is a property of the mailbox transport channel (the SMC call), and the *cli=
ent* should *not* care about it. It just sees the logical channel ID (if we=
 have one), which the controller translates into the func-ID.
>
arg0 is special only to the client/protocol, otherwise it is simply
the first argument for the arm_smccc_smc *instruction* controller.
arg[1,7] are already provided by the client, so it is only neater if
arg0 is also taken from the client.

But as I said, I am still ok if func-id is passed from dt and arg0
from client is ignored because we have one channel per controller
design and we don't have to worry about number of channels there can
be dedicated to specific functions.

> So it should really look like this (assuming only single channel controll=
ers):
> mailbox: smc-mailbox {
>     #mbox-cells =3D <0>;
>     compatible =3D "arm,smc-mbox";
>     method =3D "smc";
>
Do we want to do away with 'method' property and use different
'compatible' properties instead?
 compatible =3D "arm,smc-mbox";     or    compatible =3D "arm,hvc-mbox";

>     arm,func-id =3D <0x820000fe>;
> };
> scmi {
>     compatible =3D "arm,scmi";
>     mboxes =3D <&smc_mbox>;
>     mbox-names =3D "tx"; /* rx is optional */
>     shmem =3D <&cpu_scp_hpri>;
> };
>
> If you allow the client to provide the function ID (and I am not saying t=
his is a good idea): where would this func ID come from? It would need to b=
e a property of the client DT node, then. So one way would be to use the fu=
nc ID as the Linux mailbox channel ID:
> mailbox: smc-mailbox {
>     #mbox-cells =3D <1>;
>     compatible =3D "arm,smc-mbox";
>     method =3D "smc";
> };
> scmi {
>     compatible =3D "arm,scmi";
>     mboxes =3D <&smc_mbox 0x820000fe>;
>     mbox-names =3D "tx"; /* rx is optional */
>     shmem =3D <&cpu_scp_hpri>;
> };
>
> But this doesn't look desirable.
>
> And as I mentioned this before: allowing some mailbox clients to provide =
the function IDs sound scary, as they could use anything they want, trigger=
ing random firmware actions (think PSCI_CPU_OFF).
>
That paranoia is unwarranted. We have to keep faith in kernel-space
code doing the right thing.
Either the illegitimate function request should be rejected by the
firmware or client driver be called buggy.... just as we would call a
block device driver buggy if it messed up the sector numbers in a
write request.

thnx.
