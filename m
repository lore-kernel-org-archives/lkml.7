Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D40FC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2542081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfEBPfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:35:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:8760 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728998AbfEBPba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:31:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 08:31:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,422,1549958400"; 
   d="scan'208";a="154169893"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 02 May 2019 08:31:25 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hMDgC-0006jn-8O; Thu, 02 May 2019 18:31:24 +0300
Date:   Thu, 2 May 2019 18:31:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Esben Haabendal <esben@haabendal.dk>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-serial@vger.kernel.org,
        Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device
 resources
Message-ID: <20190502153124.GA9224@smile.fi.intel.com>
References: <20190430140416.4707-1-esben@geanix.com>
 <20190430153736.GL9224@smile.fi.intel.com>
 <874l6efxta.fsf@haabendal.dk>
 <20190502104556.GS9224@smile.fi.intel.com>
 <87pnp11112.fsf@haabendal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnp11112.fsf@haabendal.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 02:41:45PM +0200, Esben Haabendal wrote:
> Hi Lee
> 
> Could you help clarify whether or not this patch is trying to do
> something odd/wrong?
> 
> I might be misunderstanding Andy (probably is), but the discussion
> revolves around the changes I propose where I change the serial8250
> driver to use platform_get_resource() in favour of
> request_mem_region()/release_mem_region().
> 
> In my understanding, use of platform_get_resource() is the right thing
> to do in order to integrate properly with with MFD drivers that splits a
> common memory resource in mfd_add_device() using the mem_base argument.
> 
> Discussion follows:
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> 
> > On Wed, May 01, 2019 at 09:17:37AM +0200, Esben Haabendal wrote:
> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> >
> >> > Hmm... Currently it's done inside individual port drivers, like 8250_dw.c.
> >> > Each of the drivers can do it differently, for example 8250_lpss.c or
> >> > 8250_pnp.c.
> >> 
> >> So, you would prefer to create a new "specialized" port driver that uses
> >> platform resources?  I am not doing anything else different from
> >> the generic port driver here in 8250_core.c.
> >
> > If it's required and using serial8250 directly is not enough.
> 
> Sorry, I am not sure what you mean by that.

The serial8250 is the name of (generic) platform driver of 8250 which can be
used as a child for MFD.

> >> >> +				if (!(port->flags & UPF_DEV_RESOURCES))
> >> >> +					release_mem_region(port->mapbase, size);
> >> >
> >> > This is again same issue. The parent should not request resource it
> >> > doesn't use.
> >> 
> >> Yes, this is same issue.
> >> 
> >> But the last part is not true.  A parent mfd driver might "use" a memory
> >> resource for the sole purpose of splitting it up for it's mfd child
> >> devices.  This is a core part of mfd framework, and not something I am
> >> inventing with this patch.  I am just trying to make it possible to use
> >> 8250 driver in that context.
> >> 
> >> > I think I understand what is a confusion here.
> >> >
> >> > For the IO resources we have two operations:
> >> > - mapping / re-mapping (may be shared)
> >> > - requesting (exclusive)
> >> >
> >> > In the parenthesis I put a level of access to it. While many device
> >> > drivers can *share* same resource (mapped or unmapped), the only one
> >> > can actually request it.
> >> 
> >> Mostly true.  But there is an important twist to the exclusive restriction.
> >> 
> >> The exclusive part of the request is limited to the the same root/parent
> >> resource.
> >> 
> >> When you request a memory resource from the root resource
> >> (iomem_resource), the resource returned can be used as a new parent
> >> resource.  This new parent can then be used to give exclusive access to
> >> slices of that resource.  When used like that, I expect that the parent
> >> resource is not supposed to be used for anything else than honoring
> >> resource requests.
> >> 
> >> And this is exactly what mfd-core uses the mem_base argument
> >> in mfd_add_devices().
> >> 
> >> > So, the parent can take an slice resources as it would be
> >> > appropriated, but not requesting them.
> >> 
> >> The parent is not and should not be doing that by itself.  The request
> >> is done on by mfd-core when mfd_add_devices() is called.
> >
> > No, MFD *does not* (and actually *may not* in order to allow standalone drivers
> > to be used as children w/o modifications) request resources. It just passes
> > them to children as parent suggested.
> 
> In drivers/mfd/mfd-core.c:mfd_add_device() :
> 
>         for (r = 0; r < cell->num_resources; r++) {
>                 res[r].name = cell->resources[r].name;
>                 res[r].flags = cell->resources[r].flags;
> 
>                 /* Find out base to use */
>                 if ((cell->resources[r].flags & IORESOURCE_MEM) && mem_base) {
>                         res[r].parent = mem_base;
>                         res[r].start = mem_base->start +
>                                 cell->resources[r].start;
>                         res[r].end = mem_base->start +
>                                 cell->resources[r].end;
>                 } else if (cell->resources[r].flags & IORESOURCE_IRQ) {
>                         if (domain) {
>                                 /* Unable to create mappings for IRQ ranges. */
>                                 WARN_ON(cell->resources[r].start !=
>                                         cell->resources[r].end);
>                                 res[r].start = res[r].end = irq_create_mapping(
>                                         domain, cell->resources[r].start);
>                         } else {
>                                 res[r].start = irq_base +
>                                         cell->resources[r].start;
>                                 res[r].end   = irq_base +
>                                         cell->resources[r].end;
>                         }
>                 } else {
>                         res[r].parent = cell->resources[r].parent;
>                         res[r].start = cell->resources[r].start;
>                         res[r].end   = cell->resources[r].end;
>                 }
> 
>                 if (!cell->ignore_resource_conflicts) {
>                         if (has_acpi_companion(&pdev->dev)) {
>                                 ret = acpi_check_resource_conflict(&res[r]);
>                                 if (ret)
>                                         goto fail_alias;
>                         }
>                 }
>         }
> 
>         ret = platform_device_add_resources(pdev, res, cell->num_resources);
> 
> This creates the child resources.  Whether we call that requesting the
> resources or not, is a matter of word.  But it is what it is.  When it
> is done, you cannot use request_mem_region() for those memory resources,
> they are now locked/exclusive for the mfd parent *and* for the
> respective mfd child device.

Why not? Again, *slicing* resources is OK and that's what MFD for, *requesting*
them in the parent is not.

> In order to use them, child devices simply use platform_get_resource(),
> and everything works nicely.  It works fine for normal (non-mfd)
> devices, as they get (requests) the resources from the root resource
> (iomem_resource), and works fine for mfd devices as well.  So no changes
> are needed for drivers to work with mfd.
> 
> Whether you call the thing that mfd_add_device() does for "request
> resources" or just "pass them to children" is a matter of words.

Nope, *requesting* resources as you mentioned lock them to the certain user.

> The
> mfd (parent) has a resource which it cuts up into slices for its
> children, and these slices are passed to the child devices.  The drivers
> for these child devices must then pickup the resource(s) using
> platform_get_resource().  At no point is any "request_*" function
> called.
> 
> Looking at in another way.
> 
> The request_mem_region() macro call __request_resource(), which which
> simply creates a new 'struct resource' in the iomem_resource resource.
> 
> In mfd_add_device(), almost the same happens.  A new 'struct resource'
> is created in the mem_base resource.
> 
> In both cases, a 'struct resource' is created, representing exclusive
> access to the resource.  And like it or not, this is something that MFD
> already *do*, and I think it is way out of scope of this patch to change
> that.
> 
> I just try to make serial8250 driver work nicely in that (mfd) context,
> without changing how mfd is working.

There is nothing to change. It's already working. I don't see a problem here.

> >> > OTOH, it's possible to have a (weird) MFD case where parent *requested*
> >> > resources, and *all* of its children are aware of that.
> >> 
> >> I am not sure what you mean with this, but mfd drivers should not pass
> >> along it's intire requested memory resource(s) to child devices.  The
> >> child devices will get the requested resource slices, as implemented by
> >> mfd_add_devices().
> >> 
> >> I hope you can see that I am not violating any fundamental design
> >> decissions here, but actually try adhere to them (resource management,
> >> platform_device resource management, and mfd-core).

-- 
With Best Regards,
Andy Shevchenko


