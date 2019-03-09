Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E26C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 08:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FF5207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 08:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rNufaa1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfCIIOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 03:14:30 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:48196 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfCIIO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 03:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=peOy3Y+WhvWXicOY3w9ET9C2fT9Mhlo5Qck9S6sVUDo=; b=rNufaa1ngiNnm6rlzNwyrSmRc
        mbcl3iwuW61iHXBrIj5GqNlZ6AL8kemfclzVyfr2W/Rk4Q0y4Rm8N+gONblboXzpvTYWrf7ZtXHml
        WvPHrseeo6t3YfarnauNZlw6tUV3f0xIX6zBZE/rVxwHalIiifF0RbQSR0kWbNEuAZgYfomgOmfec
        axhj/H+ste3/gqCqkmNGOLlOhuPY+GUp1WfDcSi+9PFw5c5rtNDxmrrJrLY5JyQA6raqI2LNkEbPw
        iQgBgAx+NUtz6+yhVudPGKlOVc3OVzDZDGriVZkuXFh9UqE7TD3izvfKq5L5bZFaGWZV7ASgvxTsk
        OR8gzO5eA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:55042)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h2X7X-0000Tl-MH; Sat, 09 Mar 2019 08:14:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h2X7T-0006Tf-2O; Sat, 09 Mar 2019 08:14:11 +0000
Date:   Sat, 9 Mar 2019 08:14:10 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     wang.yi59@zte.com.cn, linux-arm-kernel@lists.infradead.org,
        Wen Yang <wen.yang99@zte.com.cn>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] ARM: actions: fix a leaked reference by adding
 missing of_node_put
Message-ID: <20190309081410.yqc4e45zk7grolja@shell.armlinux.org.uk>
References: <1551785646-46173-1-git-send-email-wen.yang99@zte.com.cn>
 <20190305114048.egpbeddy4pqbwl5b@shell.armlinux.org.uk>
 <20190309021742.GA5664@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309021742.GA5664@Mani-XPS-13-9360>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2019 at 07:47:42AM +0530, Manivannan Sadhasivam wrote:
> Hi Russel,
> 
> On Tue, Mar 05, 2019 at 11:40:48AM +0000, Russell King - ARM Linux admin wrote:
> > On Tue, Mar 05, 2019 at 07:33:52PM +0800, Wen Yang wrote:
> > > The call to of_get_next_child returns a node pointer with refcount
> > > incremented thus it must be explicitly decremented after the last
> > > usage.
> > > 
> > > Detected by coccinelle with the following warnings:
> > > ./arch/arm/mach-actions/platsmp.c:112:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 103, but without a corresponding object release within this function.
> > > ./arch/arm/mach-actions/platsmp.c:124:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 115, but without a corresponding object release within this function.
> > > ./arch/arm/mach-actions/platsmp.c:137:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 128, but without a corresponding object release within this function.
> > 
> > I question this.  Your reasoning is that the node is no longer used
> > so the reference count needs to be put.
> > 
> > However, in all these cases, data is read from the nodes properties
> > and the device remains in-use for the life of the kernel.  There is
> > a big difference here.
> > 
> > With normal drivers, each device is bound to their associated device
> > node associated with the device.  When the device node goes away, then
> > the corresponding device goes away too, which causes the driver to be
> > unbound from the device.
> > 
> > However, there is another class of "driver" which are the ones below,
> > where they are "permanent" devices.  These can never go away, even if
> > the device node refcount hits zero and the device node is freed - the
> > device is still present and in-use in the system.  So, having the
> > device node refcount hit zero is actually a bug: what that's saying
> > is the system device (eg, SCU) has gone away.  If you somehow were to
> > remove the SCU from the system, you'd end up severing the connection
> > between the CPU cores and the rest of the system - obviously resulting
> > in a dead system!
> > 
> > So, what is the point of dropping these refcounts for devices that can
> > never go away - and thus their associated device_node should also never
> > go away?
> > 
> 
> Yes, practically we would never hit this case but theoretically we should
> decrement the refcount for nodes/properties whenever we are done with it.
> As you know, there are 'n' number of places in kernel where we can see the
> refcount not being put after use. So I would welcome these kind of patches
> to set an example for someone who tries to use the of_* calls in future.
> 
> IMO, DT should've handled the refcount internally without exposing the
> pointers to external world.

It doesn't, that's my point.

In the case of normal drivers, there's an _extra_ refcount held by the
device that is created - see the of_node_get() in of_device_alloc().
This refcount exists for the lifetime of the device structure.  That
refcount exists for the duration that the device exists, which bounds
the lifetime of the availability of the device to the driver.

In effect, while the device driver is bound, there is a refcount on
the device node.  So, the device node is guaranteed to be around for
as long as the device driver is bound to the device.

For the cases being addressed in these patches, there is no driver, so
there is no bounding of the lifetime: the expectation is that the
lifetime is the duration of the kernel.  If such a device node were to
be deleted, then there is no way to unbind the driver, and if we have
dropped the refcount, the device node will be immediately freed.
However, the device is still in use.

These are a different "class" of driver.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
