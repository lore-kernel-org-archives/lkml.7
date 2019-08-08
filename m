Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE78C32751
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F0A21873
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 03:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uXn5OuCI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfHHD0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 23:26:17 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33384 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfHHD0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 23:26:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id i11so25208106edq.0;
        Wed, 07 Aug 2019 20:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=dFm+ntDkDYjpFiyYx8bMq6XtAhzvccojbCi+hTQfSAU=;
        b=uXn5OuCIIHbX2C7G1bWWk4/YqWY9dH1yHAg+qSjrzNaGXt84cvn1eLurDBohQyqgKx
         rRPX0sgRZACz7ksvHIZ0gdthaFudRWV7mClCkruVYWRgvisv+uwvmxNBPTO3CTHwaN4A
         E1+BX7yaEQ/32Heu4OkiJSDTuWMN55CENjAyn54YBjDzSjBP7GqGeWmMDWokBGGZ1h7t
         scBV+RnBTVYXIrVfMNd+SryRkRsjJ8PckHWiXQwA7/Ia+HEvDFvgcvvnSBFk0mIpbslk
         KVfVCRPioBZmQdMK4sg3uwOLOIM/Yryq7T536RAlIEg8nBtK02+LjLjFWOnm2BJWMPC1
         RBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=dFm+ntDkDYjpFiyYx8bMq6XtAhzvccojbCi+hTQfSAU=;
        b=d5RFXHL61h0z8PkO+fDQ+CZw2fA3JwZgAuD+jS85+8Dyov2+iCMmhudIB1eS7yYfdM
         SvKfvHK2sF/EqVabP1dR5KnZ8azIFUqkniJ3MseuIvFgIm8Yop3XH/bspd7OL1VTpmtp
         Il+bHDwNhId4LTtFnnlwXZCMHrAYbXe15y/vwwOplya4wZL0xPDcBzIDbqAg9Y22Rl05
         x/RproFlyMNWZ8Z4OjqsT4wq8Sq447jzW25kpPbIjGY/bUY5T7tRq/3Wj0jVLVbE9FoO
         GyBGBSI+BJvy+BgmcYkHbAKdCQSNYhSIREOEgJPWZWiyKu1cm+ua4xtd4GOUZGzwyBWL
         UnQA==
X-Gm-Message-State: APjAAAV/pLSi0FlNkTx0fbMojJO60QcRmWGKTOnncdfY7jZ4Z1+v73Ph
        IS0va2fNfn8vdfmFrnveJGcJbHBJF1FEim/Obw8=
X-Google-Smtp-Source: APXvYqwpSQ+XSI5DFDUtaGHNy0t0Mr97a8+cHVbmNIqfu6PXkhplyNXNb9dpwBBpIepkNcjpxfzv7yHjQTqfgfITjpE=
X-Received: by 2002:aa7:d6d3:: with SMTP id x19mr13246758edr.119.1565234775342;
 Wed, 07 Aug 2019 20:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <1564306219-17439-1-git-send-email-bmeng.cn@gmail.com>
 <1564306219-17439-2-git-send-email-bmeng.cn@gmail.com> <CAEUhbmVjELVPKwW6R+W+V2hQbZ_Zj_5j2ogjnTsuCwnK1pT-og@mail.gmail.com>
In-Reply-To: <CAEUhbmVjELVPKwW6R+W+V2hQbZ_Zj_5j2ogjnTsuCwnK1pT-og@mail.gmail.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 8 Aug 2019 11:26:03 +0800
Message-ID: <CAEUhbmXHzK0Ho27nn+zMAxZfMQxcuN2Pe8fb6_uOEi7RVbJ=_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: pci: pci-msi: Correct the unit-address
 of the pci node name
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 5:53 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Sun, Jul 28, 2019 at 5:30 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > The unit-address must match the first address specified in the
> > reg property of the node.
> >
> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > ---
> >
> >  Documentation/devicetree/bindings/pci/pci-msi.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/pci-msi.txt b/Documentation/devicetree/bindings/pci/pci-msi.txt
> > index 9b3cc81..b73d839 100644
> > --- a/Documentation/devicetree/bindings/pci/pci-msi.txt
> > +++ b/Documentation/devicetree/bindings/pci/pci-msi.txt
> > @@ -201,7 +201,7 @@ Example (5)
> >                 #msi-cells = <1>;
> >         };
> >
> > -       pci: pci@c {
> > +       pci: pci@f {
> >                 reg = <0xf 0x1>;
> >                 compatible = "vendor,pcie-root-complex";
> >                 device_type = "pci";
> > --
>
> Ping?

Ping?
