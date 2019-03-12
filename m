Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21864C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA2D214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552358338;
	bh=JXdzeVfZX3Q3GwE9L2uuADdFHApAcwGlujUZ0+o9tvI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OCsBc1RUPA3J9exITcgefipm8wRAWhW6wLlfSVcXudq0hc8DTPwSTYVZM1W6tNqQX
	 IXInbs1w5Y/H+92mOIKaD2CsZdgYtyWfIh3WX55BzKsX/ZPmkEELjQWmtcpaCXWQRx
	 mjy7jS6XFkKLGvMVnAbPJ5N0Q9GqsCaUcK7bCTE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfCLCiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:38:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfCLCiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:38:55 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 149912175B;
        Tue, 12 Mar 2019 02:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552358334;
        bh=JXdzeVfZX3Q3GwE9L2uuADdFHApAcwGlujUZ0+o9tvI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EzilIesNrm+OEdNLA/jAu1NWUR6C7y2jUbdJjL+9AX68vNlWq7fS8J6Sdqsy84TJf
         NNykaro/Xin1FBRm2ridVbXs3rAxhaQqdKCGpwdhSk/YKbEdqITNoPDUpeR3lUFMrD
         uEzEYlJctggH6pfByHzNPCM3vxgvIgCOCMoOPFaE=
Received: by mail-qt1-f180.google.com with SMTP id u7so939968qtg.9;
        Mon, 11 Mar 2019 19:38:54 -0700 (PDT)
X-Gm-Message-State: APjAAAXSqLPjCG0WLYOQ+Zk8fpUJ5XHmmJ2cexO5fGu+RanlmDKyTrWt
        lXpVCUbhKSiCncMdju1ON9OQzQoKRl96vTNBog==
X-Google-Smtp-Source: APXvYqzazq9DRiqBlriaL3N1eCH8swfJ/CwGz06a753IaFv7Fv/X9aKt5JmIaD4iG7kp9oaFbwnFVS2gJxxTUC2cHVQ=
X-Received: by 2002:ac8:267c:: with SMTP id v57mr589228qtv.76.1552358333209;
 Mon, 11 Mar 2019 19:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190304185536.211084-1-venture@google.com> <20190311222007.GA16254@bogus>
 <CAO=notzjsdOxJSf+p+OqB71N5-c1QPCcfd9OVAV8ft18e+SngQ@mail.gmail.com>
In-Reply-To: <CAO=notzjsdOxJSf+p+OqB71N5-c1QPCcfd9OVAV8ft18e+SngQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 11 Mar 2019 21:38:41 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+M2P8eEkwS9-mLXfoA3LC6K-_WHUns5sH75E6h6qC2fA@mail.gmail.com>
Message-ID: <CAL_Jsq+M2P8eEkwS9-mLXfoA3LC6K-_WHUns5sH75E6h6qC2fA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
To:     Patrick Venture <venture@google.com>
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

On Mon, Mar 11, 2019 at 6:49 PM Patrick Venture <venture@google.com> wrote:
>
> On Mon, Mar 11, 2019 at 3:20 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Mar 04, 2019 at 10:55:36AM -0800, Patrick Venture wrote:
> > > Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> > >
> > > Signed-off-by: Patrick Venture <venture@google.com>
> > > ---
> > > Changes for v6:
> > > - None
> > > Changes for v5:
> > > - None
> > > Changes for v4:
> > > - None
> > > Changes for v3:
> > > - None
> > > Changes for v2:
> > > - Added comment about syscon required parameter.
> > > ---
> > >  .../bindings/misc/aspeed-p2a-ctrl.txt         | 32 +++++++++++++++++++
> > >  1 file changed, 32 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > > new file mode 100644
> > > index 000000000000..1092d62d1c92
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > > @@ -0,0 +1,32 @@
> > > +======================================================================
> > > +Device tree bindings for Aspeed AST2400/AST2500 PCI-to-AHB Bridge Control Driver
> > > +======================================================================
> > > +
> > > +The bridge is available on platforms with the VGA enabled on the Aspeed device.
> > > +In this case, the host has access to a 64KiB window into all of the BMC's
> > > +memory.  The BMC can disable this bridge.  If the bridge is enabled, the host
> > > +has read access to all the regions of memory, however the host only has read
> > > +and write access depending on a register controlled by the BMC.
> > > +
> > > +Required properties:
> > > +===================
> > > +
> > > + - compatible: must be one of:
> > > +     - "aspeed,ast2400-p2a-ctrl"
> > > +     - "aspeed,ast2500-p2a-ctrl"
> > > +
> > > + - syscon: handle to syscon device node controlling PCI.
> > > +
> > > +Optional properties:
> > > +===================
> > > +
> > > +- memory-region: A phandle to a reserved_memory region to be used for the PCI
> > > +             to AHB mapping
> > > +
> > > +Example:
> > > +
> > > +p2a: p2a-control@1e6e2000 {
> > > +     compatible = "aspeed,ast2400-p2a-ctrl";
> > > +     memory-region = <&reserved_memory>;
> > > +     syscon = <&syscon>;
> >
> > Make this node a child of what you are pointing to instead if this the
> > only control interface.
>
> You're suggesting I make this a child of the syscon?

Yes.

Rob
