Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74D9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78632184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfC2Uck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:32:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730086AbfC2Uck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:32:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2766B308620F;
        Fri, 29 Mar 2019 20:32:40 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DEB119C65;
        Fri, 29 Mar 2019 20:32:39 +0000 (UTC)
Date:   Fri, 29 Mar 2019 14:32:39 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Joe Perches <joe@perches.com>, Bjorn Helgaas <helgaas@kernel.org>,
        kvm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfio: Use dev_printk() when possible
Message-ID: <20190329143239.60d4b9a6@x1.home>
In-Reply-To: <CAErSpo7bGn8JP9n6UaPUdTJ1ZFonnZX+C+bCFgfN4HH2Hu6OpA@mail.gmail.com>
References: <20190325194220.5873-1-helgaas@kernel.org>
        <4faf234df19c1b54b70cbe82c0dacacc58568b87.camel@perches.com>
        <CAErSpo7bGn8JP9n6UaPUdTJ1ZFonnZX+C+bCFgfN4HH2Hu6OpA@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 29 Mar 2019 20:32:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2019 12:03:11 -0500
Bjorn Helgaas <bhelgaas@google.com> wrote:

> On Mon, Mar 25, 2019 at 3:49 PM Joe Perches <joe@perches.com> wrote:
> >
> > On Mon, 2019-03-25 at 14:42 -0500, Bjorn Helgaas wrote:  
> > > Use dev_printk() when possible to make messages consistent with other
> > > device-related messages.  
> >
> > trivial note:
> >  
> > > diff --git a/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c b/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c  
> > []  
> > > @@ -89,7 +89,8 @@ static int vfio_platform_amdxgbe_reset(struct vfio_platform_device *vdev)
> > >       } while ((pcs_value & MDIO_CTRL1_RESET) && --count);
> > >
> > >       if (pcs_value & MDIO_CTRL1_RESET)
> > > -             pr_warn("%s XGBE PHY reset timeout\n", __func__);
> > > +             dev_warn(&vdev->device, "%s XGBE PHY reset timeout\n",
> > > +                      __func__);  
> >
> > Many of these could use a colon after the %s used with __func__
> > to make the output more consistent with other modules.  
> 
> Thanks, Joe.  I added a colon to the two in
> vfio_platform_amdxgbe_reset().  Those were the only ones I saw, except
> for a couple "%s failed" messages in
> drivers/vfio/vfio_iommu_spapr_tce.c, which I didn't change because (1)
> they can't use dev_err() so slightly out of scope for this patch, and
> (2) it arguably reads more naturally without the colon.
> 
> In vfio_pci.c, I converted some pr_info() to dev_info() without adding
> a dev_fmt definition, so that removed the KBUILD_MODNAME prefix, which
> I didn't intend.  I'll add "#define dev_fmt pr_fmt" to restore the
> prefix.
> 
> Messages from drivers/vfio use a variety of prefixes (none, "VFIO: ",
> KBUILD_MODNAME, __func__).  That could potentially be rationalized but
> I would want Alex's guidance first.

Hmm, sort of hard to generalize.  I suspect "VFIO:" is not super
useful, the module name is probably a better choice, augmented by
__func__ where it adds useful context.  That's probably the approach
I'd take.  Thanks,

Alex
