Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D673C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A22420823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 17:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551720949;
	bh=38tLZkWZIXN2FoXVwkQVv8/snPeJ9vD5u5f5EA6yjNw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=plYv+7pjMlnrx5bRyHGTqa8JqeUDhBBrWait6i9FYGQ5bDY7ImtwyEQyL/QnXX3sQ
	 OMb7069FiYyvGSFR2rNKK10LfaYB89fDXmQgGSNQSrQx87pTGx8CWVIg7m/ogtESwH
	 xLPKVPPd7q8X3R8B2Xrgq2o0JtP42FwFmF/9hsmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfCDRfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 12:35:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:53006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbfCDRfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 12:35:47 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62D7720835;
        Mon,  4 Mar 2019 17:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551720945;
        bh=38tLZkWZIXN2FoXVwkQVv8/snPeJ9vD5u5f5EA6yjNw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jVsTZaEoBwuO1+CvyPn6PWI5oKSuG7uuf1lvUMLrQCIDToKl3oiNzWPpJIxEjRIFL
         oreyMWiIzNSg7Ve4L3w+iNKYkJMlP6JNB/bynS1UFItiG2nxWCu/gepAoT77duBW19
         pim8+fmyW6E/6M/kzePYBzH0/PFr8w2N+SHfh9YM=
Received: by mail-qk1-f174.google.com with SMTP id z13so3237173qki.2;
        Mon, 04 Mar 2019 09:35:45 -0800 (PST)
X-Gm-Message-State: APjAAAWjWNQDAZgU3kWuyjheZRGgzOcfeOXjbOF1XQio+/PYWiCngDDt
        zJotLuNsQb+6vStgoQATH2aaSGexfSrT6nmnbg==
X-Google-Smtp-Source: APXvYqxOmV4QBHGwKG/YTrrvxP+9+Ki2yadJOLLpV6xXzpK4PcFEEand02OEeC3gP73/OTRT2VgkVdCm6zGxRRnJ3K0=
X-Received: by 2002:a37:a381:: with SMTP id m123mr14534890qke.147.1551720944588;
 Mon, 04 Mar 2019 09:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20190120172534.24617-1-lkundrak@v3.sk> <20190120172534.24617-5-lkundrak@v3.sk>
 <CAL_JsqLT7jEdwi7o7RR_3OcbMTxeNXmSzif8Ez2psjhu24No5Q@mail.gmail.com>
 <b92426e9f5c50c71fa89ea5b53396c1885cc396f.camel@v3.sk> <CAL_JsqJsfwC4fAJaVEvKwtZkZwapu5jojEFn6Ddx34a6jZ_dSQ@mail.gmail.com>
 <4e89406842c4821d590dc6518076cfe6f19cc6b9.camel@v3.sk>
In-Reply-To: <4e89406842c4821d590dc6518076cfe6f19cc6b9.camel@v3.sk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 4 Mar 2019 11:35:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ8rovEM4RtkJKwTeDrRotVr59EmU-_1ApR+c9yxB8k2Q@mail.gmail.com>
Message-ID: <CAL_JsqJ8rovEM4RtkJKwTeDrRotVr59EmU-_1ApR+c9yxB8k2Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] dt-bindings: display: armada: Add display subsystem binding
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 10:15 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> On Fri, 2019-02-22 at 14:23 -0600, Rob Herring wrote:
> > On Wed, Feb 13, 2019 at 4:37 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > > On Mon, 2019-01-21 at 09:35 -0600, Rob Herring wrote:
> > > > On Sun, Jan 20, 2019 at 11:26 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
> > > > > The Marvell Armada DRM master device is a virtual device needed to list all
> > > > > nodes that comprise the graphics subsystem.
> > > > >
> > > > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > > > ---
> > > > >  .../display/armada/marvell-armada-drm.txt     | 24 +++++++++++++++++++
> > > > >  1 file changed, 24 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt b/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> > > > > index de4cca9432c8..3dbfa8047f0b 100644
> > > > > --- a/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> > > > > +++ b/Documentation/devicetree/bindings/display/armada/marvell-armada-drm.txt
> > > > > @@ -1,3 +1,27 @@
> > > > > +Marvell Armada DRM master device
> > > > > +================================
> > > > > +
> > > > > +The Marvell Armada DRM master device is a virtual device needed to list all
> > > > > +nodes that comprise the graphics subsystem.
> > > > > +
> > > > > +Required properties:
> > > > > +
> > > > > + - compatible: value should be "marvell,dove-display-subsystem",
> > > > > +   "marvell,armada-display-subsystem"
> > > > > + - ports: a list of phandles pointing to display interface ports of CRTC
> > > > > +   devices
> > > > > + - memory-region: phandle to a node describing memory to be used for the
> > > > > +   framebuffer
> > > > > +
> > > > > +Example:
> > > > > +
> > > > > +       display-subsystem {
> > > > > +               compatible = "marvell,dove-display-subsystem",
> > > > > +                            "marvell,armada-display-subsystem";
> > > > > +               memory-region = <&display_reserved>;
> > > > > +               ports = <&lcd0_port>;
> > > >
> > > > If there is only one device, you don't need this virtual node.
> > >
> > > Before I follow up on this and submit a version without the virtual
> > > node, I'm wondering: is it okay that the bindings for the LCDC and the
> > > framebuffer are in the same file, or would it be preferrable if they
> > > were separate? Both styles seem to be used for the display bindings.
> >
> > framebuffer as in the kernel fbdev? Really, that should be the same
> > binding. It's the same h/w after all. However, there have been cases
> > where things deviated. So I don't have a good answer.
>
> No, not the fbdev device, that one is managed by drmfb and is not
> expressed in DT. I meant the reserved-memory node that sets aside
> memory for the framebuffers.
>
> See patch "[RFC 03/16] dt-bindings: display: armada: Add framebuffer
> reserved-mem binding". Perhaps that part should even go to
> Documentation/devicetree/bindings/reserved-memory/.

Okay.

A separate file will be better and probably
Documentation/devicetree/bindings/reserved-memory/ is the best
location.

Rob
