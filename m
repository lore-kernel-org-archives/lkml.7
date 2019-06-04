Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159EFC04AB5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 01:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E796D261F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 01:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfFDBnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 21:43:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46140 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfFDBnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 21:43:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id z19so11870654qtz.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 18:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UhYcCxgEtL0AtQ/eoB2A8hUZouQaYG46tp9fVW9VG8Y=;
        b=haBbHErAu8Y8OgRzB3bV4Ns6aBgJJ1GqOtzPA/XjdXE6lwaiIihe+HBYLAtegzpf5a
         5dES7k3JJEbUWrkO5uMVBGCA8PKTM3AOwPAn/OAEj6lHzc7yN/RWDuPOu+iqIUYhZKH3
         UNz6iN99z9NMW5m8yBLXVs4PQrNkuaPsQ7QcHP8UPvwFCG4yHPaIA/rWFJnIwNVaniY4
         AzbGFg6YW7cWPiKxc6C//Vo+KLvCOcjGJOEJyOsRPQxaXlA/DALee+faMBu0nsmJUSyU
         mVwRZCo5IiDq7Am2H260LOUZmD1J29Q0ubrBcOM2Ik0lgXXwUVgPwS7MZX3yeJ9d7pcu
         BejA==
X-Gm-Message-State: APjAAAWgf618gvj0zVY7+wVaLMB9BWiBmo/ynUPE6g8CVPSNKLxq/LjD
        CH1FxXdHEDNBbQruEAdRXf6C7w==
X-Google-Smtp-Source: APXvYqzNXQ/3cx4oaT89jcuj4XmgWuJZ6ovl6rypbLqytAvqStAvYyx+TJNjAlTL/uzBpJjaoQNTmA==
X-Received: by 2002:ac8:2c7d:: with SMTP id e58mr25943949qta.243.1559612582509;
        Mon, 03 Jun 2019 18:43:02 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net. [100.0.197.103])
        by smtp.gmail.com with ESMTPSA id q187sm236373qkd.19.2019.06.03.18.42.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 03 Jun 2019 18:43:01 -0700 (PDT)
Date:   Mon, 3 Jun 2019 21:42:58 -0400
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
Message-ID: <20190603211528-mutt-send-email-mst@kernel.org>
References: <20190129134750-mutt-send-email-mst@kernel.org>
 <877eefxvyb.fsf@morokweng.localdomain>
 <20190204144048-mutt-send-email-mst@kernel.org>
 <87ef71seve.fsf@morokweng.localdomain>
 <20190320171027-mutt-send-email-mst@kernel.org>
 <87tvfvbwpb.fsf@morokweng.localdomain>
 <20190323165456-mutt-send-email-mst@kernel.org>
 <87a7go71hz.fsf@morokweng.localdomain>
 <20190520090939-mutt-send-email-mst@kernel.org>
 <877ea26tk8.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877ea26tk8.fsf@morokweng.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 10:13:59PM -0300, Thiago Jung Bauermann wrote:
> 
> 
> Michael S. Tsirkin <mst@redhat.com> writes:
> 
> > On Wed, Apr 17, 2019 at 06:42:00PM -0300, Thiago Jung Bauermann wrote:
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
> >
> > OK so VIRTIO_F_ACCESS_PLATFORM is designed to allow unpriveledged
> > drivers. This is why devices fail when it's not negotiated.
> 
> Just to clarify, what do you mean by unprivileged drivers? Is it drivers
> implemented in guest userspace such as with VFIO? Or unprivileged in
> some other sense such as needing to use bounce buffers for some reason?

I had drivers in guest userspace in mind.

> > This confuses me.
> > If driver is unpriveledged then what happens with this flag?
> > It can supply any address it wants. Will that corrupt kernel
> > memory?
> 
> Not needing address translation doesn't necessarily mean that there's no
> IOMMU. On powerpc we don't use VIRTIO_F_ACCESS_PLATFORM but there's
> always an IOMMU present. And we also support VFIO drivers. The VFIO API
> for pseries (sPAPR section in Documentation/vfio.txt) has extra ioctls
> to program the IOMMU.
> 
> For our use case, we don't need address translation because we set up an
> identity mapping in the IOMMU so that the device can use guest physical
> addresses.

And can it access any guest physical address?

> If the guest kernel is concerned that an unprivileged driver could
> jeopardize its integrity it should not negotiate this feature flag.

Unfortunately flag negotiation is done through config space
and so can be overwritten by the driver.

> Perhaps there should be a note about this in the flag definition? This
> concern is platform-dependant though. I don't believe it's an issue in
> pseries.

Again ACCESS_PLATFORM has a pretty open definition. It does actually
say it's all up to the platform.

Specifically how will VIRTIO_F_ACCESS_PLATFORM_NO_TRANSLATION be
implemented portably? virtio has no portable way to know
whether DMA API bypasses translation.



> --
> Thiago Jung Bauermann
> IBM Linux Technology Center
