Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9CAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C00214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="awlW8KfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfCKXtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:49:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38664 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfCKXtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 19:49:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id m2so337324pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 16:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/IShALrVP0C9IZ3MTHfATnHvnABqWW9N4LOVGePwP2c=;
        b=awlW8KfSsYnl+36t5qKYG9ETxyoUxtnbBbUGpU2Q84E+glRERH4Z+u7TGkqaiBx0Em
         /od9zGo2Sc0CgcKzovyQKgCJ3QzPV2uIk+m6Wsn+MD6Dx8+gZfMM4aExoWI/Q/l0WbBH
         UBGtcK8p96ukA3O/tWDolvN+QQFZMoZahlcQvg+wVfHbP4vjb11NN7mTSWmjvp61Qdug
         10BGbNKi5wfbKuJuyaQUqNtYjDDgZEdQiQkKSyfZQCgWIDMrtfhVBeLm77YLmNvXl+UQ
         USa7Gxpnw6cAgNRltnAlnMOn8Hjk8udpQ7K/7L6ynytvSepxLnU8EvatpAZbREQF75hC
         fVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/IShALrVP0C9IZ3MTHfATnHvnABqWW9N4LOVGePwP2c=;
        b=Kk/ySAlBEzUs2RLv3llPkaIROQOgIc7mpJaQRqDJY28LtZWPnDxRY6QCnGfe+x6uKi
         fhf33EE303kRhkhZffKjon/QKvW3QHauS1Dp9jTPNx39gUDmS46W4Y0Kob8UlSybuioA
         qR3ratZWIWyM42BjP7lEMCzFjBuPrm4EBsOdXdVfPvwM6KU12A0JcRkoU+pPYbq9y8z8
         hTvQjq6d8m+6BrCzlbly5NtxNVOA8kxvH6ccfB4uMcW87XzEEmMlc7r1KKeZ1A3I4MYX
         ohXLRoU5coNMtp4qygICuh9PCv7m06bTApQrtFXvbi1abSy3xoLoMvo7VNGOuo4qDsTZ
         bWSA==
X-Gm-Message-State: APjAAAVCk4ZcNL6AnZt8S98gfsharVO/9DBvEI7KDTxVUD2VaEztAzuH
        2uT3TLTv57HhndGlQF+umLZpqot6/kML9m3S/TT//Q==
X-Google-Smtp-Source: APXvYqziAWi7nctQ9c5SMl6dWDD1VWB97HxF6HZD/VrrOLP6/pYqEZ3ZLAlPtqgY6or4O8Bgk5VEjra80Z3dvvu0Xcs=
X-Received: by 2002:a17:902:aa88:: with SMTP id d8mr36748824plr.61.1552348154085;
 Mon, 11 Mar 2019 16:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190304185536.211084-1-venture@google.com> <20190311222007.GA16254@bogus>
In-Reply-To: <20190311222007.GA16254@bogus>
From:   Patrick Venture <venture@google.com>
Date:   Mon, 11 Mar 2019 16:49:00 -0700
Message-ID: <CAO=notzjsdOxJSf+p+OqB71N5-c1QPCcfd9OVAV8ft18e+SngQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
To:     Rob Herring <robh@kernel.org>
Cc:     mark.rutland@arm.com, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg KH <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 3:20 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Mar 04, 2019 at 10:55:36AM -0800, Patrick Venture wrote:
> > Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> >
> > Signed-off-by: Patrick Venture <venture@google.com>
> > ---
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
> >  .../bindings/misc/aspeed-p2a-ctrl.txt         | 32 +++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> >
> > diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > new file mode 100644
> > index 000000000000..1092d62d1c92
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > @@ -0,0 +1,32 @@
> > +======================================================================
> > +Device tree bindings for Aspeed AST2400/AST2500 PCI-to-AHB Bridge Control Driver
> > +======================================================================
> > +
> > +The bridge is available on platforms with the VGA enabled on the Aspeed device.
> > +In this case, the host has access to a 64KiB window into all of the BMC's
> > +memory.  The BMC can disable this bridge.  If the bridge is enabled, the host
> > +has read access to all the regions of memory, however the host only has read
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
> > +
> > +Optional properties:
> > +===================
> > +
> > +- memory-region: A phandle to a reserved_memory region to be used for the PCI
> > +             to AHB mapping
> > +
> > +Example:
> > +
> > +p2a: p2a-control@1e6e2000 {
> > +     compatible = "aspeed,ast2400-p2a-ctrl";
> > +     memory-region = <&reserved_memory>;
> > +     syscon = <&syscon>;
>
> Make this node a child of what you are pointing to instead if this the
> only control interface.

You're suggesting I make this a child of the syscon?

>
> Rob
>
>
>
