Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00360C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35632084B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=haabendal.dk header.i=@haabendal.dk header.b="f20o62MW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfD2OZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:25:33 -0400
Received: from mailrelay1-1.pub.mailoutpod1-cph3.one.com ([46.30.210.182]:24215
        "EHLO mailrelay1-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728254AbfD2OZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=haabendal.dk; s=20140924;
        h=content-type:mime-version:message-id:in-reply-to:date:references:subject:cc:
         to:from:from;
        bh=oG7i9yZn/o4Oxniofl2+2tqTuOuKa8Z6pDLjDTXSntk=;
        b=f20o62MWzUz1nSfv4iDYjBclUCli1f+9PftRlQ/ZaHZ39mkGqAgVgeHsm9a06in6IqM7eHLkdY5yt
         6ovvYuYqT+far/+sywpMS2ZnjBr80o+m/QZJ6WndfrwushehfubjV1HOt667j0EvoxbmXZCm32laiS
         CAPAcuGs7xTN5Ugc=
X-HalOne-Cookie: 24a4b16c7a3db857b5122c41d5790eda3687d85a
X-HalOne-ID: a257edac-6a8a-11e9-b614-d0431ea8a283
Received: from localhost (unknown [193.163.1.7])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id a257edac-6a8a-11e9-b614-d0431ea8a283;
        Mon, 29 Apr 2019 14:25:27 +0000 (UTC)
From:   Esben Haabendal <esben@haabendal.dk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "open list\:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        He Zhe <zhe.he@windriver.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] serial: 8250: Allow port registration without UPF_BOOT_AUTOCONF
References: <20190426084038.6377-1-esben@geanix.com>
        <20190426084038.6377-2-esben@geanix.com>
        <20190426143946.GX9224@smile.fi.intel.com>
        <871s1og11u.fsf@haabendal.dk>
        <20190426215103.GD9224@smile.fi.intel.com>
        <87tvejakot.fsf@haabendal.dk>
        <CAHp75VfZMuQ3xagGSt6dXv1tZbSfanUdaw0SgjTqq3YET5YBKQ@mail.gmail.com>
        <87y33tz5oz.fsf@haabendal.dk>
        <CAHp75Vc6cLnLztXtvTcWisjAqDUTEWBBgv20CA34ZQmBEAvpbA@mail.gmail.com>
        <87ef5lxiqm.fsf@haabendal.dk>
        <20190429133535.GG9224@smile.fi.intel.com>
Date:   Mon, 29 Apr 2019 16:25:27 +0200
In-Reply-To: <20190429133535.GG9224@smile.fi.intel.com> (Andy Shevchenko's
        message of "Mon, 29 Apr 2019 16:35:35 +0300")
Message-ID: <87v9ywhors.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Mon, Apr 29, 2019 at 11:29:05AM +0200, Esben Haabendal wrote:
>> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>> > On Mon, Apr 29, 2019 at 9:27 AM Esben Haabendal <esben@haabendal.dk> wrote:
>> >> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>> >> > On Sat, Apr 27, 2019 at 12:01 PM Esben Haabendal <esben@haabendal.dk>
>> >> > wrote:
>> >> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> >> >> > On Fri, Apr 26, 2019 at 06:54:05PM +0200, Esben Haabendal wrote:
>> >> >> >> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>
>> So maybe we should go down that direction intead, extending 8250 driver
>> to replace mapbase with a resource struct instead?
>> 
>> > Btw, we have PCI MFD driver which enumerates 8250 (more precisely
>> > 8250_dw) w/o any issues.
>> 
>> I am aware of that (sm501.c).  It avoids the problem by not requesting
>> the parent memory region (sm->io_res), and requesting all child memory
>> regions directly in root instead of relative to the sm->io_res parent.
>> 
>> But as resoure management is designed for managing a parent/child
>> resource tree, this looks much more like a workaround than the right
>> solution.
>> 
>> >> It would be nice if child drivers requesting memory would pass the
>> >> parent memory resource.  Maybe 8250 driver could be changed to accept a
>> >> struct resource pointer instead of a simple mapbase value, allowing to
>> >> setup the resource with parent pointing to the MFD memory resource.
>> >
>> > I don't see the problem in certain driver, I guess you are trying to
>> > workaround existin Linux device resource model.
>> 
>> No, I actually try to do the right thing in relation to Linux device
>> resource model.  But 8250 is just not behaving very well in that
>> respect, not having been made really aware of the resource model.
>
> The point here is that. MFD driver can re-use existing platform drivers which
> may be used standalone. They and only they are the right owners of the
> requesting *their* resources.
>
> When parent request resources on the behalf of its child it simple will break
> this flexibility.

I hear what you say.  And I agree, parent/mfd drivers should not request
resources on behalf of it's children.

But on the other side, something is broken by design in mfd, if it is
not possible for parent/mfd driver to request the resources for itself,
which naturally contains the resources for all it's mfd
functions/childs.

Please take a look at mfd_add_device() in drivers/mfd/mfd-core.c, and
the use of the cell and mem_base arguments in particular.

        for (r = 0; r < cell->num_resources; r++) {
                res[r].name = cell->resources[r].name;
                res[r].flags = cell->resources[r].flags;

                /* Find out base to use */
                if ((cell->resources[r].flags & IORESOURCE_MEM) && mem_base) {
                        res[r].parent = mem_base;
                        res[r].start = mem_base->start +
                                cell->resources[r].start;
                        res[r].end = mem_base->start +
                                cell->resources[r].end;

It really is a core part of mfd drivers that you request a memory
resource for the mfd driver, and then have one or more child memory
resources requsted with the parent memory resource as base.

Many mfd drivers handle resources like this, like: htc/pasic3.c,
sta2x11-mfd.c and intel-lpss.c.
Ofcourse, the sm501.c driver does not, as it does not use the mfd API at
all, and is thus not a good example of a mfd driver, and there is
therefore no good examples of using 8250 with an mfd driver.

/Esben
