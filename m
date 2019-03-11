Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2482C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5082064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 21:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552339839;
	bh=ZN55pZtl4a4BzShPoF2ymQiDoDFSOYwCDjRwiPP9XBs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CVJsvKozBeiJHETqZb0VUn3KAYosS0M+9tMAXwvsTguJ51v6BrEDIkiZFqyIPrdLe
	 2CzBe42btln+kVmc6qPUpfeeWFwKgdhAC6wqH+tjKikrPOCuKwutjM1Nlphs0rQJKv
	 SLDzxHZOjWFribJHtZ3l23ufB9t5MAY0r9hD5AEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfCKVai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 17:30:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbfCKVah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 17:30:37 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D07412064A;
        Mon, 11 Mar 2019 21:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552339837;
        bh=ZN55pZtl4a4BzShPoF2ymQiDoDFSOYwCDjRwiPP9XBs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C8SkrrjL+IPPOlghfd0vMoeCZd61ZfXpFGdmadLaU9gfgl0UVgq3fl5fpIKDg0SJM
         UhNPb8At8Mv6buRX1KErVdFAdafC5/ZI+XRT2VPP95CmAFQDXdslg840gmq9VNi4et
         9+WCt0I4GIu6vUQ05bqMCmhQXQ04XDO8LWC30nmI=
Received: by mail-qt1-f171.google.com with SMTP id h39so324068qte.2;
        Mon, 11 Mar 2019 14:30:36 -0700 (PDT)
X-Gm-Message-State: APjAAAV8YvRuRVzhw+02ZxcMbfQ0IiEW0UZMeWitVe9YQK9EbJRR1wTC
        7mjeMX83S+9ww3RqDJaOmQZti+xffE6ykIOc6Q==
X-Google-Smtp-Source: APXvYqyasGu3lGDGCmLsisgGtF+oQgs0iwTpg/KSpGjUvioYZ0MmnOORe3EJYv00G7sLUTAsdstxjlTtONrEcebwGBo=
X-Received: by 2002:a0c:ecc5:: with SMTP id o5mr27934281qvq.106.1552339836104;
 Mon, 11 Mar 2019 14:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <1550658842-19167-1-git-send-email-srinath.mannam@broadcom.com>
 <1550658842-19167-2-git-send-email-srinath.mannam@broadcom.com>
 <20190222172042.GA6792@bogus> <CABe79T5SqQJhF0GY06-+-aSCV-ya-RODEeV0DLg0Poupjeq+fA@mail.gmail.com>
 <CAL_JsqKyYoc3wLWGhbBdQxn=1NLhGbxfB2sUZUXm13_YTEyTGw@mail.gmail.com> <CABe79T7LQFf9J67P=eo0sAn6oJ10ovciR4o3_Z_K=6NLjtyr3A@mail.gmail.com>
In-Reply-To: <CABe79T7LQFf9J67P=eo0sAn6oJ10ovciR4o3_Z_K=6NLjtyr3A@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 11 Mar 2019 16:30:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLnuERhPXFuLcBpUMn-g4=nQU5T6fNed6jxF1kY5WBzRw@mail.gmail.com>
Message-ID: <CAL_JsqLnuERhPXFuLcBpUMn-g4=nQU5T6fNed6jxF1kY5WBzRw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: phy: Add Stingray USB PHY binding document
To:     Srinath Mannam <srinath.mannam@broadcom.com>
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

On Sun, Mar 10, 2019 at 10:32 PM Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
>
> Hi Rob,
>
> Please find my comments below,
>
> On Sat, Feb 23, 2019 at 1:05 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Feb 22, 2019 at 11:29 AM Srinath Mannam
> > <srinath.mannam@broadcom.com> wrote:
> > >
> > > Hi Rob,
> > >
> > > Thanks for the review, Please find my comments below in line.
> > >
> > > On Fri, Feb 22, 2019 at 10:50 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Wed, Feb 20, 2019 at 04:04:00PM +0530, Srinath Mannam wrote:
> > > > > Add DT binding document for Stingray USB PHY.
> > > > >
> > > > > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > > > > Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> > > > > Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> > > > > ---
> > > > >  .../bindings/phy/brcm,stingray-usb-phy.txt         | 62 ++++++++++++++++++++++
> > > > >  1 file changed, 62 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> > > > > new file mode 100644
> > > > > index 0000000..da19236
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
> > > > > @@ -0,0 +1,62 @@
> > > > > +Broadcom Stingray USB PHY
> > > > > +
> > > > > +Required properties:
> > > > > + - compatible : should be one of the listed compatibles
> > > > > +     - "brcm,sr-usb-combo-phy" is a combo PHY has one SS PHY and one HS PHY.
> > > > > +     - "brcm,sr-usb-hs-phy" has a single HS PHY.
> > > > > + - reg: offset and length of the PHY blocks registers
> > > > > + - address-cells: should be 1
> > > > > + - size-cells: should be 0
> > > > > +
> > > > > +Sub-nodes:
> > > > > +  brcm,sr-usb-combo-phy have two sub-nodes for one SS PHY and one HS PHY.
> > > > > +
> > > > > +Sub-nodes required properties:
> > > > > + - reg: required for brcm,sr-usb-phy model PHY.
> > > > > +     reg value 0 is HS PHY and 1 is SS PHY.
> > > > > + - phy-cells: generic PHY binding; must be 0
> > > > > +
> > > > > +Refer to phy/phy-bindings.txt for the generic PHY binding properties
> > > > > +
> > > > > +Example:
> > > > > +     usbphy0: usb-phy@0 {
> > > > > +             compatible = "brcm,sr-usb-combo-phy";
> > > > > +             reg = <0x00000000 0x100>;
> > > > > +             #address-cells = <1>;
> > > > > +             #size-cells = <0>;
> > > > > +
> > > > > +             usb0_phy0: phy@0 {
> > > > > +                     reg = <0>;
> > > > > +                     #phy-cells = <0>;
> > > > > +             };
> > > > > +
> > > > > +             usb0_phy1: phy@1 {
> > > > > +                     reg = <1>;
> > > > > +                     #phy-cells = <0>;
> > > > > +             };
> > > >
> > > > Again, you don't need child nodes here. There are not any per child
> > > > resources. Clients can refer to <&usbphy0 1> just as easily as
> > > > <&usb0_phy1>. This is why we have #phy-cells.
> > > This phy controller is combo PHY it has one Super Speed USB PHY and
> > > one High Speed USB PHY.
> > > We required to create two PHY devices inside driver to initialize and
> > > service(reset) both SS and HS PHYs separately.
> > > That is the reason we used two child nodes.
> >
> > What you do in the driver is your business. That is independent of the
> > binding. Go look at other phy drivers which use #phy-cells=1.
> > .of_xlate() function is what converts the phy cells to a struct phy.
> >
> I have followed exactly same pattern available in open source.
> ex: Documentation/devicetree/bindings/phy/brcm-sata-phy.txt
> In this also, two child nodes are used with #phy-cells 0.

You'll notice DT maintainers did not review that binding (only changes
to it). There's no shortage of DT examples of how not to do things.

Rob
