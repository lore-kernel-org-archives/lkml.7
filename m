Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0F9C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA942075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfEBKqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 06:46:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:20662 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfEBKqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:46:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 03:46:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,421,1549958400"; 
   d="scan'208";a="228622453"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga001.jf.intel.com with ESMTP; 02 May 2019 03:45:58 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hM9Dw-0004MM-M5; Thu, 02 May 2019 13:45:56 +0300
Date:   Thu, 2 May 2019 13:45:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Esben Haabendal <esben@haabendal.dk>
Cc:     linux-serial@vger.kernel.org, Enrico Weigelt <lkml@metux.net>,
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
Message-ID: <20190502104556.GS9224@smile.fi.intel.com>
References: <20190430140416.4707-1-esben@geanix.com>
 <20190430153736.GL9224@smile.fi.intel.com>
 <874l6efxta.fsf@haabendal.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874l6efxta.fsf@haabendal.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 09:17:37AM +0200, Esben Haabendal wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> > Hmm... Currently it's done inside individual port drivers, like 8250_dw.c.
> > Each of the drivers can do it differently, for example 8250_lpss.c or
> > 8250_pnp.c.
> 
> So, you would prefer to create a new "specialized" port driver that uses
> platform resources?  I am not doing anything else different from
> the generic port driver here in 8250_core.c.

If it's required and using serial8250 directly is not enough.

> >> +				if (!(port->flags & UPF_DEV_RESOURCES))
> >> +					release_mem_region(port->mapbase, size);
> >
> > This is again same issue. The parent should not request resource it
> > doesn't use.
> 
> Yes, this is same issue.
> 
> But the last part is not true.  A parent mfd driver might "use" a memory
> resource for the sole purpose of splitting it up for it's mfd child
> devices.  This is a core part of mfd framework, and not something I am
> inventing with this patch.  I am just trying to make it possible to use
> 8250 driver in that context.
> 
> > I think I understand what is a confusion here.
> >
> > For the IO resources we have two operations:
> > - mapping / re-mapping (may be shared)
> > - requesting (exclusive)
> >
> > In the parenthesis I put a level of access to it. While many device
> > drivers can *share* same resource (mapped or unmapped), the only one
> > can actually request it.
> 
> Mostly true.  But there is an important twist to the exclusive restriction.
> 
> The exclusive part of the request is limited to the the same root/parent
> resource.
> 
> When you request a memory resource from the root resource
> (iomem_resource), the resource returned can be used as a new parent
> resource.  This new parent can then be used to give exclusive access to
> slices of that resource.  When used like that, I expect that the parent
> resource is not supposed to be used for anything else than honoring
> resource requests.
> 
> And this is exactly what mfd-core uses the mem_base argument
> in mfd_add_devices().
> 
> > So, the parent can take an slice resources as it would be
> > appropriated, but not requesting them.
> 
> The parent is not and should not be doing that by itself.  The request
> is done on by mfd-core when mfd_add_devices() is called.

No, MFD *does not* (and actually *may not* in order to allow standalone drivers
to be used as children w/o modifications) request resources. It just passes
them to children as parent suggested.

> > OTOH, it's possible to have a (weird) MFD case where parent *requested*
> > resources, and *all* of its children are aware of that.
> 
> I am not sure what you mean with this, but mfd drivers should not pass
> along it's intire requested memory resource(s) to child devices.  The
> child devices will get the requested resource slices, as implemented by
> mfd_add_devices().
> 
> I hope you can see that I am not violating any fundamental design
> decissions here, but actually try adhere to them (resource management,
> platform_device resource management, and mfd-core).

-- 
With Best Regards,
Andy Shevchenko


