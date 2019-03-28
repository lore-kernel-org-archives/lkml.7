Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33322C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0335A20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Srj0h6GV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfC1QGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:06:21 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44756 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfC1QGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:06:19 -0400
Received: by mail-oi1-f195.google.com with SMTP id i21so16177855oib.11;
        Thu, 28 Mar 2019 09:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J2YnF4j3XKMHvgYMrtOtaTfN5SnS3wNUPDSLACqrJC8=;
        b=Srj0h6GVrZLToj12j8htEi2KLXrdj2pQhRHLDPOoF0TJUkA5ilRx3W3E4CK58n+soJ
         Hsz4gQ1LIWwjEvZWRqbIhY8anPAKX7aOF6BGYSdPpYgGsuOsjrkZHfYfDiatPFuf3Fv1
         pBLg7auZG3c9UNxF9FZC/ahPFPiiLbeTMg7H7VjoH1k2id43NDG04PM9eHdOGmwy8p9h
         Ya6UBP6XtwbLLhA9PHlyMo+ztRb2xoGbnOpeF9tHJ2TKZzMIfesMPU6MJre6Hc81v0UN
         wtD5z/EUXOuHSfbtbYNQxGx4+JckDKuB6XXWM3wygaxA8Xqk/XyYwygUUQrriggYb2gl
         Yfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J2YnF4j3XKMHvgYMrtOtaTfN5SnS3wNUPDSLACqrJC8=;
        b=f8tqRdAvF42TcZ9crvuumLOlf8PemVVV4WwYeKW+IpCymxraXNwffiYmN/wdShgvJU
         +zK97nMSGQqVVyZTm5chw6E7IcDT1+tDQc5Lw2MclfyVIkM4TNuLxxeuyzFyxQcxJ55z
         5DgdKuUuIPs+ZmnPILfMifvFKBNObOwWAiL+aMwz6qIEvuCtiTZfFYnYjEGQnknwylmR
         HI9Vu+s/jCv5tfgq9b0+HBJu4KOb2ivng9hCU/onIIjJRokZpfhppU4MbICH2r41iljW
         pYQ3Yw+zx/0vD2chDBzUf9wThD22J5rWt/lAQM80B1H8SYYmRPxxK4Cz6BTRMCyWm5gp
         9a9Q==
X-Gm-Message-State: APjAAAU0JoiYqngwvO4Z2en6rffZB/t3dghu4+gek8eA2ceLL3elktaf
        t1ILq+VXeUVqG1eu2btz5byV1COYyYevKTgP20s=
X-Google-Smtp-Source: APXvYqycU1o1ldnqB15PgpXFB9zdTWPJNGcTklAAHTLIu/9LPEUTaUsKN3pjLs35oM3l4Cg894pzUPc8R2UsiORNqm4=
X-Received: by 2002:aca:d4d8:: with SMTP id l207mr531154oig.29.1553789177972;
 Thu, 28 Mar 2019 09:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190314132210.654-1-sergio.paracuellos@gmail.com>
 <20190314132210.654-3-sergio.paracuellos@gmail.com> <20190328154238.GA20934@bogus>
In-Reply-To: <20190328154238.GA20934@bogus>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 28 Mar 2019 17:06:05 +0100
Message-ID: <CAMhs-H8akrBVWf5G2unAYmEAv852jvGdieZVk=o59LWW8FnxSw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: phy: Add binding for Mediatek MT7621
 PCIe PHY
To:     Rob Herring <robh@kernel.org>
Cc:     kishon@ti.com, linux-kernel <linux-kernel@vger.kernel.org>,
        driverdev-devel@linuxdriverproject.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, John Crispin <john@phrozen.org>,
        linux-mips@vger.kernel.org, NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the review.

On Thu, Mar 28, 2019 at 4:42 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Mar 14, 2019 at 02:22:10PM +0100, Sergio Paracuellos wrote:
> > Add bindings to describe Mediatek MT7621 PCIe PHY.
>
> Binding should come before the driver.

Do you mean this should be PATCH 1 of the series?

>
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  .../bindings/phy/mediatek,mt7621-pci-phy.txt  | 54 +++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.txt
> >
> > diff --git a/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.txt b/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.txt
> > new file mode 100644
> > index 000000000000..8addedbe815e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.txt
> > @@ -0,0 +1,54 @@
> > +Mediatek Mt7621 PCIe PHY
> > +
> > +Required properties:
> > +- compatible: must be "mediatek,mt7621-pci-phy"
> > +- reg: base address and length of the PCIe PHY block
> > +- #address-cells: must be 1
> > +- #size-cells: must be 0
> > +
> > +Each PCIe PHY should be represented by a child node
> > +
> > +Required properties For the child node:
> > +- reg: the PHY ID
> > +0 - PCIe RC 0
> > +1 - PCIe RC 1
> > +- #phy-cells: must be 0
> > +
> > +Example:
> > +     pcie0_phy: pcie-phy@1e149000 {
> > +             compatible = "mediatek,mt7621-pci-phy";
> > +             reg = <0x1e149000 0x0700>;
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +
> > +             pcie0_port: pcie-phy@0 {
> > +                     reg = <0>;
> > +                     #phy-cells = <0>;
> > +             };
> > +
> > +             pcie1_port: pcie-phy@1 {
> > +                     reg = <1>;
> > +                     #phy-cells = <0>;
> > +             };
>
> If each phy port doesn't have its own resources, then you don't need
> child nodes. Just set #phy-cells to 1.

I see. I will change those two into:

pcie0_phy: pcie-phy@1e149000 {
     compatible = "mediatek,mt7621-pci-phy";
     reg = <0x1e149000 0x0700>;
     #phy-cells = <1>;
};

pcie1_phy: pcie-phy@1e14a000 {
     compatible = "mediatek,mt7621-pci-phy";
     reg = <0x1e14a000 0x0700>;
     #phy-cells = <0>;
};

>
> > +     };
> > +
> > +     pcie1_phy: pcie-phy@1e14a000 {
> > +             compatible = "mediatek,mt7621-pci-phy";
> > +             reg = <0x1e14a000 0x0700>;
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +
> > +             pcie2_port: pcie-phy@0 {
> > +                     reg = <0>;
> > +                     #phy-cells = <0>;
> > +             };
> > +     };
> > +
> > +     /* users of the PCIe phy */
> > +
> > +     pcie: pcie@1e140000 {
> > +             ...
> > +             ...
> > +             phys = <&pcie0_port>, <&pcie1_port>, <&pcie2_port>;
> > +             phy-names = "pcie-phy0", "pcie-phy1", "pcie-phy2";
> > +     };

I think changing the previous one as you suggested make clients to do now:

pcie: pcie@1e140000 {
      phys = <&pcie0_phy 0>, <&pcie0_phy 1>, <&pcie1_phy>;
      phy-names = "pcie-phy0", "pcie-phy1", "pcie-phy2";
};

Am I right?

I have to figure out how to change the driver to achieve this changes
also to properly get the phy.

Thanks, I will make the changes in staging to be tested by Neil a send
v2 PATCHEs for this with your suggested changes.

Best regards and thanks again for your time.

Sergio Paracuellos
