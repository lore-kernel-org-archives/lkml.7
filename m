Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D2EC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48125205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="pbbOd/ST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfEFPrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:47:02 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com ([46.30.210.183]:63865
        "EHLO mailrelay2-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726956AbfEFPrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=BrBTos4Ri320tFwLt4cGQ97J+wp4q16E+EwIU/kn/1Y=;
        b=pbbOd/ST9PZUAxwW5/FWO96CWrCumPw4AM7tMpvj1SzU1TbXnMnn3YzboXihe7GDDJO6AgC9ffXrf
         4MPQ/z6fKgBeJiybeUg55M6M4aALVcsEk9TpM0522ZMqdZdcLnTm9XWFXKf085UwoyE91fsLGUN9bz
         S3A+HEz6QpTf4IkQ=
X-HalOne-Cookie: c9055974d5f473aba7f2516bac49aae6a102f6e2
X-HalOne-ID: 2d8f06bd-7016-11e9-9368-d0431ea8a290
Received: from localhost (unknown [193.163.1.7])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 2d8f06bd-7016-11e9-9368-d0431ea8a290;
        Mon, 06 May 2019 15:46:56 +0000 (UTC)
From:   Esben Haabendal <esben@haabendal.dk>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device resources
References: <20190430140416.4707-1-esben@geanix.com>
        <20190430153736.GL9224@smile.fi.intel.com>
        <874l6efxta.fsf@haabendal.dk>
        <20190502104556.GS9224@smile.fi.intel.com>
        <87pnp11112.fsf@haabendal.dk>
        <20190502153124.GA9224@smile.fi.intel.com>
Date:   Mon, 06 May 2019 17:46:56 +0200
In-Reply-To: <20190502153124.GA9224@smile.fi.intel.com> (Andy Shevchenko's
        message of "Thu, 2 May 2019 18:31:24 +0300")
Message-ID: <87ef5boaa7.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

>> > On Wed, May 01, 2019 at 09:17:37AM +0200, Esben Haabendal wrote:
>> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> >
>> >> > Hmm... Currently it's done inside individual port drivers, like 8250_dw.c.
>> >> > Each of the drivers can do it differently, for example 8250_lpss.c or
>> >> > 8250_pnp.c.
>> >> 
>> >> So, you would prefer to create a new "specialized" port driver that uses
>> >> platform resources?  I am not doing anything else different from
>> >> the generic port driver here in 8250_core.c.
>> >
>> > If it's required and using serial8250 directly is not enough.
>> 
>> Sorry, I am not sure what you mean by that.
>
> The serial8250 is the name of (generic) platform driver of 8250 which can be
> used as a child for MFD.

The last part is only true, if you don't let MFD manage the memory
resources, which is the main thing that MFD is doing.

As an example, the sm501.c driver, the only driver in drivers/mfd/ which
uses serial8250 driver, does not use any code from mfd-core.
Incidentally, it is 1 year older than mfd-core.c, and as never been
refactored to use mfd-core functionality.

>> >> > I think I understand what is a confusion here.
>> >> >
>> >> > For the IO resources we have two operations:
>> >> > - mapping / re-mapping (may be shared)
>> >> > - requesting (exclusive)
>> >> >
>> >> > In the parenthesis I put a level of access to it. While many device
>> >> > drivers can *share* same resource (mapped or unmapped), the only one
>> >> > can actually request it.
>> >> 
>> >> Mostly true.  But there is an important twist to the exclusive restriction.
>> >> 
>> >> The exclusive part of the request is limited to the the same root/parent
>> >> resource.
>> >> 
>> >> When you request a memory resource from the root resource
>> >> (iomem_resource), the resource returned can be used as a new parent
>> >> resource.  This new parent can then be used to give exclusive access to
>> >> slices of that resource.  When used like that, I expect that the parent
>> >> resource is not supposed to be used for anything else than honoring
>> >> resource requests.
>> >> 
>> >> And this is exactly what mfd-core uses the mem_base argument
>> >> in mfd_add_devices().
>> >> 
>> >> > So, the parent can take an slice resources as it would be
>> >> > appropriated, but not requesting them.
>> >> 
>> >> The parent is not and should not be doing that by itself.  The request
>> >> is done on by mfd-core when mfd_add_devices() is called.
>> >
>> > No, MFD *does not* (and actually *may not* in order to allow standalone drivers
>> > to be used as children w/o modifications) request resources. It just passes
>> > them to children as parent suggested.
>> 
>> In drivers/mfd/mfd-core.c:mfd_add_device() :
>> 
>>         for (r = 0; r < cell->num_resources; r++) {
>>                 res[r].name = cell->resources[r].name;
>>                 res[r].flags = cell->resources[r].flags;
>> 
>>                 /* Find out base to use */
>>                 if ((cell->resources[r].flags & IORESOURCE_MEM) && mem_base) {
>>                         res[r].parent = mem_base;
>>                         res[r].start = mem_base->start +
>>                                 cell->resources[r].start;
>>                         res[r].end = mem_base->start +
>>                                 cell->resources[r].end;
>>                 } else if (cell->resources[r].flags & IORESOURCE_IRQ) {
>>                         if (domain) {
>>                                 /* Unable to create mappings for IRQ ranges. */
>>                                 WARN_ON(cell->resources[r].start !=
>>                                         cell->resources[r].end);
>>                                 res[r].start = res[r].end = irq_create_mapping(
>>                                         domain, cell->resources[r].start);
>>                         } else {
>>                                 res[r].start = irq_base +
>>                                         cell->resources[r].start;
>>                                 res[r].end   = irq_base +
>>                                         cell->resources[r].end;
>>                         }
>>                 } else {
>>                         res[r].parent = cell->resources[r].parent;
>>                         res[r].start = cell->resources[r].start;
>>                         res[r].end   = cell->resources[r].end;
>>                 }
>> 
>>                 if (!cell->ignore_resource_conflicts) {
>>                         if (has_acpi_companion(&pdev->dev)) {
>>                                 ret = acpi_check_resource_conflict(&res[r]);
>>                                 if (ret)
>>                                         goto fail_alias;
>>                         }
>>                 }
>>         }
>> 
>>         ret = platform_device_add_resources(pdev, res, cell->num_resources);
>> 
>> This creates the child resources.  Whether we call that requesting the
>> resources or not, is a matter of word.  But it is what it is.  When it
>> is done, you cannot use request_mem_region() for those memory resources,
>> they are now locked/exclusive for the mfd parent *and* for the
>> respective mfd child device.
>
> Why not? Again, *slicing* resources is OK and that's what MFD for, *requesting*
> them in the parent is not.

Why we cannot use request_mem_region() for those memory resources again?
It fails because the resources are now already owned the mfd driver, on
behalf of the child.

>> In order to use them, child devices simply use platform_get_resource(),
>> and everything works nicely.  It works fine for normal (non-mfd)
>> devices, as they get (requests) the resources from the root resource
>> (iomem_resource), and works fine for mfd devices as well.  So no changes
>> are needed for drivers to work with mfd.
>> 
>> Whether you call the thing that mfd_add_device() does for "request
>> resources" or just "pass them to children" is a matter of words.
>
> Nope, *requesting* resources as you mentioned lock them to the certain user.

I still think there is some confusion in relation to your use of the
word "requesting".  There is no explicit request/lock action in
kernel/resource.c.

There are basically only two steps involved in resource management in
kernel/resource.c:
1. You create a struct resource.
2. You add it to the child list of another resource.

Requesting a reasource is just another word for 2.  And
request_mem_region() is just a that, hardcoded to the iomem_resource
struct.

And mfd_add_device() implements step 2 for the resources included in the
cell.resources field.  The purpose is a generic resource slicing
implementation, and is also what you call requesting.

>> The mfd (parent) has a resource which it cuts up into slices for its
>> children, and these slices are passed to the child devices.  The
>> drivers for these child devices must then pickup the resource(s)
>> using platform_get_resource().  At no point is any "request_*"
>> function called.
>> 
>> Looking at in another way.
>> 
>> The request_mem_region() macro call __request_resource(), which which
>> simply creates a new 'struct resource' in the iomem_resource resource.
>> 
>> In mfd_add_device(), almost the same happens.  A new 'struct resource'
>> is created in the mem_base resource.
>> 
>> In both cases, a 'struct resource' is created, representing exclusive
>> access to the resource.  And like it or not, this is something that MFD
>> already *do*, and I think it is way out of scope of this patch to change
>> that.
>> 
>> I just try to make serial8250 driver work nicely in that (mfd) context,
>> without changing how mfd is working.
>
> There is nothing to change. It's already working. I don't see a problem here.

No.  It is not working.

Why are you saying that?  There is no existing usage of the serial8250
driver in combination of mfd_add_devices().  And it cannot be done with
the current serial8250 driver, as it will fail in the
request_mem_region() call.

I really think it is a shame if we cannot use mfd-core for mfd drivers
that just happens to need serial8250 driver.

/Esben
