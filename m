Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378A4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0E02087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VGaY5fJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfCLDyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:54:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56181 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfCLDyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:54:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so1083779wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 20:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uNqG33lDmG2ipNglkTGftnysXD5/Q1zR9XWc/GcmZ+0=;
        b=VGaY5fJUsusDtdd+ZFgpXiDcv3npszM02UNNcOPeMityn7wwltSM+7usq26qnK/hhV
         O6UDuHDd5XY0ArNhgHPGxcmfPfHbn8SdUYvT3bkZzMRbMSVYSVfL12piiDzDzuj8Z3mV
         nE8PGSywIKNjQHxc9DOraGpP1fXgVFggqgUHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uNqG33lDmG2ipNglkTGftnysXD5/Q1zR9XWc/GcmZ+0=;
        b=JNrT6VBY+Vu4FHdreIL3yO4uhcWAdEqyI84kQctnYYTRGCYQfW6zkkvs+ZDL2XqPrl
         jRIuuWAwOJx9rGOu3u8Ggasq88UE0LaOjfP9ehJkFZoMCLlkgLBpWOsQ+pgG3ZBtu+Uy
         JVqGOViLIzNg5s3R/Z1J+736j1uD5xJhlgeKjE67kdzXOTC/uT2KSN1eEIujkKwvFVXl
         jzzLZ6SssS3YjO6xrJ+/G9AbtN8D3u6kSv2iww+sPDgNwYUV4NjuAsUC1cAK10gSV2qh
         V0YVgWWRYTlBi1w5fE8yi0Kh+VHxIENDBdefRnxG4pUNZdgp6FDUqp0juyim9VFE3iUN
         UiUQ==
X-Gm-Message-State: APjAAAVSzMI/9ZR/QuMCoHiwD5BTTkpf3fhuNFh2r/MuKXXDcjRxSXWB
        IpgjeSM9iHtQxPT+ZhEL1uK196PL7afFMilm6z59cg==
X-Google-Smtp-Source: APXvYqygtlU/EpIpJAdAByL7kVy5MuR5nPDusn+oO+hmijHvlbcKDxLE+sOPQ9c3KVaFh5QOUzyylzwIAMMLyyb7Ucg=
X-Received: by 2002:a1c:2d4c:: with SMTP id t73mr777213wmt.142.1552362854343;
 Mon, 11 Mar 2019 20:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <1550658842-19167-1-git-send-email-srinath.mannam@broadcom.com>
 <1550658842-19167-2-git-send-email-srinath.mannam@broadcom.com>
 <20190222172042.GA6792@bogus> <CABe79T5SqQJhF0GY06-+-aSCV-ya-RODEeV0DLg0Poupjeq+fA@mail.gmail.com>
 <CAL_JsqKyYoc3wLWGhbBdQxn=1NLhGbxfB2sUZUXm13_YTEyTGw@mail.gmail.com>
 <CABe79T7LQFf9J67P=eo0sAn6oJ10ovciR4o3_Z_K=6NLjtyr3A@mail.gmail.com> <CAL_JsqLnuERhPXFuLcBpUMn-g4=nQU5T6fNed6jxF1kY5WBzRw@mail.gmail.com>
In-Reply-To: <CAL_JsqLnuERhPXFuLcBpUMn-g4=nQU5T6fNed6jxF1kY5WBzRw@mail.gmail.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Tue, 12 Mar 2019 09:24:02 +0530
Message-ID: <CABe79T7vV9eMLDDSaow29SVq-MmLkCkOd3ht5Yqv2m_G2yperg@mail.gmail.com>
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

Thank you, I will send next patch set with the changes as you suggested.

Regards,
Srinath.
On Tue, Mar 12, 2019 at 3:00 AM Rob Herring <robh@kernel.org> wrote:
>
> On Sun, Mar 10, 2019 at 10:32 PM Srinath Mannam
> <srinath.mannam@broadcom.com> wrote:
> >
> > Hi Rob,
> >
> > Please find my comments below,
> >
> > On Sat, Feb 23, 2019 at 1:05 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Feb 22, 2019 at 11:29 AM Srinath Mannam
> > > <srinath.mannam@broadcom.com> wrote:
> > > >
> > > > Hi Rob,
> > > >
> > > > Thanks for the review, Please find my comments below in line.
> > > >
> > > > On Fri, Feb 22, 2019 at 10:50 PM Rob Herring <robh@kernel.org> wrote:
> > > > >
> > > > > On Wed, Feb 20, 2019 at 04:04:00PM +0530, Srinath Mannam wrote:
> > > > > > Add DT binding document for Stingray USB PHY.
> > > > > >
> > > > > > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > > > > > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> > > > > > Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> > > > > > ---
> > > > > >  .../bindings/phy/brcm,stingray-usb-phy.txt         | 62 ++++++++++++++++++++++
> > > > > >  1 file changed, 62 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> > > > > > new file mode 100644
> > > > > > index 0000000..da19236
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> > > > > > @@ -0,0 +1,62 @@
> > > > > > +Broadcom Stingray USB PHY
> > > > > > +
> > > > > > +Required properties:
> > > > > > + - compatible : should be one of the listed compatibles
> > > > > > +     - "brcm,sr-usb-combo-phy" is a combo PHY has one SS PHY and one HS PHY.
> > > > > > +     - "brcm,sr-usb-hs-phy" has a single HS PHY.
> > > > > > + - reg: offset and length of the PHY blocks registers
> > > > > > + - address-cells: should be 1
> > > > > > + - size-cells: should be 0
> > > > > > +
> > > > > > +Sub-nodes:
> > > > > > +  brcm,sr-usb-combo-phy have two sub-nodes for one SS PHY and one HS PHY.
> > > > > > +
> > > > > > +Sub-nodes required properties:
> > > > > > + - reg: required for brcm,sr-usb-phy model PHY.
> > > > > > +     reg value 0 is HS PHY and 1 is SS PHY.
> > > > > > + - phy-cells: generic PHY binding; must be 0
> > > > > > +
> > > > > > +Refer to phy/phy-bindings.txt for the generic PHY binding properties
> > > > > > +
> > > > > > +Example:
> > > > > > +     usbphy0: usb-phy@0 {
> > > > > > +             compatible = "brcm,sr-usb-combo-phy";
> > > > > > +             reg = <0x00000000 0x100>;
> > > > > > +             #address-cells = <1>;
> > > > > > +             #size-cells = <0>;
> > > > > > +
> > > > > > +             usb0_phy0: phy@0 {
> > > > > > +                     reg = <0>;
> > > > > > +                     #phy-cells = <0>;
> > > > > > +             };
> > > > > > +
> > > > > > +             usb0_phy1: phy@1 {
> > > > > > +                     reg = <1>;
> > > > > > +                     #phy-cells = <0>;
> > > > > > +             };
> > > > >
> > > > > Again, you don't need child nodes here. There are not any per child
> > > > > resources. Clients can refer to <&usbphy0 1> just as easily as
> > > > > <&usb0_phy1>. This is why we have #phy-cells.
> > > > This phy controller is combo PHY it has one Super Speed USB PHY and
> > > > one High Speed USB PHY.
> > > > We required to create two PHY devices inside driver to initialize and
> > > > service(reset) both SS and HS PHYs separately.
> > > > That is the reason we used two child nodes.
> > >
> > > What you do in the driver is your business. That is independent of the
> > > binding. Go look at other phy drivers which use #phy-cells=1.
> > > .of_xlate() function is what converts the phy cells to a struct phy.
> > >
> > I have followed exactly same pattern available in open source.
> > ex: Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
> > In this also, two child nodes are used with #phy-cells 0.
>
> You'll notice DT maintainers did not review that binding (only changes
> to it). There's no shortage of DT examples of how not to do things.
>
> Rob
