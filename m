Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F726C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29365218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfCUNBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:01:38 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:51961 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbfCUNBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:01:38 -0400
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 6806D1BF20D;
        Thu, 21 Mar 2019 13:01:34 +0000 (UTC)
Date:   Thu, 21 Mar 2019 14:01:33 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Bin Liu <b-liu@ti.com>, Paul Kocialkowski <contact@paulk.fr>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] usb: musb: Support gadget mode when the port is set to
 dual role
Message-ID: <20190321130133.zllt5pqbrhiecoch@flea>
References: <20180328215213.29538-1-contact@paulk.fr>
 <20180329092326.dayuccomq5zrywqo@flea>
 <1522324644.1746.19.camel@bootlin.com>
 <20180420142524.GB29011@uda0271908>
 <2db056d6f65ecbcdc4f31a37fe2e1b1ddfb93c87.camel@paulk.fr>
 <20180421143426.GA10632@LTA0271908.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ppsyyzq7p33rbszu"
Content-Disposition: inline
In-Reply-To: <20180421143426.GA10632@LTA0271908.dhcp.ti.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ppsyyzq7p33rbszu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm reviving this thread a bit, because I encountered this bug today.

On Thu, Mar 21, 2019 at 11:02:10AM +0100, Bin Liu wrote:
> On Sat, Apr 21, 2018 at 12:59:23PM +0200, Paul Kocialkowski wrote:
> > Hi,
> >
> > Le vendredi 20 avril 2018 =E0 09:25 -0500, Bin Liu a =E9crit :
> > > On Thu, Mar 29, 2018 at 01:57:24PM +0200, Paul Kocialkowski wrote:
> > > > Hi,
> > > >
> > > > On Thu, 2018-03-29 at 11:23 +0200, Maxime Ripard wrote:
> > > > > On Wed, Mar 28, 2018 at 11:52:13PM +0200, Paul Kocialkowski wrote:
> > > > > > This allows dual-role ports to be reported as having gadget mode
> > > > > > by
> > > > > > the
> > > > > > musb_has_gadget helper. This is required to enable MUSB at all
> > > > > > with
> > > > > > MUSB
> > > > > > glue layers that set the port mode to MUSB_PORT_MODE_DUAL_ROLE
> > > > > > at
> > > > > > init.
> > > > > >
> > > > > > Most notably, this allows calling musb_start when needed in the
> > > > > > virtual
> > > > > > MUSB root HUB, regardless of whether the current mode should be
> > > > > > gadget
> > > > > > or host.
> > > > > >
> > > > > > This fixes USB OTG on Allwinner devices that I could test it
> > > > > > with,
> > > > > > mainly A20 devices.
> > > > > >
> > > > > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > > > >
> > > > > Surely there's more to it than that. The gadget mode of A20 boards
> > > > > have been working in the past, including when compiling with mUSB
> > > > > setup as dual role.
> > > > >
> > > > > Is this a regression since a particular commit? Or is there
> > > > > another,
> > > > > deeper issue overlooked in the commit log?
> > > >
> > > > The root of the issue here is that musb_start is not called at any
> > > > point
> > > > without this patch. My understanding of the flow is the following:
> > > > when
> > > > the PHY detects that there was a VBUS/ID change, it will notify its
> > > > listeners (mainly the musb sunxi glue layer). This will then
> > > > schedule
> > > > the driver's work (sunxi_musb_work), which does nothing since the
> > > > SUNXI_MUSB_FL_ENABLED bit was never set. This bit is only set after
> > > > calling sunxi_musb_enable, which is called from
> > > > musb_platform_enable,
> > > > that originates from musb_start.
> > > >
> > > > Currently I see two places where musb_start is called:
> > > > * musb_virthub
> > > > * musb_gadget
> > > >
> > > > In the latter case, it is in turn called from udc_start, which
> > > > should
> > > > probably (correct me if I'm wrong) happen later in the call chain
> > > > than
> > > > ID/VBUS change notification time.
> > >
> > > I don't think it is correct that udc_start() is triggered by ID/VBUS
> > > events, but I don't have an Allwinner platform to verify the callflow.
> >
> > Yes you're right, I didn't make myself very clear here. I didn't
> > investigate the udc_start call path much since it was apparently not the
> > culprit.
> >
> > > Have you tried to load with a gadget driver? When a gadget function is
> > > bound to UDC, udc_start() is triggered, which in turn calls
> > > musb_start().
> >
> > It does work under that scenario, although my used case here is using
> > musb with DUAL_ROLE but no gadget driver loaded. That it, I want the
> > musb_start call to originate from the virtual hub, not from the gadget
> > side.
> >
> > > > In the former case, musb_start is called in the root controller hub
> > > > control, when setting the USB_PORT_FEAT_POWER feature. This looks
> > > > perfectly legit and IMO this is where it should be initially calling
> > > > musb_start in the dual role case. The kernel is indeed setting the
> > >
> > > No actually. A dual-role port should be in b_idle state by default, so
> > > logically all actions should go to the gadget path until the port
> > > switches to host mode.
> >
> > It makes sense that the port should be in b_idle state by default, but
> > here it fails to switch to host mode when the ID pin detects that it
> > should. Or does b_idle state entail that a gadget must be loaded (per
> > the USB spec), and thus nothing should (ever) happen until that happens?
> >
> > I find it really odd to need a gadget device to trigger host mode.
> > This patch does fix the issue, but I am puzzled as to why it is needed
> > in the first place. The comment above it mentions that "In OTG mode we
> > have to wait until we loaded a gadget. We don't really need a gadget if
> > we operate as a host but we should not start a session as a device
> > without a gadget or else we explode.", which is apparently compatible
> > with my use case: a gadget is not really needed and I'm not trying to
> > start a session as a device without a gadget loaded.
> >
> > What do you think?
>
> Okay, this came down to an argument that whether we should require
> loading a gadget driver on a dual-role port to work in host mode,
> which is currently required on musb since a long long time ago.
>
> I understand the requirement is kinda unnecessary, but since it already
> exists on musb stack for a long time, I don't plan to change it. Because I
> cannot think of a use case in real products that doesn't automatically
> load a gadget function on the dual-role port.
>
> If you can explain a use case in real world (not a engineering lab) that
> the gadget driver will not be loaded at linux booting up, but later
> based on user's input, I will reconsider my decision. To remove this
> requirement from musb stack, the work is more than this patch.

I have one for you: we're working on a device that boots pretty fast,
and therefore are pushing as much things as we can to modules. It
includes gadgets, the musb driver and glue, etc. That doesn't sound
way very different from what a generic distro would do as well.

At boot, the various modules for the hardware are loaded
automatically: the musb glue, the musb core, our USB PHY, etc. We end
up in a situation where the musb driver is loaded and reported to work
properly. The USB cable to the OTG port (in peripheral) might or might
not be connected, it's kind of irrelevant.

The gadgets, however, are not loaded automatically.

Now comes a user that wants to use musb as a host, and connect a
proper USB adapter, that wires the ID pin properly. In our case, the
phy detects it, reports the mode change, and .... nothing.

That doesn't really look like an engineering lab setup to me.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ppsyyzq7p33rbszu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXJOLLQAKCRDj7w1vZxhR
xWByAP47hzgTKUP/vKhVYSOnitQgS8XjmT0RCIuNCY71VGxJnAD/ReeWmZPmd4k8
JaqU3y/rddQOf9fkJSgrfOb6dCLASQk=
=TC4r
-----END PGP SIGNATURE-----

--ppsyyzq7p33rbszu--
