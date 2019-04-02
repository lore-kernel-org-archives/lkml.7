Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FC8C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0402075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ie4bQWsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfDBVYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:24:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46162 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfDBVYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:24:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id q1so7161727pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bkGQE13GsdWKLOaw1fQZ4yp5t1Jwweb12JetTyoT95g=;
        b=Ie4bQWsyRA5nCrRG/T244BrMSLw9Xw1X/ipBKi8zbzuEJgCyPmMq+eCXWKmkHriQqt
         TDAtm24hckOUcG1/g0T4X4qOcD3Nwhu0pquimbUFdtOkgAZyiOPH47Q7HKkXPGyUfBrM
         2yK5yhklU6Kd0J/WEK87NjO9PI63UbIPqBNZWyRI3lx36S8jljnHiiuOKywxhR25lJUi
         EWVMR/RQjyzLpsTlyNjeQEV4u0ldG/Z4jRP1sV73An3N1P4uLeXmafiFNtmzULy5JuqL
         WtDjOR99h4D9Dzxzk/Ry6eE4Zx76loF2XDuIwQ0ERqd7V9sOZ03Cs90a7yTxqs0QssEC
         EvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkGQE13GsdWKLOaw1fQZ4yp5t1Jwweb12JetTyoT95g=;
        b=bDiZPQrXOcvRi5SohO67HVDWx4ZA46iryNAk+9VOY5PXU+2rn/ZBO8Dw3Qq7LldO0R
         iG6nzP/aPYGBnST6tII7qaiYQa9J3VNSfmaj8Km4oi3RBtoXcLL0tB2HlAWHb7cDlw6m
         q5mDyQAfD5VBMkPNhCsXIX+TG7C4DBULcMLqFD88UWZAh/ceKQab6u23pWrdwD7BxpYJ
         BrGJeXofWpUG/p+W3UWkILblDF0layEj4SNEZeVGaZUZsoDiaXP/xk9PGu7XDo+mHGIa
         hvrl8Y7/gmAMxjucmY5L8xy+nP1OKL5EUAPtOH1MyQ9EdOZeQTwM0IHGI4xzl3JBsIAq
         pGyQ==
X-Gm-Message-State: APjAAAXcrdWigCcSHWaBbFREuMm9t8unUNpP344DpAt1+LmioPF3kGhf
        4yTmbsLs8idgt2cUYBoi9T7t4MnsfTd3nS5Vx39kxw==
X-Google-Smtp-Source: APXvYqwZQ7n+paBvBR6wM+KWwQkbMjXi9aFcieJwOT4vUYxhMNV0YPOS3ocfS0fNnP2KqqiL39nlJ8TRn9xkHqWxX2Q=
X-Received: by 2002:a62:61c2:: with SMTP id v185mr20217596pfb.117.1554240281133;
 Tue, 02 Apr 2019 14:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190329151025.204094-1-venture@google.com> <e33bc539-2350-4b7d-9833-df270383b062@www.fastmail.com>
In-Reply-To: <e33bc539-2350-4b7d-9833-df270383b062@www.fastmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Tue, 2 Apr 2019 14:24:29 -0700
Message-ID: <CAO=noty_jSMLatu5Z-h03hrQ=uozd1eX8SSG=iGNeB+D4W6LQw@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 8:42 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Hi Patrick,
>
> I held off on reviewing this until we'd hashed out what we needed in the driver.
>
> I have some comments below.
>
> On Sat, 30 Mar 2019, at 01:40, Patrick Venture wrote:
> > Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> >
> > Signed-off-by: Patrick Venture <venture@google.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> > Changes for v8:
> > - None
> > Changes for v7:
> > - Moved node under the syscon node it requires
> > Changes for v6:
> > - None
> > Changes for v5:
> > - None
> > Changes for v4:
> > - None
> > Changes for v3:
> > - None
> > Changes for v2:
> > - Added comment about syscon required parameter.
> > ---
> >  .../bindings/misc/aspeed-p2a-ctrl.txt         | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> >
> > diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > new file mode 100644
> > index 0000000000000..088cc4e3dc54b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > @@ -0,0 +1,48 @@
> > +======================================================================
> > +Device tree bindings for Aspeed AST2400/AST2500 PCI-to-AHB Bridge
> > Control Driver
> > +======================================================================
> > +
> > +The bridge is available on platforms with the VGA enabled on the
> > Aspeed device.
> > +In this case, the host has access to a 64KiB window into all of the
> > BMC's
> > +memory.  The BMC can disable this bridge.  If the bridge is enabled,
> > the host
> > +has read access to all the regions of memory, however the host only
> > has read
> > +and write access depending on a register controlled by the BMC.
> > +
> > +Required properties:
> > +===================
> > +
> > + - compatible: must be one of:
> > +     - "aspeed,ast2400-p2a-ctrl"
> > +     - "aspeed,ast2500-p2a-ctrl"
> > +
> > + - syscon: handle to syscon device node controlling PCI.
>
> The p2a-ctrl node is meant to be a child of the syscon. I noted this in my review
> of the associated driver - you need to remove the description of the syscon
> property.

Roger that, I'll take a hack at cleaning this up later this week (I'm OOO).

>
> > +
> > +Optional properties:
> > +===================
> > +
> > +- memory-region: A phandle to a reserved_memory region to be used for
> > the PCI
> > +             to AHB mapping
> > +
> > +The p2a-control node should be the child of a syscon node with the
> > required
> > +property:
> > +
> > +- compatible : Should be one of the following:
> > +             "aspeed,ast2400-scu", "syscon", "simple-mfd"
> > +             "aspeed,g4-scu", "syscon", "simple-mfd"
> > +             "aspeed,ast2500-scu", "syscon", "simple-mfd"
> > +             "aspeed,g5-scu", "syscon", "simple-mfd"
>
> The note above should go where you've described the syscon property above.
>
> Cheers,
>
> Andrew
>
> > +
> > +Example:
> > +
> > +g4 Example
> > +----------
> > +
> > +syscon: scu@1e6e2000 {
> > +     compatible = "aspeed,ast2400-scu", "syscon", "simple-mfd";
> > +     reg = <0x1e6e2000 0x1a8>;
> > +
> > +     p2a: p2a-control {
> > +             compatible = "aspeed,ast2400-p2a-ctrl";
> > +             memory-region = <&reserved_memory>;
> > +     };
> > +};
> > --
> > 2.21.0.392.gf8f6787159e-goog
> >
> >
