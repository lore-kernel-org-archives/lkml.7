Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC90C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02966214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387715AbfDYBS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 21:18:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40662 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfDYBS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 21:18:59 -0400
Received: by mail-qt1-f196.google.com with SMTP id y49so3926004qta.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 18:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gSdbl7tiCDChVFi/egk34T6hGKLdbLIMT0F6PPP6KJk=;
        b=LRGp8HnKuyTQ8iaGOXzJX7efeZ8PRDyPoP/+z9c8f8p16TCTghiIGWOk3J9oRloU1Z
         yZQIleBd3TYP5m3a4q7RnR9R/g7KOx/l+xTnLzj2yJYjXIvFSybBe0bpD1O78JOIzocz
         ewB4Bmm7mYCAbaXFF83XrrqpyPFRV13UkvS8Qpfki0cC3bNWYK8Vszx683HkTZ46lJ12
         ZWrUYogR5x3wehY3Oq4s9C8xBPXDKO6eyaCEes8lOIdK3EzwHzdPXeoOL9VMd7hAyChw
         iGpxWZJLxeAxCo7HaYK4IqAa3fYAhAl+50JNCTnsBGTO/guWaGEFPmDPIKRwJAgif8FZ
         jYwA==
X-Gm-Message-State: APjAAAX4ZniUW3g0wefui788T8FPgi+ximdMXtes5l2gsyQkXUOZ+wOo
        Ab3H6nWVcN8Ebb2B7M7jTOCVbLqk3q4=
X-Google-Smtp-Source: APXvYqxKlHSNlPqQN4XmzYneFKkJ/mvtPnQ1lM7Bwy+vkifcs/0Fs/s/gpyQh6mYewhWVUy9oqbl+w==
X-Received: by 2002:aed:20c4:: with SMTP id 62mr26929160qtb.256.1556155138200;
        Wed, 24 Apr 2019 18:18:58 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net. [173.76.105.71])
        by smtp.gmail.com with ESMTPSA id e6sm9930128qtr.56.2019.04.24.18.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 18:18:56 -0700 (PDT)
Date:   Wed, 24 Apr 2019 21:18:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     virtualization@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Michael Roth <mdroth@linux.vnet.ibm.com>,
        Mike Anderson <andmike@linux.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Message-ID: <20190424210813-mutt-send-email-mst@kernel.org>
References: <20190129134750-mutt-send-email-mst@kernel.org>
 <877eefxvyb.fsf@morokweng.localdomain>
 <20190204144048-mutt-send-email-mst@kernel.org>
 <87ef71seve.fsf@morokweng.localdomain>
 <20190320171027-mutt-send-email-mst@kernel.org>
 <87tvfvbwpb.fsf@morokweng.localdomain>
 <20190323165456-mutt-send-email-mst@kernel.org>
 <87a7go71hz.fsf@morokweng.localdomain>
 <20190419190258-mutt-send-email-mst@kernel.org>
 <875zr228zf.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zr228zf.fsf@morokweng.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 10:01:56PM -0300, Thiago Jung Bauermann wrote:
> 
> Michael S. Tsirkin <mst@redhat.com> writes:
> 
> > On Wed, Apr 17, 2019 at 06:42:00PM -0300, Thiago Jung Bauermann wrote:
> >>
> >> Michael S. Tsirkin <mst@redhat.com> writes:
> >>
> >> > On Thu, Mar 21, 2019 at 09:05:04PM -0300, Thiago Jung Bauermann wrote:
> >> >>
> >> >> Michael S. Tsirkin <mst@redhat.com> writes:
> >> >>
> >> >> > On Wed, Mar 20, 2019 at 01:13:41PM -0300, Thiago Jung Bauermann wrote:
> >> >> >> >From what I understand of the ACCESS_PLATFORM definition, the host will
> >> >> >> only ever try to access memory addresses that are supplied to it by the
> >> >> >> guest, so all of the secure guest memory that the host cares about is
> >> >> >> accessible:
> >> >> >>
> >> >> >>     If this feature bit is set to 0, then the device has same access to
> >> >> >>     memory addresses supplied to it as the driver has. In particular,
> >> >> >>     the device will always use physical addresses matching addresses
> >> >> >>     used by the driver (typically meaning physical addresses used by the
> >> >> >>     CPU) and not translated further, and can access any address supplied
> >> >> >>     to it by the driver. When clear, this overrides any
> >> >> >>     platform-specific description of whether device access is limited or
> >> >> >>     translated in any way, e.g. whether an IOMMU may be present.
> >> >> >>
> >> >> >> All of the above is true for POWER guests, whether they are secure
> >> >> >> guests or not.
> >> >> >>
> >> >> >> Or are you saying that a virtio device may want to access memory
> >> >> >> addresses that weren't supplied to it by the driver?
> >> >> >
> >> >> > Your logic would apply to IOMMUs as well.  For your mode, there are
> >> >> > specific encrypted memory regions that driver has access to but device
> >> >> > does not. that seems to violate the constraint.
> >> >>
> >> >> Right, if there's a pre-configured 1:1 mapping in the IOMMU such that
> >> >> the device can ignore the IOMMU for all practical purposes I would
> >> >> indeed say that the logic would apply to IOMMUs as well. :-)
> >> >>
> >> >> I guess I'm still struggling with the purpose of signalling to the
> >> >> driver that the host may not have access to memory addresses that it
> >> >> will never try to access.
> >> >
> >> > For example, one of the benefits is to signal to host that driver does
> >> > not expect ability to access all memory. If it does, host can
> >> > fail initialization gracefully.
> >>
> >> But why would the ability to access all memory be necessary or even
> >> useful? When would the host access memory that the driver didn't tell it
> >> to access?
> >
> > When I say all memory I mean even memory not allowed by the IOMMU.
> 
> Yes, but why? How is that memory relevant?

It's relevant when driver is not trusted to only supply correct
addresses. The feature was originally designed to support userspace
drivers within guests.

> >> >> >> >> > But the name "sev_active" makes me scared because at least AMD guys who
> >> >> >> >> > were doing the sensible thing and setting ACCESS_PLATFORM
> >> >> >> >>
> >> >> >> >> My understanding is, AMD guest-platform knows in advance that their
> >> >> >> >> guest will run in secure mode and hence sets the flag at the time of VM
> >> >> >> >> instantiation. Unfortunately we dont have that luxury on our platforms.
> >> >> >> >
> >> >> >> > Well you do have that luxury. It looks like that there are existing
> >> >> >> > guests that already acknowledge ACCESS_PLATFORM and you are not happy
> >> >> >> > with how that path is slow. So you are trying to optimize for
> >> >> >> > them by clearing ACCESS_PLATFORM and then you have lost ability
> >> >> >> > to invoke DMA API.
> >> >> >> >
> >> >> >> > For example if there was another flag just like ACCESS_PLATFORM
> >> >> >> > just not yet used by anyone, you would be all fine using that right?
> >> >> >>
> >> >> >> Yes, a new flag sounds like a great idea. What about the definition
> >> >> >> below?
> >> >> >>
> >> >> >> VIRTIO_F_ACCESS_PLATFORM_NO_IOMMU This feature has the same meaning as
> >> >> >>     VIRTIO_F_ACCESS_PLATFORM both when set and when not set, with the
> >> >> >>     exception that the IOMMU is explicitly defined to be off or bypassed
> >> >> >>     when accessing memory addresses supplied to the device by the
> >> >> >>     driver. This flag should be set by the guest if offered, but to
> >> >> >>     allow for backward-compatibility device implementations allow for it
> >> >> >>     to be left unset by the guest. It is an error to set both this flag
> >> >> >>     and VIRTIO_F_ACCESS_PLATFORM.
> >> >> >
> >> >> > It looks kind of narrow but it's an option.
> >> >>
> >> >> Great!
> >> >>
> >> >> > I wonder how we'll define what's an iommu though.
> >> >>
> >> >> Hm, it didn't occur to me it could be an issue. I'll try.
> >>
> >> I rephrased it in terms of address translation. What do you think of
> >> this version? The flag name is slightly different too:
> >>
> >>
> >> VIRTIO_F_ACCESS_PLATFORM_NO_TRANSLATION This feature has the same
> >>     meaning as VIRTIO_F_ACCESS_PLATFORM both when set and when not set,
> >>     with the exception that address translation is guaranteed to be
> >>     unnecessary when accessing memory addresses supplied to the device
> >>     by the driver. Which is to say, the device will always use physical
> >>     addresses matching addresses used by the driver (typically meaning
> >>     physical addresses used by the CPU) and not translated further. This
> >>     flag should be set by the guest if offered, but to allow for
> >>     backward-compatibility device implementations allow for it to be
> >>     left unset by the guest. It is an error to set both this flag and
> >>     VIRTIO_F_ACCESS_PLATFORM.
> >
> > Thanks, I'll think about this approach. Will respond next week.
> 
> Thanks!
> 
> >> >> > Another idea is maybe something like virtio-iommu?
> >> >>
> >> >> You mean, have legacy guests use virtio-iommu to request an IOMMU
> >> >> bypass? If so, it's an interesting idea for new guests but it doesn't
> >> >> help with guests that are out today in the field, which don't have A
> >> >> virtio-iommu driver.
> >> >
> >> > I presume legacy guests don't use encrypted memory so why do we
> >> > worry about them at all?
> >>
> >> They don't use encrypted memory, but a host machine will run a mix of
> >> secure and legacy guests. And since the hypervisor doesn't know whether
> >> a guest will be secure or not at the time it is launched, legacy guests
> >> will have to be launched with the same configuration as secure guests.
> >
> > OK and so I think the issue is that hosts generally fail if they set
> > ACCESS_PLATFORM and guests do not negotiate it.
> > So you can not just set ACCESS_PLATFORM for everyone.
> > Is that the issue here?
> 
> Yes, that is one half of the issue. The other is that even if hosts
> didn't fail, existing legacy guests wouldn't "take the initiative" of
> not negotiating ACCESS_PLATFORM to get the improved performance. They'd
> have to be modified to do that.

So there's a non-encrypted guest, hypervisor wants to set
ACCESS_PLATFORM to allow encrypted guests but that will slow down legacy
guests since their vIOMMU emulation is very slow.

So enabling support for encryption slows down non-encrypted guests. Not
great but not the end of the world, considering even older guests that
don't support ACCESS_PLATFORM are completely broken and you do not seem
to be too worried by that.

For future non-encrypted guests, bypassing the emulated IOMMU for when
that emulated IOMMU is very slow might be solvable in some other way,
e.g. with virtio-iommu. Which reminds me, could you look at
virtio-iommu as a solution for some of the issues?
Review of that patchset from that POV would be appreciated.

> --
> Thiago Jung Bauermann
> IBM Linux Technology Center
