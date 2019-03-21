Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C7DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187B2218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wfW1kFlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfCUKCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:02:15 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:42485 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbfCUKCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:02:15 -0400
Received: from aptenodytes (aaubervilliers-681-1-92-153.w90-88.abo.wanadoo.fr [90.88.33.153])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 25FE8200009;
        Thu, 21 Mar 2019 10:02:10 +0000 (UTC)
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CD5CC207AC; Sat, 21 Apr 2018 16:35:00 +0200 (CEST)
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
        by mail.bootlin.com (Postfix) with ESMTPS id 5CA9A20376;
        Sat, 21 Apr 2018 16:34:28 +0200 (CEST)
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllnx209.ext.ti.com (8.15.1/8.15.1) with ESMTP id w3LEYR5H006756;
        Sat, 21 Apr 2018 09:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ti.com;
        s=ti-com-17Q1; t=1524321267;
        bh=4ef32eIQfxLD+iUFF7RfwwrAUtGXZSnAXsDZG9dllVk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=wfW1kFlKv4IXwt6e95RwzCp5hm0Fl0LKnt6b1o32lJWKoPgAEWcFkP2ogr2OH4O9G
         4qN2CTAjDBn02TR06MyhoG0MiU3bXBMxUF4Fw2sV6DbIPFsoEtaunMlYhnpB6Y1Ite
         aHjK/dA88PhmR2vQkbIuaofgbMQSDmtQlV88Kuec=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w3LEYRu5005984;
        Sat, 21 Apr 2018 09:34:27 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Sat, 21
 Apr 2018 09:34:27 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Sat, 21 Apr 2018 09:34:27 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w3LEYQbW019061;
        Sat, 21 Apr 2018 09:34:27 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Paul Kocialkowski <contact@paulk.fr>
CC:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>
Message-ID: <20180421143426.GA10632@LTA0271908.dhcp.ti.com>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Kocialkowski <contact@paulk.fr>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>
References: <20180328215213.29538-1-contact@paulk.fr>
 <20180329092326.dayuccomq5zrywqo@flea>
 <1522324644.1746.19.camel@bootlin.com>
 <20180420142524.GB29011@uda0271908>
 <2db056d6f65ecbcdc4f31a37fe2e1b1ddfb93c87.camel@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <2db056d6f65ecbcdc4f31a37fe2e1b1ddfb93c87.camel@paulk.fr>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Subject: Re: [PATCH] usb: musb: Support gadget mode when the port is set to
 dual role
Date:   Thu, 21 Mar 2019 11:02:10 +0100
User-Agent: Evolution 3.32.0 
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20190321100210._OIfIxBa4RCCw0FIVukLAwYKLctJzy8Q20iPAnvieO0@z>

On Sat, Apr 21, 2018 at 12:59:23PM +0200, Paul Kocialkowski wrote:
> Hi,
>=20
> Le vendredi 20 avril 2018 =E0 09:25 -0500, Bin Liu a =E9crit :
> > On Thu, Mar 29, 2018 at 01:57:24PM +0200, Paul Kocialkowski wrote:
> > > Hi,
> > >=20
> > > On Thu, 2018-03-29 at 11:23 +0200, Maxime Ripard wrote:
> > > > On Wed, Mar 28, 2018 at 11:52:13PM +0200, Paul Kocialkowski wrote:
> > > > > This allows dual-role ports to be reported as having gadget mode
> > > > > by
> > > > > the
> > > > > musb_has_gadget helper. This is required to enable MUSB at all
> > > > > with
> > > > > MUSB
> > > > > glue layers that set the port mode to MUSB_PORT_MODE_DUAL_ROLE
> > > > > at
> > > > > init.
> > > > >=20
> > > > > Most notably, this allows calling musb_start when needed in the
> > > > > virtual
> > > > > MUSB root HUB, regardless of whether the current mode should be
> > > > > gadget
> > > > > or host.
> > > > >=20
> > > > > This fixes USB OTG on Allwinner devices that I could test it
> > > > > with,
> > > > > mainly A20 devices.
> > > > >=20
> > > > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > >=20
> > > > Surely there's more to it than that. The gadget mode of A20 boards
> > > > have been working in the past, including when compiling with mUSB
> > > > setup as dual role.
> > > >=20
> > > > Is this a regression since a particular commit? Or is there
> > > > another,
> > > > deeper issue overlooked in the commit log?
> > >=20
> > > The root of the issue here is that musb_start is not called at any
> > > point
> > > without this patch. My understanding of the flow is the following:
> > > when
> > > the PHY detects that there was a VBUS/ID change, it will notify its
> > > listeners (mainly the musb sunxi glue layer). This will then
> > > schedule
> > > the driver's work (sunxi_musb_work), which does nothing since the
> > > SUNXI_MUSB_FL_ENABLED bit was never set. This bit is only set after
> > > calling sunxi_musb_enable, which is called from
> > > musb_platform_enable,
> > > that originates from musb_start.
> > >=20
> > > Currently I see two places where musb_start is called:
> > > * musb_virthub
> > > * musb_gadget
> > >=20
> > > In the latter case, it is in turn called from udc_start, which
> > > should
> > > probably (correct me if I'm wrong) happen later in the call chain
> > > than
> > > ID/VBUS change notification time.
> >=20
> > I don't think it is correct that udc_start() is triggered by ID/VBUS
> > events, but I don't have an Allwinner platform to verify the callflow.
>=20
> Yes you're right, I didn't make myself very clear here. I didn't
> investigate the udc_start call path much since it was apparently not the
> culprit.
>=20
> > Have you tried to load with a gadget driver? When a gadget function is
> > bound to UDC, udc_start() is triggered, which in turn calls
> > musb_start().
>=20
> It does work under that scenario, although my used case here is using
> musb with DUAL_ROLE but no gadget driver loaded. That it, I want the
> musb_start call to originate from the virtual hub, not from the gadget
> side.
>=20
> > > In the former case, musb_start is called in the root controller hub
> > > control, when setting the USB_PORT_FEAT_POWER feature. This looks
> > > perfectly legit and IMO this is where it should be initially calling
> > > musb_start in the dual role case. The kernel is indeed setting the
> >=20
> > No actually. A dual-role port should be in b_idle state by default, so
> > logically all actions should go to the gadget path until the port
> > switches to host mode.
>=20
> It makes sense that the port should be in b_idle state by default, but
> here it fails to switch to host mode when the ID pin detects that it
> should. Or does b_idle state entail that a gadget must be loaded (per
> the USB spec), and thus nothing should (ever) happen until that happens?
>=20
> I find it really odd to need a gadget device to trigger host mode.
> This patch does fix the issue, but I am puzzled as to why it is needed
> in the first place. The comment above it mentions that "In OTG mode we
> have to wait until we loaded a gadget. We don't really need a gadget if
> we operate as a host but we should not start a session as a device
> without a gadget or else we explode.", which is apparently compatible
> with my use case: a gadget is not really needed and I'm not trying to
> start a session as a device without a gadget loaded.
>=20
> What do you think?

Okay, this came down to an argument that whether we should require
loading a gadget driver on a dual-role port to work in host mode,
which is currently required on musb since a long long time ago.

I understand the requirement is kinda unnecessary, but since it already
exists on musb stack for a long time, I don't plan to change it. Because I
cannot think of a use case in real products that doesn't automatically
load a gadget function on the dual-role port.

If you can explain a use case in real world (not a engineering lab) that
the gadget driver will not be loaded at linux booting up, but later
based on user's input, I will reconsider my decision. To remove this
requirement from musb stack, the work is more than this patch.

Regards,
-Bin.


