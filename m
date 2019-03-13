Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144E2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7D02077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="stq7c43d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfCMUmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:42:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45859 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfCMUmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:42:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id v21so2182915pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 13:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+WPJi31K/m3PfqXYJ59XAhUKKyjaobifWPIkYqHLp8I=;
        b=stq7c43d39qaOnOJNTxEyo70bayp8mTqyfBSv/TgcWBq/xZgEP/4WCvXHwDQG7prV5
         De2xnCVBm5PCc7yny9SpJzZePV/H/ihBTK7ePhIq4tyXcekCF1IhNzKX0F5oSzlmCIDu
         /SwtQuNSBlwt3W8zz17JaxRTE7JkKsbmTxTAbq+t+fYzurwjlmbD1o9uuQxrT7zJJ6uE
         NfhLYZRfmxJmn8fA7u5U8C66a1FXLk/vIWmH+e8gfKhinqtmLr9EM8ReiMlmUjdDqeSr
         ZPgfbmUL9YUXKmCjL/HP3VtvFrTy0mP9/jNrY+0gnn50YIirofzbiBBlVczfyisaTSGq
         rAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+WPJi31K/m3PfqXYJ59XAhUKKyjaobifWPIkYqHLp8I=;
        b=ABDjema2myyb5EAskHOy38g2GbjOp4nkfp/8lsyr/ZBEzN1HV0Rhl7vWt/asExnC1b
         nq30dY2dvFgPUerqOHwNZQeMPeQBOZJXR/gs3TjxCEzVpkV9k9GYmfQG8ibjikhNCHkx
         D7tj5Lmtg+d2i+vug+8TeyH5sDTknwaPkGod5cR3h96PftJvB8NOj8dyUwxFY8u0mB7W
         SiVNOnii5gpAlecWpOmVX3fls7y8yNYaChTLXVmFCT9u6szyouqsKW69GXHycoOAcLoG
         G04JnrwCnwtFy91F6N9v+ydtwzBZJukMqpfsB0b4At0fxIbYhDE+WOfWVUR/8sr40gdi
         tuKw==
X-Gm-Message-State: APjAAAXIRXtFjrJGXzh52HY3OwqmcceGIlKjO85ZaEa3Xi2lH4Oivoeu
        lWWjSOWlbsKYy8SHMgLj90YrncTOxE+YKD4OThaYXg==
X-Google-Smtp-Source: APXvYqztBKPKUvx1Ju9Kuf4rQsop4OXyJgCdd+6tfRKwCrN8+ikLyOdx6+xedC+IwNr4jraxrTupP1xQhQoqMt1V9UA=
X-Received: by 2002:a62:8384:: with SMTP id h126mr45504977pfe.243.1552509727647;
 Wed, 13 Mar 2019 13:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190312163051.155405-1-venture@google.com> <CAL_JsqLRO8m+voL_6mSpcrGmAT-SPwXhXDSOMEgQW6wmmTxZfQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLRO8m+voL_6mSpcrGmAT-SPwXhXDSOMEgQW6wmmTxZfQ@mail.gmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Wed, 13 Mar 2019 13:41:56 -0700
Message-ID: <CAO=notz1Wrqaj4wWw5HmfMPpp6BMacMkr++WirLEHrphaesySA@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 12:54 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Mar 12, 2019 at 11:30 AM Patrick Venture <venture@google.com> wrote:
> >
> > Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> >
> > Signed-off-by: Patrick Venture <venture@google.com>
> > ---
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
> > diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > new file mode 100644
> > index 000000000000..088cc4e3dc54
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > @@ -0,0 +1,48 @@
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
> > +       - "aspeed,ast2400-p2a-ctrl"
> > +       - "aspeed,ast2500-p2a-ctrl"
> > +
> > + - syscon: handle to syscon device node controlling PCI.
> > +
> > +Optional properties:
> > +===================
> > +
> > +- memory-region: A phandle to a reserved_memory region to be used for the PCI
> > +               to AHB mapping
> > +
> > +The p2a-control node should be the child of a syscon node with the required
> > +property:
> > +
> > +- compatible : Should be one of the following:
> > +               "aspeed,ast2400-scu", "syscon", "simple-mfd"
> > +               "aspeed,g4-scu", "syscon", "simple-mfd"
> > +               "aspeed,ast2500-scu", "syscon", "simple-mfd"
> > +               "aspeed,g5-scu", "syscon", "simple-mfd"
> > +
> > +Example:
> > +
> > +g4 Example
> > +----------
> > +
> > +syscon: scu@1e6e2000 {
> > +       compatible = "aspeed,ast2400-scu", "syscon", "simple-mfd";
> > +       reg = <0x1e6e2000 0x1a8>;
> > +
> > +       p2a: p2a-control {
> > +               compatible = "aspeed,ast2400-p2a-ctrl";
>
> If there's a defined register range, then you could add a reg property
> (even though Linux doesn't use it).

in this case, the device just needs access to two separate registers
controlled by the syscon to which it is now a child.

>
> Either way,
>
> Reviewed-by: Rob Herring <robh@kernel.org>
