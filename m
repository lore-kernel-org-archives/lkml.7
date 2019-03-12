Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B652C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E850C214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nHHAjvzq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfCLOXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:23:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41775 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfCLOXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:23:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id k11so1945283pgb.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LI142OUzs1YvVlGYbMcRtFCPXzRJ3AxyDPmY/uwg1pw=;
        b=nHHAjvzq9WC4XOF5Lmdj9oRtCGQaZ5IEU1ro1rgt/t66NS86a9v/OpuoGcqon3L1Jp
         mjUWBuNpw2/r+5/qu/5LDUaAexMf3MsUkLXNg3EIP7/aLTGEyk39Bfzq/QtstI/ePtRk
         /c42DUF1q7z1vlXt6zBkJznDp6131Vjyw80vJwBTxvcskdel1GRALPkmWUJ9hgwy7Fhn
         pDOcm75paIS7e58VjSCKtNIKqVq9IipqVhq2Fjqe9SqF85Obhj9MI0KobEMIFWdIPflQ
         7vwXlP73qIND8PLsjYtDzIHjeDZDj7+1FKUYv7N+vPt1hHl4Y6pY+bfp02/yI4KoH+ys
         o4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LI142OUzs1YvVlGYbMcRtFCPXzRJ3AxyDPmY/uwg1pw=;
        b=VIkw1RvJ+L9BNZ9j8+oIa/zQs3sTxER/8ZIT74qIyy/6tKywYu5z2FJY4wcneTn0uR
         nZn0dJg+d/DeG4Me2IMkR67W6INDxufyC1cQEn1PSfpUz57J3jfvD8HQRAAt/sdbIlm6
         6o/7zAFnUwak9e0SGgHP5/oWp1KRGhC79xqWJ9w01PuyM6WSmx9KPFaTWx0oOszsU65H
         qJCwMEUQqA6ifuocYrRRq8z0B0Y7dng7KBil7UV4WkGDju3ek5Hkor5Fvwx68NDR2JXg
         01AXBPpypmJ8CxV+fsdqupdZtMSZF5KIWzsmcvcGHCVD+LqJpdQM4iFqFKwgPijVyjLv
         vkGA==
X-Gm-Message-State: APjAAAUZtifwId1Js8RDvTZCDsJJPuB8aFrpjbk3JNYz/ptVicE+f6N2
        ExQh0I6mYuOU7x93kvv8scRSCH4IV4dXJlsI9FRkmQ==
X-Google-Smtp-Source: APXvYqxmysn/xiDkK/XwNwe/vY58Z+eHyo+qJIe/Ry5g2s8YszjsaaP793gS7wH3lCV8rFhe+y9qBoUtiDOJqLCrEQ8=
X-Received: by 2002:a17:902:8b83:: with SMTP id ay3mr1382485plb.1.1552400595900;
 Tue, 12 Mar 2019 07:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190304185536.211084-1-venture@google.com> <20190311222007.GA16254@bogus>
 <CAO=notzjsdOxJSf+p+OqB71N5-c1QPCcfd9OVAV8ft18e+SngQ@mail.gmail.com> <CAL_Jsq+M2P8eEkwS9-mLXfoA3LC6K-_WHUns5sH75E6h6qC2fA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+M2P8eEkwS9-mLXfoA3LC6K-_WHUns5sH75E6h6qC2fA@mail.gmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Tue, 12 Mar 2019 07:23:04 -0700
Message-ID: <CAO=noty8c3T+6=L+m=85Ps8Ms-5EGwkcT1FMJK0UFf=EqRbOww@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg KH <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 7:38 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Mar 11, 2019 at 6:49 PM Patrick Venture <venture@google.com> wrote:
> >
> > On Mon, Mar 11, 2019 at 3:20 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Mon, Mar 04, 2019 at 10:55:36AM -0800, Patrick Venture wrote:
> > > > Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> > > >
> > > > Signed-off-by: Patrick Venture <venture@google.com>
> > > > ---
> > > > Changes for v6:
> > > > - None
> > > > Changes for v5:
> > > > - None
> > > > Changes for v4:
> > > > - None
> > > > Changes for v3:
> > > > - None
> > > > Changes for v2:
> > > > - Added comment about syscon required parameter.
> > > > ---
> > > >  .../bindings/misc/aspeed-p2a-ctrl.txt         | 32 +++++++++++++++++++
> > > >  1 file changed, 32 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > > > new file mode 100644
> > > > index 000000000000..1092d62d1c92
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > > > @@ -0,0 +1,32 @@
> > > > +======================================================================
> > > > +Device tree bindings for Aspeed AST2400/AST2500 PCI-to-AHB Bridge Control Driver
> > > > +======================================================================
> > > > +
> > > > +The bridge is available on platforms with the VGA enabled on the Aspeed device.
> > > > +In this case, the host has access to a 64KiB window into all of the BMC's
> > > > +memory.  The BMC can disable this bridge.  If the bridge is enabled, the host
> > > > +has read access to all the regions of memory, however the host only has read
> > > > +and write access depending on a register controlled by the BMC.
> > > > +
> > > > +Required properties:
> > > > +===================
> > > > +
> > > > + - compatible: must be one of:
> > > > +     - "aspeed,ast2400-p2a-ctrl"
> > > > +     - "aspeed,ast2500-p2a-ctrl"
> > > > +
> > > > + - syscon: handle to syscon device node controlling PCI.
> > > > +
> > > > +Optional properties:
> > > > +===================
> > > > +
> > > > +- memory-region: A phandle to a reserved_memory region to be used for the PCI
> > > > +             to AHB mapping
> > > > +
> > > > +Example:
> > > > +
> > > > +p2a: p2a-control@1e6e2000 {
> > > > +     compatible = "aspeed,ast2400-p2a-ctrl";
> > > > +     memory-region = <&reserved_memory>;
> > > > +     syscon = <&syscon>;
> > >
> > > Make this node a child of what you are pointing to instead if this the
> > > only control interface.
> >
> > You're suggesting I make this a child of the syscon?
>
> Yes.

Roger that, will update and send out a patchset v6 with the
corresponding changes.

>
> Rob
