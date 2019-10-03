Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D283C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 726A820873
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 19:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570130470;
	bh=knFIrOxdW8scykcgxDgzLn5ulatxJoq8OU9aYL71OBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fyNI3gTONDVUNkrE4CfYJLNxjOctdb/NzDJXPjWA9XeNISCPfvE3ptKVHxxsCdj47
	 HOOZaFhcYkea68wXlhSQWYOfUGShVEREqDodGDQdPj35IvvKHIxKP9TeX69FXxAM2C
	 m9OiaCnc2gln5etNUPEco5pSzanuGd7L67tcBLBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbfJCTVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 15:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfJCTVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 15:21:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90E442086A;
        Thu,  3 Oct 2019 19:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570130468;
        bh=knFIrOxdW8scykcgxDgzLn5ulatxJoq8OU9aYL71OBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yMhDL53nQ4JhrYph+99cbAsNsgehvKUQsrD8Ro9DeFcqbaZj4aw8RCnk9vnfD5D4q
         iMnUGpxzedlSSOqsru5+7pookRzSmPma4MMS9JJvMhfYLOpLsZ0lYG66JGgl5tpiqU
         ectxzCnurY3TeR2/C1nC4EiZuMvxS/2J1GzmNLLM=
Date:   Thu, 3 Oct 2019 21:21:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Streetman <ddstreet@canonical.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/vio: use simple dummy struct device as bus parent
Message-ID: <20191003192105.GB3587427@kroah.com>
References: <20190927130402.687-1-ddstreet@canonical.com>
 <20190927181856.GD1804168@kroah.com>
 <CAOZ2QJM+qgiYR+15rydwT6ebuL7UBfPcVp9vXCug6NSWDRS-Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOZ2QJM+qgiYR+15rydwT6ebuL7UBfPcVp9vXCug6NSWDRS-Cg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 03:10:03PM -0400, Dan Streetman wrote:
> On Fri, Sep 27, 2019 at 2:19 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Sep 27, 2019 at 09:04:02AM -0400, Dan Streetman wrote:
> > > The dummy vio_bus_device creates the /sys/devices/vio directory, which
> > > contains real vio devices under it; since it represents itself as having
> > > a bus = &vio_bus_type, its /sys/devices/vio/uevent does call the bus's
> > > .uevent function, vio_hotplug(), and as that function won't find a real
> > > device for the dummy vio_dev, it will return -ENODEV.
> > >
> > > One of the main users of the uevent node is udevadm, e.g. when it is called
> > > with 'udevadm trigger --devices'.  Up until recently, it would ignore any
> > > errors returned when writing to devices' uevent file, but it was recently
> > > changed to start returning error if it gets an error writing to any uevent
> > > file:
> > > https://github.com/systemd/systemd/commit/97afc0351a96e0daa83964df33937967c75c644f
> > >
> > > since the /sys/devices/vio/uevent file has always returned ENODEV from
> > > any write to it, this now causes the udevadm trigger command to return
> > > an error.  This may be fixed in udevadm to ignore ENODEV errors, but the
> > > vio driver should still be fixed.
> > >
> > > This patch changes the arch/powerpc/platform/pseries/vio.c 'dummy'
> > > parent device into a real dummy device with no .bus, so its uevent
> > > file will stop returning ENODEV and simply do nothing and return 0.
> > >
> > > Signed-off-by: Dan Streetman <ddstreet@canonical.com>
> > > ---
> > >  arch/powerpc/platforms/pseries/vio.c | 11 ++++-------
> > >  1 file changed, 4 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
> > > index 79e2287991db..63bc16631680 100644
> > > --- a/arch/powerpc/platforms/pseries/vio.c
> > > +++ b/arch/powerpc/platforms/pseries/vio.c
> > > @@ -32,11 +32,8 @@
> > >  #include <asm/page.h>
> > >  #include <asm/hvcall.h>
> > >
> > > -static struct vio_dev vio_bus_device  = { /* fake "parent" device */
> > > -     .name = "vio",
> > > -     .type = "",
> > > -     .dev.init_name = "vio",
> > > -     .dev.bus = &vio_bus_type,
> > > +static struct device vio_bus = {
> > > +     .init_name      = "vio",
> >
> > Eeek, no!  Why are you creating a static device that will then be
> > reference counted?  Not nice :(
> 
> so, I looked again and it seems quite a few places appear to do
> exactly this, is it something that should be fixed?

Yes.
