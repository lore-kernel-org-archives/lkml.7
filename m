Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CBCCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC4C20679
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nZdVxcSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388026AbfJVIsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:48:42 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40170 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387575AbfJVIsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MtL3YOiN71djeLoYB9yivNmcp6DZe3ZfGe1tUxOoKk8=; b=nZdVxcSfO3OODaDonUKkJDZp+
        p/ojEa1+QNdV4Bar+TtDVx0SS/00km22RcUYQoZOh45qChHxG9hFOihQBSiJFSfHMz0k5g+ETpQCF
        D0P9k5sJzwS5JlHx8zOhs+jG/Ydc7HXmHlAtIpnTtsTvylN7nA6z1qZuV1tl7y3PKfkUg97E4Wo/k
        ff6wUb744sqaA2kix/oN5v08RmSNsQGzl9VgUWYWey+m6+CeJoAJvK91DRhsL6LCZxA5n3hRx5rrM
        5b6PBXuuBB/bqjejOKT/VkIW/fOojFJgYYNWKTJ2+kvN654lhZ3zOrNMAgW2WPCSvRaqfzWuh6keh
        A21EgMV1A==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:45890)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iMpqC-00065m-AN; Tue, 22 Oct 2019 09:48:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iMpq6-0004PU-O5; Tue, 22 Oct 2019 09:48:26 +0100
Date:   Tue, 22 Oct 2019 09:48:26 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Brian Starkey <Brian.Starkey@arm.com>, nd <nd@arm.com>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Sean Paul <sean@poorly.run>
Subject: Re: [RFC,3/3] drm/komeda: Allow non-component drm_bridge only
 endpoints
Message-ID: <20191022084826.GP25745@shell.armlinux.org.uk>
References: <20191004143418.53039-4-mihail.atanassov@arm.com>
 <20191009055407.GA3082@jamwan02-TSP300>
 <5390495.Gzyn2rW8Nj@e123338-lin>
 <20191016162206.u2yo37rtqwou4oep@DESKTOP-E1NTVVP.localdomain>
 <20191017030752.GA3109@jamwan02-TSP300>
 <20191017082043.bpiuvfr3r4jngxtu@DESKTOP-E1NTVVP.localdomain>
 <20191017102055.GA8308@jamwan02-TSP300>
 <20191017104812.6qpuzoh5bx5i2y3m@DESKTOP-E1NTVVP.localdomain>
 <20191017114137.GC25745@shell.armlinux.org.uk>
 <20191022084210.GX11828@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022084210.GX11828@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 10:42:10AM +0200, Daniel Vetter wrote:
> On Thu, Oct 17, 2019 at 12:41:37PM +0100, Russell King - ARM Linux admin wrote:
> > On Thu, Oct 17, 2019 at 10:48:12AM +0000, Brian Starkey wrote:
> > > On Thu, Oct 17, 2019 at 10:21:03AM +0000, james qian wang (Arm Technology China) wrote:
> > > > On Thu, Oct 17, 2019 at 08:20:56AM +0000, Brian Starkey wrote:
> > > > > On Thu, Oct 17, 2019 at 03:07:59AM +0000, james qian wang (Arm Technology China) wrote:
> > > > > > On Wed, Oct 16, 2019 at 04:22:07PM +0000, Brian Starkey wrote:
> > > > > > > 
> > > > > > > If James is strongly against merging this, maybe we just swap
> > > > > > > wholesale to bridge? But for me, the pragmatic approach would be this
> > > > > > > stop-gap.
> > > > > > >
> > > > > > 
> > > > > > This is a good idea, and I vote +ULONG_MAX :)
> > > > > > 
> > > > > > and I also checked tda998x driver, it supports bridge. so swap the
> > > > > > wholesale to brige is perfect. :)
> > > > > > 
> > > > > 
> > > > > Well, as Mihail wrote, it's definitely not perfect.
> > > > > 
> > > > > Today, if you rmmod tda998x with the DPU driver still loaded,
> > > > > everything will be unbound gracefully.
> > > > > 
> > > > > If we swap to bridge, then rmmod'ing tda998x (or any other bridge
> > > > > driver the DPU is using) with the DPU driver still loaded will result
> > > > > in a crash.
> > > > 
> > > > I haven't read the bridge code, but seems this is a bug of drm_bridge,
> > > > since if the bridge is still in using by others, the rmmod should fail
> > > > 
> > > 
> > > Correct, but there's no fix for that today. You can also take a look
> > > at the thread linked from Mihail's cover letter.
> > > 
> > > > And personally opinion, if the bridge doesn't handle the dependence.
> > > > for us:
> > > > 
> > > > - add such support to bridge
> > > 
> > > That would certainly be helpful. I don't know if there's consensus on
> > > how to do that.
> > > 
> > > >   or
> > > > - just do the insmod/rmmod in correct order.
> > > > 
> > > > > So, there really are proper benefits to sticking with the component
> > > > > code for tda998x, which is why I'd like to understand why you're so
> > > > > against this patch?
> > > > >
> > > > 
> > > > This change handles two different connectors in komeda internally, compare
> > > > with one interface, it increases the complexity, more risk of bug and more
> > > > cost of maintainance.
> > > > 
> > > 
> > > Well, it's only about how to bind the drivers - two different methods
> > > of binding, not two different connectors. I would argue that carrying
> > > our out-of-tree patches to support both platforms is a larger
> > > maintenance burden.
> > > 
> > > Honestly this looks like a win-win to me. We get the superior approach
> > > when its supported, and still get to support bridges which are more
> > > common.
> > > 
> > > As/when improvements are made to the bridge code we can remove the
> > > component bits and not lose anything.
> > 
> > There was an idea a while back about using the device links code to
> > solve the bridge issue - but at the time the device links code wasn't
> > up to the job.  I think that's been resolved now, but I haven't been
> > able to confirm it.  I did propose some patches for bridge at the
> > time but they probably need updating.
> 
> I think the only patches that existed where for panel, and we only
> discussed the bridge case. At least I can only find patches for panel,not
> bridge, but might be missing something.

I had a patches, which is why I raised the problem with the core:

6961edfee26d bridge hacks using device links

but it never went further than an experiment at the time because of the
problems in the core.  As it was a hack, it never got posted.  Seems
that kernel tree (for the cubox) is still 5.2 based, so has a lot of
patches and might need updating to a more recent base before anything
can be tested.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
