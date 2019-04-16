Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A164AC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633CA20693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SAKNrZAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfDPO1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:27:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39315 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfDPO1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:27:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so10502085pfo.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 07:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IbW3fW3dtTiI4e2mL4N5yspBvoNIWpqUcEPzc9yVMMs=;
        b=SAKNrZAS4r5CTzxwXqAtj0J1pcFfow9Ux1ut81Z4wbTVmJ09iggBPkxknYzHAALqdW
         Yn1z3IOdg3a/0QS86WnOTObQLtlPH+O34JzQpWis3PgycXJAljXLQ+smlf7YTVTe3Qi1
         cjrD3Of/y8kCEARVcIICqasDTER/YF/jBGBXFF+KBE/0EmS3WReLk4rmXCrOGxIW4qTE
         ezLmUDRBij9huULXYlEbm+2pdYP0d3alWMaB5LK7fXhqa8+gA4+NKoCppMe4bKhNTDZz
         x33E4iWyMZ6MOiafyfJazXB/N8G3QblxaVHhgr90utbDGEXv4uEYMItE22ysEiU8V/8V
         CLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IbW3fW3dtTiI4e2mL4N5yspBvoNIWpqUcEPzc9yVMMs=;
        b=H2jdItIFszCJyT2FehNJH0VWVAM9reAX0NUFEAkvlRszjq0gzk0zZiQLFQVK4HuL6F
         aiT8AFicBDhMkZc+MlTbo3kXl9+fSP4lmRCCyFeohvij7XlwB+dskP32GeRttV0eTuM/
         IsTRVOvgSZAth1tkq95dUE9cw79BBuB7lvaucHktd2zHG6TlrHD0L0SDXyeuzrvoADZd
         dhibVq769wwDd8CRpz7c2/217/bDQrsv24td29agfbPyEyPjndnNiO3mT0jNjDPzqdhB
         eTLbw4jPEw+k3mVtf+sl6f+s85H9QUGhNgWWu+VThk3IvsuhiXNx37q7fgp7V1PQA8Nc
         qK9w==
X-Gm-Message-State: APjAAAWMNnBA/BJpXP6XAPAIZB9UzwB/F7REXRH+SYEZRLaUiOHHTf6g
        JlrA0WjRk1iI7FPa+n8mTxYmK0OWct+DMAR2JTxyzA==
X-Google-Smtp-Source: APXvYqwsR2LF2lPPNKB1bF5LsVJ5erulZSHTlwrKQn9m9P9+nkN0SdbbvNBGXz164/9dAyXWp0lHSwqDTEGcl5J9dAI=
X-Received: by 2002:a65:4048:: with SMTP id h8mr65774740pgp.6.1555424865564;
 Tue, 16 Apr 2019 07:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190408144216.160082-1-venture@google.com> <998d869d-de1d-4ac9-b4e6-8942945912dd@www.fastmail.com>
In-Reply-To: <998d869d-de1d-4ac9-b4e6-8942945912dd@www.fastmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Tue, 16 Apr 2019 07:27:34 -0700
Message-ID: <CAO=notza3Tz55_dRoTpenY+yP=J=TmvpMoWE58VQG=nvQ_Rpow@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
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

On Mon, Apr 8, 2019 at 5:48 PM Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Tue, 9 Apr 2019, at 00:12, Patrick Venture wrote:
> > Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> >
> > Signed-off-by: Patrick Venture <venture@google.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
>
> > ---
> > Changes for v10:
> >  - Chopped out nearly identical information.
> > Changes for v9:
> >  - Added missing details about syscon parent
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
> >  .../bindings/misc/aspeed-p2a-ctrl.txt         | 47 +++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> >
> > diff --git a/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > new file mode 100644
> > index 0000000000000..854bd67ffec68
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> > @@ -0,0 +1,47 @@
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
> > +
> > +Example
> > +===================
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

I'm sorry, is there something more I need to do with the patch series?
 Sometimes I miss emails.

Thanks,
Patrick
