Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AA7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 03:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D195220657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 03:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ax602LMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfCKDcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 23:32:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37687 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfCKDcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 23:32:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id y15so1586029wro.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 20:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eprZ8cmXoh2OhO59jEglRlcZUCoRFQq0VHh61J/wlVk=;
        b=Ax602LMdRKf06MjSYF+aGj3/q7oXrsgOiu8Mm7Dq69CYfDhurckZY7BapXTc+ZzzJj
         MZX3qVPq1DLys/25gqnW3hkEfrM59o7BVU0PU7MKAvakJLzVIZUkbY41f/8keT2mO5YA
         OhWuQFZCbBuOznoTzXCKGWhA0/uf2LovS6bSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eprZ8cmXoh2OhO59jEglRlcZUCoRFQq0VHh61J/wlVk=;
        b=rW94HEhLlz2Kn1t9WyMJ9GbbPP8PvycXJpxbNFEgBa4dmDBZYLBb5hAjQZ1T1J5dK9
         QW1++fr2++qXoKO5980ft5L3bxFJ6JZA1qxnCFvgUW9KJIdvQM+XPRMqrT6XvFFRE93h
         fkKmKMHuECGOWliN7A2Y3HAHKHgD3gACPGDmqsNz5u8koRwsj5O9L9fe5yi1kmeEBYSz
         FW09x8PTd0jJM0SWcj8TA9rgWxb0ZOHZtf2+FpHIsArXs836glZI/VCbM8dW97ZITNa6
         D7FwkLr4oX7yeFzlxG0+q9ttrBPXRevSoyCK2iaN139GQnMcNXg3O/rlvTJ78phnYWkS
         yThQ==
X-Gm-Message-State: APjAAAX8vbM0i4Hpjt8onzYValJgVXm4gnRVOOn8gcykFcLQhFLr2UFa
        /ZYTRnnm1qkReBvQuKfKQeOXWJZZdZg9SRrDvy9v1g==
X-Google-Smtp-Source: APXvYqz/9R5ArHb2zL9mELHsbEiKNd+w17Du+LtSjwrRoOBcoFsc6vgj+qPCxmhihNluWgawbmZn6Lr1TMLJAXm2EBY=
X-Received: by 2002:adf:9ecc:: with SMTP id b12mr18848219wrf.83.1552275164821;
 Sun, 10 Mar 2019 20:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <1550658842-19167-1-git-send-email-srinath.mannam@broadcom.com>
 <1550658842-19167-2-git-send-email-srinath.mannam@broadcom.com>
 <20190222172042.GA6792@bogus> <CABe79T5SqQJhF0GY06-+-aSCV-ya-RODEeV0DLg0Poupjeq+fA@mail.gmail.com>
 <CAL_JsqKyYoc3wLWGhbBdQxn=1NLhGbxfB2sUZUXm13_YTEyTGw@mail.gmail.com>
In-Reply-To: <CAL_JsqKyYoc3wLWGhbBdQxn=1NLhGbxfB2sUZUXm13_YTEyTGw@mail.gmail.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Mon, 11 Mar 2019 09:02:33 +0530
Message-ID: <CABe79T7LQFf9J67P=eo0sAn6oJ10ovciR4o3_Z_K=6NLjtyr3A@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: phy: Add Stingray USB PHY binding document
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Please find my comments below,

On Sat, Feb 23, 2019 at 1:05 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Feb 22, 2019 at 11:29 AM Srinath Mannam
> <srinath.mannam@broadcom.com> wrote:
> >
> > Hi Rob,
> >
> > Thanks for the review, Please find my comments below in line.
> >
> > On Fri, Feb 22, 2019 at 10:50 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, Feb 20, 2019 at 04:04:00PM +0530, Srinath Mannam wrote:
> > > > Add DT binding document for Stingray USB PHY.
> > > >
> > > > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > > > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> > > > Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> > > > ---
> > > >  .../bindings/phy/brcm,stingray-usb-phy.txt         | 62 ++++++++++++++++++++++
> > > >  1 file changed, 62 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> > > > new file mode 100644
> > > > index 0000000..da19236
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> > > > @@ -0,0 +1,62 @@
> > > > +Broadcom Stingray USB PHY
> > > > +
> > > > +Required properties:
> > > > + - compatible : should be one of the listed compatibles
> > > > +     - "brcm,sr-usb-combo-phy" is a combo PHY has one SS PHY and one HS PHY.
> > > > +     - "brcm,sr-usb-hs-phy" has a single HS PHY.
> > > > + - reg: offset and length of the PHY blocks registers
> > > > + - address-cells: should be 1
> > > > + - size-cells: should be 0
> > > > +
> > > > +Sub-nodes:
> > > > +  brcm,sr-usb-combo-phy have two sub-nodes for one SS PHY and one HS PHY.
> > > > +
> > > > +Sub-nodes required properties:
> > > > + - reg: required for brcm,sr-usb-phy model PHY.
> > > > +     reg value 0 is HS PHY and 1 is SS PHY.
> > > > + - phy-cells: generic PHY binding; must be 0
> > > > +
> > > > +Refer to phy/phy-bindings.txt for the generic PHY binding properties
> > > > +
> > > > +Example:
> > > > +     usbphy0: usb-phy@0 {
> > > > +             compatible = "brcm,sr-usb-combo-phy";
> > > > +             reg = <0x00000000 0x100>;
> > > > +             #address-cells = <1>;
> > > > +             #size-cells = <0>;
> > > > +
> > > > +             usb0_phy0: phy@0 {
> > > > +                     reg = <0>;
> > > > +                     #phy-cells = <0>;
> > > > +             };
> > > > +
> > > > +             usb0_phy1: phy@1 {
> > > > +                     reg = <1>;
> > > > +                     #phy-cells = <0>;
> > > > +             };
> > >
> > > Again, you don't need child nodes here. There are not any per child
> > > resources. Clients can refer to <&usbphy0 1> just as easily as
> > > <&usb0_phy1>. This is why we have #phy-cells.
> > This phy controller is combo PHY it has one Super Speed USB PHY and
> > one High Speed USB PHY.
> > We required to create two PHY devices inside driver to initialize and
> > service(reset) both SS and HS PHYs separately.
> > That is the reason we used two child nodes.
>
> What you do in the driver is your business. That is independent of the
> binding. Go look at other phy drivers which use #phy-cells=1.
> .of_xlate() function is what converts the phy cells to a struct phy.
>
I have followed exactly same pattern available in open source.
ex: Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
In this also, two child nodes are used with #phy-cells 0.
> Rob
